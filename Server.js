////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                       (C)MISSION2GO                                        //
//                            2020                                            //
//  LINES MARKED /*** ARE NOT MY ORIGINAL WORK BUT WERE USED UPON OBTAINING   //
//               GRACIOUS WRITTEN PERMISSION FROM THE AUTHOR                  //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
const express = require('express'); //prereq
const uuid = require('uuid/v4');
const session = require('express-session'); //manages session cookies
const helmet = require('helmet');
const https = require('https');
const fs = require('fs');
const app = express(); //prereq
const sql = require('mssql');
const path = require('path');
var cookieParser = require('cookie-parser');
app.use(helmet());
var bodyParser = require('body-parser'); //for finding user and pass data
var moment = require('moment');
app.use(cookieParser());
//configure session for cookies and uuid
//DB Credentials
const config = {
    user:     'sa',
    password: 'M2Gadmin',
    server:   'localhost',
    database: 'mission2Go'
};
var options = {
  ttl: 40000
};
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
//Includes for Redis (memory-based session store)
const redis = require('redis');
const redisStore = require('connect-redis')(session);
const redisCli = redis.createClient();

redisCli.on('error', (err) => {
      console.log('ERROR: REDIS FAILED: ');
      console.log(err);
});
app.use(
    session({
      id: (req) => {
      console.log(req.sessionID);
      return uuid(); // uuid random string is session id (encrypted by middleware)
    },
    store: new redisStore({host: 'localhost', port: 6379, client: redisCli, ttl: 90000}),
    secret: 'adminSecret',
    name: 'RedisConn',
    resave: false,
    saveUninitialized: true,
    cookie: {secure: false},
}))
var indexV;
var indexE;
var indexD;
var indexA;
var indexP;
var TIDref;
var PIDref;
var indexTIDE;
var indexTIDD;
var ids = [];
var defaults = [];
var results = [];
var TDFD;
////////////////////////////////////////////////////////////////////////////////
//X    set up DB credentials, load login page, and ensure DB is connected    X//
////////////////////////////////////////////////////////////////////////////////
app.get('/', async function(req,res){
    app.set('view engine', 'pug'); // added for pug
    app.set("views", path.join(__dirname, "views"));
    res.render('default');  //added for pug
    var sql = require('mssql'); //official mssql package
    //credentials
    var connection = sql.connect(config, function(err){
    if (err) { console.log(err); }                  //print what's wrong
    else { console.log('[DATABASE CONNECTED]'); }     //good! move on....
    });
    //console.log(req.sessionID);
    //console.log("<- SessionID");

});

////////////////////////////////////////////////////////////////////////////////
//X              use POST data from login and process it                     X//
////////////////////////////////////////////////////////////////////////////////
app.post('/login', function(request, response, next){
        var user = request.body.user; //pull credentials that were entered and save them
        var pass = request.body.pass;

    const promise1 = new Promise(function (resolve, reject) { //promise awaits results before proceeding
            var check = new sql.Request();
            check.input('user', sql.NVarChar(64), user); //pass user and pass to stored procedure
            check.input('pass', sql.NVarChar(64), pass);
            check.execute('AuthenticateUser').then(function (result, recordset){
            var flag = result.returnValue;
            resolve(flag);
        }).catch(function(error){
                console.log(error);
                sql.close();
                reject(error);
            });
        });
            promise1.then((verdict) => {
            if (verdict === 1) {
                    var SessInfo = request.session;
                    SessInfo.user= user;
                    response.redirect('ScheduledTeamsView&Edit');
                    //response.end();   //maybe?????
            }
            else{
                response.send('Login Failed! Please return to the previous page and try again!');
            }
         });
});

app.get('/registration', function(req,res){
  res.render('registration');
});

app.post('/register', function(req, res){
  var newUser = req.body.newUser;
  var newPass = req.body.newPass;
  var newEmail = req.body.newEmail;
  const promiseReg = new Promise(function (resolve, reject) { //promise awaits results before proceeding
          var R = new sql.Request();
          R.input('newUser', sql.NVarChar(64), newUser); //pass user and pass to stored procedure
          R.input('newPass', sql.NVarChar(64), newPass);
          R.input('newEmail', sql.NVarChar(64), newEmail);
          R.execute('registerUser').then(function (result, recordset){
          var flag = result.returnValue;
          resolve(flag);
      }).catch(function(error){
              console.log(error);
              sql.close();
              reject(error);
          });
      });
          promiseReg.then((verdict) => {
          if (verdict === 0) {
                  res.send("THIS USER ALREADY EXISTS");
                  res.redirect('/login');
                  //maybe?????
          }
          else{
              //console.log("...ACCOUNT CREATION SUCCESSFUL...");
              res.redirect('/');
          }
      });
});
////////////////////////////////////////////////////////////////////////////////
//--                  Maxima Teams Page handler                             --//
////////////////////////////////////////////////////////////////////////////////
app.get('/MaximaTeams', function (req, res){
          const promise3 = new Promise(async function r (resolve, reject) {
          var check3 = new sql.Request();
          var tableArray = [];

          check3.execute('ProjectTeamTablesMaxima').then(function(result){
              var len = result.recordset.length;
              var today = new Date();
              for(var i = 0; i < len; i++) {
                          tableArray.push({
                          "Maxima":         result.recordset[i].Maxima,
                          "TeamName":       result.recordset[i].TeamName,
                          "CountryName":    result.recordset[i].CountryName,
                          "Days":           Math.round((result.recordset[i].ArrivalDate - today)/(1000*60*60*24)),
                          "ArrivalDate":    moment(result.recordset[i].ArrivalDate).format('YYYY-MM-DD'),
                          "DepartDate":     moment(result.recordset[i].DepartDate).format('YYYY-MM-DD'),
                          "NumTeamMemb":    result.recordset[i].NumTeamMemb,
                          "ProjectID":      result.recordset[i].ProjectID,
                          "FName":          result.recordset[i].FName,
                          "ProjectMoney":   result.recordset[i].ProjectMoney,
                          "SumOfUSD":       result.recordset[i].SumOfUSD,
                });
            };
          tableArray=tableArray.filter(tableArray => tableArray.Maxima == 1);
          //console.log("redirect success");
          res.render('MaximaTeams', {tableArray : tableArray});
        });
    });
});

////////////////////////////////////////////////////////////////////////////////
//X                    The default visible page upon login                   X//
////////////////////////////////////////////////////////////////////////////////
app.get('/ScheduledTeamsView&Edit', function (req, res){
        var UsNm = req.session.user;
        console.log(req.sessionID);
        if(UsNm == null && sessionID == null){res.redirect('/')};
        console.log(`logged in as: ${UsNm}`);
        const promise2 = new Promise(function (resolve, reject) {
        var check2 = new sql.Request();
        var tableArray = [];

        check2.execute('ProjectTeamTables').then(function(result){
            var len = result.recordset.length;
            var today = new Date();
            for(var i = 0; i < len; i++) {
                        tableArray.push({
                        "Maxima":         result.recordset[i].Maxima,
                        "TeamName":       result.recordset[i].TeamName,
                        "CountryName":    result.recordset[i].CountryName,
                        "Days":           Math.round((result.recordset[i].ArrivalDate - today)/(1000*60*60*24)),
                        "ArrivalDate":    moment(result.recordset[i].ArrivalDate).format('YYYY-MM-DD'),
                        "DepartDate":     moment(result.recordset[i].DepartDate).format('YYYY-MM-DD'),
                        "NumTeamMemb":    result.recordset[i].NumTeamMemb,
                        "ProjectID":      result.recordset[i].ProjectID,
                        "FName":          result.recordset[i].FName,
                        "ProjectMoney":   result.recordset[i].ProjectMoney,
                        "SumOfUSD":       result.recordset[i].SumOfUSD,


                    });

            };
 //The above loop creates an array of objects...
 //...which is easily rendered on the client side upon redirect and rendering
        resolve(tableArray);
        //console.log("redirect success");
        res.render('ScheduledTeamsView&Edit', {tableArray : tableArray});
        delete tableArray;
        });
    });
});
////////////////////////////////////////////////////////////////////////////////
//        Get the row of the record and send that records info to editor      //
////////////////////////////////////////////////////////////////////////////////
app.post('/GetIndex', function(req,res){
indexE = req.body.RowForEdit;
indexD = req.body.RowForDelete;
if(indexD == undefined){
  res.redirect('editRecord');
}
else {
  res.redirect('deleteRecord');
}
});

app.get('/deleteRecord', function(req, res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var tableArrayDelete = [];
  //  const promise4 = new Promise(function(resolve, reject) {
  var check5 = new sql.Request();
  check5.execute('ProjectTeamTables').then(function(result){
      var today = new Date();
      var ie = indexD
      TDFD = result.recordset[ie].TeamDetailsID;
                  tableArrayDelete.push({
                  "TeamDetailsID":      result.recordset[ie].TeamDetailsID,  //PK, MAKE NOT EDITABLE
                  "TeamID":             result.recordset[ie].TeamID,         //PK, MAKE NOT EDITABLE
                  "ChruchName":         result.recordset[ie].ChurchName,     //EDITABLE, BUT NOT IN INITAL view
                  "CancelTeam":         result.recordset[ie].CancelTeam,
                  "ArriveFlightNumber": result.recordset[ie].ArriveFlightNumber,
                  "DepartFlightNumber": result.recordset[ie].DepartFlightNumber,
                  "Maxima":             result.recordset[ie].Maxima,
                  "TeamName":           result.recordset[ie].TeamName,
                  "CountryName":        result.recordset[ie].CountryName,
                  "Days":               Math.round((result.recordset[ie].ArrivalDate - today)/(1000*60*60*24)),
                  "ArrivalDate":        moment(result.recordset[ie].ArrivalDate).format('YYYY-MM-DD'),
                  "DepartDate":         moment(result.recordset[ie].DepartDate).format('YYYY-MM-DD'),
                  "NumTeamMemb":        result.recordset[ie].NumTeamMemb,
                  "ProjectID":          result.recordset[ie].ProjectID,    //PK, MAKE NOT EDITABLE
                  "FName":              result.recordset[ie].FName,
                  "ProjectMoney":       result.recordset[ie].ProjectMoney,
                  "TID":                result.recordset[ie].TID
              });
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
  //console.log(tableArrayDelete);
  res.render('deleteRecord', {tableArrayDelete : tableArrayDelete});
  res.end();
});
});
app.post('/deleteRecord', function(req,res){
    var deleteRec = new sql.Request();
    deleteRec.input('TeamDetailsID', sql.INT, TDFD);
    deleteRec.execute('DeleteTeamDetails').then(function(result, recordset){
      //console.log(result, recordset);
    });
  res.redirect('ScheduledTeamsView&Edit');
});
//view all teams
app.get('/allTeams', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var teamViewArray = [];
  var check5 = new sql.Request();
  check5.execute('ViewTeams').then(function(result){
      var len = result.recordset.length;
      var c;
      for(var i = 0; i < len; i++){
                  c=i;
                  teamViewArray.push({
                  "TeamID":       result.recordset[i].TeamID,
                  "TeamName":     result.recordset[i].TeamName,
                  "ChurchName":   result.recordset[i].ChurchName,
                  "District":     result.recordset[i].District,
                  "LeaderEmail":  result.recordset[i].LeaderEmail,
                  "LeaderName":   result.recordset[i].LeaderName,
              });
            };
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
//console.log(teamViewArray);
defaults[0] =  result.recordset[c].TeamName;
defaults[1] =  result.recordset[c].ChurchName;
defaults[2] =  result.recordset[c].District;
defaults[3] =  result.recordset[c].LeaderEmail;
defaults[4] =  result.recordset[c].LeaderName;
ids[0] =  result.recordset[c].TeamID;
//console.log(ids[0]);
res.render('allTeams', {teamViewArray: teamViewArray});
res.end();
});
});

app.post('/allTeams', function(req,res){
  indexE = req.body.RowForEditTeam;
  indexD = req.body.RowForDeleteTeam;
  indexV = req.body.RowForViewMembers;
  if(indexD == undefined && indexE == undefined){
    res.redirect('viewTeamMembers');
  }
  else if(indexD == undefined && indexV == undefined) {
    res.redirect('editTeam');
  }
  else{
    res.redirect('deleteTeam');
  }
});

app.get('/editTeam', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var teamViewArrayEdit = [];
  var check4 = new sql.Request();
  check4.execute('ViewTeams').then(function(result){
      var ie = indexE;
                  teamViewArrayEdit.push({
                  "TeamID":       result.recordset[ie].TeamID,
                  "TeamName":     result.recordset[ie].TeamName,
                  "ChurchName":   result.recordset[ie].ChurchName,
                  "District":     result.recordset[ie].District,
                  "LeaderEmail":  result.recordset[ie].LeaderEmail,
                  "LeaderName":   result.recordset[ie].LeaderName
              });
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
//console.log(teamViewArrayEdit);
ids[0] = result.recordset[ie].TeamID;
//console.log(ids[0]);
defaults[0] = result.recordset[ie].TeamName;
defaults[1] = result.recordset[ie].ChruchName;
defaults[2] = result.recordset[ie].District; 
defaults[3] = result.recordset[ie].LeaderEmail;
defaults[4] = result.recordset[ie].LeaderName
res.render('editTeam', {teamViewArrayEdit : teamViewArrayEdit});
res.end();
});

});
//
app.post('/edit-Team', function(req,res){
  var NewTeamID = ids[0]; //PK
  var NewTeamName = req.body.newTeamName;
      if(NewTeamName == null || NewTeamName == undefined || NewTeamName.length === 0){
            NewTeamName = defaults[0];
      }
  var NewChurchName = req.body.newChurchName;
      if(NewChurchName == null || NewChurchName == undefined || NewChurchName.length === 0){
            NewChurchName = defaults[1];
      }
  var NewDistrict = req.body.newDistrict;
      if(NewDistrict == null || NewDistrict == undefined || NewDistrict.length === 0){
            NewDistrict = defaults[2];
      }
  var NewLeaderEmail = req.body.newLeaderEmail;
      if(NewLeaderEmail == null || NewLeaderEmail == undefined || NewLeaderEmail.length === 0){
            NewLeaderEmail = defaults[3];
      }
  var NewLeaderName = req.body.newLeaderName;
      if(NewLeaderName == null || NewLeaderName == undefined || NewLeaderName.length === 0){
            NewLeaderName = defaults[4];
      }
  var NewCancelTeam = req.body.newCancelled
      if(NewCancelTeam == null || NewCancelTeam == undefined || NewCancelTeam.length === 0){
            CancelTeam = 0;
      }
      var recordTeams = new sql.Request();
      recordTeams.input('NewTeamID', sql.INT, NewTeamID);
      recordTeams.input('NewTeamName', sql.NVARCHAR(255), NewTeamName);
      recordTeams.input('NewChurchName', sql.NVARCHAR(255), NewChurchName);
      recordTeams.input('NewDistrict', sql.NVARCHAR(255), NewDistrict);
      recordTeams.input('NewLeaderEmail', sql.NVARCHAR(255), NewLeaderEmail);
      recordTeams.input('NewLeaderName', sql.NVARCHAR(255), NewLeaderName);
      recordTeams.input('NewCancelled', sql.INT, NewCancelTeam);
      recordTeams.execute('EditTeam').then(function(err){
        console.log(err);
      });

    res.redirect('ScheduledTeamsView&Edit');

  });


app.get('/deleteTeam', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var teamViewArrayDelete = [];
  var check4 = new sql.Request();
  check4.execute('ViewTeams').then(function(result){
      var ie = indexD;
                  teamViewArrayDelete.push({
                  "TeamID":       result.recordset[ie].TeamID,
                  "TeamName":     result.recordset[ie].TeamName,
                  "ChurchName":   result.recordset[ie].ChurchName,
                  "District":     result.recordset[ie].District,
                  "LeaderEmail":  result.recordset[ie].LeaderEmail,
                  "LeaderName":   result.recordset[ie].LeaderName,
              });
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
//console.log(teamViewArrayDelete);
ids[0] = result.recordset[ie].TeamID;
//console.log(ids[0]);
res.render('deleteTeam', {teamViewArrayDelete : teamViewArrayDelete});
res.end();
});
});

//
app.post('/Team-Delete', function(req,res){
    var NewTeamID = ids[0];
    var check = new sql.Request();
    check.input('NewTeamID', sql.INT, NewTeamID);
    check.execute('DeleteTeam');
  res.redirect('ScheduledTeamsView&Edit');
});

//FUNDS
app.get('/funds', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var tableArrayFunds = [];
  var check5 = new sql.Request();
  check5.execute('ExpectedFunds').then(function(result){
      var len = result.recordset.length;
      for(var i = 0; i < len; i++){
                  tableArrayFunds.push({
                  "TeamDetailsID":            result.recordset[i].TeamDetailsID,
                  "ProjectFundsRecieved":     result.recordset[i].ProjectFundsRecieved,
                  "CancelTeam":               result.recordset[i].CancelTeam,
                  "ProjectMoney":             result.recordset[i].ProjectMoney,
              });
            };
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
//console.log(tableArrayFunds);
res.render('funds', {tableArrayFunds: tableArrayFunds});
res.end();
});
});

app.post('/EF', function(req,res){
indexE = req.body.RowForEditEF;
res.redirect('editEF');
});

app.get('/editEF', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var tableArrayFundsEditor = [];
  //  const promise4 = new Promise(function(resolve, reject) {
  var check7 = new sql.Request();
  check7.execute('ExpectedFunds').then(function(result){
      var i = indexE;
                  tableArrayFundsEditor.push({
                  "TeamDetailsID":          result.recordset[i].TeamDetailsID,
                  "ProjectFundsReceived":   result.recordset[i].ProjectFundsReceived,
                  "CancelTeam":             result.recordset[i].CancelTeam,
                  "ProjectMoney":           result.recordset[i].ProjectMoney,
              });
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
  ids[0] =  result.recordset[i].TeamDetailsID;
  ids[1] =  result.recordset[i].TeamID;
  defaults[0] = result.recordset[i].ProjectFundsRecieved;
  defaults[1] = result.recordset[i].CancelTeam;
  defaults[2] = result.recordset[i].ProjectMoney;
  defaults[3] = result.recordset[i].ArriveDate;
  res.render('editEF', {tableArrayFundsEditor : tableArrayFundsEditor});
  res.end();
});
});

app.post('/editEFs', function(req,res){
  var NewTeamDetailsID = ids[0]; //PK
  var NewProjectFundsRecieved = req.body.newProjectFundsRecieved;
      if(NewProjectFundsRecieved == null || NewProjectFundsRecieved == undefined || NewProjectFundsRecieved.length === 0){
            NewProjectFundsRecieved = defaults[0];
      }
  var NewCancelTeam = req.body.newCancelTeam;
      if(NewCancelTeam == null || NewCancelTeam == undefined || NewCancelTeam.length === 0){
            NewCancelTeam = defaults[1];
      }
  var NewProjectMoney = req.body.newProjectMoney;
      if(NewProjectMoney == null || NewProjectMoney == undefined || NewProjectMoney.length === 0){
            NewProjectMoney = defaults[2];
      }
  var NewArrivalDate = req.body.newArrivaltDate;
      if(NewArrivalDate == null || NewArrivalDate == undefined || NewArrivalDate.length === 0){
            NewArrivalDate = defaults[3];
      }
      var recordFunds = new sql.Request();
      recordFunds.input('NewTeamDetailsID', sql.INT, NewTeamDetailsID); //PK
      recordFunds.input('NewProjectFundsRecieved', sql.INT, NewProjectFundsRecieved);
      recordFunds.input('NewCancelTeam', sql.INT, NewCancelTeam);
      recordFunds.input('NewProjectMoney', sql.MONEY, NewProjectMoney);
      recordFunds.execute('EditFunds').then(function(result, recordset){
        //console.log(result, recordset);
      });

    res.redirect('ScheduledTeamsView&Edit');

});

app.get('/cancelled', function(req, res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var tableArrayCancelledTeams = [];
  var check5 = new sql.Request();
  check5.execute('CancelledTeams').then(function(result){
      var len = result.recordset.length;
      var c;
      for(var i = 0; i < len; i++){
                  tableArrayCancelledTeams.push({
                  "TeamID":                       result.recordset[i].TeamID,
                  "TeamName":                   result.recordset[i].TeamName,
                  "ChurchName":               result.recordset[i].ChurchName,
                  "District":                   result.recordset[i].District,
                  "LeaderEmail":             result.recordset[i].LeaderEmail,
                  "LeaderName":               result.recordset[i].LeaderName,
                  "CancelTeam":               result.recordset[i].CancelTeam,
              });
            };
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
res.render('cancelled', {tableArrayCancelledTeams: tableArrayCancelledTeams});
res.end();
});
});

app.post('/cancelledTeams', function(req,res){
  indexE = req.body.RowForEditCancelledTeam;
  indexD = req.body.RowForDeleteCancelledTeam;
  if(indexD == undefined){
    res.redirect('editCT');
  }
  else {
    res.redirect('deleteCT');
  }
});

app.get('/editCT', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var teamCTedit = [];
  var check4 = new sql.Request();
  check4.execute('CancelledTeams').then(function(result){
      var ie = indexE;
                  teamCTedit.push({
                  "TeamID":       result.recordset[ie].TeamID,
                  "TeamName":     result.recordset[ie].TeamName,
                  "ChurchName":   result.recordset[ie].ChurchName,
                  "District":     result.recordset[ie].District,
                  "LeaderEmail":  result.recordset[ie].LeaderEmail,
                  "LeaderName":   result.recordset[ie].LeaderName,
              });
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
  //console.log(teamCTedit);
  ids[0] = result.recordset[ie].TeamID;
  defaults[0] =  result.recordset[ie].TeamName;
  defaults[1] =  result.recordset[ie].ChurchName;
  defaults[2] =  result.recordset[ie].District;
  defaults[3] =  result.recordset[ie].LeaderEmail;
  defaults[4] =  result.recordset[ie].LeaderName;
  //console.log(ids[0]);
  res.render('editCT', {teamCTedit : teamCTedit});
  res.end();
  });
});

app.get('/deleteCT', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var teamCTdelete = [];
  var check4 = new sql.Request();
  check4.execute('CancelledTeams').then(function(result){
      var ie = indexD;
                  teamCTdelete.push({
                  "TeamID":       result.recordset[ie].TeamID,
                  "TeamName":     result.recordset[ie].TeamName,
                  "ChurchName":   result.recordset[ie].ChurchName,
                  "District":     result.recordset[ie].District,
                  "LeaderEmail":  result.recordset[ie].LeaderEmail,
                  "LeaderName":   result.recordset[ie].LeaderName,
              });
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
  ids[0] = result.recordset[ie].TeamID;
  //console.log(ids[0]);
  res.render('deleteCT', {teamCTdelete : teamCTdelete});
  res.end();
  });
});

app.post('/editCTteam', function(req,res){
  var NewTeamID = ids[0]; //PK
  var NewTeamName = req.body.newTeamName;
      if(NewTeamName == null || NewTeamName == undefined || NewTeamName.length === 0){
            NewTeamName = defaults[0];
      }
  var NewChurchName = req.body.newChurchName;
      if(NewChurchName == null || NewChurchName == undefined || NewChurchName.length === 0){
            NewChurchName = defaults[1];
      }
  var NewDistrict = req.body.newDistrict;
      if(NewDistrict == null || NewDistrict == undefined || NewDistrict.length === 0){
            NewDistrict = defaults[2];
      }
  var NewLeaderEmail = req.body.newLeaderEmail;
      if(NewLeaderEmail == null || NewLeaderEmail == undefined || NewLeaderEmail.length === 0){
            NewLeaderEmail = defaults[3];
      }
  var NewLeaderName = req.body.newLeaderName;
      if(NewLeaderName == null || NewLeaderName == undefined || NewLeaderName.length === 0){
            NewLeaderName = defaults[4];
      }
  var NewCancelTeam = req.body.newCancelTeam
      if(NewCancelTeam == null || NewCancelTeam == undefined || NewCancelTeam.length === 0){
            NewCancelTeam = 1;
      }
      var recordTeams = new sql.Request();
      recordTeams.input('NewTeamID', sql.INT, NewTeamID);
      recordTeams.input('NewTeamName', sql.NVARCHAR(255), NewTeamName);
      recordTeams.input('NewChurchName', sql.NVARCHAR(255), NewChurchName);
      recordTeams.input('NewDistrict', sql.NVARCHAR(255), NewDistrict);
      recordTeams.input('NewLeaderEmail', sql.NVARCHAR(255), NewLeaderEmail);
      recordTeams.input('NewLeaderName', sql.NVARCHAR(255), NewLeaderName);
      recordTeams.input('NewCancelled', sql.INT, NewCancelTeam);
      recordTeams.execute('editCTteam').then(function(err){
        console.log(err);
        delete ids;
        delete defaults;
      });
      delete ids;
      delete defaults;
    res.redirect('ScheduledTeamsView&Edit');

  });



app.post('/deleteCTteam', function(req,res){
  var NewTeamID = ids[0];
  var check9 = new sql.Request();
  check9.input('NewTeamID', sql.INT, NewTeamID);
  check9.execute('DeleteTeam');
  delete ids;
  delete defaults;
  res.redirect('ScheduledTeamsView&Edit');
});

app.get('/ppd', function(req, res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var tableArrayPBD = [];
  var check7 = new sql.Request();
  check7.execute('ProjectsByDistrict').then(function(result){
      var len = result.recordset.length;
      for(var i = 0; i < len; i++){
                  tableArrayPBD.push({
                  "DistrictName":     result.recordset[i].DistrictName,
                  "ArriveDate":       result.recordset[i].ArriveDate,
                  "CountryName":      result.recordset[i].CountryName
              });
            };
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
  res.render('ppd', {tableArrayPBD: tableArrayPBD});
  res.end();
});
});
///////////////////////////////////////////////////////////////////////////////
// NOW FOR THE REAL MEAT OF THE PROJECT
//////////////////////////////////////////////////////////////////////////////
app.get('/allProjects', function(req,res){////////////////////////////////////////////////////////////////////////////////////////
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var ProjectsViewArray = [];
  var check = new sql.Request();
  check.execute('ViewProjects').then(function(result){
      var len = result.recordset.length;
      for(var i = 0; i < len; i++){
                  ProjectsViewArray.push({
                  "ProjectID":                       result.recordset[i].ProjectID,
                  "TeamLeaderID":                   result.recordset[i].TeamLeaderID,
                  "WWCoorID":                       result.recordset[i].WWCoorID,
                  "TeamID":                   result.recordset[i].TeamID,
                  "LinkToWWsite":               result.recordset[i].LinkToWWsite,
                  "ProjectTypeID":              result.recordset[i].ProjectTypeID,
                  "DistrictID":              result.recordset[i].DistrictID,
                  "CityName":              result.recordset[i].CityName,
                  "ChurchName":              result.recordset[i].ChurchName,
                  "PastorName":              result.recordset[i].PastorName,
                  "PastorPhone":              result.recordset[i].PastorPhone,
                  "ProjectDesc":              result.recordset[i].ProjectDesc,
                  "ProjectPlans":              result.recordset[i].ProjectPlans,
                  "TeamDetailsID":              result.recordset[i].TeamDetailsID,
                  "ProjectCompleted":              result.recordset[i].ProjectCompleted,
                  "CountryID":              result.recordset[i].CountryID,
              });
            };
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
  res.render('allProjects', {ProjectsViewArray: ProjectsViewArray});
  res.end();
  });
});

app.get('/joinTeam', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var teamJoinArray = [];
  var checkTJ = new sql.Request();
  checkTJ.execute('ViewTeams').then(function(result){
      var len = result.recordset.length;
      for(var i = 0; i < len; i++){
                  teamJoinArray.push({
                  "TeamID":                       result.recordset[i].TeamID,
                  "TeamName":                   result.recordset[i].TeamName,
                  "ChurchName":               result.recordset[i].ChurchName,
                  "District":                   result.recordset[i].District,
                  "LeaderEmail":             result.recordset[i].LeaderEmail,
                  "LeaderName":               result.recordset[i].LeaderName
              });
            };
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
  res.render('joinTeam', {teamJoinArray: teamJoinArray});
  res.end();
  });
});

app.post('/joinAteam', function(req,res){
var NTMFName = req.body.NTMFName;
if(NTMFName == null || NTMFName == undefined || NTMFName.length === 0){
      NTMFName = 'None Provided';
}
var NTMPhoneNumber = req.body.NTMPhoneNumber;
if(NTMPhoneNumber == null || NTMPhoneNumber == undefined || NTMPhoneNumber.length === 0){
      NTMPhoneNumber = 'None Provided';
}
var NTMCountry = req.body.NTMCountry;
if(NTMCountry == null || NTMCountry == undefined || NTMCountry.length === 0){
      NTMCountry = 'None Provided';
}
var NTMDistrict = req.body.NTMDistrict;
if(NTMDistrict == null || NTMDistrict == undefined || NTMDistrict.length === 0){
      NTMDistrict = 'None Provided';
}
var NTMPreviousProjects = req.body.NTMPreviousProjects;
if(NTMPreviousProjects == null || NTMPreviousProjects == undefined || NTMPreviousProjects.length === 0){
      NTMPreviousProjects = 0;
}
var NTMSecondLanguage = req.body.NTMSecondLanguage;
if(NTMSecondLanguage == null || NTMSecondLanguage == undefined || NTMSecondLanguage.length === 0){
      NTMSecondLanguage = 1;
}
var NTMSkillsID =req.body.NTMSkillsID;
if(NTMSkillsID == null || NTMSkillsID == undefined || NTMSkillsID.length === 0){
      NTMSkillsID = 0;
}
var NTMTeamMemberTypeID = req.body.NTMTeamMemberTypeID;
if(NTMTeamMemberTypeID == null || NTMTeamMemberTypeID == undefined || NTMTeamMemberTypeID.length === 0){
      NTMTeamMemberTypeID = 0
}
var NTMTeamLeader = req.body.NTMTeamLeader;
if(NTMTeamLeader == null || NTMTeamLeader == undefined || NTMTeamLeader.length === 0){
      NTMTeamLeader = 0;
}
var TeamID = req.body.ttj;
if(TeamID == null || TeamID == undefined || TeamID.length === 0){
      TeamID = 0;
}
var NTMLastTrip = req.body.NTMLastTrip;
if(NTMLastTrip == null || NTMLastTrip == undefined || NTMLastTrip.length === 0){
      NTMLastTrip = '09/09/9999';
}
var NTMMale = req.body.NTMMale;
if(NTMMale == null || NTMMale == undefined || NTMMale.length === 0){
      NTMMale = 0;
}
var NTMFemale = req.body.NTMFemale;
if(NTMFemale == null || NTMFemale == undefined || NTMFemale.length === 0){
      NTMFemale = 0;
}
var NTMSpouseOnTeam = req.body.NTMSpouseOnTeam;
if(NTMSpouseOnTeam == null || NTMSpouseOnTeam == undefined || NTMSpouseOnTeam.length === 0){
    NTMSpouseOnTeam = 0;
}
var NTMPassPortExp = req.body.NTMPassPortExp;
if(NTMPassPortExp == null || NTMPassPortExp == undefined || NTMPassPortExp.length === 0){
      NTMPassPortExp = '09/09/9999';
}
var NTMFoodAllergies = req.body.NTMFoodAllergies;
if(NTMFoodAllergies == null || NTMFoodAllergies == undefined || NTMFoodAllergies.length === 0){
      NTMFoodAllergies = 'None Provided';
}
var NTMMedicalAllergies = req.body.NTMMedicalAllergies;
if(NTMMedicalAllergies == null || NTMMedicalAllergies == undefined || NTMMedicalAllergies.length === 0){
      NTMMedicalAllergies = 'None Provided';
}
var NTMDPI = req.body.NTMDPI;
if(NTMDPI== null || NTMDPI == undefined || NTMDPI.length === 0){
      NTMDPI = 'None Provided';
}
var NTMEmail = req.body.NTMEmail;
if(NTMEmail == null || NTMEmail == undefined || NTMEmail.length === 0){
      NTMEmail = 'None Provided';
}
var jat = new sql.Request();
const promise = new Promise(function (resolve, reject) {
jat.input('NTMFName', sql.NVARCHAR(255), NTMFName);
jat.input('NTMPhoneNumber', sql.NVARCHAR(255), NTMPhoneNumber);
jat.input('NTMCountry', sql.NVARCHAR(255), NTMCountry);
jat.input('NTMDistrict', sql.NVARCHAR(255), NTMDistrict);
jat.input('NTMPreviousProjects', sql.INT, NTMPreviousProjects);
jat.input('NTMSecondLanguage', sql.NVARCHAR(50), NTMSecondLanguage);
jat.input('NTMSkillsID', sql.INT, NTMSkillsID);
jat.input('NTMTeamMemberTypeID', sql.INT, NTMTeamMemberTypeID);
jat.input('NTMTeamLeader', sql.INT, NTMTeamLeader);
jat.input('NTMTeamID', sql.INT, TeamID);
jat.input('NTMLastTrip', sql.DATE, NTMLastTrip);
jat.input('NTMMale', sql.INT, NTMMale);
jat.input('NTMFemale',sql.INT, NTMFemale);
jat.input('NTMSpouseOnTeam', sql.INT, NTMSpouseOnTeam);
jat.input('NTMPassPortExp', sql.DATE, NTMPassPortExp);
jat.input('NTMFoodAllergies', sql.NVARCHAR(255), NTMFoodAllergies);
jat.input('NTMMedicalAllergies', sql.NVARCHAR(255), NTMMedicalAllergies);
jat.input('NTMDPI', sql.NVARCHAR(255), NTMDPI);
jat.input('NTMEmail', sql.NVARCHAR(255), NTMEmail);
jat.execute('AddTeamMember').then(function (result, recordset){
var flag = result.returnValue;
resolve(flag);
}).catch(function(error){
    console.log(error);
    sql.close();
    reject(error);
});
});
promise.then((verdict) => {
if (verdict === 1) {
        res.redirect('ScheduledTeamsView&Edit');
}
else{
    ids[0]=TeamID;
    ids[1]=NTMFName;
    ids[2]=NTMEmail;
    res.redirect('joinOnTDDuplicate');
}
});
});


app.get('/joinOnTDDuplicate', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var teamJoinArrayDup = [];
  var check = new sql.Request();
  check.input('NTMTeamID', sql.INT, ids[0]);
  check.execute('AddTeamMemberOnMultiple').then(function(result){
      var len = result.recordset.length;
      for(var i = 0; i < len; i++){
                  teamJoinArrayDup.push({
                  "TeamDetailsID":        result.recordset[i].TeamDetailsID,
                  "ProjectId":            result.recordset[i].ProjectId,
                  "NumTeamMemb":          result.recordset[i].NumTeamMemb
              });
            };
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
  //console.log(teamJoinArrayDup);
  res.render('joinOnTDDuplicate', {teamJoinArrayDup : teamJoinArrayDup});
  res.end();
  });
});
app.post('/TIDAssign', function(req,res){
  var TID = req.body.TeamDetailsIDToAssign;
  var teamJoinArrayDup = [];
  var check = new sql.Request();
  check.input('NTMTeamID', sql.INT, ids[0]);
  check.execute('AddTeamMemberOnMultiple').then(function(result){
      var ie = TID;
                  teamJoinArrayDup.push({
                  "TeamDetailsID":        result.recordset[ie].TeamDetailsID,
                  "ProjectId":            result.recordset[ie].ProjectId,
                  "NumTeamMemb":          result.recordset[ie].NumTeamMemb
              });
  var check20 = new sql.Request();
  var TeID = result.recordset[ie].TeamDetailsID;
  var PrID = result.recordset[ie].ProjectId;
  check20.input('NTMFName', sql.NVARCHAR(255), ids[1]);
  check20.input('NTMEmail', sql.NVARCHAR(255), ids[2]);
  check20.input('NTMTeamDetailsID', sql.INT, TeID);
  check20.input('NTMProjectID', sql.INT, PrID);
  check20.execute('AddTeamMemberOnMultipleWork').then(function(err){
    console.log(err);
  });
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
  res.redirect('/ScheduledTeamsView&Edit');
  res.end();
  });
});
app.get('/assignTeams', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var teamViewAssign = [];
  var check5 = new sql.Request();
  check5.execute('ViewTeams').then(function(result){
      var len = result.recordset.length;
      var c;
      for(var i = 0; i < len; i++){
                  c=i;
                  teamViewAssign.push({
                  "TeamID":       result.recordset[i].TeamID,
                  "TeamName":     result.recordset[i].TeamName,
                  "ChurchName":   result.recordset[i].ChurchName,
                  "District":     result.recordset[i].District,
                  "LeaderEmail":  result.recordset[i].LeaderEmail,
                  "LeaderName":   result.recordset[i].LeaderName
              });
            };
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
res.render('assignTeams', {teamViewAssign : teamViewAssign});
res.end();
});
});

app.post('/GetTeamIndex', function(req,res){
  indexA = req.body.RowForTeamToAssign;
  res.redirect('assignProject');
  res.end();
});

app.get('/assignProject', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var tableArrayAssignProject = [];
  var check5 = new sql.Request();
  check5.execute('ViewProjects').then(function(result){
      var len = result.recordset.length;

      for(var i = 0; i < len; i++){
                  tableArrayAssignProject.push({
                  "ProjectID":       result.recordset[i].ProjectID,
                  "TeamID":          result.recordset[i].TeamID,
                  "ChurchName":      result.recordset[i].ChurchName,
                  "Country":         result.recordset[i].Country,
                  "PastorName":      result.recordset[i].PastorName,
              });
            };
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
res.render('assignProject', {tableArrayAssignProject: tableArrayAssignProject});
res.end();
});
});
app.post('/GetProjectIndex', function(req, res){
  const promise1 = new Promise(function (resolve, reject) {
      indexP = req.body.RowForProjectToAssign;
      var teamID = indexA;
      var projectID = indexP;
      //console.log("A AND P INDEX TEST BOI");
      var nsr = new sql.Request()
      nsr.input('teamID',teamID);
      nsr.input('projectID',projectID);
      //console.log("EXEC AssignTeam" + " " + teamID + ", " + projectID + "")
      sql.query("EXEC AssignTeam" + " " + teamID + ", " + projectID + "").then(function(result){
        var flag = result.returnValue;
        resolve(flag);
    }).catch(function(error){
            console.log(error);
            sql.close();
            reject(error);
        });
    });
        promise1.then((flag) => {
        if (flag === 0) {
            res.redirect('AssignTeamOnDuplicate');
                   //double-check this
        }
        else{
            res.redirect('ScheduledTeamsView&Edit');
        }

});
});

app.get('/AssignTeamOnDuplicate', function(req, res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var teamViewAssignOpts = [];
  var check5 = new sql.Request();
  check5.execute('AssignTeam').then(function(result){
      var len = result.recordset.length;
      for(var i = 0; i < len; i++){
                  teamViewAssignOpts.push({
                  "TeamID":       result.recordset[i].TeamID,
                  "TeamName":     result.recordset[i].TeamName,
                  "ChurchName":   result.recordset[i].ChurchName,
                  "District":     result.recordset[i].District,
                  "LeaderEmail":  result.recordset[i].LeaderEmail,
                  "LeaderName":   result.recordset[i].LeaderName
              });
            };
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
teamViewAssignOpts=teamViewAssignOpts.filter(teamViewAssignOpts => teamViewAssignOpts.TeamID == indexA);
res.render('AssignTeamOnDuplicate', {teamViewAssignOpts: teamViewAssignOpts});
res.end();
});
});

app.post('AssignTeamOnDuplicate', function(req,res){
    var NewTeamID = req.body.newTeamID;
    var TeamDetailsID = req.body.TeamDetailsID;
    var pa = new sql.Request();
    pa.input('TeamID', sql.Int, NewTeamID);
    pa.input('ProjectID', sql.Int, indexP);
    pa.input('TeamDetailsID', sql.Int, TeamDetailsID);
    pa.execute('AssignTeamOnDuplicate');
    res.redirect('/');
});

app.get('/createTeam', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
    res.render('createTeam');
    res.end();
});

app.post('/create-Team', function(req,res){
    var NewTeamName = req.body.newTeamName;
    var NewChurchName = req.body.newChurchName;
    var NewDistrict = req.body.newDistrict;
    var NewLeaderEmail = req.body.newLeaderEmail;
    var NewLeaderName = req.body.newLeaderName;
    var ntq = new sql.Request();
    ntq.input('NewTeamName', sql.NVarChar(255), NewTeamName);
    ntq.input('NewChurchName', sql.NVarChar(255), NewChurchName);
    ntq.input('NewDistrict', sql.NVarChar(255), NewDistrict);
    ntq.input('NewLeaderEmail', sql.NVarChar(255), NewLeaderEmail);
    ntq.input('NewLeaderName', sql.NVarChar(255), NewLeaderName);
    ntq.execute('createNewTeam');
    res.redirect('/ScheduledTeamsView&Edit');
});

app.get('/createProject', function(req,res){
      var UsNm = req.session.user;
      console.log(req.sessionID);
      if(UsNm == null && sessionID == null){res.redirect('/')};
      console.log(`logged in as: ${UsNm}`);
      var check = new sql.Request();
      var WWcoordArray = [];
      check.query("SELECT * FROM WWCoordinator").then(function(result){
          var len = result.recordset.length;
          for(var i = 0; i < len; i++){
                WWcoordArray.push({
            "WWcoordID":     result.recordset[i].WWCoordID,
            "FullName":      result.recordset[i].FullName
          });
          }
          res.render('createProject', {WWcoordArray : WWcoordArray});
          res.end();
      });
        
    });
app.post('/create-Project', function(req,res){
    var NewWWCoorID = req.body.newWWCoorID;
    var NewDateReceived = req.body.newDateReceived;
    var NewLinkToWWsite = req.body.newLinkToWWsite;
    var NewUserPermission = req.body.newUserPermission;
    var NewProjectTypeID = req.body.newProjectTypeID;
    var NewDistrictID = req.body.newDistrictID;
    var NewCityName = req.body.newCityName;
    var NewPastorName = req.body.newPastorName;
    var NewPastorPhone = req.body.newPastorPhone;
    var NewLocationLink = req.body.newLocationLink;
    var NewDistanceFromDistrictOff = req.body.newDistanceFromDistrictOff;
    var NewDistrictBudgetCurrent = req.body.newDistrictBudgetCurrent;
    var NewDistrictBudgetLast = req.body.newDistrictBudgetLast;
    var NewFEMCurrent = req.body.newFEMCurrent;
    var NewFEMLast = req.body.newFEMLast;
    var NewDateOrganized = req.body.newDateOrganized;
    var NewMembersLast = req.body.newMembersLast;
    var NewMembersCurrent = req.body.newMembersCurrent;
    var NewAvgAttendanceLast = req.body.newAvgAttendanceLast;
    var NewAvgAttendanceCurent = req.body.newAvgAttendanceCurent;
    var NewProjectDesc = req.body.newProjectDesc;
    var NewTempleCapacity = req.body.newTempleCapacity;
    var NewRoofWidth = req.body.newRoofWidth;
    var NewRoofLength = req.body.newRoofLength;
    var NewBriefDescriptionConst = req.body.newBriefDescriptionConst;
    var NewPropertyWidth = req.body.newPropertyWidth;
    var NewPropertyLength = req.body.newPropertyLength;
    var NewPhotos = req.body.newPhotos;
    var NewDigital = req.body.newDigital;
    var NewLotLayout = req.body.newLotLayout;
    var NewProjectPlans = req.body.newProjectPlans;
    var NewMoneyRaised = req.body.NewMoneyRaised;
    var NewMoneyInvested = req.body.newMoneyInvested;
    var NewMoney12Months = req.body.newMoney12Months;
    var NewProjectNeed = req.body.newProjectNeed;
    var NewTitleToProperty = req.body.newTitleToProperty;
    var NewPropertyDeededToChurch = req.body.newPropertyDeededToChurch;
    var NewBuildingPermitNeeded = req.body.newBuildingPermitNeeded;
    var NewBuildingPermitApproved =req.body.newBuildingPermitApproved;
    var NewPastorApproved = req.body.newPastorApproved;
    var NewChurchBoardApproved = req.body.newChurchBoardApproved;
    var NewTreasureApproved = req.body.newTreasureApproved;
    var NewTreasureApprovedDate = req.body.NewTreasureApprovedDate;
    var NewSuperApproval = req.body.newSuperApproval;
    var NewSuperApprovalDate = req.body.newSuperApprovalDate;
    var NewDistrictSecretaryApproval = req.body.newDistrictSecretaryApproval;
    var NewDistrictTreasureApproval = req.body.newDistrictTreasureApproval;
    var NewDistrictTreasureApprovalDate = req.body.newDistrictTreasueApprovalDate;
    var NewDistrictPriority = req.body.newDistrictPriority;
    var NewTyTapproved = req.body.newTyTapproved;
    var NewTyTPriority = req.body.newTyTPriority;
    var NewProjectCompleted = req.body.newProjectCompleted;
    var NewWWLink = req.body.newWWLink;
    var NewPhotoLocation = req.body.newPhotoLocation;
    var NewPermitStart = req.body.newPermitStart;
    var NewPermitEnd = req.body.newPermitEnd;
    var NewCountryID = req.body.newCountryID;
if(NewWWCoorID == null || NewWWCoorID == undefined || NewWWCoorID.length === 0){
      NewWWCoorID = 0
}
if(NewDateReceived == null || NewDateReceived == undefined || NewDateReceived.length === 0){
      NewDateReceived = '09/09/9999'
}
if(NewLinkToWWsite == null || NewLinkToWWsite == undefined || NewLinkToWWsite.length === 0){
      NewLinkToWWsite = 'NONE PROVIDED'
}
if(NewUserPermission == null || NewUserPermission == undefined || NewUserPermission.length === 0){
      NewUserPermission = 'NONE PROVIDED'
}
if(NewProjectTypeID == null || NewProjectTypeID == undefined || NewProjectTypeID.length === 0){
      NewProjectTypeID = 0
}
if(NewDistrictID == null || NewDistrictID == undefined || NewDistrictID.length === 0){
      NewDistrictID = 0
}
if(NewCityName == null || NewCityName == undefined || NewCityName.length === 0){
      NewCityName = 'NONE PROVIDED'
}
if(NewPastorName == null || NewPastorName == undefined || NewPastorName.length === 0){
      NewPastorName = 'NONE PROVIDED'
}
if(NewPastorPhone == null || NewPastorPhone == undefined || NewPastorPhone.length === 0){
      NewPastorPhone = 'NONE PROVIDED'
}
if(NewLocationLink == null || NewLocationLink == undefined || NewLocationLink.length === 0){
      NewLocationLink = 'NONE PROVIDED'
}
if(NewDistanceFromDistrictOff == null || NewDistanceFromDistrictOff == undefined || NewDistanceFromDistrictOff.length === 0){
      NewDistanceFromDistrictOff = 0
}
if(NewDistrictBudgetCurrent == null || NewDistrictBudgetCurrent == undefined || NewDistrictBudgetCurrent.length === 0){
      NewDistrictBudgetCurrent = 0
}
if(NewDistrictBudgetLast == null || NewDistrictBudgetLast == undefined || NewDistrictBudgetLast.length === 0){
      NewDistrictBudgetLast = 0
}
if(NewFEMCurrent == null || NewFEMCurrent == undefined || NewFEMCurrent.length === 0){
      NewFEMCurrent = 0
}
if(NewFEMLast == null || NewFEMLast == undefined || NewFEMLast.length === 0){
      NewFEMLast = 0
}
if(NewDateOrganized == null || NewDateOrganized == undefined || NewDateOrganized.length === 0){
      NewDateOrganized = '09/09/9999'
}
if(NewMembersLast == null || NewMembersLast == undefined || NewMembersLast.length === 0){
      NewMembersLast = 0
}
if(NewMembersCurrent == null || NewMembersCurrent == undefined || NewMembersCurrent.length === 0){
      NewMembersCurrent = 0
}
if(NewAvgAttendanceLast == null || NewAvgAttendanceLast == undefined || NewAvgAttendanceLast.length === 0){
      NewAvgAttendanceLast = 0
}
if(NewAvgAttendanceCurent == null || NewAvgAttendanceCurent == undefined || NewAvgAttendanceCurent.length === 0){
      NewAvgAttendanceCurent = 0
}
if(NewProjectDesc == null || NewProjectDesc == undefined || NewProjectDesc.length === 0){
      NewProjectDesc = 'NONE PROVIDED'
}
if(NewTempleCapacity == null || NewTempleCapacity == undefined || NewTempleCapacity.length === 0){
      NewTempleCapacity = 0
}
if(NewRoofWidth == null || NewRoofWidth == undefined || NewRoofWidth.length === 0){
      NewRoofWidth = 0
}
if(NewRoofLength == null || NewRoofLength == undefined || NewRoofLength.length === 0){
      NewRoofLength = 0
}
if(NewBriefDescriptionConst == null || NewBriefDescriptionConst == undefined || NewBriefDescriptionConst.length === 0){
      NewBriefDescriptionConst = 'NONE PROVIDED'
}
if(NewPropertyWidth == null || NewPropertyWidth == undefined || NewPropertyWidth.length === 0){
      EMFName = 0
}
if(NewPropertyLength == null || NewPropertyLength == undefined || NewPropertyLength.length === 0){
      NewPropertyLength = 0
}
if(NewPhotos == null || NewPhotos == undefined || NewPhotos.length === 0){
      NewPhotos = 1
}
if(NewDigital == null || NewDigital == undefined || NewDigital.length === 0){
      NewDigital = 1
}
if(NewLotLayout == null || NewLotLayout == undefined || NewLotLayout.length === 0){
      NewLotLayout = 1
}
if(NewProjectPlans == null || NewProjectPlans == undefined || NewProjectPlans.length === 0){
      NewProjectPlans = 1
}
if(NewMoneyRaised == null || NewMoneyRaised == undefined || NewMoneyRaised.length === 0){
      NewMoneyRaised = 0.00
}
if(NewMoneyInvested == null || NewMoneyInvested == undefined || NewMoneyInvested.length === 0){
      NewMoneyInvested = 0.00
}
if(NewMoney12Months == null || NewMoney12Months == undefined || NewMoney12Months.length === 0){
      NewMoney12Months = 0.00
}
if(NewProjectNeed == null || NewProjectNeed == undefined || NewProjectNeed.length === 0){
      NewProjectNeed = 'NONE PROVIDED'
}
if(NewTitleToProperty == null || NewTitleToProperty == undefined || NewTitleToProperty.length === 0){
      NewTitleToProperty = 0
}
if(NewPropertyDeededToChurch == null || NewPropertyDeededToChurch == undefined || NewPropertyDeededToChurch.length === 0){
      NewPropertyDeededToChurch = 0
}
if(NewBuildingPermitNeeded == null || NewBuildingPermitNeeded == undefined || NewBuildingPermitNeeded.length === 0){
      NewBuildingPermitNeeded = 1
}
if(NewBuildingPermitApproved == null || NewBuildingPermitApproved == undefined || NewBuildingPermitApproved.length === 0){
      NewBuildingPermitApproved = 0
}
if(NewPastorApproved == null || NewPastorApproved == undefined || NewPastorApproved.length === 0){
      NewPastorApproved = 0
}
if(NewChurchBoardApproved == null || NewChurchBoardApproved == undefined || NewChurchBoardApproved.length === 0){
      NewChurchBoardApproved = 0
}
if(NewTreasureApproved == null || NewTreasureApproved == undefined || NewTreasureApproved.length === 0){
      NewTreasureApproved = 0
}
if(NewTreasureApprovedDate == null || NewTreasureApprovedDate == undefined || NewTreasureApprovedDate.length === 0){
      NewTreasureApprovedDate = '09/09/9999'
}
if(NewSuperApproval == null || NewSuperApproval == undefined || NewSuperApproval.length === 0){
      NewSuperApproval = 0
}
if(NewSuperApprovalDate == null || NewSuperApprovalDate == undefined || NewSuperApprovalDate.length === 0){
      NewSuperApprovalDate = '09/09/9999'
}
if(NewDistrictSecretaryApproval == null || NewDistrictSecretaryApproval == undefined || NewDistrictSecretaryApproval.length === 0){
      NewDistrictSecretaryApproval = 0
}
if(NewDistrictTreasureApproval == null || NewDistrictTreasureApproval == undefined || NewDistrictTreasureApproval.length === 0){
      NewDistrictTreasureApproval = 0
}
if(NewDistrictTreasureApprovalDate == null || NewDistrictTreasureApprovalDate == undefined || NewDistrictTreasureApprovalDate.length === 0){
      NewDistrictTreasureApprovalDate = '09/09/9999'
}
if(NewDistrictPriority == null || NewDistrictPriority == undefined || NewDistrictPriority.length === 0){
      NewDistrictPriority = 0
}
if(NewTyTapproved == null || NewTyTapproved == undefined || NewTyTapproved.length === 0){
      NewTyTapproved = 0
}
if(NewTyTPriority == null || NewTyTPriority == undefined || NewTyTPriority.length === 0){
      NewTyTPriority = 0
}
if(NewProjectCompleted == null || NewProjectCompleted == undefined || NewProjectCompleted.length === 0){
      NewProjectCompleted = 0
}
if(NewWWLink == null || NewWWLink == undefined || NewWWLink.length === 0){
      NewWWLink = 'NONE PROVIDED'
}
if(NewPhotoLocation == null || NewPhotoLocation == undefined || NewPhotoLocation.length === 0){
      NewPhotoLocation = 'NONE PROVIDED'
}
if(NewPermitStart == null || NewPermitStart == undefined || NewPermitStart.length === 0){
      NewPermitStart = '09/09/9999'
}
if(NewPermitEnd == null || NewPermitEnd == undefined || NewPermitEnd.length === 0){
      NewPermitEnd = '09/09/9999'
}
if(NewCountryID == null || NewCountryID == undefined || NewCountryID.length === 0){
      NewCountryID = 0
}

var npq = new sql.Request();
    npq.input('NewWWCoorID', sql.Int, NewWWCoorID);
    npq.input('NewDateRecieved', sql.Date, NewDateReceived);
    npq.input('NewLinkToWWsite', sql.NVarChar(255), NewLinkToWWsite);
    npq.input('NewUserPermission', sql.NVarChar(255), NewUserPermission);
    npq.input('NewProjectTypeID', sql.Int, NewProjectTypeID);
    npq.input('NewDistrictID', sql.Int, NewDistrictID);
    npq.input('NewCityName', sql.NVarChar(255), NewCityName);
    npq.input('NewPastorName', sql.NVarChar(255), NewPastorName);
    npq.input('NewPastorPhone', sql.NVarChar(255), NewPastorPhone);
    npq.input('NewLocationLink', sql.NVarChar(255), NewLocationLink);
    npq.input('NewDistanceFromDistrictOff', sql.NVarChar(255), NewDistanceFromDistrictOff);
    npq.input('NewDistrictBudgetCurrent', sql.Money, NewDistrictBudgetCurrent);
    npq.input('NewDistrictBudgetLast', sql.Money, NewDistrictBudgetLast);
    npq.input('NewFEMCurrent', sql.Money, NewFEMCurrent);
    npq.input('NewFEMLast', sql.Money, NewFEMLast);
    npq.input('NewDateOrganized', sql.Date, NewDateOrganized);
    npq.input('NewMembersLast', sql.Int, NewMembersLast);
    npq.input('NewMembersCurrent', sql.Int, NewMembersCurrent);
    npq.input('NewAvgAttendanceLast', sql.Int, NewAvgAttendanceLast);
    npq.input('NewAvgAttendanceCurent', sql.Int, NewAvgAttendanceCurent);
    npq.input('NewProjectDesc', sql.NVarChar(255), NewProjectDesc);
    npq.input('NewTempleCapacity', sql.Int, NewTempleCapacity);
    npq.input('NewRoofWidth', sql.Int, NewRoofWidth);
    npq.input('NewRoofLength', sql.Int, NewRoofLength);
    npq.input('NewBriefDescriptionConst', sql.NVarChar(255), NewBriefDescriptionConst);
    npq.input('NewPropertyWidth', sql.Int, NewPropertyWidth);
    npq.input('NewPropertyLength', sql.Int, NewPropertyLength);
    npq.input('NewPhotos', sql.Int, NewPhotos);
    npq.input('NewDigital', sql.Int, NewDigital);
    npq.input('NewLotLayout', sql.Int, NewLotLayout);
    npq.input('NewProjectPlans', sql.Int, NewProjectPlans);
    npq.input('NewMoneyRaised', sql.Money, NewMoneyRaised);
    npq.input('NewMoneyInvested', sql.Money, NewMoneyInvested);
    npq.input('NewMoney12Months', sql.Money, NewMoney12Months);
    npq.input('NewProjectNeed', sql.NVarChar(255), NewProjectNeed);
    npq.input('NewTitleToProperty', sql.Int, NewTitleToProperty);
    npq.input('NewPropertyDeededToChurch', sql.Int, NewPropertyDeededToChurch);
    npq.input('NewBuildingPermitNeeded', sql.Int, NewBuildingPermitNeeded);
    npq.input('NewBuildingPermitApproved', sql.Int, NewBuildingPermitApproved);
    npq.input('NewPastorApproved', sql.Int, NewPastorApproved);
    npq.input('NewChurchBoardApproved', sql.Int, NewChurchBoardApproved);
    npq.input('NewTreasureApproved', sql.Int, NewTreasureApproved);
    npq.input('NewTreasureApprovedDate', sql.Date, NewTreasureApprovedDate);
    npq.input('NewSuperApproval', sql.Int, NewSuperApproval);
    npq.input('NewSuperApprovalDate', sql.Date, NewSuperApprovalDate);
    npq.input('NewDistrictSecretaryApproval', sql.Int, NewDistrictSecretaryApproval);
    npq.input('NewDistrictTreasureApproval', sql.Int, NewDistrictTreasureApproval);
    npq.input('NewDistrictTreasureApprovalDate', sql.Date, NewDistrictTreasureApprovalDate);
    npq.input('NewDistrictPriority', sql.Int, NewDistrictPriority);
    npq.input('NewTyTapproved', sql.Int, NewTyTapproved);
    npq.input('NewTyTPriority', sql.Int, NewTyTPriority);
    npq.input('NewProjectCompleted', sql.Int, NewProjectCompleted);
    npq.input('NewWwLink', sql.NVarChar(255), NewWWLink);
    npq.input('NewPhotoLocation', sql.NVarChar(255), NewPhotoLocation);
    npq.input('NewPermitStart', sql.Date, NewPermitStart);
    npq.input('NewPermitEnd', sql.Date, NewPermitEnd);
    npq.input('NewCountryID', sql.Int, NewCountryID);
    npq.execute('createNewProject');
    res.redirect('/ScheduledTeamsView&Edit');

});

app.get('/viewTeamMembers', function(req,res){
  var viewMem = new sql.Request();
  var MembersArray = [];
  var TeamID = indexV;
  viewMem.input('TeamID', sql.Int, TeamID);
  viewMem.execute('ViewTeamMembers').then(function(result){
    var len = result.recordset.length;
    for(var i = 0; i < len; i++){
      if(result.recordset[i].TeamID != indexV){
        //console.log("searching...");
      }
      else{
                MembersArray.push({
                "TeamMemberID":       result.recordset[i].TeamMemberID,
                "FName":     result.recordset[i].FName,
                "PhoneNumber":   result.recordset[i].PhoneNumber,
                "District":     result.recordset[i].District,
                "Email":  result.recordset[i].Email,
                "FoodAllergies":   result.recordset[i].FoodAllergies,
                "MedicalAllergies":  result.recordset[i].MedicalAllergies
            });
          };
    };
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
res.render('viewTeamMembers', {MembersArray : MembersArray});
res.end();
});
});

app.post('/getMemberID', function(req,res){
  indexE = req.body.RowForMemberToEdit;
  indexD = req.body.RowForMemberToDelete;
  if(indexD == undefined){
    res.redirect('editTeamMember');
  }
  else{
    res.redirect('deleteTeamMember');
  }

});

app.get('/editTeamMember', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var tableArrayEditMember = [];
  //const promise4 = new Promise(function(resolve, reject) {
  var check7 = new sql.Request();
  check7.input('TeamID', sql.Int, indexV);
  check7.execute('ViewTeamMembers').then(function(result){
      var ie = indexE;
                  tableArrayEditMember.push({
                  "TeamMemberID":           result.recordset[ie].TeamMemberID,
                  "FName":                  result.recordset[ie].FName,
                  "PhoneNumber":            result.recordset[ie].PhoneNumber,
                  "Country":                result.recordset[ie].Country,
                  "District":               result.recordset[ie].District,
                  "PreviousProjects":       result.recordset[ie].PreviousProjects,
                  "SecondLanguage":         result.recordset[ie].SecondLanguage,
                  "SkillsID":               result.recordset[ie].SkillsID,
                  "TeamMemberTypeID":       result.recordset[ie].TeamMemberTypeID,
                  "TeamLeader":             result.recordset[ie].TeamLeader,
                  "TeamID":                 result.recordset[ie].TeamID,
                  "LastTrip":               result.recordset[ie].LastTrip,
                  "Male":                   result.recordset[ie].Male,
                  "Female":                 result.recordset[ie].Female,
                  "SpouseOnTeam":           result.recordset[ie].SpouseOnTeam,
                  "PassPortExp":            result.recordset[ie].PassPortExp,
                  "FoodAllergies":          result.recordset[ie].FoodAllergies,
                  "MedicalAllergies":       result.recordset[ie].MedicalAllergies,
                  "DPI":                    result.recordset[ie].DPI,
                  "Email":                  result.recordset[ie].Email
              });
              //console.log(tableArrayEditMember);
              ids[0] =  result.recordset[ie].TeamMemberID;
              ids[1] =  result.recordset[ie].TeamID;
              defaults[0] = result.recordset[ie].FName;
              defaults[1] = result.recordset[ie].PhoneNumber;
              defaults[2] = result.recordset[ie].Country;
              defaults[3] = result.recordset[ie].District;
              defaults[5] = result.recordset[ie].PreviousProjects;
              defaults[6] = result.recordset[ie].SecondLanguage;
              defaults[7] = result.recordset[ie].SkillsID;
              defaults[8] = result.recordset[ie].TeamMemberTypeID;
              defaults[9] = result.recordset[ie].TeamLeader;
              defaults[10] = result.recordset[ie].TeamID;
              defaults[11] = result.recordset[ie].LastTrip;
              defaults[12] = result.recordset[ie].Male;
              defaults[13] = result.recordset[ie].Female;
              defaults[14] = result.recordset[ie].SpouseOnTeam;
              defaults[15] = result.recordset[ie].PassPortExp;
              defaults[16] = result.recordset[ie].FoodAllergies;
              defaults[17] = result.recordset[ie].MedicalAllergies;
              defaults[18] = result.recordset[ie].DPI;
              defaults[19] = result.recordset[ie].Email;
              res.render('editTeamMember', {tableArrayEditMember : tableArrayEditMember});

})
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
//res.end();
});



app.post('/edit-Member', function(req,res){
    var EMtid = ids[0];
    TIFref = EMtid;
    //console.log(EMtid);
    var EMFName = req.body.EMFName;
    var EMPhoneNumber = req.body.EMPhoneNumber;
    var EMCountry = req.body.EMCountry;
    var EMDistrict = req.body.EMDistrict;
    var EMPreviousProjects = req.body.EMPreviousProjects;
    var EMSecondLanguage = req.body.EMSecondLanguage;
    var EMSkillsID = req.body.EMSkillsID;
    var EMTeamMemberTypeID = req.body.EMTeamMemberTypeID;
    var EMTeamLeader = req.body.EMTeamLeader;
    var EMTeamID = req.body.EMTeamID;
    var EMLastTrip = req.body.EMLastTrip;
    var EMMale = req.body.EMMale;
    var EMFemale = req.body.EMFemale;
    var EMSpouseOnTeam = req.body.EMSpouseOnTeam;
    var EMPassPortExp = req.body.EMPassPortExp;
    var EMFoodAllergies = req.body.EMFoodAllergies;
    var EMMedicalAllergies = req.body.EMMedicalAllergies;
    var EMdpi = req.body.EMDPI;
    var EMEmail = req.body.EMEmail;
    if(EMFName == null || EMFName == undefined || EMFName.length === 0){
          EMFName = defaults[0];
    }
    if(EMPhoneNumber == null || EMPhoneNumber == undefined || EMPhoneNumber.length === 0){
          EMPhoneNumber = defaults[1];
    }
    if(EMCountry == null || EMCountry == undefined || EMCountry.length === 0){
          EMCountry = defaults[2];
    }
    if(EMDistrict == null || EMDistrict == undefined || EMDistrict.length === 0){
          EMDistrict = defaults[3];
    }
    if(EMPreviousProjects == null || EMPreviousProjects == undefined || EMPreviousProjects.length === 0){
          EMPreviousProjects = defaults[5];
    }
    if(EMSecondLanguage == null || EMSecondLanguage == undefined || EMSecondLanguage.length === 0){
          EMSecondLanguage = defaults[6];
    }
    if(EMSkillsID == null || EMSkillsID == undefined || EMSkillsID.length === 0){
          EMSkillsID = defaults[7];
    }
    if(EMTeamMemberTypeID == null || EMTeamMemberTypeID == undefined || EMTeamMemberTypeID.length === 0){
          EMTeamMemberTypeID = defaults[8];
    }
    if(EMTeamLeader == null || EMTeamLeader == undefined || EMTeamLeader.length === 0){
          EMTeamLeader = defaults[9];
    }
    if(EMTeamID == null || EMTeamID == undefined || EMTeamID.length === 0){
          EMTeamID = defaults[10];
    }
    if(EMLastTrip == null || EMLastTrip == undefined || EMLastTrip.length === 0){
          EMLastTrip = defaults[11];
    }
    if(EMMale == null || EMMale == undefined || EMMale.length === 0){
          EMMale = defaults[12];
    }
    if(EMFemale == null || EMFemale == undefined || EMFemale.length === 0){
          EMFemale = defaults[13];
    }
    if(EMSpouseOnTeam == null || EMSpouseOnTeam == undefined || EMSpouseOnTeam.length === 0){
          EMSpouseOnTeam = defaults[14];
    }
    if(EMPassPortExp == null || EMPassPortExp == undefined || EMPassPortExp.length === 0){
          EMPassPortExp = defaults[15];
    }
    if(EMFoodAllergies == null || EMFoodAllergies == undefined || EMFoodAllergies.length === 0){
          EMFoodAllergies = defaults[16];
    }
    if(EMMedicalAllergies == null || EMMedicalAllergies == undefined || EMMedicalAllergies.length === 0){
          EMMedicalAllergies = defaults[17];
    }
    if(EMdpi == null || EMdpi == undefined || EMdpi.length === 0){
          EMdpi = defaults[18];
    }
    if(EMEmail == null || EMEmail == undefined || EMEmail.length === 0){
          EMEmail = defaults[19];
    }

    var em = new sql.Request();
    em.input('EMTID', sql.Int, EMtid);
    em.input('EMFName', sql.NVarChar(255), EMFName);
    em.input('EMPhoneNumber',sql.NVarChar(255), EMPhoneNumber);
    em.input('EMCountry', sql.NVarChar(255), EMCountry);
    em.input('EMDistrict', sql.NVarChar(255), EMDistrict);
    em.input('EMPreviousProjects', sql.Int, EMPreviousProjects);
    em.input('EMSecondLanguage', sql.NVarChar(50),EMSecondLanguage);
    em.input('EMSkillsID', sql.Int, EMSkillsID);
    em.input('EMTeamMemberTypeID', sql.Int, EMTeamMemberTypeID);
    em.input('EMTeamLeader', sql.Int, EMTeamLeader);
    em.input('EMTeamID', sql.Int, EMTeamID);
    em.input('EMLastTrip', sql.Date, EMLastTrip);
    em.input('EMMale', sql.Int,EMMale);
    em.input('EMFemale', sql.Int, EMFemale);
    em.input('EMSpouseOnTeam', sql.Int, EMSpouseOnTeam);
    em.input('EMPassPortExp', sql.Date, EMPassPortExp);
    em.input('EMFoodAllergies', sql.NVarChar(255), EMFoodAllergies);
    em.input('EMMedicalAllergies', sql.NVarChar(255), EMMedicalAllergies);
    em.input('EMDPI', sql.NVarChar(255), EMdpi);
    em.input('EMEmail', sql.NVarChar(255), EMEmail);
    em.execute('EditTeamMember').then(function(err){
      console.log(err);
    });
    res.redirect('editMemberTeam');
});

app.get('/editMemberTeam', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var teamViewArray = [];
  var check5 = new sql.Request();
  check5.execute('ViewTeams').then(function(result){
      var len = result.recordset.length;
      for(var i = 0; i < len; i++){
                  c=i;
                  teamViewArray.push({
                  "TeamID":       result.recordset[i].TeamID,
                  "TeamName":     result.recordset[i].TeamName,
                  "ChurchName":   result.recordset[i].ChurchName,
                  "District":     result.recordset[i].District,
                  "LeaderEmail":  result.recordset[i].LeaderEmail,
                  "LeaderName":   result.recordset[i].LeaderName,
              });
            };
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
res.render('editMemberTeam', {teamViewArray: teamViewArray});
res.end();
});
});
app.post('/editMemberAssign', function(req,res){
  var TMid = TIFref;
  var TeamID = req.body.ttj;
  var Atm = new sql.Request();
  Atm.input('TMID', sql.Int, TMid);
  Atm.input('TeamID', sql.Int, TeamID);
  Atm.execute('EditMemberTeam').then(function(err){
    console.log(err);
  })
  res.redirect('ScheduledTeamsView&Edit');
});


app.get('/deleteTeamMember', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var tableArrayDeleteMember = [];
  //const promise4 = new Promise(function(resolve, reject) {
  var check7 = new sql.Request();
  check7.input('TeamID', sql.Int, indexV);
  check7.execute('ViewTeamMembers').then(function(result){
      var ie = indexD;
                  tableArrayDeleteMember.push({
                  "TeamMemberID":           result.recordset[ie].TeamMemberID,
                  "FName":                  result.recordset[ie].FName,
                  "PhoneNumber":            result.recordset[ie].PhoneNumber,
                  "Country":                result.recordset[ie].Country,
                  "District":               result.recordset[ie].District,
                  "PreviousProjects":       result.recordset[ie].PreviousProjects,
                  "SecondLanguage":         result.recordset[ie].SecondLanguage,
                  "SkillsID":               result.recordset[ie].SkillsID,
                  "TeamMemberTypeID":       result.recordset[ie].TeamMemberTypeID,
                  "TeamLeader":             result.recordset[ie].TeamLeader,
                  "TeamID":                 result.recordset[ie].TeamID,
                  "LastTrip":               result.recordset[ie].LastTrip,
                  "Male":                   result.recordset[ie].Male,
                  "Female":                 result.recordset[ie].Female,
                  "SpouseOnTeam":           result.recordset[ie].SpouseOnTeam,
                  "PassPortExp":            result.recordset[ie].PassPortExp,
                  "FoodAllergies":          result.recordset[ie].FoodAllergies,
                  "MedicalAllergies":       result.recordset[ie].MedicalAllergies,
                  "DPI":                    result.recordset[ie].DPI,
                  "Email":                  result.recordset[ie].Email
              });
  res.render('deleteTeamMember', {tableArrayDeleteMember : tableArrayDeleteMember});
});
});

app.post('/delete-Member', function(req,res){
  var TMID = req.body.RowForMemberToDelete;
  var check = new sql.Request();
  check.input('NewTeamMemberID', sql.Int, TMID);
  check.execute('DeleteTeamMember').then(function(err){
    if(err){console.log(err);}
  });
  res.redirect('ScheduledTeamsView&Edit');
});


app.post('/getProjectID', function(req,res){
  indexE = req.body.RowForEditProject;
  indexD = req.body.RowForDeleteProject;
  if(indexD == undefined){
    res.redirect('editProject');
  }
  else{
    res.redirect('deleteProject');
  }
});

app.get('/editProject', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var tableArrayEditProject = [];
  //const promise4 = new Promise(function(resolve, reject) {
  var check = new sql.Request();
  check.execute('ViewProjects').then(function(result){
      var ie = indexE;
                  PIDref = result.recordset[ie].ProjectID;
                  tableArrayEditProject.push({
                  "ProjectID":           result.recordset[ie].ProjectID,
                  "WWCoorID":                  result.recordset[ie].WWCoorID,
                  "DateRecieved":            result.recordset[ie].DateRecieved,
                  "LinkToWWsite":                result.recordset[ie].LinkToWWsite,
                  "UserPermission":               result.recordset[ie].UserPermission,
                  "ProjectTypeID":              result.recordset[ie].ProjectTypeID,
                  "DistrictID":       result.recordset[ie].DistrictID,
                  "CityName":         result.recordset[ie].CityName,
                  "PastorName":       result.recordset[ie].PastorName,
                  "PastorPhone":             result.recordset[ie].PastorPhone,
                  "LocationLink":               result.recordset[ie].LocationLink,
                  "DistanceFromDistrictOff":                   result.recordset[ie].DistanceFromDistrictOff,
                  "DistrictBudgetCurrent":                 result.recordset[ie].DistrictBudgetCurrent,
                  "DistrictBudgetLast":           result.recordset[ie].DistrictBudgetLast,
                  "FEMCurrent":            result.recordset[ie].FEMCurrent,
                  "FEMLast":          result.recordset[ie].FEMLast,
                  "DateOrganized":       result.recordset[ie].DateOrganized,
                  "MembersLast":                    result.recordset[ie].MembersLast,
                  "MembersCurrent":                  result.recordset[ie].MembersCurrent,
                  "AvgAttendanceLast":       result.recordset[ie].AvgAttendanceLast,
                  "AvgAttendanceCurent":         result.recordset[ie].AvgAttendanceCurent,
                  "ProjectDesc":               result.recordset[ie].ProjectDesc,
                  "TempleCapacity":       result.recordset[ie].TempleCapacity,
                  "RoofWidth":             result.recordset[ie].RoofWidth,
                  "RoofLength":                 result.recordset[ie].RoofLength,
                  "BriefDescriptionConst":               result.recordset[ie].BriefDescriptionConst,
                  "PropertyWidth":                   result.recordset[ie].PropertyWidth,
                  "PropertyLength":                 result.recordset[ie].PropertyLength,
                  "Photos":           result.recordset[ie].Photos,
                  "Digital":            result.recordset[ie].Digital,
                  "LotLayout":          result.recordset[ie].LotLayout,
                  "ProjectPlans":       result.recordset[ie].ProjectPlans,
                  "MoneyRaised":                    result.recordset[ie].MoneyRaised,
                  "MoneyInvested":                  result.recordset[ie].MoneyInvested,
                  "Money12Months":       result.recordset[ie].Money12Months,
                  "ProjectNeed":         result.recordset[ie].ProjectNeed,
                  "TitleToProperty":               result.recordset[ie].TitleToProperty,
                  "PropertyDeededToChurch":       result.recordset[ie].PropertyDeededToChurch,
                  "BuildingPermitNeeded":             result.recordset[ie].BuildingPermitNeeded,
                  "BuildingPermitApproved":                 result.recordset[ie].BuildingPermitApproved,
                  "PastorApproved":               result.recordset[ie].PastorApproved,
                  "ChurchBoardApproved":                   result.recordset[ie].ChurchBoardApproved,
                  "TreasureApproved":                 result.recordset[ie].TreasureApproved,
                  "TreasureApprovedDate":           result.recordset[ie].TreasureApprovedDate,
                  "SuperApproval":            result.recordset[ie].SuperApproval,
                  "SuperApprovalDate":          result.recordset[ie].SuperApprovalDate,
                  "DistrictSecretaryApproval":       result.recordset[ie].DistrictSecretaryApproval,
                  "DistrictTreasureApproval":                    result.recordset[ie].DistrictTreasureApproval,
                  "DistrictTreasureApprovalDate":                  result.recordset[ie].DistrictTreasureApprovalDate,
                  "DistrictPriority":           result.recordset[ie].DistrictPriority,
                  "TyTapproved":          result.recordset[ie].TyTapproved,
                  "TyTPriority":       result.recordset[ie].TyTPriority,
                  "ProjectCompleted":                    result.recordset[ie].ProjectCompleted,
                  "Wwlink":          result.recordset[ie].Wwlink,
                  "PhotoLocation":       result.recordset[ie].PhotoLocation,
                  "PermitStart":                    result.recordset[ie].PermitStart,
                  "PermitEnd":       result.recordset[ie].PermitEnd,
                  "CountryID":                    result.recordset[ie].CountryID,
                  "ChurchID":                       result.recordset[ie].ChurchID
              });
  //The above loop creates an array of objects...
  //...which is easily rendered on the client side upon redirect and rendering
  //console.log(tableArrayEditProject);
  TIDref = result.recordset[ie].ProjectID;
  ids[0] =  result.recordset[ie].ProjectID;
  defaults[0] = result.recordset[ie].WWCoorID;
  defaults[1] = result.recordset[ie].DateRecieved;
  defaults[2] = result.recordset[ie].LinkToWWsite;
  defaults[3] = result.recordset[ie].UserPermission;
  defaults[4] = result.recordset[ie].ProjectTypeID;
  defaults[5] = result.recordset[ie].DistrictID;
  defaults[6] = result.recordset[ie].CityName;
  defaults[8] = result.recordset[ie].PastorName;
  defaults[9] = result.recordset[ie].PastorPhone;
  defaults[11] = result.recordset[ie].LocationLink;
  defaults[12] = result.recordset[ie].DistanceFromDistrictOff;
  defaults[13] = result.recordset[ie].DistrictBudgetCurrent;
  defaults[14] = result.recordset[ie].DistrictBudgetLast;
  defaults[15] = result.recordset[ie].FEMCurrent;
  defaults[16] = result.recordset[ie].FEMLast;
  defaults[17] = result.recordset[ie].DateOrganized;
  defaults[18] = result.recordset[ie].MembersLast;
  defaults[19] = result.recordset[ie].MembersCurrent;
  defaults[20] = result.recordset[ie].AvgAttendanceLast;
  defaults[21] = result.recordset[ie].AvgAttendanceCurent;
  defaults[22] = result.recordset[ie].ProjectDesc;
  defaults[23] = result.recordset[ie].TempleCapacity;
  defaults[24] = result.recordset[ie].RoofWidth;
  defaults[25] = result.recordset[ie].RoofLength;
  defaults[26] = result.recordset[ie].BriefDescriptionConst;
  defaults[27] = result.recordset[ie].PropertyWidth;
  defaults[28] = result.recordset[ie].PropertyLength;
  defaults[29] = result.recordset[ie].Photos;
  defaults[30] = result.recordset[ie].Digital;
  defaults[31] = result.recordset[ie].LotLayout;
  defaults[32] = result.recordset[ie].ProjectPlans;
  defaults[33] = result.recordset[ie].MoneyRaised;
  defaults[34] = result.recordset[ie].MoneyInvested;
  defaults[35] = result.recordset[ie].Money12Months;
  defaults[36] = result.recordset[ie].ProjectNeed;
  defaults[37] = result.recordset[ie].TitleToProperty;
  defaults[38] = result.recordset[ie].PropertyDeededToChurch;
  defaults[39] = result.recordset[ie].BuildingPermitNeeded;
  defaults[40] = result.recordset[ie].BuildingPermitApproved;
  defaults[41] = result.recordset[ie].PastorApproved;
  defaults[42] = result.recordset[ie].ChurchBoardApproved;
  defaults[43] = result.recordset[ie].TreasureApproved;
  defaults[44] = result.recordset[ie].TreasureApprovedDate;
  defaults[45] = result.recordset[ie].SuperApproval;
  defaults[46] = result.recordset[ie].SuperApprovalDate;
  defaults[47] = result.recordset[ie].DistrictSecretaryApproval;
  defaults[48] = result.recordset[ie].DistrictTreasureApproval;
  defaults[49] = result.recordset[ie].DistrictTreasureApprovalDate;
  defaults[50] = result.recordset[ie].DistrictPriority;
  defaults[51] = result.recordset[ie].TyTapproved;
  defaults[52] = result.recordset[ie].TyTPriority;
  defaults[53] = result.recordset[ie].ProjectCompleted;
  defaults[54] = result.recordset[ie].Wwlink;
  defaults[55] = result.recordset[ie].PhotoLocation;
  defaults[56] = result.recordset[ie].PermitStart;
  defaults[57] = result.recordset[ie].PermitEnd;
  defaults[58] = result.recordset[ie].CountryID;
  defaults[59] = result.recordset[ie].ChurchID;
  res.render('editProject', {tableArrayEditProject : tableArrayEditProject});
  res.end();
});
});


app.post('/edit-Project', function(req,res){
  var NewProjectID = TIDref;
  var NewWWCoorID = req.body.newWWCoorID;
  var NewDateRecieved = req.body.newDateReceived;
  var NewLinkToWWsite = req.body.newLinkToWWsite;
  var NewUserPermission = req.body.newUserPermission;
  var NewProjectTypeID = req.body.newProjectTypeID;
  var NewDistrictID = req.body.newDistrictID;
  var NewCityName = req.body.newCityName;
  var NewPastorName = req.body.newPastorName;
  var NewPastorPhone = req.body.newPastorPhone;
  var NewLocationLink = req.body.newLocationLink;
  var NewDistanceFromDistrictOff = req.body.newDistanceFromDistrictOff;
  var NewDistrictBudgetCurrent = req.body.newDistrictBudgetCurrent;
  var NewDistrictBudgetLast = req.body.newDistrictBudgetLast;
  var NewFEMCurrent = req.body.newFEMCurrent;
  var NewFEMLast = req.body.newFEMLast;
  var NewDateOrganized = req.body.newDateOrganized;
  var NewMembersLast = req.body.newMembersLast;
  var NewMembersCurrent = req.body.newMembersCurrent;
  var NewAvgAttendanceLast = req.body.newAvgAttendanceLast;
  var NewAvgAttendanceCurent = req.body.newAvgAttendanceCurrent;
  var NewProjectDesc = req.body.newProjectDesc;
  var NewTempleCapacity = req.body.newTempleCapacity;
  var NewRoofWidth = req.body.newRoofWidth;
  var NewRoofLength = req.body.newRoofLength;
  var NewBriefDescriptionConst = req.body.newBriefDescriptionConst;
  var NewPropertyWidth = req.body.newPropertyWidth;
  var NewPropertyLength = req.body.newPropertyLength;
  var NewPhotos = req.body.newPhotos;
  var NewDigital = req.body.newDigital;
  var NewLotLayout = req.body.newLotLayout;
  var NewProjectPlans = req.body.newProjectPlans;
  var NewMoneyRaised = req.body.NewMoneyRaised;
  var NewMoneyInvested = req.body.newMoneyInvested;
  var NewMoney12Months = req.body.newMoney12Months;
  var NewProjectNeed = req.body.newProjectNeed;
  var NewTitleToProperty = req.body.newTitleToProperty;
  var NewPropertyDeededToChurch = req.body.newPropertyDeededToChurch;
  var NewBuildingPermitNeeded = req.body.newBuildingPermitNeeded;
  var NewBuildingPermitApproved =req.body.newBuildingPermitApproved;
  var NewPastorApproved = req.body.newPastorApproved;
  var NewChurchBoardApproved = req.body.newChurchBoardApproved;
  var NewTreasureApproved = req.body.newTreasureApproved;
  var NewTreasureApprovedDate = req.body.NewTreasureApprovedDate;
  var NewSuperApproval = req.body.newSuperApproval;
  var NewSuperApprovalDate = req.body.newSuperApprovalDate;
  var NewDistrictSecretaryApproval = req.body.newDistrictSecretaryApproval;
  var NewDistrictTreasureApproval = req.body.newDistrictTreasureApproval;
  var NewDistrictTreasureApprovalDate = req.body.newDistrictTreasueApprovalDate;
  var NewDistrictPriority = req.body.newDistrictPriority;
  var NewTyTapproved = req.body.newTyTapproved;
  var NewTyTPriority = req.body.newTyTPriority;
  var NewProjectCompleted = req.body.newProjectCompleted;
  var NewWWLink = req.body.newWWLink;
  var NewPhotoLocation = req.body.newPhotoLocation;
  var NewPermitStart = req.body.newPermitStart;
  var NewPermitEnd = req.body.newPermitEnd;
  var NewCountryID = req.body.newCountryID;
  var NewChurchID = req.body.newChurchID;
  if(NewProjectID == null || NewProjectID == undefined || NewProjectID.length === 0){
        NewProjectID = ids[0];
  }
  if(NewWWCoorID == null || NewWWCoorID == undefined || NewWWCoorID.length === 0){
        NewWWCoorID = defaults[0];
  }
  if(NewDateRecieved == null || NewDateRecieved == undefined || NewDateRecieved.length === 0){
        NewDateRecieved = defaults[1];
  }
  if(NewLinkToWWsite == null || NewLinkToWWsite == undefined || NewLinkToWWsite.length === 0){
        NewLinkToWWsite = defaults[2];
  }
  if(NewUserPermission == null || NewUserPermission == undefined || NewUserPermission.length === 0){
        NewUserPermission = defaults[3];
  }
  if(NewProjectTypeID == null || NewProjectTypeID == undefined || NewProjectTypeID.length === 0){
        NewProjectTypeID = defaults[4];
  }
  if(NewDistrictID == null || NewDistrictID == undefined || NewDistrictID.length === 0){
        NewDistrictID = defaults[5];
  }
  if(NewCityName == null || NewCityName == undefined || NewCityName.length === 0){
        NewCityName = defaults[6];
  }
  if(NewPastorName == null || NewPastorName == undefined || NewPastorName.length === 0){
        NewPastorName = defaults[8];
  }
  if(NewPastorPhone == null || NewPastorPhone == undefined || NewPastorPhone.length === 0){
        NewPastorPhone = defaults[9];
  }
  if(NewLocationLink == null || NewLocationLink == undefined || NewLocationLink.length === 0){
        NewLocationLink = defaults[11];
  }
  if(NewDistanceFromDistrictOff == null || NewDistanceFromDistrictOff	 == undefined || NewDistanceFromDistrictOff	.length === 0){
        NewDistanceFromDistrictOff	 = defaults[12];
  }
  if(NewDistrictBudgetCurrent == null || NewDistrictBudgetCurrent == undefined || NewDistrictBudgetCurrent.length === 0){
        NewDistrictBudgetCurrent = defaults[13];
  }
  if(NewDistrictBudgetLast == null || NewDistrictBudgetLast == undefined || NewDistrictBudgetLast.length === 0){
        NewDistrictBudgetLast = defaults[14];
  }
  if(NewFEMCurrent == null || NewFEMCurrent == undefined || NewFEMCurrent.length === 0){
        NewFEMCurrent = defaults[15];
  }
  if(NewFEMLast == null || NewFEMLast == undefined || NewFEMLast.length === 0){
        NewFEMLast = defaults[16];
  }
  if(NewDateOrganized == null || NewDateOrganized == undefined || NewDateOrganized.length === 0){
        NewDateOrganized = defaults[17];
  }
  if(NewMembersLast == null || NewMembersLast == undefined || NewMembersLast.length === 0){
        NewMembersLast = defaults[18];
  }
  if(NewMembersCurrent == null || NewMembersCurrent == undefined || NewMembersCurrent.length === 0){
        NewMembersCurrent = defaults[19];
  }
  if(NewAvgAttendanceLast == null || NewAvgAttendanceLast == undefined || NewAvgAttendanceLast.length === 0){
        NewAvgAttendanceLast = defaults[20];
  }
  if(NewAvgAttendanceCurent == null || NewAvgAttendanceCurent == undefined || NewAvgAttendanceCurent.length === 0){
        NewAvgAttendanceCurent = defaults[21];
  }
  if(NewProjectDesc == null || NewProjectDesc == undefined || NewProjectDesc.length === 0){
        NewProjectDesc = defaults[22];
  }
  if(NewTempleCapacity == null || NewTempleCapacity == undefined || NewTempleCapacity.length === 0){
        NewTempleCapacity = defaults[23];
  }
  if(NewRoofWidth == null || NewRoofWidth == undefined || NewRoofWidth.length === 0){
        NewRoofWidth = defaults[24];
  }
  if(NewRoofLength == null || NewRoofLength == undefined || NewRoofLength.length === 0){
        NewRoofLength = defaults[25];
  }
  if(NewBriefDescriptionConst == null || NewBriefDescriptionConst == undefined || NewBriefDescriptionConst.length === 0){
        NewBriefDescriptionConst = defaults[26];
  }
  if(NewPropertyWidth == null || NewPropertyWidth == undefined || NewPropertyWidth.length === 0){
        NewPropertyWidth = defaults[27];
  }
  if(NewPropertyLength == null || NewPropertyLength == undefined || NewPropertyLength.length === 0){
        NewPropertyLength = defaults[28];
  }
  if(NewPhotos === -1){
        NewPhotos = defaults[29];
  }
  if(NewDigital === -1){
        NewDigital = defaults[30];
  }
  if(NewLotLayout === -1){
        NewLotLayout = defaults[31];
  }
  if(NewProjectPlans === -1){
        NewProjectPlans = defaults[32];
  }
  if(NewMoneyRaised == null || NewMoneyRaised == undefined || NewMoneyRaised.length === 0){
        NewMoneyRaised = defaults[33];
  }
  if(NewMoneyInvested == null || NewMoneyInvested == undefined || NewMoneyInvested.length === 0){
        NewMoneyInvested = defaults[34];
  }
  if(NewMoney12Months == null || NewMoney12Months == undefined || NewMoney12Months.length === 0){
        NewMoney12Months = defaults[35];
  }
  if(NewProjectNeed == null || NewProjectNeed == undefined || NewProjectNeed.length === 0){
        NewProjectNeed = defaults[36];
  }
  if(NewTitleToProperty == -1){
        NewTitleToProperty = defaults[37];
  }
  if(NewPropertyDeededToChurch == -1){
        NewPropertyDeededToChurch = defaults[38];
  }
  if(NewBuildingPermitNeeded == -1){
        NewBuildingPermitNeeded = defaults[39];
  }
  if(NewBuildingPermitApproved == -1){
        NewBuildingPermitApproved = defaults[40];
  }
  if(NewPastorApproved == -1){
        NewPastorApproved = defaults[41];
  }
  if(NewChurchBoardApproved == -1){
        NewChurchBoardApproved = defaults[442];
  }
  if(NewTreasureApproved == -1){
        NewTreasureApproved = defaults[43];
  }
  if(NewTreasureApprovedDate == -1){
        NewTreasureApprovedDate = defaults[44];
  }
  if(NewSuperApproval == -1){
        NewSuperApproval = defaults[45];
  }
  if(NewSuperApprovalDate == null || NewSuperApprovalDate == undefined ||NewSuperApprovalDate.length === 0){
        NewSuperApprovalDate = defaults[46];
  }
  if(NewDistrictSecretaryApproval == -1){
        NewDistrictSecretaryApproval = defaults[47];
  }
  if(NewDistrictTreasureApproval == -1){
        NewDistrictTreasureApproval = defaults[48];
  }
  if(NewDistrictTreasureApprovalDate == null || NewDistrictTreasureApprovalDate == undefined || NewDistrictTreasureApprovalDate.length === 0){
        NewDistrictTreasureApprovalDate = defaults[49];
  }
  if(NewDistrictPriority == -1){
        NewDistrictPriority = defaults[50];
  }
  if(NewTyTapproved == -1){
        NewTyTapproved	 = defaults[51];
  }
  if(NewTyTPriority == -1){
        NewTyTPriority = defaults[52];
  }
  if(NewProjectCompleted == -1){
        NewProjectCompleted = defaults[53];
  }
  if(NewWWLink == null || NewWWLink == undefined ||NewWWLink.length === 0){
        NewWWLink = defaults[54];
  }
  if(NewPhotoLocation == null || NewPhotoLocation == undefined || NewPhotoLocation.length === 0){
        NewPhotoLocation = defaults[55];
  }
  if(NewPermitStart == null || NewPermitStart == undefined ||NewPermitStart.length === 0){
        NewPermitStart = defaults[56];
  }
  if(NewPermitEnd == null || NewPermitEnd == undefined || NewPermitEnd.length === 0){
        NewPermitEnd = defaults[57];
  }
  if(NewCountryID == null || NewCountryID == undefined ||NewCountryID.length === 0){
        NewCountryID = defaults[58];
  }
  if(NewChurchID == null || NewChurchID == undefined ||NewChurchID.length === 0){
      NewChurchID = defaults[59];
}
  //console.log("PID REF ->>>>");
  //console.log(PIDref);
  var pe = new sql.Request();
  pe.input('NewProjectID', sql.INT, NewProjectID);
  pe.input('NewWWCoorID', sql.INT, NewWWCoorID);
  pe.input('NewDateRecieved', sql.DATE, NewDateRecieved);
  pe.input('NewLinkToWWsite', sql.NVARCHAR(255), NewLinkToWWsite);
  pe.input('NewUserPermission', sql.NVARCHAR(255), NewUserPermission);
  pe.input('NewProjectTypeID', sql.INT, NewProjectTypeID);
  pe.input('NewDistrictID', sql.INT, NewDistrictID);
  pe.input('NewCityName', sql.NVARCHAR(255), NewCityName);
  pe.input('NewPastorName', sql.NVARCHAR(255), NewPastorName);
  pe.input('NewPastorPhone', sql.NVARCHAR(255), NewPastorPhone);
  pe.input('NewLocationLink', sql.NVARCHAR(255), NewLocationLink);
  pe.input('NewDistanceFromDistrictOff', sql.NVARCHAR(255), NewDistanceFromDistrictOff);
  pe.input('NewDistrictBudgetCurrent', sql.MONEY, NewDistrictBudgetCurrent);
  pe.input('NewDistrictBudgetLast', sql.MONEY, NewDistrictBudgetLast);
  pe.input('NewFEMCurrent', sql.MONEY, NewFEMCurrent);
  pe.input('NewFEMLast', sql.MONEY, NewFEMLast);
  pe.input('NewDateOrganized', sql.DATE, NewDateOrganized);
  pe.input('NewMembersLast', sql.INT, NewMembersLast);
  pe.input('NewMembersCurrent', sql.INT, NewMembersCurrent);
  pe.input('NewAvgAttendanceLast', sql.INT, NewAvgAttendanceLast);
  pe.input('NewAvgAttendanceCurent', sql.INT, NewAvgAttendanceCurent);
  pe.input('NewProjectDesc', sql.NVARCHAR(255), NewProjectDesc);
  pe.input('NewTempleCapacity', sql.INT, NewTempleCapacity);
  pe.input('NewRoofWidth', sql.INT, NewRoofWidth);
  pe.input('NewRoofLength', sql.INT, NewRoofLength);
  pe.input('NewBriefDescriptionConst', sql.NVarChar(255), NewBriefDescriptionConst);
  pe.input('NewPropertyWidth', sql.INT, NewPropertyWidth);
  pe.input('NewPropertyLength', sql.INT, NewPropertyLength);
  pe.input('NewPhotos', sql.INT, NewPhotos);
  pe.input('NewDigital', sql.INT, NewDigital);
  pe.input('NewLotLayout', sql.INT, NewLotLayout);
  pe.input('NewProjectPlans', sql.INT, NewProjectPlans);
  pe.input('NewMoneyRaised', sql.MONEY, NewMoneyRaised);
  pe.input('NewMoneyInvested', sql.MONEY, NewMoneyInvested);
  pe.input('NewMoney12Months', sql.MONEY, NewMoney12Months);
  pe.input('NewProjectNeed', sql.NVARCHAR(255), NewProjectNeed);
  pe.input('NewTitleToProperty', sql.INT, NewTitleToProperty);
  pe.input('NewPropertyDeededToChurch', sql.INT, NewPropertyDeededToChurch);
  pe.input('NewBuildingPermitNeeded', sql.INT, NewBuildingPermitNeeded);
  pe.input('NewBuildingPermitApproved', sql.INT, NewBuildingPermitApproved);
  pe.input('NewPastorApproved', sql.INT, NewPastorApproved);
  pe.input('NewChurchBoardApproved', sql.INT, NewChurchBoardApproved);
  pe.input('NewTreasureApproved', sql.INT, NewTreasureApproved);
  pe.input('NewTreasureApprovedDate', sql.DATE, NewTreasureApprovedDate);
  pe.input('NewSuperApproval', sql.INT, NewSuperApproval);
  pe.input('NewSuperApprovalDate', sql.DATE, NewSuperApprovalDate);
  pe.input('NewDistrictSecretaryApproval', sql.INT, NewDistrictSecretaryApproval);
  pe.input('NewDistrictTreasureApproval', sql.INT, NewDistrictTreasureApproval);
  pe.input('NewDistrictTreasureApprovalDate', sql.DATE, NewDistrictTreasureApprovalDate);
  pe.input('NewDistrictPriority', sql.INT, NewDistrictPriority);
  pe.input('NewTyTapproved', sql.INT, NewTyTapproved);
  pe.input('NewTyTPriority', sql.INT, NewTyTPriority);
  pe.input('NewProjectCompleted', sql.INT, NewProjectCompleted);
  pe.input('NewWwLink', sql.NVARCHAR(255), NewWWLink);
  pe.input('NewPhotoLocation', sql.NVARCHAR(255), NewPhotoLocation);
  pe.input('NewPermitStart', sql.DATE, NewPermitStart);
  pe.input('NewPermitEnd', sql.DATE, NewPermitEnd);
  pe.input('NewCountryID', sql.INT, NewCountryID);
  pe.execute('EditProject').then(function(err){
    if(err){console.log(err);}
  });
  res.redirect('/ScheduledTeamsView&Edit');
});


app.get('/deleteProject', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  var check = new sql.Request();
  var projectViewArrayDelete = [];

  check.execute('ViewTeams').then(function(result){
      var ie = indexD;
                projectViewArrayDelete.push({
                  "ProjectID":      result.recordset[ie].ProjectID,
                  "TeamID":          result.recordset[ie].TeamID,
                  "ChurchName":   result.recordset[ie].ChurchName,
                  "BriefDescriptionConst":       result.recordset[ie].BriefDescriptionConst,
        });
    });
  console.log("redirect success");
  res.render('deleteProject', {projectViewArrayDelete : projectViewArrayDelete});
});

app.post('/delete-Project', function(req,res){
    var ProID = req.body.ProjectID;
    var PD = new sql.Request();
    PD.input('NewProjectID', sql.INT, ProID);
    PD.execute('DeleteProject').then(function(err){
      if(err){console.log(err)}
    });
    res.redirect('ScheduledTeamsView&EditTeam');
});

app.get('/allTeamDetails', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  var check = new sql.Request();
  var AllTeamDetails= [];
  check.execute('ViewTeamDetails').then(function(result){
      var len = result.recordset.length;
      for(var i = 0; i < len; i++){
                AllTeamDetails.push({
                  "TeamDetailsID":      result.recordset[i].TeamDetailsID,
                  "TotalDailyFunds":          result.recordset[i].TotalDailyFunds,
                  "ArriveFlightNumber":   result.recordset[i].ArriveFlightNumber,
                  "ArriveDate":       result.recordset[i].ArriveDate,
                  "DepartDate":      result.recordset[i].DepartDate,
                  "DepartAirline":          result.recordset[i].DepartAirline,
                  "DepartFlightNumber":   result.recordset[i].DepartFlightNumber,
                  "ProjectID":       result.recordset[i].ProjectID,
                  "TeamID":      result.recordset[i].TeamID,
                  "DistanceToRR":          result.recordset[i].DistanceToRR,
                  "DistanceToProject":   result.recordset[i].DistanceToProject,
                  "HotelID":       result.recordset[i].HotelID,
                  "CountryID":      result.recordset[i].CountryID,
                  "AirportID":          result.recordset[i].AirportID,
                  "TeamRegistration":   result.recordset[i].TeamRegistration,
                  "Insurance":       result.recordset[i].Insurance,
                  "Maxima":      result.recordset[i].Maxima,
                  "ProjectMoney":          result.recordset[i].ProjectMoney,
                  "PartnershipID":   result.recordset[i].PartnershipID,
                  "TeamPartnerProfileID":       result.recordset[i].TeamPartnerProfileID,
                  "TeamHost":      result.recordset[i].TeamHost,
                  "CulBroker":          result.recordset[i].CulBroker,
                  "TruckDriver":   result.recordset[i].TruckDriver,
                  "BusDriver":       result.recordset[i].BusDriver,
                  "Translator":      result.recordset[i].Translator,
                  "StructureDelivery":          result.recordset[i].StructureDelivery,
                  "CancelTeam":   result.recordset[i].CancelTeam,
                  "ProjectFundsReceived":       result.recordset[i].ProjectFundsReceived
        });
    };
  //console.log("redirect success");
  res.render('allTeamDetails', {AllTeamDetails : AllTeamDetails});
});
app.post('/getTeamDetailsID', function(req, res){
  indexTIDE = req.body.RowForEditTeamDetails;
  indexTIDD = req.body.RowForDeleteTeamDetails;
  if(indexTIDD == undefined){
    res.redirect('editTeamDetails');
  }
  else{
    res.redirect('deleteTeamDetails');
  }

});

app.get('/editTeamDetails', function(req,res){
      var UsNm = req.session.user;
      console.log(req.sessionID);
      if(UsNm == null && sessionID == null){res.redirect('/')};
      var check = new sql.Request();
      var tableArrayEditTeamDetails = [];
      check.execute('ViewTeamDetails').then(function(result){
          var ie = indexTIDE;
          TIDref = result.recordset[ie].TeamDetailsID;
                    tableArrayEditTeamDetails.push({
                      "TeamDetailsID":      result.recordset[ie].TeamDetailsID,
                      "TotalDailyFunds":          result.recordset[ie].TotalDailyFunds,
                      "ArriveFlightNumber":   result.recordset[ie].ArriveFlightNumber,
                      "ArriveDate":       result.recordset[ie].ArriveDate,
                      "DepartDate":      result.recordset[ie].DepartDate,
                      "DepartAirline":          result.recordset[ie].DepartAirline,
                      "DepartFlightNumber":   result.recordset[ie].DepartFlightNumber,
                      "ProjectID":       result.recordset[ie].ProjectID,
                      "TeamID":      result.recordset[ie].TeamID,
                      "DistanceToRR":          result.recordset[ie].DistanceToRR,
                      "DistanceToProject":   result.recordset[ie].DistanceToProject,
                      "HotelID":       result.recordset[ie].HotelID,
                      "CountryID":      result.recordset[ie].CountryID,
                      "AirportID":          result.recordset[ie].AirportID,
                      "TeamRegistration":   result.recordset[ie].TeamRegistration,
                      "Insurance":       result.recordset[ie].Insurance,
                      "Maxima":      result.recordset[ie].Maxima,
                      "ProjectMoney":          result.recordset[ie].ProjectMoney,
                      "PartnershipID":   result.recordset[ie].PartnershipID,
                      "TeamPartnerProfileID":       result.recordset[ie].TeamPartnerProfileID,
                      "TeamHost":      result.recordset[ie].TeamHost,
                      "CulBroker":          result.recordset[ie].CulBroker,
                      "TruckDriver":   result.recordset[ie].TruckDriver,
                      "BusDriver":       result.recordset[ie].BusDriver,
                      "Translator":      result.recordset[ie].Translator,
                      "StructureDelivery":          result.recordset[ie].StructureDelivery,
                      "CancelTeam":   result.recordset[ie].CancelTeam,
                      "ProjectFundsReceived":       result.recordset[ie].ProjectFundsReceived
            });
            ids[0] = result.recordset[ie].TeamDetailsID;
            defaults[0] = result.recordset[ie].TotalDailyFunds;
            defaults[1] = result.recordset[ie].ArriveFlightNumber;
            defaults[2] = result.recordset[ie].ArriveDate;
            defaults[3] = result.recordset[ie].DepartDate;
            defaults[4] = result.recordset[ie].DepartAirline;
            defaults[5] = result.recordset[ie].DepartFlightNumber;
            defaults[6] = result.recordset[ie].DistanceToRR;
            defaults[7] = result.recordset[ie].DistanceToProject;
            defaults[20]= result.recordset[ie].CountryID;
            defaults[21]= result.recordset[ie].AirportID;
            defaults[8] = result.recordset[ie].TeamRegistration; 
            defaults[9] = result.recordset[ie].Insurance;
            defaults[10] = result.recordset[ie].Maxima;
            defaults[11] = result.recordset[ie].ProjectMoney;
            defaults[12] = result.recordset[ie].TeamHost;
            defaults[13] = result.recordset[ie].CulBroker;
            defaults[14] = result.recordset[ie].TruckDriver;
            defaults[15] = result.recordset[ie].BusDriver;
            defaults[16] = result.recordset[ie].Translator;
            defaults[17] = result.recordset[ie].StructureDelivery;
            defaults[18] = result.recordset[ie].CancelTeam;
            defaults[19] = result.recordset[ie].ProjectFundsReceived;
        });
      console.log("redirect success");
      res.render('editTeamDetails', {tableArrayEditTeamDetails : tableArrayEditTeamDetails});
    });
});
app.post('/edit-TeamDetails', function(req,res){
      //console.log(TIDref);
      //console.log("TID REF CHECK");
      ids[0] = req.body.newTeamDetailsID;
      results[0] = req.body.newTotalDailyFunds;
      results[1] = req.body.newArriveFlightNumber;
      results[2] = req.body.newArriveDate;
      results[3] = req.body.newDepartDate;
      results[4] = req.body.newDepartAirline;
      results[5] = req.body.newDepartFlightNumber;
      results[6] = req.body.newDistanceToRR;
      results[7] = req.body.newDistanceToProject;
      results[8] = req.body.newTeamRegistration; 
      results[9] = req.body.newInsurance;
      results[10] = req.body.newMaxima;
      results[11] = req.body.newProjectMoney;
      results[12] = req.body.newTeamHost;
      results[13] = req.body.newCulBroker;
      results[14] = req.body.newTruckDriver;
      results[15] = req.body.newBusDriver;
      results[16] = req.body.newTranslator;
      results[17] = req.body.StructureDelivery;
      results[18] = req.body.newCancelTeam;
      results[19] = req.body.newProjectFundsReceived;

if(results[0] == null || results[0] == undefined || results[0].length === 0){
      results[0] = defaults[0];
}
if(results[1] == null || results[1] == undefined || results[1].length === 0){
      results[1] = defaults[1];
}
if(results[2] == null || results[2] == undefined || results[2].length === 0){
      results[2] = defaults[2];
}
if(results[3] == null || results[3] == undefined || results[3].length === 0){
      results[3] = defaults[3];
}
if(results[4] == null || results[4] == undefined || results[4].length === 0){
      results[4] = defaults[4];
}
if(results[5] == null || results[5] == undefined || results[5].length === 0){
      results[5] = defaults[5];
}
if(results[6] == null || results[6] == undefined || results[6].length === 0){
      results[6] = defaults[6];
}
if(results[7] == null || results[7] == undefined || results[7].length === 0){
      results[7] = defaults[7];
}
if(results[8] == null || results[8] == undefined || results[8].length === 0){
      results[8] = defaults[8];
}
if(results[9] == null || results[9] == undefined || results[9].length === 0){
      results[9] = defaults[9];
}
if(results[10] == null || results[10] == undefined || results[10].length === 0){
      results[10] = defaults[10];
}
if(results[11] == null || results[11] == undefined || results[11].length === 0){
      results[11] = defaults[11];
}
if(results[12] == null || results[12] == undefined || results[12].length === 0){
      results[12] = defaults[12];
}
if(results[13] == null || results[13] == undefined || results[13].length === 0){
      results[13] = defaults[13];
}
if(results[14] == null || results[14] == undefined || results[14].length === 0){
      results[14] = defaults[14];
}
if(results[15] == null || results[15] == undefined || results[15].length === 0){
      results[15] = defaults[15];
}
if(results[16] == null || results[16] == undefined || results[16].length === 0){
      results[16] = defaults[16];
}
if(results[17] == null || results[17] == undefined || results[17].length === 0){
      results[17] = defaults[17];
}
if(results[18] == null || results[18] == undefined || results[18].length === 0){
      results[18] = defaults[18];
}
if(results[19] == null || results[19] == undefined || results[19].length === 0){
      results[19] = defaults[19];
}
res.redirect('/chooseCountry');
res.end();
});
app.get('/deleteTeamDetails', function(req, res){
      var UsNm = req.session.user;
      console.log(req.sessionID);
      if(UsNm == null && sessionID == null){res.redirect('/')};
      var check = new sql.Request();
      var deleteTeamDetails = [];
      check.execute('ViewTeamDetails').then(function(result){
          var ie = indexTIDD;
                    deleteTeamDetails.push({
                      "TeamDetailsID":      result.recordset[ie].TeamDetailsID,
                      "TotalDailyFunds":          result.recordset[ie].TotalDailyFunds,
                      "ArriveFlightNumber":   result.recordset[ie].ArriveFlightNumber,
                      "ArriveDate":       result.recordset[ie].ArriveDate,
                      "DepartDate":      result.recordset[ie].DepartDate,
                      "DepartAirline":          result.recordset[ie].DepartAirline,
                      "DepartFlightNumber":   result.recordset[ie].DepartFlightNumber,
                      "ProjectID":       result.recordset[ie].ProjectID,
                      "TeamID":      result.recordset[ie].TeamID,
                      "DistanceToRR":          result.recordset[ie].DistanceToRR,
                      "DistanceToProject":   result.recordset[ie].DistanceToProject,
                      "HotelID":       result.recordset[ie].HotelID,
                      "CountryID":      result.recordset[ie].CountryID,
                      "AirportID":          result.recordset[ie].AirportID,
                      "TeamRegistration":   result.recordset[ie].TeamRegistration,
                      "Insurance":       result.recordset[ie].Insurance,
                      "Maxima":      result.recordset[ie].Maxima,
                      "ProjectMoney":          result.recordset[ie].ProjectMoney,
                      "PartnershipID":   result.recordset[ie].PartnershipID,
                      "TeamPartnerProfileID":       result.recordset[ie].TeamPartnerProfileID,
                      "TeamHost":      result.recordset[ie].TeamHost,
                      "CulBroker":          result.recordset[ie].CulBroker,
                      "TruckDriver":   result.recordset[ie].TruckDriver,
                      "BusDriver":       result.recordset[ie].BusDriver,
                      "Translator":      result.recordset[ie].Translator,
                      "StructureDelivery":          result.recordset[ie].StructureDelivery,
                      "CancelTeam":   result.recordset[ie].CancelTeam,
                      "ProjectFundsReceived":       result.recordset[ie].ProjectFundsReceived
            });
      //("redirect success");
      res.render('deleteTeamDetails', {deleteTeamDetails : deleteTeamDetails});
    });
});
app.post('/delete-TeamDetails', function(req,res){
      var TeamDetailsID = req.body.TDdelete;
      var check = new sql.Request();
      check.input('TeamDetailsID', sql.Int, TeamDetailsID)
      check.execute('DeleteTeamDetails').then(function(err){
            console.log(err);
      })
      res.redirect('ScheduledTeamsView&Edit');
})
app.get('/chooseCountry', function(req,res){
      var UsNm = req.session.user;
      console.log(req.sessionID);
      if(UsNm == null && sessionID == null){res.redirect('/')};
      console.log(`logged in as: ${UsNm}`);
      var tableArrayChooseCountry = [];
      var check = new sql.Request();
      check.execute('ViewCountries').then(function(result){
          var len = result.recordset.length;
          for(var i = 0; i < len; i++){
                      tableArrayChooseCountry.push({
                      "CountryID":       result.recordset[i].CountryID,
                      "CountryName":     result.recordset[i].CountryName,
                      "FieldID":         result.recordset[i].FieldID
                  });
                };
    //The above loop creates an array of objects...
    //...which is easily rendered on the client side upon redirect and rendering
    res.render('chooseCountry', {tableArrayChooseCountry: tableArrayChooseCountry});
    res.end();
    });
});
app.post('/edit-td-Country', function(req,res){
      results[20]= req.body.ctd;
      //console.log("COUNTRY BELOW");
      //console.log(results[20]);
      if (results[20] == null || results[20] == undefined || results[20] === 0){
            results[20] = defaults[20]; 
      }
      res.redirect('chooseAirport');
});
app.get('/chooseAirport', function(req,res){
      var UsNm = req.session.user;
      console.log(req.sessionID);
      if(UsNm == null && sessionID == null){res.redirect('/')};
      console.log(`logged in as: ${UsNm}`);
      var tableArrayChooseAirport = [];
      var check5 = new sql.Request();
      check5.execute('ViewAirports').then(function(result){
          var len = result.recordset.length;
          for(var i = 0; i < len; i++){
                      tableArrayChooseAirport.push({
                      "AirportID":       result.recordset[i].AirportID,
                      "AirportName":     result.recordset[i].AirportName,
                      "AirportCode":   result.recordset[i].AirportCode,
                      "City":     result.recordset[i].City,
                      "Country":  result.recordset[i].Country
                  });
                };
    //The above loop creates an array of objects...
    //...which is easily rendered on the client side upon redirect and rendering
    res.render('chooseAirport', {tableArrayChooseAirport: tableArrayChooseAirport});
    res.end();
    });
});
app.post('/edit-td-Airport', function(req,res){
      var airportID = req.body.tda;
      results[21] = airportID;
      if(airportID == null || airportID == undefined || results[21] === 0){
            results[21] = defaults[21];
      }
      res.redirect('chooseHotel');
});

app.get('/meals', function(req,res){
      var UsNm = req.session.user;
      console.log(req.sessionID);
      if(UsNm == null && sessionID == null){res.redirect('/')};
      console.log(`logged in as: ${UsNm}`);
      var MealsViewArray = [];
      var check = new sql.Request();
      check.execute('ViewMeals').then(function(result){
          var len = result.recordset.length;
          for(var i = 0; i < len; i++){
                      MealsViewArray.push({
                      "MealID":       result.recordset[i].MealID,
                      "MealDesc":     result.recordset[i].MealDesc,
                      "MealDateStart":     moment(result.recordset[i].MealDateStart).format('YYYY-MM-DD'),
                      "MealDateStop":  moment(result.recordset[i].MealDateStop).format('YYYY-MM-DD'),
                      "DaysForThisMeal":   Math.round((result.recordset[i].MealDateStart - result.recordset.MealDateStop)/(1000*60*60*24)),
                      "MealCost":     result.recordset[i].MealCost,
                      "HowManyEating":  result.recordset[i].HowManyEating,
                      "TeamDetailsID":  result.recordset[i].TeamDetailsID
                  });
                };
    //The above loop creates an array of objects...
    //...which is easily rendered on the client side upon redirect and rendering
    res.render('meals', {MealsViewArray: MealsViewArray});
    res.end();
    });
});
app.post('/get-MealsID', function(req,res){
      indexD = req.body.MID;
      //(indexD);
      if(indexD == undefined){
        res.redirect('ScheduledTeamsView&Edit');
      }
      else{
        res.redirect('deleteMeals');
      }
}); 
app.get('/deleteMeals', function(req,res){
      var ie = indexD;
      var tableArrayDeleteMeal = [];
      var check = new sql.Reques();
      check.execute('ViewMeals').then(function(result){
          tableArrayDeleteMeal.push({
                "MealID":       result.recordset[ie].MealID,
                "MealDesc":     result.recordset[ie].MealDesc,
                "MealDateStart":     moment(result.recordset[ie].MealDateStart).format('YYYY-MM-DD'),
                "MealDateStop":      moment(result.recordset[ie].MealDateStop).format('YYYY-MM-DD'),
                "DaysForThisMeal":  (moment(result.recordset[ie].MealDateStart).format('YYYY-MM-DD')).diff(moment(result.recordset[ie].MealDateStop).format('YYYY-MM-DD'), 'days'),
                "MealCost":     result.recordset[ie].MealCost,
                "HowManyEating":  result.recordset[ie].HowManyEating,
                "TeamDetailsID":  result.recordset[ie].TeamDetailsID
            });
          });
      res.render('deleteMeals', {tableArrayDeleteMeal: tableArrayDeleteMeal});
      res.end();
});
app.post('/delete-Meals', function(req,res){
      var mealID = indexD;
      var check = new sql.Request();
      check.input('MealID', sql.Int, mealID).
      check.execute('DeleteMeal').then(function(err){
            console.log(err);
      });
      res.redirect('ScheduledTeamsView&Edit');
});
    
app.get('/createMeals', function(req,res){
      var UsNm = req.session.user;
      console.log(req.sessionID);
      if(UsNm == null && sessionID == null){res.redirect('/')};
      console.log(`logged in as: ${UsNm}`);
      var AllTeamDetailsForMeal = [];
      var check = new sql.Request();
      check.execute('ViewTeamDetails').then(function(result){
            var len = result.recordset.length;
            for(var i = 0; i < len; i++){
                      AllTeamDetailsForMeal.push({
                        "TeamDetailsID":      result.recordset[i].TeamDetailsID,
                        "ArriveDate":       result.recordset[i].ArriveDate,
                        "DepartDate":      result.recordset[i].DepartDate,
                        "ProjectID":       result.recordset[i].ProjectID,
                        "TeamID":      result.recordset[i].TeamID,
                        "CountryID":      result.recordset[i].CountryID,
                        "ProjectMoney":          result.recordset[i].ProjectMoney,
                        "CancelTeam":   result.recordset[i].CancelTeam,
                        "ProjectFundsReceived":       result.recordset[i].ProjectFundsReceived
              });
          };
        //console.log("redirect success");
        res.render('createMeals', {AllTeamDetailsForMeal : AllTeamDetailsForMeal});
});
});
app.post('/create-Meals', function(req,res){
      var MealDesc = req.body.newMealDesc;
      var MealDateStart = req.body.newMealDateStart;
            var MealDateStart = moment(MealDateStart).format('YYYY-MM-DD');
      var MealDateStop = req.body.newMealDateStop;
            var MealDateStop= moment(MealDateStop).format('YYYY-MM-DD');
      var MealCost = req.body.newMealCost;
      var HowManyEating = req.body.HowManyEating;
      var TeamDetailsID = req.body.tdm;
      //console.log("SEE TID FOR MEAL INSERT BELOW:");
      //console.log(TeamDetailsID);
      var check = new sql.Request();
      check.input('MealDesc', sql.NVarChar(255), MealDesc)
      check.input('MealDateStart', sql.Date, MealDateStart)
      check.input('MealDateStop', sql.Date, MealDateStop)
      check.input('MealCost', sql.Money, MealCost)
      check.input('HowManyEating', sql.Int, HowManyEating)
      check.input('TeamDetailsID', sql.Int, TeamDetailsID)
      check.execute('UpsertMeals').then(function(err){
            console.log(err)
      });
      res.redirect('ScheduledTeamsView&Edit');
});

app.get('/chooseHotel', function(req,res){
      var UsNm = req.session.user;
      console.log(req.sessionID);
      if(UsNm == null && sessionID == null){res.redirect('/')};
      console.log(`logged in as: ${UsNm}`);
      var tableArrayChooseHotel = [];
      var check5 = new sql.Request();
      check5.execute('ViewHotels').then(function(result){
          var len = result.recordset.length;
          for(var i = 0; i < len; i++){
                      tableArrayChooseHotel.push({
                      "HotelID":       result.recordset[i].HotelID,
                      "HotelName":     result.recordset[i].HotelName,
                      "City":   result.recordset[i].City,
                      "PhoneNum":     result.recordset[i].PhoneNum,
                  });
                };
    //The above loop creates an array of objects...
    //...which is easily rendered on the client side upon redirect and rendering
    res.render('chooseHotel', {tableArrayChooseHotel: tableArrayChooseHotel});
    res.end();
    });
});

app.post('/edit-td-Hotel', function(req,res){
      var HotelID = req.body.tdh
      results[22] = HotelID;
if(results[0] == null || results[0] == undefined || results[0].length === 0){
      results[0] = defaults[0]
}
if(results[1] == null || results[1] == undefined || results[1].length === 0){
      results[1] = defaults[1]
}
if(results[2] == null || results[2] == undefined || results[2].length === 0){
      results[2] = defaults[2]
}
if(results[3] == null || results[3] == undefined || results[3].length === 0){
      results[3] = defaults[3]
}
if(results[4] == null || results[4] == undefined || results[4].length === 0){
      results[4] = defaults[4]
}
if(results[5] == null || results[5] == undefined || results[5].length === 0){
      results[5] = defaults[5]
}
if(results[6] == null || results[6] == undefined || results[6].length === 0){
      results[6] = defaults[6]
}
if(results[7] == null || results[7] == undefined || results[7].length === 0){
      results[7] = defaults[7]
}
if(results[8] === -1){
      results[8] = defaults[8]
}
if(results[9] === -1){
      results[9] = defaults[9]
}
if(results[10] === -1){
      results[10] = defaults[10]
}
if(results[11] == null || results[11] == undefined || results[11].length === 0){
      results[11] = defaults[11]
}
if(results[12] === -1){
      results[12] = defaults[12]
}
if(results[13] === -1){
      results[13] = defaults[13]
}
if(results[14] === -1){
      results[14] = defaults[14]
}
if(results[15] === -1){
      results[15] = defaults[15]
}
if(results[16] === -1){
      results[16] = defaults[16]
}
if(results[17] === -1){
      results[17] = defaults[17]
}
if(results[18] === -1){
      results[18] = defaults[18]
}
if(results[19] === -1){
      results[19] = defaults[19] 
}
if(results[20] == 0 ){
      results[20] = defaults[20];
}
if(results[21] == 0 ){
      results[21] = defaults[21];
}
var check = new sql.Request();
check.input('TeamDetailsID', sql.Int, TIDref)
check.input('TotalDailyFunds', sql.Money, results[0])
check.input('ArriveFlightNumber', sql.NVarChar(255), results[1])
check.input('ArriveDate', sql.Date, results[2])
check.input('DepartDate', sql.Date, results[3])
check.input('DepartAirline', sql.NVarChar(255), results[4])
check.input('DepartFlightNumber', sql.NVarChar(255), results[5])
check.input('DistanceToRR',sql.Int, results[6])
check.input('DistanceToProject', sql.Int, results[7])
check.input('HotelID', sql.Int, results[22])
check.input('CountryID', sql.Int, results[20])
check.input('AirportID', sql.Int, results[21])
check.input('TeamRegistration', sql.Int, results[8])
check.input('Insurance', sql.Int, results[9])
check.input('Maxima', sql.Int, results[10])
check.input('ProjectMoney', sql.Money, results[11])
check.input('TeamHost', sql.Int, results[12])
check.input('CulBroker', sql.Int, results[13])
check.input('TruckDriver', sql.Int, results[14])
check.input('BusDriver', sql.Int, results[15])
check.input('Translator',sql.Int, results[16])
check.input('StructureDelivery', sql.Int, results[17])
check.input('CancelTeam', sql.Int, results[18])
check.input('ProjectFundsReceived', sql.Int, results[19])
check.execute('EditTeamDetails').then(function(err){
      console.log(err);
    });
    res.redirect('meals');
});



app.get('/newAirport', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var check = new sql.Request();
  var tableArrayChooseCountry = [];
  check.execute('ViewCountries').then(function(result){
      var len = result.recordset.length;
      for(var i = 0; i < len; i++){
                  tableArrayChooseCountry.push({
                  "CountryID":       result.recordset[i].CountryID,
                  "CountryName":     result.recordset[i].CountryName,
                  "FieldID":         result.recordset[i].FieldID
              });
            };
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
    res.render('newAirport', {tableArrayChooseCountry : tableArrayChooseCountry});
    res.end();
});
});
app.post('/new-Airport', function(req,res){
      var newAirportName = req.body.newAirportName;
      var newAirportCode = req.body.newAirportCode;
      var newAirportCity = req.body.newAirportCity;
      var newAirportCountryID = req.body.nac;
      var check = new sql.Request();
      check.input('AirportName', sql.NVarChar(255), newAirportName)
      check.input('AirportCode', sql.NVarChar(255), newAirportCode)
      check.input('City', sql.NVarChar(255), newAirportCity)
      check.input('CountryID', sql.Int, newAirportCountryID)
      check.execute('UpsertAirport').then(function(err){
            console.log(err);
          })
          res.redirect('ScheduledTeamsView&Edit');
});
        

app.get('/newCountry', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var tableArrayField = [];
  var check = new sql.Request();
  check.execute('GetAllField').then(function(result){
        var len = result.recordset.length
        for(var i = 0; i < len; i++){
            tableArrayField.push({
            "FieldID":       result.recordset[i].FieldID,
            "FieldName":     result.recordset[i].FieldName,
        });
      };
//The above loop creates an array of objects...
//...which is easily rendered on the client side upon redirect and rendering
res.render('newCountry', {tableArrayField: tableArrayField});
res.end();
});
});
app.post('/new-Country', function(req,res){
      var countryName  = req.body.newCountryName;
      var fieldID  = req.body.ncf;
      var check = new sql.Request();
      check.input('CountryName', sql.NVarChar(255), countryName) 
      check.input('FieldID', sql.Int, fieldID)
      check.execute('UpsertCountry').then(function(err){
            console.log(err);
      })
      res.redirect('ScheduledTeamsView&Edit');     
});

app.get('/newHotel', function(req,res){
  var UsNm = req.session.user;
  console.log(req.sessionID);
  if(UsNm == null && sessionID == null){res.redirect('/')};
  console.log(`logged in as: ${UsNm}`);
  var check = new sql.Request();
  var tableArrayChooseCountry = [];
  check.execute('ViewCountries').then(function(result){
      var len = result.recordset.length;
      for(var i = 0; i < len; i++){
                  tableArrayChooseCountry.push({
                  "Country":       result.recordset[i].CountryID,
                  "CountryName":     result.recordset[i].CountryName,
                  "FieldID":         result.recordset[i].FieldID
              });
            };
    res.render('newHotel', {tableArrayChooseCountry : tableArrayChooseCountry});
    res.end();
});
});
app.post('/new-Hotel', function(req,res){
   var HotelName = req.body.newHotelName;
   var CountryID = req.body.hc;
   var RandR = req.body.RandR;
   if(RandR == null || RandR == undefined || RandR.length === 0){
      RandR = 0
   }
   var Comments = req.body.Comments;
   if(Comments == null || Comments == undefined || Comments.length === 0){
      Comments = 'NONE PROVIDED'
   }
   var PhoneNum = req.body.PhoneNum;
   var WiFi = req.body.WiFi;
   var AirCond = req.body.AirCond;
   var Pool = req.body.Pool;
   var MapLoc = req.body.MapLoc;
   var City = req.body.City;
   var LastUsed = req.body.LastUsed;
   if(LastUsed == null || LastUsed == undefined || LastUsed.length === 0){
      LastUsed = '09/09/9999'
   }


   var check = new sql.Request;
   check.input('HotelName', sql.NVarChar(255), HotelName)
   check.input('CountryID', sql.Int, CountryID)
   check.input('RandR', sql.Bit, RandR)
   check.input('Comments', sql.NVarChar(255), Comments)
   check.input('PhoneNum', sql.NVarChar(255), PhoneNum)
   check.input('WiFi', sql.Bit, WiFi)
   check.input('AirCond', sql.Bit, AirCond)
   check.input('Pool', sql.Bit, Pool)
   check.input('MapLoc', sql.NVarChar(255), MapLoc)
   check.input('City', sql.NVarChar(255), City)
   check.input('LastUsed', sql.Date, LastUsed)
   check.execute('UpsertHotel').then(function(err){
         console.log(err)
   })
   res.redirect('ScheduledTeamsView&Edit');
});

app.get('/viewCountries', function(req,res){
      var tableArrayAllCountries = [];
      var check = new sql.Request();
      check.query('SELECT * FROM Country').then(function(result){
            var len = result.recordset.length;
            for(var i = 0; i< len; i++){
                  tableArrayAllCountries.push({
                        "CountryID":      result.recordset[i].CountryID,
                        "CountryName":    result.recordset[i].CountryName,
                        "FieldID":        result.recordset[i].FieldID
                  });
            };
          res.render('viewCountries',{tableArrayAllCountries : tableArrayAllCountries});
          res.end();
      })
});
app.get('/viewAirports', function(req,res){
      var tableArrayAllAirports = [];
      var check = new sql.Request();
      check.query('SELECT * FROM Airport').then(function(result){
            var len = result.recordset.length;
            for(var i = 0; i< len; i++){
                  tableArrayAllAirports.push({
                        "AirportID":      result.recordset[i].AirportID,
                        "AirportName":    result.recordset[i].AirportName,
                        "AirportCode":    result.recordset[i].AirportCode,
                        "City":           result.recordset[i].City,     
                        "Country":        result.recordset[i].Country
                  });
            };
          res.render('viewAirports',{tableArrayAllAirports : tableArrayAllAirports});
          res.end();
      })
});
app.get('/viewHotels', function(req,res){
      var tableArrayAllHotels = [];
      var check = new sql.Request();
      check.query('SELECT * FROM Hotel').then(function(result){
            var len = result.recordset.length;
            for(var i = 0; i< len; i++){
                  tableArrayAllHotels.push({
                        "HotelID":      result.recordset[i].HotelID,
                        "HotelName":    result.recordset[i].HotelName,
                        "City":        result.recordset[i].City,
                        "PhoneNum":    result.recordset[i].PhoneNum
                  });
            };
          res.render('viewHotels',{tableArrayAllHotels : tableArrayAllHotels});
          res.end();
      });
});

///////////////////////////////////////////////////////////////////////////////
// NOW IT'S TIME TO MOP UP
//////////////////////////////////////////////////////////////////////////////
app.get('/logout',function(req,res){
  req.session.destroy();
  req.session = null;
  res.redirect('/');
});

https.createServer({
      key: fs.readFileSync(__dirname + '/privateKey.key'), 
      cert: fs.readFileSync(__dirname + '/certificate.crt') 
  }, app).listen(5000, function(){                          //*** 
    console.log("RUNNING!!! SECURED!!!");                   //*** 
  });

// server code from https://www.tutorialsteacher.com/nodejs/access-sql-server-in-nodejs
// I contacted this site and recieved written permission to use server script. Will show email upon request.

USE [master]
GO
/****** Object:  Database [mission2Go]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE DATABASE [mission2Go]
CONTAINMENT = NONE
GO
ALTER DATABASE [mission2Go] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [mission2Go].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [mission2Go] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [mission2Go] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [mission2Go] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [mission2Go] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [mission2Go] SET ARITHABORT OFF 
GO
ALTER DATABASE [mission2Go] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [mission2Go] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [mission2Go] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [mission2Go] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [mission2Go] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [mission2Go] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [mission2Go] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [mission2Go] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [mission2Go] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [mission2Go] SET  DISABLE_BROKER 
GO
ALTER DATABASE [mission2Go] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [mission2Go] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [mission2Go] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [mission2Go] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [mission2Go] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [mission2Go] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [mission2Go] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [mission2Go] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [mission2Go] SET  MULTI_USER 
GO
ALTER DATABASE [mission2Go] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [mission2Go] SET DB_CHAINING OFF 
GO
ALTER DATABASE [mission2Go] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [mission2Go] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [mission2Go] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [mission2Go] SET QUERY_STORE = OFF
GO
USE [mission2Go]
GO
/****** Object:  UserDefinedFunction [dbo].[Authenticate]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Authenticate](@user nvarchar(40), @pass nvarchar(40))
RETURNS INT
AS
	BEGIN
DECLARE @result INT
IF  NOT EXISTS(
	(SELECT TOP(1) 
	[userID], 
	[userName],
	[userPassword],
	[userEmail],
	[userClearanceLevel]
	FROM userInfo
	WHERE 
    userName = @user
	AND 
	userPassword = @pass))
	SET @result = 0 --@FailString	
ELSE
	SET @result = 1 --@SuccessString

	RETURN @result
END

GO
/****** Object:  Table [dbo].[Airport]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airport](
	[AirportID] [int] IDENTITY(1,1) NOT NULL,
	[AirportName] [nvarchar](255) NULL,
	[AirportCode] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[CountryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AirportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CheckSolicitud]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckSolicitud](
	[CheckSolicitudID] [int] IDENTITY(1,1) NOT NULL,
	[SolicitudDate] [datetime2](7) NULL,
	[CheckName] [nvarchar](255) NULL,
	[CheckAmount] [money] NULL,
	[TextDollarAmount] [nvarchar](255) NULL,
	[PurchaseDescription] [nvarchar](255) NULL,
	[AccountingCode] [nvarchar](255) NULL,
	[ShortDesc] [nvarchar](255) NULL,
	[USD] [money] NULL,
	[LocalCurrency] [money] NULL,
	[ExchangeRate] [money] NULL,
	[RequestedBy] [nvarchar](255) NULL,
	[ReviewedBy] [nvarchar](255) NULL,
	[ApprovedBy] [nvarchar](255) NULL,
	[ProjectID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CheckSolicitudID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChurchName]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChurchName](
	[ChurchID] [int] IDENTITY(1,1) NOT NULL,
	[ChurchName] [nvarchar](255) NULL,
	[DistrictID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ChurchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](255) NULL,
	[FieldID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CurrencyType]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyType](
	[CurrencyTypeID] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyIndicator] [nvarchar](255) NULL,
	[CurrencyName] [nvarchar](255) NULL,
	[CountryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CurrencyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExchangeRate]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeRate](
	[ExchangeRateID] [int] IDENTITY(1,1) NOT NULL,
	[LastUpdate] [datetime2](7) NULL,
	[ExchangeRate] [money] NULL,
	[CurrencyTypeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ExchangeRateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Field]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Field](
	[FieldID] [int] IDENTITY(1,1) NOT NULL,
	[FieldName] [nvarchar](255) NULL,
	[RegionID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hotel]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotel](
	[HotelID] [int] IDENTITY(1,1) NOT NULL,
	[HotelName] [nvarchar](255) NULL,
	[CountryID] [int] NULL,
	[R&R] [bit] NULL,
	[Comments] [nvarchar](max) NULL,
	[PhoneNum] [nvarchar](255) NULL,
	[WiFi] [bit] NULL,
	[AirCond] [bit] NULL,
	[Pool] [bit] NULL,
	[MapLoc] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[LastUsed] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[HotelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[LanguageID] [int] IDENTITY(1,1) NOT NULL,
	[LanguageSpoken] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocalCoordinator]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalCoordinator](
	[LocalCoordID] [int] IDENTITY(1,1) NOT NULL,
	[CoordName] [nvarchar](255) NULL,
	[DistrictID] [int] NULL,
	[CoordPhone] [nvarchar](255) NULL,
	[CoordEmail] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[LocalCoordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Meals]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meals](
	[MealID] [int] IDENTITY(1,1) NOT NULL,
	[MealDesc] [nvarchar](255) NULL,
	[DaysForThisMeal] [int] NULL,
	[MealDateStart] [datetime2](7) NULL,
	[MealDateStop] [datetime2](7) NULL,
	[MealCost] [money] NULL,
	[HowManyEating] [int] NULL,
	[TeamDetailsID] [int] NOT NULL,
 CONSTRAINT [PK__Meals__ACF6A65DEB5000B6] PRIMARY KEY CLUSTERED 
(
	[MealID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partnerships]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partnerships](
	[PartnershipID] [int] IDENTITY(1,1) NOT NULL,
	[Vision] [nvarchar](255) NULL,
	[Scope] [nvarchar](255) NULL,
	[TeamID] [int] NOT NULL,
	[SelectedPartnerID] [int] NOT NULL,
 CONSTRAINT [PK__Partners__AD185E5966985140] PRIMARY KEY CLUSTERED 
(
	[PartnershipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[WWCoordID] [int] NULL,
	[DateReceived] [date] NULL,
	[LinkToWWsite] [nvarchar](max) NULL,
	[UserPermission] [nvarchar](255) NULL,
	[ProjectTypeID] [int] NULL,
	[DistrictID] [int] NULL,
	[CityName] [nvarchar](255) NULL,
	[PastorName] [nvarchar](max) NULL,
	[PastorPhone] [nvarchar](max) NULL,
	[LocationLink] [nvarchar](255) NULL,
	[DistanceFromDistrictOff] [nvarchar](255) NULL,
	[DistrictBudgetCurrent] [money] NULL,
	[DistrictBudgetLast] [money] NULL,
	[FEMcurrent] [money] NULL,
	[FEMlast] [money] NULL,
	[DateOrganized] [datetime2](7) NULL,
	[MembersLast] [int] NULL,
	[MembersCurrent] [int] NULL,
	[AvgAttendanceLast] [int] NULL,
	[AvgAttendanceCurr] [int] NULL,
	[ProjectDesc] [nvarchar](max) NULL,
	[TempleCapacity] [int] NULL,
	[RoofWidth] [int] NULL,
	[RoofLength] [int] NULL,
	[BriefDescriptionConst] [nvarchar](max) NULL,
	[PropertyWidth] [int] NULL,
	[PropertyLength] [int] NULL,
	[Photos] [bit] NULL,
	[Digital] [bit] NULL,
	[LotLayout] [bit] NULL,
	[ProjectPlans] [bit] NULL,
	[MoneyRaised] [money] NULL,
	[MoneyInvested] [money] NULL,
	[Money12Months] [money] NULL,
	[ProjectNeed] [nvarchar](max) NULL,
	[TitleToProperty] [int] NULL,
	[PropertyDeededToChurch] [int] NULL,
	[BuildingPermitNeeded] [int] NULL,
	[BuildingPermitApproved] [int] NULL,
	[PastorApproved] [int] NULL,
	[ChurchBoardApproved] [int] NULL,
	[TreasureApproved] [int] NULL,
	[TreasureApprovalDate] [date] NULL,
	[SuperApproval] [int] NULL,
	[SuperApprovalDate] [date] NULL,
	[DistrictSecretaryApproval] [int] NULL,
	[DistrictTreasureApproval] [int] NULL,
	[DistrictTreasureApprovalDate] [date] NULL,
	[DistrictPriority] [int] NULL,
	[TyTapproved] [int] NULL,
	[TyTPriority] [int] NULL,
	[ProjectCompleted] [int] NULL,
	[Wwlink] [nvarchar](255) NULL,
	[PhotoLocation] [nvarchar](255) NULL,
	[PermitStart] [date] NULL,
	[PermitEnd] [date] NULL,
	[CountryID] [int] NULL,
	[ChurchID] [int] NULL,
 CONSTRAINT [PK__Project__761ABED000DB60F3] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectNotes]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectNotes](
	[ProjectNoteID] [int] IDENTITY(1,1) NOT NULL,
	[Pdate] [datetime2](7) NULL,
	[Pnotes] [nvarchar](max) NULL,
	[ProjectID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectNoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectPhotos]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectPhotos](
	[ProjectPhotosID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectPhotos] [nvarchar](255) NULL,
	[ProjectID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectPhotosID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectType]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectType](
	[ProjectTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectType] [nvarchar](255) NULL,
	[ListOrder] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Region]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[RegionID] [int] IDENTITY(1,1) NOT NULL,
	[RegionName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SkillLevel]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SkillLevel](
	[SkillLevelId] [int] NOT NULL,
	[SkillLevel] [nvarchar](255) NULL,
	[SkillsID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Skills]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Skills](
	[SkillsID] [int] IDENTITY(1,1) NOT NULL,
	[Skill] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SkillsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SSMA$District$local]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SSMA$District$local](
	[DistrictID] [int] IDENTITY(1,1) NOT NULL,
	[DistrictName] [nvarchar](255) NULL,
	[CountryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supers]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supers](
	[SuperID] [int] IDENTITY(1,1) NOT NULL,
	[DistrictID] [int] NULL,
	[SuperName] [nvarchar](255) NULL,
	[SuperPhone] [nvarchar](255) NULL,
	[SuperEmail] [nvarchar](255) NULL,
	[SuperMobile] [nvarchar](255) NULL,
	[SuperWorkEmail] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SuperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [nvarchar](255) NULL,
	[ChurchName] [nvarchar](255) NULL,
	[District] [nvarchar](255) NULL,
	[LeaderEmail] [nvarchar](255) NULL,
	[LeaderName] [nvarchar](255) NULL,
	[Partership] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamDetails]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamDetails](
	[TeamDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[TotalDailyFunds] [money] NULL,
	[NumTeamMemb] [int] NULL,
	[TeamMemberID] [int] NULL,
	[TeamTypeID] [int] NULL,
	[NumberOfDays] [int] NULL,
	[NumberOfNights] [int] NULL,
	[ArriveFlightNumber] [nvarchar](255) NULL,
	[ArriveTime] [datetime2](7) NULL,
	[ArriveDate] [date] NULL,
	[DepartTime] [datetime2](7) NULL,
	[DepartDate] [date] NULL,
	[DepartAirline] [nvarchar](255) NULL,
	[DepartFlightNumber] [nvarchar](255) NULL,
	[ProjectID] [int] NULL,
	[TeamID] [int] NULL,
	[DistanceToRR] [int] NULL,
	[DistanceToProject] [int] NULL,
	[HotelID] [int] NULL,
	[CountryID] [int] NULL,
	[AirportID] [int] NULL,
	[TeamRegistration] [bit] NULL,
	[Insurance] [bit] NULL,
	[Maxima] [bit] NULL,
	[ProjectMoney] [money] NULL,
	[PartnershipID] [int] NULL,
	[TeamPartnerProfileID] [int] NULL,
	[TeamHost] [int] NULL,
	[CulBroker] [int] NULL,
	[TruckDriver] [int] NULL,
	[BusDriver] [int] NULL,
	[Translator] [int] NULL,
	[StructureDelivery] [int] NULL,
	[CancelTeam] [int] NULL,
	[ProjectFundsReceived] [bit] NULL,
 CONSTRAINT [PK__TeamDeta__7A68EB530C969A05] PRIMARY KEY CLUSTERED 
(
	[TeamDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamMember]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamMember](
	[TeamMemberID] [int] IDENTITY(1,1) NOT NULL,
	[FName] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](255) NULL,
	[Country] [nvarchar](255) NULL,
	[District] [nvarchar](255) NULL,
	[PreviousProjects] [bit] NULL,
	[SecondLanguage] [int] NULL,
	[SkillsID] [int] NULL,
	[TeamMemberTypeID] [int] NULL,
	[TeamLeader] [int] NULL,
	[TeamID] [int] NULL,
	[LastTrip] [date] NULL,
	[Male] [int] NULL,
	[Female] [int] NULL,
	[SpouseOnTeam] [int] NULL,
	[PassPortExp] [date] NULL,
	[FoodAllergies] [nvarchar](255) NULL,
	[MedicalAllergies] [nvarchar](255) NULL,
	[DPI] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
 CONSTRAINT [PK__TeamMemb__C7C0928568918DC2] PRIMARY KEY CLUSTERED 
(
	[TeamMemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamMemberSkills]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamMemberSkills](
	[TMSid] [int] IDENTITY(1,1) NOT NULL,
	[TeamMemberID] [int] NULL,
	[SkillsID] [int] NULL,
	[SkillLevelID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TMSid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamMemberType]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamMemberType](
	[TeamMemberTypeID] [int] IDENTITY(1,1) NOT NULL,
	[MemberType] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[TeamMemberTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamPartnerProfile]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamPartnerProfile](
	[TeamPartnerProfileID] [int] IDENTITY(1,1) NOT NULL,
	[TeamID] [int] NULL,
	[Scope] [nvarchar](255) NULL,
	[StartDate] [datetime2](7) NULL,
	[EndDate] [datetime2](7) NULL,
	[Finished] [int] NULL,
	[ProjectedTerm] [int] NULL,
	[ScopeTitle] [nvarchar](255) NULL,
 CONSTRAINT [PK__TeamPart__BA857138728A944D] PRIMARY KEY CLUSTERED 
(
	[TeamPartnerProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamTrackInfo]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamTrackInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmailPath] [nvarchar](255) NULL,
	[TeamID] [int] NULL,
	[TeamMemberTypeID] [int] NULL,
	[TeamHost] [int] NULL,
	[TruckDriver] [int] NULL,
	[BusDriver] [int] NULL,
	[Translator] [int] NULL,
	[ToolDriver] [int] NULL,
	[StructureDelivery] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamType]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamType](
	[TeamTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TeamDiscription] [nvarchar](255) NULL,
	[ListOrder] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TeamTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userInfo]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userInfo](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[userName] [nvarchar](64) NULL,
	[userPassword] [nvarchar](64) NULL,
	[userEmail] [nvarchar](64) NULL,
	[userClearanceLevel] [int] NULL,
	[userSalt] [nvarchar](64) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WWCoordinator]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WWCoordinator](
	[WWcoordID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[StartDate] [datetime2](7) NULL,
	[NumberOfTeams] [int] NULL,
	[RegionID] [int] NULL,
	[MaxHostingTeams] [int] NULL,
	[CoordStatusID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[WWcoordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Airport] ON 

INSERT [dbo].[Airport] ([AirportID], [AirportName], [AirportCode], [City], [CountryID]) VALUES (0, N'NONE PROVIDED', N'NONE', N'NONE', 0)
INSERT [dbo].[Airport] ([AirportID], [AirportName], [AirportCode], [City], [CountryID]) VALUES (1, N'Golosón International Airport', N'LCE', N'La Ceiba', 3)
INSERT [dbo].[Airport] ([AirportID], [AirportName], [AirportCode], [City], [CountryID]) VALUES (2, N'Juan Manuel Gálvez International Airport', N'RTB', N'Roatán', 3)
INSERT [dbo].[Airport] ([AirportID], [AirportName], [AirportCode], [City], [CountryID]) VALUES (3, N'Ramón Villeda Morales International Airport', N'SAP', N'San Pedro Sula', 3)
INSERT [dbo].[Airport] ([AirportID], [AirportName], [AirportCode], [City], [CountryID]) VALUES (4, N'	Toncontin International Airport', N'TGU', N'Tegucigalpa', 3)
INSERT [dbo].[Airport] ([AirportID], [AirportName], [AirportCode], [City], [CountryID]) VALUES (5, N'Augusto C. Sandino International Airport', N'MGA', N'Managua', 4)
INSERT [dbo].[Airport] ([AirportID], [AirportName], [AirportCode], [City], [CountryID]) VALUES (6, N'La Aurora International Airport', N'GUA', N'Guatemala City', 1)
INSERT [dbo].[Airport] ([AirportID], [AirportName], [AirportCode], [City], [CountryID]) VALUES (7, N'Mundo Maya International Airport', N'Flores', N'FRS', 1)
SET IDENTITY_INSERT [dbo].[Airport] OFF
SET IDENTITY_INSERT [dbo].[CheckSolicitud] ON 

INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (5, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, 43)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (9, CAST(N'2020-01-08T00:00:00.0000000' AS DateTime2), N'Distribuidora de Perfiles', 10549.9000, N'Diez Mil Quinientos Cuarenta y Nueve 90/100 Quetzales Exactos', N'Compra de material Proyecto Iglesia del Nazareno Antigua Guatemala, Equipo T&T Bangor, Maine USA.', N'5144R400NCA4001MCGT000', N'Compra de material', 1406.6533, 10549.9000, 7.5000, N'Roger Kellogg', N'Lic. Raúl Sosa', N'Lic. Raúl Sosa', 15)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (10, CAST(N'2020-01-09T00:00:00.0000000' AS DateTime2), N'TyT Admin 5%', 3750.0000, NULL, NULL, NULL, NULL, 500.0000, 3750.0000, 7.5000, NULL, NULL, NULL, 15)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (12, CAST(N'2020-01-08T00:00:00.0000000' AS DateTime2), N'Olga Lidia Novoa', 6043.5400, N'Seis Mil Cuarenta y Tres 54/100 Dolares', N'Reembolso por compra de material Proyecto NazaGol Santa Tecla, El Salvador, Equipo T&T Faithbrook C/D, Dayton (MN)', N'5144R400NCA4001MCGT000', N'Compra de Material', 6043.5400, 6043.5400, 0.0000, N'Roger Kellogg', N'Lic. Raúl Sosa', N'Lic. Raúl Sosa', 32)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (13, CAST(N'2020-01-09T00:00:00.0000000' AS DateTime2), N'T&T', 4500.0000, NULL, NULL, NULL, NULL, 600.0000, 4500.0000, 7.5000, NULL, NULL, NULL, 12)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (15, CAST(N'2020-01-07T00:00:00.0000000' AS DateTime2), N'Distribuidora de Perfiles Gonzalez', 105729.0000, N'Ciento Cinco Mil Setecientos Veintinueve 00/100 Quetzales Exactos', N'Compra de Material Proyecto Techo Salón Multiusos Seminario Teológico Nazareno, Equipo T&T Lenexa, Kansas City', N'5144R400NCA4001MCGT000', N'Compra de Material', 14097.2000, 105729.0000, 7.5000, N'Roger Kellogg', N'Lic. Raúl Sosa', N'Lic. Raúl Sosa', 23)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (16, CAST(N'2020-01-07T00:00:00.0000000' AS DateTime2), N'Distribuidora de Perfiles Gonzalez', 311.0000, N'Tres Cientos Once 00/100 Quetzales Exactos', N'Compra de material Proyecto Techo Salon Multiusos Seminario Teológico Nazareno, Equipo de Trabajo y Testimonio Lenexa, Kansas', N'5144R400NCA4001MCGT000', N'Compra de Material', 41.4667, 311.0000, 7.5000, N'Roger Kellogg', N'Lic. Raúl Sosa', N'Lic. Raúl Sosa', 23)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (17, CAST(N'2020-01-07T00:00:00.0000000' AS DateTime2), N'Esvin Dario López', 10000.0000, N'Diez Mil 00/100 Quetzales Exactos', N'An Proyecto Techo Salon Multiusos Seminario Teológico Nazareno, Equipo de Trabajo y Testimonio Lenexa, Kansas', N'5144R400NCA4001MCGT000', N'Mano de Obra', 1333.3333, 10000.0000, 7.5000, N'Roger Kellogg', N'Lic. Raúl Sosa', N'Lic. Raúl Sosa', 23)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (18, CAST(N'2020-01-09T00:00:00.0000000' AS DateTime2), N'Distribuidora de Perfiles Gonzalez', 2024.0000, N'Dos Mil Veinticuatro 00/100 Quetzales Exactos', N'Compra de material Proyecto Techo Salon Multiusos Seminario Teológico Nazareno, Equipo de Trabajo y Testimonio Lenexa, Kansas', N'5144R400NCA4001MCGT000', N'Compra de Material', 269.8667, 2024.0000, 7.5000, N'Roger Kellogg', N'Lic. Raúl Sosa', N'Lic. Raúl Sosa', 23)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (19, CAST(N'2020-01-09T00:00:00.0000000' AS DateTime2), N'TyT', 7749.4000, N'Siete Mil Setecientos Cuarenta y Nueve 40/100 Quetzales', NULL, NULL, NULL, 1033.2533, 7749.4000, 7.5000, N'Roger Kellogg', N'Lic. Raúl Sosa', N'Lic. Raúl Sosa', 23)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (20, CAST(N'2020-01-10T00:00:00.0000000' AS DateTime2), N'Esvin Dario Lopez', 32300.0000, N'Treinta y Dos Mil Trecientos 00/100 Quetzales Exactos', N'Pago por Mano de Obra, Proyecto Techo Salon Multiusos Seminario Teológico Nazareno, Equipo de Trabajo y Testimonio Lenexa, Kansas', N'5144R400NCA4001MCGT000', N'Mano de Obra', 4306.6667, 32300.0000, 7.5000, N'Roger Kellogg', N'Lic. Raúl Sosa', N'Lic. Raúl Sosa', 23)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (21, CAST(N'2020-01-29T00:00:00.0000000' AS DateTime2), N'Celasa (Budget purpose)', 10000.0000, NULL, NULL, NULL, NULL, 1333.3333, 10000.0000, 7.5000, NULL, NULL, NULL, 15)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (22, CAST(N'2020-01-29T00:00:00.0000000' AS DateTime2), N'Ferromax (Budeting)', 20257.0000, NULL, NULL, NULL, NULL, 2700.9333, 20257.0000, 7.5000, NULL, NULL, NULL, 15)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (24, CAST(N'2020-01-29T00:00:00.0000000' AS DateTime2), N'TyT Structure', 30000.0000, NULL, NULL, NULL, NULL, 4000.0000, 30000.0000, 7.5000, NULL, NULL, NULL, 15)
INSERT [dbo].[CheckSolicitud] ([CheckSolicitudID], [SolicitudDate], [CheckName], [CheckAmount], [TextDollarAmount], [PurchaseDescription], [AccountingCode], [ShortDesc], [USD], [LocalCurrency], [ExchangeRate], [RequestedBy], [ReviewedBy], [ApprovedBy], [ProjectID]) VALUES (25, CAST(N'2020-01-29T00:00:00.0000000' AS DateTime2), N'Don Eswing (Budgeting', 13704.0000, NULL, NULL, NULL, NULL, 1827.2000, 13704.0000, 7.5000, NULL, NULL, NULL, 15)
SET IDENTITY_INSERT [dbo].[CheckSolicitud] OFF
SET IDENTITY_INSERT [dbo].[ChurchName] ON 

INSERT [dbo].[ChurchName] ([ChurchID], [ChurchName], [DistrictID]) VALUES (0, N'NONE', 0)
INSERT [dbo].[ChurchName] ([ChurchID], [ChurchName], [DistrictID]) VALUES (1, N'MiCasa', 0)
INSERT [dbo].[ChurchName] ([ChurchID], [ChurchName], [DistrictID]) VALUES (2, N'John 3:16', 0)
SET IDENTITY_INSERT [dbo].[ChurchName] OFF
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([CountryID], [CountryName], [FieldID]) VALUES (0, N'NONE', 0)
INSERT [dbo].[Country] ([CountryID], [CountryName], [FieldID]) VALUES (1, N'Guatemala', 1)
INSERT [dbo].[Country] ([CountryID], [CountryName], [FieldID]) VALUES (2, N'El Salvador', 1)
INSERT [dbo].[Country] ([CountryID], [CountryName], [FieldID]) VALUES (3, N'Honduras', 1)
INSERT [dbo].[Country] ([CountryID], [CountryName], [FieldID]) VALUES (4, N'Nicaragua', 1)
SET IDENTITY_INSERT [dbo].[Country] OFF
SET IDENTITY_INSERT [dbo].[CurrencyType] ON 

INSERT [dbo].[CurrencyType] ([CurrencyTypeID], [CurrencyIndicator], [CurrencyName], [CountryID]) VALUES (0, N'NONE', N'NONE', 0)
SET IDENTITY_INSERT [dbo].[CurrencyType] OFF
SET IDENTITY_INSERT [dbo].[ExchangeRate] ON 

INSERT [dbo].[ExchangeRate] ([ExchangeRateID], [LastUpdate], [ExchangeRate], [CurrencyTypeID]) VALUES (0, NULL, 0.0000, 0)
INSERT [dbo].[ExchangeRate] ([ExchangeRateID], [LastUpdate], [ExchangeRate], [CurrencyTypeID]) VALUES (1, CAST(N'2020-02-03T00:00:00.0000000' AS DateTime2), 7.5000, 0)
INSERT [dbo].[ExchangeRate] ([ExchangeRateID], [LastUpdate], [ExchangeRate], [CurrencyTypeID]) VALUES (2, CAST(N'2020-02-03T00:00:00.0000000' AS DateTime2), 1.0000, 0)
INSERT [dbo].[ExchangeRate] ([ExchangeRateID], [LastUpdate], [ExchangeRate], [CurrencyTypeID]) VALUES (3, NULL, 0.0000, 0)
INSERT [dbo].[ExchangeRate] ([ExchangeRateID], [LastUpdate], [ExchangeRate], [CurrencyTypeID]) VALUES (4, NULL, 0.0000, 0)
SET IDENTITY_INSERT [dbo].[ExchangeRate] OFF
SET IDENTITY_INSERT [dbo].[Field] ON 

INSERT [dbo].[Field] ([FieldID], [FieldName], [RegionID]) VALUES (0, N'NONE', 0)
INSERT [dbo].[Field] ([FieldID], [FieldName], [RegionID]) VALUES (1, N'Nor Central', 1)
INSERT [dbo].[Field] ([FieldID], [FieldName], [RegionID]) VALUES (2, N'Mexico', 1)
SET IDENTITY_INSERT [dbo].[Field] OFF
SET IDENTITY_INSERT [dbo].[Hotel] ON 

INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (0, N'NONE', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (1, N'Seminary', 1, 0, NULL, NULL, 1, 0, 0, NULL, N'Guatemala', CAST(N'2020-02-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (2, N'Chisec', 1, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (3, N'Hotel Cristal', 1, 0, N'2', N'+502-78329528 / +502-52630822', 0, 0, 0, NULL, N'Antigua', NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (4, N'Hostal de Asturias', 2, 0, NULL, N'+503 2260-4333', 1, 0, 0, NULL, N'San Salvador', NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (5, N'Hotel Posada Santa Teresita', 1, 0, NULL, N'+502 78320755', 1, 0, 0, NULL, N'Antigua', NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (6, N'Hotel Cristal Antigua', 1, 0, NULL, NULL, 0, 0, 0, NULL, N'Antigua', NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (7, N'hostal de asturias', 2, 1, NULL, N'+503 22601572', 1, 1, 0, NULL, N'Miramonte San Salvador', NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (8, N'Alamo', 2, 1, NULL, N'+50325123174', 1, 1, 1, NULL, N'San Salvador', NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (9, N'Camino Real Antigua', 1, 1, NULL, N'+502 7873 7000', 1, 1, 0, NULL, N'Antigua Guatemala', NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (10, N'Porta Hotel del Lago', 0, 1, NULL, N'+5025 2244-0600', 1, 1, 0, NULL, N'Panajachel', NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (11, NULL, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL)
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (12, N'Ecologico', 1, 0, NULL, N'+502 5597 6191', 1, 1, 1, NULL, N'El Estor-Rio Dulce', CAST(N'2020-02-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Hotel] ([HotelID], [HotelName], [CountryID], [R&R], [Comments], [PhoneNum], [WiFi], [AirCond], [Pool], [MapLoc], [City], [LastUsed]) VALUES (13, N'Viñas del Lago', 1, 1, NULL, N'+502 7930 5053', 1, 1, 1, NULL, N'Rio dulce, livingston', NULL)
SET IDENTITY_INSERT [dbo].[Hotel] OFF
SET IDENTITY_INSERT [dbo].[Language] ON 

INSERT [dbo].[Language] ([LanguageID], [LanguageSpoken]) VALUES (0, N'NONE')
INSERT [dbo].[Language] ([LanguageID], [LanguageSpoken]) VALUES (1, N'English')
INSERT [dbo].[Language] ([LanguageID], [LanguageSpoken]) VALUES (2, N'Spanish')
INSERT [dbo].[Language] ([LanguageID], [LanguageSpoken]) VALUES (3, N'Portugese')
SET IDENTITY_INSERT [dbo].[Language] OFF
SET IDENTITY_INSERT [dbo].[LocalCoordinator] ON 

INSERT [dbo].[LocalCoordinator] ([LocalCoordID], [CoordName], [DistrictID], [CoordPhone], [CoordEmail]) VALUES (0, N'NONE PROVIDED', 0, N'NONE PROVIDED', N'NONE PROVIDED')
SET IDENTITY_INSERT [dbo].[LocalCoordinator] OFF
SET IDENTITY_INSERT [dbo].[Meals] ON 

INSERT [dbo].[Meals] ([MealID], [MealDesc], [DaysForThisMeal], [MealDateStart], [MealDateStop], [MealCost], [HowManyEating], [TeamDetailsID]) VALUES (0, N'NONE', 0, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0.0000, 0, 0)
SET IDENTITY_INSERT [dbo].[Meals] OFF
SET IDENTITY_INSERT [dbo].[Partnerships] ON 

INSERT [dbo].[Partnerships] ([PartnershipID], [Vision], [Scope], [TeamID], [SelectedPartnerID]) VALUES (0, N'NONE', N'NONE', 0, 0)
SET IDENTITY_INSERT [dbo].[Partnerships] OFF
SET IDENTITY_INSERT [dbo].[Project] ON 

INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, NULL, 0, 0, 0, 0, NULL, 0, 0, 0, NULL, 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, NULL, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (4, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 6, 49, N'NONE PROVIDED', N'Luciano Teni Cucul', N'4813-2660', N'https://www.google.com/maps/place/15%C2%B031''45.9%22N+89%C2%B020''56.2%22W/@15.5294198,-89.3511262,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d15.5294198!4d-89.3489375?hl=es', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 10, 20, N'NONE PROVIDED', 0, 0, 1, 1, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 1, CAST(N'9999-09-09' AS Date), 1, CAST(N'9999-09-09' AS Date), 0, 1, CAST(N'9999-09-09' AS Date), 1, 1, 1, 0, N'https://workandwitnessadmin.nazarene.org/WorkAndWitnessAdmin/auth/projects/view.xhtml?pid=4866', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (9, 0, CAST(N'2018-10-25' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 6, 0, N'NONE PROVIDED', N'Heriberto Ba Caal', N'4097-0489', N'NONE PROVIDED', N'NONE PROVIDED', 90.2700, 78.9100, 40.5400, 37.5700, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 15, 26, N'NONE PROVIDED', 0, 0, 1, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 1, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 1, CAST(N'9999-09-09' AS Date), 1, 1, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (12, 0, CAST(N'2018-08-20' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 6, 47, N'NONE PROVIDED', N'Gregorio Maas Ico', N'5064-8109', N'https://www.google.com/maps/place/15°21''49.1"N+90°14''05.8"W/@15.3634716,-90.234921,232m/data=!3m1!1e3!4m5!3m4!1s0x0:0x0!8m2!3d15.3636413!4d-90.2349324?hl=es', N'NONE PROVIDED', 404.0000, 266.0000, 133.0000, 66.0000, CAST(N'1964-01-01T00:00:00.0000000' AS DateTime2), 248, 260, 130, 140, N'NONE PROVIDED', 180, 14, 26, N'Roof', 14, 26, 0, 0, 0, 0, 20000.0000, 20000.0000, 2000.0000, N'NONE PROVIDED', 1, 1, 0, 1, 1, 1, 1, CAST(N'2018-08-15' AS Date), 1, CAST(N'2018-08-15' AS Date), 1, 1, CAST(N'2018-08-15' AS Date), 1, 1, 1, 0, N'https://workandwitnessadmin.nazarene.org/WorkAndWitnessAdmin/auth/projects/view.xhtml?pid=4883', N'T:\Projects\2020\Chamisun\', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 0, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (13, 0, CAST(N'2019-08-05' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 6, 51, N'NONE PROVIDED', N'Wally Josue Hernandez', N'5553-6302 / 5805-9976', N'NONE PROVIDED', N'NONE PROVIDED', 1765.0000, 1977.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 10, 23, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 1, 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 1, CAST(N'9999-09-09' AS Date), 1, 1, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 0, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (14, 0, CAST(N'2019-08-26' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 6, 43, N'NONE PROVIDED', N'Gustavo Chic', N'4524-3623', N'NONE PROVIDED', N'68 km', 84.0000, 238.0000, 17.5600, 40.5400, CAST(N'2017-07-30T00:00:00.0000000' AS DateTime2), 60, 60, 60, 66, N'NONE PROVIDED', 180, 8, 17, N'Building a meeting place at the district center', 50, 50, 0, 0, 0, 0, 5405.4000, 5405.4000, 0.0000, N'NONE PROVIDED', 1, 1, 0, 1, 1, 1, 1, CAST(N'2019-05-28' AS Date), 1, CAST(N'2019-05-28' AS Date), 1, 1, CAST(N'2019-05-28' AS Date), 1, 1, 1, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (15, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 6, 1, N'NONE PROVIDED', N'Erwin Bol', N'5951-9225', N'https://www.google.com/maps/place/14%C2%B032''48.6%22N+90%C2%B044''50.6%22W/@14.5468387,-90.7495761,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d14.5468387!4d-90.7473874?hl=es', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 10, 25, N'NONE PROVIDED', 12, 32, 1, 1, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 1, 0, 0, 1, 1, 0, 0, CAST(N'9999-09-09' AS Date), 1, CAST(N'9999-09-09' AS Date), 1, 1, CAST(N'2019-03-15' AS Date), 1, 1, 1, 0, N'https://workandwitnessadmin.nazarene.org/WorkAndWitnessAdmin/auth/projects/view.xhtml?pid=3876', N'T:\Projects\2020\Antigua\', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (16, 0, CAST(N'2019-09-02' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 3, 44, N'NONE PROVIDED', N'Billy Emanuel Salas', N'+503 6633 5693', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 1, CAST(N'2019-08-26' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 0, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (17, 0, CAST(N'2019-09-02' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 6, 44, N'NONE PROVIDED', N'Jose Angel Mendoza', N'+503 7111 7542', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 8, 16, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 1, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 2, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (18, 0, CAST(N'2019-09-02' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 0, 44, N'NONE PROVIDED', N'Ovidio Bernal', N'+503 7558 1513', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 1, CAST(N'2019-08-30' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 0, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (19, 0, CAST(N'2019-06-01' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 1, 59, N'NONE PROVIDED', N'Rafael Rodriguez Ramirez', N'+503 7932 8328', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 25, 36, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'2019-06-01' AS Date), 1, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 1, 0, 1, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 2, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (20, 0, CAST(N'2019-05-13' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 2, 60, N'NONE PROVIDED', N'Oscar Cal Laj', N'5776 3190', N'NONE PROVIDED', N'NONE PROVIDED', 200.0000, 40.0000, 40.0000, 12.0000, CAST(N'2018-12-17T00:00:00.0000000' AS DateTime2), 50, 60, 46, 55, N'is not ready', 0, 0, 0, N'NONE PROVIDED', 12, 9, 0, 0, 0, 0, 3000.0000, 3000.0000, 2500.0000, N'NONE PROVIDED', 1, 1, 1, 1, 1, 1, 1, CAST(N'2019-07-30' AS Date), 1, CAST(N'2019-05-19' AS Date), 1, 1, CAST(N'2019-05-17' AS Date), 1, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (21, 0, CAST(N'2019-05-14' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 6, 42, N'NONE PROVIDED', N'Erwin Chun Caal', N'4067 6740', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'Change Roof', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 0, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (22, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, N'NONE PROVIDED', N'Hugo Lucero', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 6, 16, N'galera de 6.5 metros de ancho x 16 metros de largo', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 0, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (23, 0, CAST(N'2019-10-07' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 6, 1, N'NONE PROVIDED', N'Leonel De Leon', N'NONE PROVIDED', N'NONE PROVIDED', N'0', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'Training and support of the Area', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 1, 0, 1, 1, 1, 1, CAST(N'9999-09-09' AS Date), 1, CAST(N'9999-09-09' AS Date), 1, 1, CAST(N'9999-09-09' AS Date), 0, 1, 1, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (24, 0, CAST(N'2019-02-01' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 10, 48, N'NONE PROVIDED', N'Manuel Tec Maquin', N'5738 1617', N'https://www.google.com/maps/place/17%C2%B005''14.8%22N+90%C2%B043''52.0%22W/@17.0874374,-90.7333113,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d17.0874374!4d-90.7311226?hl=es', N'NONE PROVIDED', 425.2500, 0.0000, 142.0000, 0.0000, CAST(N'2005-01-01T00:00:00.0000000' AS DateTime2), 21, 32, 30, 50, N'The roof is ruined in all the parts - They build another construction and need a roof', 80, 10, 18, N'NONE PROVIDED', 15, 51, 1, 1, 1, 0, 110029.0000, 110029.0000, 0.0000, N'We don''t have the resources because there was no harvest proque solo en ella nos dedicamos', 1, 1, 0, 1, 1, 1, 1, CAST(N'2019-01-29' AS Date), 1, CAST(N'2019-01-29' AS Date), 1, 1, CAST(N'2017-09-10' AS Date), 1, 1, 1, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (25, 0, CAST(N'2019-07-16' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 0, 54, N'NONE PROVIDED', N'Gregorio Benjamin Tzuo Cuin', N'5162-0441', N'NONE PROVIDED', N'80 km', 491.4500, 1184.0000, 37.2500, 116.5000, CAST(N'2015-11-29T00:00:00.0000000' AS DateTime2), 66, 68, 30, 30, N'NONE PROVIDED', 80, 12, 20, N'North 24.69 South 29.45 West 19.59 East 19.19', 0, 0, 0, 0, 0, 0, 9000.0000, 0.0000, 10000.0000, N'Urge construir un templo porque la iglesa no tinene Templo. Solo esta alquilando por este medio solicitamos ayuda pro el amor de dios suplicomos tomar en cuenta estea solicitud porque lost hermanos somos de escasos recursos.', 0, 1, 0, 0, 1, 1, 1, CAST(N'2019-07-16' AS Date), 1, CAST(N'2019-07-16' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (26, 0, CAST(N'2015-06-26' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 0, 54, N'NONE PROVIDED', N'Natanael Geronimo', N'+502 4905 4482', N'https://www.google.com/maps/place/15%C2%B021''49.1%22N+90%C2%B014''05.8%22W/@15.3635553,-90.2354187,403m/data=!3m1!1e3!4m5!3m4!1s0x0:0x0!8m2!3d15.3636413!4d-90.2349324?hl=es', N'NONE PROVIDED', 0.0000, 0.0000, 17.0000, 64.0000, CAST(N'1995-01-05T00:00:00.0000000' AS DateTime2), 50, 60, 0, 0, N'NONE PROVIDED', 0, 7, 20, N'NONE PROVIDED', 7, 20, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 1, 1, 1, 1, 1, 1, 1, CAST(N'2015-06-25' AS Date), 1, CAST(N'2019-06-26' AS Date), 1, 1, CAST(N'2019-06-26' AS Date), 1, 1, 1, 0, N'https://workandwitnessadmin.nazarene.org/WorkAndWitnessAdmin/auth/projects/view.xhtml?pid=4104', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (27, 0, CAST(N'2019-08-12' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 0, 43, N'NONE PROVIDED', N'Samuel Coc', N'+502 5781 9126', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'Techo y construccion de salon para reuniones', 10, 20, 0, 0, 0, 0, 9200.0000, 9200.0000, 0.0000, N'NONE PROVIDED', 1, 1, 0, 1, 0, 0, 0, CAST(N'9999-09-09' AS Date), 1, CAST(N'2019-08-10' AS Date), 1, 1, CAST(N'2019-08-10' AS Date), NULL, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (28, 0, CAST(N'2019-08-05' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 5, 51, N'NONE PROVIDED', N'Mario Pineda', N'&nbsp5002-7001', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'Piso y Techo', 0, 0, 0, N'NONE PROVIDED', 6, 17, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 1, 1, 0, 1, 0, 0, 0, CAST(N'9999-09-09' AS Date), 1, CAST(N'2019-08-06' AS Date), 1, 0, CAST(N'9999-09-09' AS Date), 1, 1, 1, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (30, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 3, 39, N'NONE PROVIDED', N'Juan Garza', N'9570-2528', N'NONE PROVIDED', N'NONE PROVIDED', 7720.0000, 11640.0000, 0.0000, 0.0000, CAST(N'1980-01-01T00:00:00.0000000' AS DateTime2), 72, 79, 53, 62, N'Sunday school class rooms', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 50000.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 1, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 3, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (31, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 0, 41, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 4, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (32, 0, CAST(N'2019-08-22' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 7, 56, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'T:\Projects\2020\4NazaGol - Becky Lazarte\', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 2, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (33, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 6, 54, N'NONE PROVIDED', N'Odilia Ramos Lopez', N'+502 4287-7621', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 257.0000, 0.0000, 142.0000, CAST(N'2015-03-01T00:00:00.0000000' AS DateTime2), 40, 42, 10, 15, N'Galera, aulas escuela dominical', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 1, 1, 1, 1, 1, 1, 1, CAST(N'2019-09-14' AS Date), 1, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (34, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 0, 43, N'NONE PROVIDED', N'Jose Pa Xol', N'+502 5199-5064 / +502 5322-0999', N'NONE PROVIDED', N'NONE PROVIDED', 1157.3700, 1204.7000, 106.0000, 229.2000, CAST(N'2019-11-19T00:00:00.0000000' AS DateTime2), 81, 81, 63, 65, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (36, 0, CAST(N'2019-11-29' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 0, 61, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 40, 60, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 4, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (37, 0, CAST(N'2019-11-29' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 0, 61, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), NULL, 80, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 4, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (38, 0, CAST(N'2019-11-29' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 0, 61, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 30, 45, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 1, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 4, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (39, 0, CAST(N'2019-11-29' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 2, 61, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 30, 50, 0, 0, N'Construccion de Casa Pastoral', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 4, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (40, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 11, 44, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 2, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (41, 0, CAST(N'2020-01-02' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 12, 39, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 3, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (42, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 11, 40, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 3, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (43, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 1, 40, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 3, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (44, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 3, 40, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'15000', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 3, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (45, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 13, 1, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'NONE PROVIDED', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
INSERT [dbo].[Project] ([ProjectID], [WWCoordID], [DateReceived], [LinkToWWsite], [UserPermission], [ProjectTypeID], [DistrictID], [CityName], [PastorName], [PastorPhone], [LocationLink], [DistanceFromDistrictOff], [DistrictBudgetCurrent], [DistrictBudgetLast], [FEMcurrent], [FEMlast], [DateOrganized], [MembersLast], [MembersCurrent], [AvgAttendanceLast], [AvgAttendanceCurr], [ProjectDesc], [TempleCapacity], [RoofWidth], [RoofLength], [BriefDescriptionConst], [PropertyWidth], [PropertyLength], [Photos], [Digital], [LotLayout], [ProjectPlans], [MoneyRaised], [MoneyInvested], [Money12Months], [ProjectNeed], [TitleToProperty], [PropertyDeededToChurch], [BuildingPermitNeeded], [BuildingPermitApproved], [PastorApproved], [ChurchBoardApproved], [TreasureApproved], [TreasureApprovalDate], [SuperApproval], [SuperApprovalDate], [DistrictSecretaryApproval], [DistrictTreasureApproval], [DistrictTreasureApprovalDate], [DistrictPriority], [TyTapproved], [TyTPriority], [ProjectCompleted], [Wwlink], [PhotoLocation], [PermitStart], [PermitEnd], [CountryID], [ChurchID]) VALUES (46, 0, CAST(N'2020-01-30' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', 14, 54, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0.0000, 0.0000, 0.0000, 0.0000, CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, N'NONE PROVIDED', 0, 0, 0, N'Install Water Filters', 0, 0, 0, 0, 0, 0, 0.0000, 0.0000, 0.0000, N'7000', 0, 0, 0, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, CAST(N'9999-09-09' AS Date), 0, 0, CAST(N'9999-09-09' AS Date), 0, 1, 0, 0, N'NONE PROVIDED', N'NONE PROVIDED', CAST(N'9999-09-09' AS Date), CAST(N'9999-09-09' AS Date), 1, NULL)
SET IDENTITY_INSERT [dbo].[Project] OFF
SET IDENTITY_INSERT [dbo].[ProjectNotes] ON 

INSERT [dbo].[ProjectNotes] ([ProjectNoteID], [Pdate], [Pnotes], [ProjectID]) VALUES (0, CAST(N'2019-11-20T00:00:00.0000000' AS DateTime2), NULL, 0)
INSERT [dbo].[ProjectNotes] ([ProjectNoteID], [Pdate], [Pnotes], [ProjectID]) VALUES (12, CAST(N'2019-10-07T00:00:00.0000000' AS DateTime2), N'Tomas Suas (Mayordomo)
5041-3360', 25)
INSERT [dbo].[ProjectNotes] ([ProjectNoteID], [Pdate], [Pnotes], [ProjectID]) VALUES (13, CAST(N'2019-11-15T00:00:00.0000000' AS DateTime2), NULL, 14)
INSERT [dbo].[ProjectNotes] ([ProjectNoteID], [Pdate], [Pnotes], [ProjectID]) VALUES (14, CAST(N'2019-11-20T00:00:00.0000000' AS DateTime2), NULL, 25)
SET IDENTITY_INSERT [dbo].[ProjectNotes] OFF
SET IDENTITY_INSERT [dbo].[ProjectPhotos] ON 

INSERT [dbo].[ProjectPhotos] ([ProjectPhotosID], [ProjectPhotos], [ProjectID]) VALUES (0, N'NONE', 0)
SET IDENTITY_INSERT [dbo].[ProjectPhotos] OFF
SET IDENTITY_INSERT [dbo].[ProjectType] ON 

INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (0, N'NONE PROVIDED', 0)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (1, N'Templo', NULL)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (2, N'Casa Pastoral', NULL)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (3, N'Aulas De ED', NULL)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (4, N'Casa Districtal', NULL)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (5, N'Centro Districal', NULL)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (6, N'Techo', NULL)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (7, N'NazaGol', NULL)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (10, N'Extreme Team', 0)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (11, N'Medical Team', 0)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (12, N'Leadership Training', 0)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (13, N'Seminary Maintenance', 0)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectType], [ListOrder]) VALUES (14, N'Water Filters', 0)
SET IDENTITY_INSERT [dbo].[ProjectType] OFF
SET IDENTITY_INSERT [dbo].[Region] ON 

INSERT [dbo].[Region] ([RegionID], [RegionName]) VALUES (0, N'NONE PROVIDED')
INSERT [dbo].[Region] ([RegionID], [RegionName]) VALUES (1, N'Mesoamerica')
SET IDENTITY_INSERT [dbo].[Region] OFF
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (1, N'Beginner', 1)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (2, N'Intermediate', 1)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (3, N'Expert', 1)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (1, N'Beginner', 1)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (2, N'Intermediate', 1)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (3, N'Expert', 1)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (1, N'Beginner', 2)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (2, N'Intermediate', 2)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (3, N'Expert', 2)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (1, N'Beginner', 3)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (2, N'Intermediate', 3)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (3, N'Expert', 3)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (1, N'Beginner', 4)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (2, N'Intermediate', 4)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (3, N'Expert', 4)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (1, N'Beginner', 5)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (2, N'Intermediate', 5)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (3, N'Expert', 5)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (1, N'Beginner', 6)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (2, N'Intermediate', 6)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (3, N'Expert', 6)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (1, N'Beginner', 7)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (2, N'Intermediate', 7)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (3, N'Expert', 7)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (1, N'Beginner', 8)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (2, N'Intermediate', 8)
INSERT [dbo].[SkillLevel] ([SkillLevelId], [SkillLevel], [SkillsID]) VALUES (3, N'Expert', 8)
SET IDENTITY_INSERT [dbo].[Skills] ON 

INSERT [dbo].[Skills] ([SkillsID], [Skill]) VALUES (0, N'NONE PROVIDED')
INSERT [dbo].[Skills] ([SkillsID], [Skill]) VALUES (1, N'Team Host')
INSERT [dbo].[Skills] ([SkillsID], [Skill]) VALUES (2, N'Truck Driver')
INSERT [dbo].[Skills] ([SkillsID], [Skill]) VALUES (3, N'Bus Driver')
INSERT [dbo].[Skills] ([SkillsID], [Skill]) VALUES (4, N'Translator')
INSERT [dbo].[Skills] ([SkillsID], [Skill]) VALUES (5, N'Electrition')
INSERT [dbo].[Skills] ([SkillsID], [Skill]) VALUES (6, N'Welder')
INSERT [dbo].[Skills] ([SkillsID], [Skill]) VALUES (7, N'Block Layer')
INSERT [dbo].[Skills] ([SkillsID], [Skill]) VALUES (8, N'Tool Driver')
SET IDENTITY_INSERT [dbo].[Skills] OFF
SET IDENTITY_INSERT [dbo].[SSMA$District$local] ON 

INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (0, N'NONE PROVIDED', 0)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (1, N'Central', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (38, N'Franja Occidental Guatemala', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (39, N'Nor Occidente', 3)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (40, N'Centro Sur-Oriente', 3)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (41, N'Sureste De Nicaragua', 4)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (42, N'Franja Central', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (43, N'Sur Occidental de Peten', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (44, N'Central', 2)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (45, N'Norte De Nicaragua', 4)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (46, N'Noroccidente', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (47, N'Verapaz del Norte', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (48, N'Norte', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (49, N'Verapaz Oriental', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (50, N'Suroriente', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (51, N'Atlántico', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (52, N'Franja Oriental', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (53, N'Norte de Cobán', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (54, N'Occidente', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (56, N'Occidente', 2)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (57, N'Baja Verapaz', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (58, N'Sur', 4)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (59, N'Oriente', 2)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (60, N'Verapaz del Sur', 1)
INSERT [dbo].[SSMA$District$local] ([DistrictID], [DistrictName], [CountryID]) VALUES (61, N'Central', 4)
SET IDENTITY_INSERT [dbo].[SSMA$District$local] OFF
SET IDENTITY_INSERT [dbo].[Supers] ON 

INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (1, 1, N'Cesar Ayala', N'5022514687', N'cesar.ayala@micasa.net.gt', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (7, 38, N'Abelino Bol', N'50248986168', N'abelinobol@hotmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (8, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (9, 39, N'Etan Bardales', N'504 3283 9956', N'pastoralex@hotmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (10, 40, N'Begardo Bardales', N'504 99858498', N'distrito_honduras@yahoo.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (11, 41, N'Carlos Pena', N'505 8839 2094', N'carlos_70nic@yahoo.es', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (12, 42, N'Agusto Misti', N'502 5706 6311', N'dnfranjacentral@yahoo.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (13, 43, N'Samuel Coc', N'502 57819126', N'suroccipeten@gmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (14, 44, N'Julian Cruz', N'503 78606203', N'juliannaz@hotmail.es', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (15, 45, N'Denis Espinoza', N'505 8494 6156', N'iglnazdn@hotmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (16, 46, N'Edgar Figueroa', N'502 5376 5675', N'noroccidente@gmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (17, 47, N'Francisco Cho', N'502 4990 4320', N'nazarenoverapazdelnore@gmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (18, 48, N'Francisco Quej', N'+502 55171722', NULL, N'+502 79260621', N'distritonortepeten@hotmail.com')
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (19, 0, N'Francisco Quej', N'502 5517 1722', N'distritonortepeten@hotmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (20, 49, N'Ignacio Quej', N'502 3113 8359', N'ignacioquej@gmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (21, 50, N'Luis Marroquin', N'502 5979 0753', N'marrcast@yahoo.es', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (22, 51, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (23, 0, N'Pineda Mario', N'502 50027001', N'pastorpinedamario@hotmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (24, 52, N'Nery Teni Medina', N'502 3037 2110', N'nerytenimedina@hotmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (25, 53, N'Miguel Xol', N'502 4041 9305', N'ministroxol@yahoo.es', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (26, 54, N'Rene Orellana', N'502 5959 3394', N'renem90@yahoo.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (27, 61, N'Maria Antonia Ponce', N'505 8768 1062', N'maanponce@hotmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (28, 56, N'Alexander Castro', N'503 2563 3718', N'lexlexcastro@hotmail.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (29, 57, N'Leonel De Leon', N'502 4033 1365', N'lbdeleon@me.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (30, 58, N'Gerardo Reyes', N'505 8466 1455', N'reyes_villarrial@yahoo.com', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (31, 59, N'Ulises Solis', N'502 3031 1080', N'usolis@norcentral.org', NULL, NULL)
INSERT [dbo].[Supers] ([SuperID], [DistrictID], [SuperName], [SuperPhone], [SuperEmail], [SuperMobile], [SuperWorkEmail]) VALUES (32, 60, N'Victor Bin', N'502 4051 1350', N'victormanuelbin@hotmail.com', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Supers] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (0, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (2, N'Pastor Mark', N'Maine, Church of the Nazarene', N'Maine', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (5, N'Encuentro', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (6, N'Pete Demars', N'Lenexa Central', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (7, N'Bethel Sunday School', N'Bethel Nazarene Nampa Idaho', N'Intermountain District', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (8, N'Becky LaZerte', N'Faithbrook MN', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (9, N'Tamara Tolley', N'WestSide Medical', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (10, N'Water Filter Team', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (11, N'Bryan Heil', N'West Carrollton Nazarene', N'Southwestern Ohio', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (12, N'Jeremy Bowden', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (13, N'Hagerstown MD', N'Kevin Liddle', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (14, N'Don and Lana', N'Springdale Nazarene', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (15, N'Matt and Fay Wagner', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (16, N'Bethel Teens', N'Bethel Nazarene Nampa Idaho', N'Intermountain District', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (17, N'Wollaston MA', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (18, N'Shane Lima', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (19, N'Wichita 1st', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (20, N'Indy District', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (21, N'Chris Kaplan', N'Danli Medical Team', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (22, N'Carol Byran', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (23, N'Springfield High Stree CN Ohio', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (24, N'Penny Ure', N'Canada', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (26, N'Blank Please put a different Team here', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (27, N'Thomas & Paula', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (28, N'Blank Use for a New Team', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (29, N'Countryside Nazarene', N'NONE PROVIDED', N'NONE PROVIDED', N'ljones@ccnaz.org', N'Lester Jones', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (30, N'Grove City', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'Dan Baumgardner', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (31, N'Ken Brubaker', N'NONE PROVIDED', N'KC District', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (32, N'Doug Jones', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (33, N'Crystal Bramlett', N'NONE PROVIDED', N'South Carolina', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (34, N'Susan Wendleton', N'Carthage Nazarene', N'Missouri', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (35, N'Ed and Kathy', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (36, N'Debby Johnson', N'Grace Point Church of the Nazarene', N'NONE PROVIDED', N'NONE PROVIDED', N'Debby Johnson', 0)
INSERT [dbo].[Team] ([TeamID], [TeamName], [ChurchName], [District], [LeaderEmail], [LeaderName], [Partership]) VALUES (37, N'NTN', N'NCN', N'ND', N'NLE', N'NLN', 0)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[TeamDetails] ON 

INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (0, 0.0000, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0.0000, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (7, 0.0000, 20, 0, 0, 0, 0, N'0', NULL, CAST(N'2019-10-07' AS Date), NULL, CAST(N'2019-10-11' AS Date), NULL, NULL, 0, 5, 0, 0, 0, 1, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (8, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2019-10-12' AS Date), NULL, CAST(N'2019-10-20' AS Date), NULL, NULL, 0, 6, 0, 0, 0, 1, NULL, 0, 0, 0, NULL, NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (9, 9180.0000, 17, 0, NULL, 9, 6, N'1013', CAST(N'1899-12-30T19:22:00.0000000' AS DateTime2), CAST(N'2019-10-31' AS Date), CAST(N'1899-12-30T07:20:00.0000000' AS DateTime2), CAST(N'2019-11-10' AS Date), N'American Airlines', N'1188', 0, 7, 0, 0, 0, 1, 6, 0, 0, 0, 10000.0000, NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (10, 0.0000, 0, 0, 0, 0, 0, N'si', NULL, CAST(N'2020-01-02' AS Date), NULL, CAST(N'2020-01-11' AS Date), NULL, NULL, 42, 21, 0, 0, 0, 3, NULL, 0, 0, 0, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (11, 0.0000, 0, 0, 0, 0, 0, N'Si', NULL, CAST(N'2020-01-16' AS Date), NULL, CAST(N'2020-01-25' AS Date), NULL, NULL, 43, 22, 0, 0, 2, 3, NULL, 0, 0, 0, 257.0000, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (12, 65.0000, 19, 0, 3, 9, 8, N'UA 1451', CAST(N'1899-12-30T14:57:00.0000000' AS DateTime2), CAST(N'2020-02-01' AS Date), CAST(N'1899-12-30T07:10:00.0000000' AS DateTime2), CAST(N'2020-02-09' AS Date), NULL, N'UA 1467', 40, 9, 0, 0, 0, 2, NULL, 1, 1, 0, 3564.1700, NULL, NULL, 3, NULL, NULL, 4, 5, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (13, 65.0000, 18, 0, 2, 11, 10, N'DL872', CAST(N'1899-12-30T12:44:00.0000000' AS DateTime2), CAST(N'2020-02-12' AS Date), CAST(N'1899-12-30T13:46:00.0000000' AS DateTime2), CAST(N'2020-02-22' AS Date), NULL, N'DL374', 32, 8, 0, 0, 0, 2, NULL, 0, 0, 0, 11400.0000, NULL, NULL, 3, NULL, NULL, 4, 5, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (14, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-03-14' AS Date), NULL, CAST(N'2020-03-23' AS Date), NULL, NULL, 23, 6, 0, 0, 0, 1, NULL, 0, 0, 0, NULL, NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (15, 0.0000, 0, 0, 7, 0, 0, N'0', NULL, CAST(N'2020-03-25' AS Date), NULL, CAST(N'2020-04-03' AS Date), NULL, NULL, 0, 10, 0, 0, 0, 0, 6, 0, 0, 0, 7000.0000, NULL, NULL, 21, NULL, NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (16, NULL, 14, 0, 2, 10, 9, N'DL 904', CAST(N'1899-12-30T12:09:00.0000000' AS DateTime2), CAST(N'2020-04-19' AS Date), CAST(N'1899-12-30T13:21:00.0000000' AS DateTime2), CAST(N'2020-04-27' AS Date), NULL, N'DL 906', 12, 11, 0, 0, 0, 1, 6, 1, 0, 1, 12000.0000, NULL, NULL, 15, NULL, 12, 11, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (18, 0.0000, 0, 0, 5, 0, 0, N'0', NULL, CAST(N'2021-06-07' AS Date), NULL, CAST(N'2021-06-23' AS Date), NULL, NULL, 0, 13, 0, 0, 0, 1, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (19, 0.0000, 20, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-06-19' AS Date), NULL, CAST(N'2020-06-26' AS Date), NULL, NULL, 0, 5, 0, 0, 0, 1, 6, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (20, 0.0000, 20, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-06-26' AS Date), NULL, CAST(N'2020-07-04' AS Date), NULL, NULL, 0, 5, 0, 0, 0, 1, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (21, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-07-04' AS Date), NULL, CAST(N'2020-07-12' AS Date), NULL, NULL, 0, 6, 0, 0, 0, 1, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (22, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-07-04' AS Date), NULL, CAST(N'2020-07-12' AS Date), NULL, NULL, 26, 14, 0, 0, 0, 1, 6, 0, 0, 0, NULL, NULL, NULL, 20, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (23, 0.0000, 0, 0, 0, 0, 0, N'Honduras', NULL, CAST(N'2020-07-09' AS Date), NULL, CAST(N'2020-07-18' AS Date), NULL, NULL, 44, 23, 0, 0, 0, 3, NULL, 0, 0, 0, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (24, NULL, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-07-15' AS Date), NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 20, 15, 0, 0, 0, 1, NULL, 0, 0, 0, NULL, NULL, NULL, 20, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (25, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-07-24' AS Date), NULL, CAST(N'2020-08-03' AS Date), NULL, NULL, NULL, 16, 0, 0, 0, 1, NULL, 0, 0, 1, NULL, NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (26, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-07-17' AS Date), NULL, CAST(N'2020-07-24' AS Date), NULL, NULL, 0, 24, 0, 0, 0, 1, NULL, 0, 0, 0, NULL, NULL, NULL, 21, NULL, NULL, 11, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (27, 0.0000, 0, 0, 0, 0, 0, N'Honduras', NULL, CAST(N'2020-08-12' AS Date), NULL, CAST(N'2020-08-22' AS Date), NULL, NULL, 0, 17, 0, 0, 0, 3, NULL, 0, 0, 0, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (28, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-08-28' AS Date), NULL, CAST(N'2020-08-05' AS Date), NULL, NULL, 0, 18, 0, 0, 0, 3, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (33, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-10-25' AS Date), NULL, CAST(N'2020-10-31' AS Date), NULL, NULL, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 10000.0000, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (34, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2021-03-04' AS Date), NULL, CAST(N'2021-03-16' AS Date), NULL, NULL, 31, 31, 0, 0, 0, 4, 0, 0, 0, 0, 0.0000, 0, 0, 18, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (35, 0.0000, 0, 0, 0, 0, 0, N'Honduras', NULL, CAST(N'2020-03-18' AS Date), NULL, CAST(N'2020-04-01' AS Date), NULL, NULL, 30, 32, 0, 0, 0, 3, 0, 0, 0, 0, 15000.0000, 0, 0, 14, 0, 0, 0, 0, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (37, 65.0000, 20, 0, 2, 11, 0, N'UAL1909', CAST(N'1899-12-30T15:35:00.0000000' AS DateTime2), CAST(N'2020-02-12' AS Date), CAST(N'1899-12-30T23:50:00.0000000' AS DateTime2), CAST(N'2020-02-22' AS Date), NULL, N'UAL1208', 4, 2, 0, 0, 0, 1, 6, 0, 0, 1, 10000.0000, 0, 0, 15, 0, 12, 11, 0, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (38, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-06-05' AS Date), NULL, CAST(N'2020-06-14' AS Date), NULL, NULL, 0, 12, 0, 0, 0, 1, 6, 0, 0, 0, 12000.0000, 0, 0, 15, 0, 12, 11, 0, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (39, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-07-03' AS Date), NULL, CAST(N'2020-07-12' AS Date), NULL, NULL, 0, 33, 0, 0, 0, 4, 5, 0, 0, 0, 0.0000, 0, 0, 18, 0, 0, 0, 0, NULL, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (40, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-05-30' AS Date), NULL, CAST(N'2020-06-07' AS Date), NULL, NULL, 0, 34, 0, 0, 0, 4, 5, 0, 0, 0, 0.0000, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (41, 0.0000, 0, 0, 0, 0, 0, N'0', NULL, CAST(N'2020-08-08' AS Date), NULL, CAST(N'2020-08-16' AS Date), NULL, NULL, 0, 35, 0, 0, 0, 1, 6, 0, 0, 1, 0.0000, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (42, 0.0000, 0, 0, 6, 0, 0, N'Honduras', NULL, CAST(N'2020-02-01' AS Date), NULL, CAST(N'2020-02-04' AS Date), NULL, NULL, 41, 29, 0, 0, 0, 3, 0, 0, 0, 0, 0.0000, 0, 0, 17, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (43, 0.0000, 0, 0, 2, 0, 0, NULL, NULL, CAST(N'2020-10-17' AS Date), NULL, CAST(N'2020-10-24' AS Date), NULL, NULL, 45, 2, 0, 0, 0, 1, 6, 0, 0, 0, 2200.0000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (44, 0.0000, 0, 0, 0, 0, 0, N'No Flight', NULL, CAST(N'2020-01-10' AS Date), NULL, CAST(N'2020-01-31' AS Date), NULL, NULL, 23, 6, 0, 0, 0, 1, 0, 0, 0, 0, 20665.0000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
INSERT [dbo].[TeamDetails] ([TeamDetailsID], [TotalDailyFunds], [NumTeamMemb], [TeamMemberID], [TeamTypeID], [NumberOfDays], [NumberOfNights], [ArriveFlightNumber], [ArriveTime], [ArriveDate], [DepartTime], [DepartDate], [DepartAirline], [DepartFlightNumber], [ProjectID], [TeamID], [DistanceToRR], [DistanceToProject], [HotelID], [CountryID], [AirportID], [TeamRegistration], [Insurance], [Maxima], [ProjectMoney], [PartnershipID], [TeamPartnerProfileID], [TeamHost], [CulBroker], [TruckDriver], [BusDriver], [Translator], [StructureDelivery], [CancelTeam], [ProjectFundsReceived]) VALUES (45, 0.0000, 0, 0, 0, 0, 0, NULL, NULL, CAST(N'2021-06-06' AS Date), NULL, CAST(N'2021-06-06' AS Date), NULL, NULL, 0, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0.0000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[TeamDetails] OFF
SET IDENTITY_INSERT [dbo].[TeamMember] ON 

INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (1, N'Pastor Mark', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 1, 2, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (2, N'Manuel Gonzales', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (3, N'Dan Ermovick', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (4, N'Alejandro Rivas', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (5, N'Josseline Hernandez', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (6, N'James Smith', N'NONE PROVIDED', N'James.Smith@mvnu.edu', N'NONE PROVIDED', 0, 1, 0, 1, 1, 5, CAST(N'2020-06-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (7, N'Bob Evans', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 5, CAST(N'2020-06-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (8, N'Shawn Evans', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 5, CAST(N'2020-06-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (10, N'Milton Gay', N'NONE PROVIDED', N'Guatemala', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'2253 94308 0101', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (11, N'Estuardo Perez', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (12, N'Gerbeth Cho', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (13, N'Mitchel Ramos', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (14, N'Brian Raurk', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (15, N'Roger Kellogg', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (16, N'Bob Shea', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (17, N'Efriam Soriano', N'+504-9976-1679', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (18, N'Tony Picado', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (19, N'Elizabeth Hernandez', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (20, N'Don Roe', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (21, N'Damaris Kellogg', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 0, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (22, NULL, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 0, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (23, N'James Tolley', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'2020-02-01' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (24, N'Tamara Tolley', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 1, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (25, N'Barb Sheller', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (26, N'Shelley Otto', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (27, N'Tammy Hempstead', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (28, N'Katlyn Case', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (29, N'Chuck Gaitan', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (30, N'Betty Gaitan', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (31, N'Lori Buol', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (32, N'Joan Holtzberg', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (33, N'Kimberly Bailey', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (34, N'Ayo Lincoln', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (35, N'Kenneth Arnold', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (36, N'Karen Arnold', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (37, N'Mark Forgrave', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (38, N'Roxanne Forgrave', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (39, N'Abigail Stein', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (40, N'Daughter #1', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (41, N'Daughter #2', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 9, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (44, N'Noah Clarson', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (45, N'Ryan Clarson', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (46, N'Jim Comfort', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (47, N'Susan Cooper', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (48, N'Lewis Cooper', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (49, N'Nick Elkins', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (50, N'Nikki Elkins', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (51, N'Steven Flynn', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (52, N'Kathy Fuder', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (53, N'Ted Hogan', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (54, N'Becky LaZerte', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 1, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (55, N'Rick LaZerte', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (56, N'Peggy Mingus', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (57, N'David Mingus', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (58, N'Grant Neuharth', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'9999-09-09' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (59, N'Ryan Clarson', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (60, N'Jim Comfort', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (61, N'Susan Cooper', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (62, N'Lewis Cooper', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (63, N'Nick Elkins', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (64, N'Nikki Elkins', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (65, N'Steven Flinn', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (66, N'Kathy Funder', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'1972-05-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (67, N'Ted Hogan', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (68, N'Becky LaZerte', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 1, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (69, NULL, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'1972-05-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (70, N'Rick LaZerte', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (71, N'Peggy Mingus', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (72, N'David Mingus', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (73, N'Grant Neuharth', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (74, N'Ryan Neuharth', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (75, N'Bob Ramsey', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (76, N'Nicole Ramsey', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (77, N'Timothy Spurling', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (78, N'Teri Spurling', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 8, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (79, N'Debby Johnson', N'e-mail4debby@comcast.net', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 1, 36, CAST(N'2021-06-06' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (80, N'Bryan Heil', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 1, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (81, N'Tim Macy', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (82, N'Rich Harmon', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (83, N'Sam Southerland', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (84, N'Holly Harmon', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (85, N'Delaney Harmon', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (86, N'Emma Lackens', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (87, N'Lea Gauthier', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (88, N'Elijah Knost', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (89, N'Ross Frank', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (90, N'Don Parrish', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (91, N'Craig Hardyman', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 11, CAST(N'2020-04-19' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (92, N'Mark Stanford', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 1, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (93, N'Troy', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (94, N'Hayden', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (95, N'Mike', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (96, N'Kristal', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (97, N'Doug', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (98, N'Elsie', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (99, N'Chris Kelley', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (101, N'John David Sylvester', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (102, N'Mark Anthony Bennett', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
GO
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (103, N'Ryan Chistopher Kelley', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (104, N'Diane Louise Kelley', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (105, N'Kayla Mackenzie McLeish', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (106, N'Liam Goodwin Adams', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (107, N'Kelly Rae Hasselbrack', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (108, N'Jordan Samuel Adams', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (109, N'Timothy George Patrick Tetu', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (110, N'Sylvia Ivery Tetu', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (111, N'Willis Young', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (112, N'Kyle Paul Byrd', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
INSERT [dbo].[TeamMember] ([TeamMemberID], [FName], [PhoneNumber], [Country], [District], [PreviousProjects], [SecondLanguage], [SkillsID], [TeamMemberTypeID], [TeamLeader], [TeamID], [LastTrip], [Male], [Female], [SpouseOnTeam], [PassPortExp], [FoodAllergies], [MedicalAllergies], [DPI], [Email]) VALUES (113, NULL, N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', 0, 1, 0, 1, 0, 2, CAST(N'2020-02-12' AS Date), 0, 0, 0, CAST(N'9999-09-09' AS Date), N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED', N'NONE PROVIDED')
SET IDENTITY_INSERT [dbo].[TeamMember] OFF
SET IDENTITY_INSERT [dbo].[TeamMemberSkills] ON 

INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (1, 2, 8, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (2, 2, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (3, 3, 1, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (4, 4, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (5, 5, 4, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (6, 10, 8, 2)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (7, 11, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (8, 11, 5, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (9, 11, 6, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (10, 11, 8, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (11, 12, 2, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (12, 12, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (13, 12, 6, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (14, 12, 8, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (15, 13, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (16, 13, 4, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (17, 13, 6, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (18, 14, 1, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (19, 14, 4, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (20, 14, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (21, 15, 1, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (22, 15, 2, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (23, 15, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (24, 15, 4, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (25, 15, 5, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (26, 15, 6, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (27, 15, 8, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (28, 16, 1, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (29, 16, 4, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (30, 16, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (31, 17, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (32, 17, 1, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (33, 18, 1, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (34, 18, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (35, 18, 4, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (36, 19, 4, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (37, 20, 1, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (38, 20, 5, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (39, 20, 3, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (40, 21, 1, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (41, 21, 4, 0)
INSERT [dbo].[TeamMemberSkills] ([TMSid], [TeamMemberID], [SkillsID], [SkillLevelID]) VALUES (42, 4, 8, 0)
SET IDENTITY_INSERT [dbo].[TeamMemberSkills] OFF
SET IDENTITY_INSERT [dbo].[TeamMemberType] ON 

INSERT [dbo].[TeamMemberType] ([TeamMemberTypeID], [MemberType]) VALUES (0, N'NONE PROVIDED')
INSERT [dbo].[TeamMemberType] ([TeamMemberTypeID], [MemberType]) VALUES (1, N'USA')
INSERT [dbo].[TeamMemberType] ([TeamMemberTypeID], [MemberType]) VALUES (2, N'Maxima')
SET IDENTITY_INSERT [dbo].[TeamMemberType] OFF
SET IDENTITY_INSERT [dbo].[TeamPartnerProfile] ON 

INSERT [dbo].[TeamPartnerProfile] ([TeamPartnerProfileID], [TeamID], [Scope], [StartDate], [EndDate], [Finished], [ProjectedTerm], [ScopeTitle]) VALUES (0, 0, N'NONE', CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, N'NONE')
SET IDENTITY_INSERT [dbo].[TeamPartnerProfile] OFF
SET IDENTITY_INSERT [dbo].[TeamTrackInfo] ON 

INSERT [dbo].[TeamTrackInfo] ([ID], [EmailPath], [TeamID], [TeamMemberTypeID], [TeamHost], [TruckDriver], [BusDriver], [Translator], [ToolDriver], [StructureDelivery]) VALUES (1, N'NONE', 0, 0, 0, 0, 0, 0, NULL, 0)
SET IDENTITY_INSERT [dbo].[TeamTrackInfo] OFF
SET IDENTITY_INSERT [dbo].[TeamType] ON 

INSERT [dbo].[TeamType] ([TeamTypeID], [TeamDiscription], [ListOrder]) VALUES (0, N'NONE PROVIDED', 0)
INSERT [dbo].[TeamType] ([TeamTypeID], [TeamDiscription], [ListOrder]) VALUES (1, N'Youth', NULL)
INSERT [dbo].[TeamType] ([TeamTypeID], [TeamDiscription], [ListOrder]) VALUES (2, N'Construction', NULL)
INSERT [dbo].[TeamType] ([TeamTypeID], [TeamDiscription], [ListOrder]) VALUES (3, N'Medical', NULL)
INSERT [dbo].[TeamType] ([TeamTypeID], [TeamDiscription], [ListOrder]) VALUES (4, N'Evangilism', NULL)
INSERT [dbo].[TeamType] ([TeamTypeID], [TeamDiscription], [ListOrder]) VALUES (5, N'Naza Gol', 0)
INSERT [dbo].[TeamType] ([TeamTypeID], [TeamDiscription], [ListOrder]) VALUES (6, N'Training', 0)
INSERT [dbo].[TeamType] ([TeamTypeID], [TeamDiscription], [ListOrder]) VALUES (7, N'Water Filters', 0)
SET IDENTITY_INSERT [dbo].[TeamType] OFF
SET IDENTITY_INSERT [dbo].[userInfo] ON 

INSERT [dbo].[userInfo] ([userID], [userName], [userPassword], [userEmail], [userClearanceLevel], [userSalt]) VALUES (10, N'Sigmund', N'ﵷꆇ�Ᲊਓ氉�ꟁ렜滑訹劣度䘶�᫠륑궴⬶攬ꬅ颛唵䠝嬴䅵⼓蜵꭯軟', N'SFreud@Example.com', 0, N's 	!23 
/
- :6. %HV  M9C) V-   7*%C   )A&  .?  ')
INSERT [dbo].[userInfo] ([userID], [userName], [userPassword], [userEmail], [userClearanceLevel], [userSalt]) VALUES (10, N'Sigmund', N'ﵷꆇ�Ᲊਓ氉�ꟁ렜滑訹劣度䘶�᫠륑궴⬶攬ꬅ颛唵䠝嬴䅵⼓蜵꭯軟', N'SFreud@Example.com', 0, N's 	!23 
/
- :6. %HV  M9C) V-   7*%C   )A&  .?  ')
SET IDENTITY_INSERT [dbo].[userInfo] OFF
SET IDENTITY_INSERT [dbo].[WWCoordinator] ON 

INSERT [dbo].[WWCoordinator] ([WWcoordID], [FullName], [StartDate], [NumberOfTeams], [RegionID], [MaxHostingTeams], [CoordStatusID]) VALUES (0, N'NONE PROVIDED', CAST(N'9999-09-09T00:00:00.0000000' AS DateTime2), 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[WWCoordinator] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [AirportCode]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [AirportCode] ON [dbo].[Airport]
(
	[AirportCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [AirportCountryID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [AirportCountryID] ON [dbo].[Airport]
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [AccountingCode]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [AccountingCode] ON [dbo].[CheckSolicitud]
(
	[AccountingCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ProjectID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [ProjectID] ON [dbo].[CheckSolicitud]
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [DistrictID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [DistrictID] ON [dbo].[ChurchName]
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CountryID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [CountryID] ON [dbo].[Country]
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [RegionID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [RegionID] ON [dbo].[Country]
(
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CountryID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [CountryID] ON [dbo].[CurrencyType]
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CurrencyTypeID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [CurrencyTypeID] ON [dbo].[ExchangeRate]
(
	[CurrencyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [DistrictID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [DistrictID] ON [dbo].[Field]
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [FieldID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [FieldID] ON [dbo].[Field]
(
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CountryID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [CountryID] ON [dbo].[Hotel]
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [HotelID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [HotelID] ON [dbo].[Hotel]
(
	[HotelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PhoneNum]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [PhoneNum] ON [dbo].[Hotel]
(
	[PhoneNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [LanguageID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [LanguageID] ON [dbo].[Language]
(
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [LocalCoordinatorDistrictID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [LocalCoordinatorDistrictID] ON [dbo].[LocalCoordinator]
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MealID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [MealID] ON [dbo].[Meals]
(
	[MealID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [SelectedPartnerID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [SelectedPartnerID] ON [dbo].[Partnerships]
(
	[SelectedPartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamID] ON [dbo].[Partnerships]
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CountryID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [CountryID] ON [dbo].[Project]
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [DistrictID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [DistrictID] ON [dbo].[Project]
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ProjectID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [ProjectID] ON [dbo].[Project]
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ProjectProjectTypeId]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [ProjectProjectTypeId] ON [dbo].[Project]
(
	[ProjectTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ProjectWWcoordID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [ProjectWWcoordID] ON [dbo].[Project]
(
	[WWCoordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ProjectNotesProjectID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [ProjectNotesProjectID] ON [dbo].[ProjectNotes]
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ProjectID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [ProjectID] ON [dbo].[ProjectPhotos]
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ProjectPhotosID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [ProjectPhotosID] ON [dbo].[ProjectPhotos]
(
	[ProjectPhotosID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ProjectTypeId]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [ProjectTypeId] ON [dbo].[ProjectType]
(
	[ProjectTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [RegionID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [RegionID] ON [dbo].[Region]
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [SkillLevelId]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [SkillLevelId] ON [dbo].[SkillLevel]
(
	[SkillLevelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [SkillsID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [SkillsID] ON [dbo].[SkillLevel]
(
	[SkillsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [SkillID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [SkillID] ON [dbo].[Skills]
(
	[SkillsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CountryID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [CountryID] ON [dbo].[SSMA$District$local]
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [DistrictID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [DistrictID] ON [dbo].[SSMA$District$local]
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [SupersDistrictID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [SupersDistrictID] ON [dbo].[Supers]
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [USAteamID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [USAteamID] ON [dbo].[Team]
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [AirportID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [AirportID] ON [dbo].[TeamDetails]
(
	[AirportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CountryID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [CountryID] ON [dbo].[TeamDetails]
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [HotelID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [HotelID] ON [dbo].[TeamDetails]
(
	[HotelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NumberOfDays]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [NumberOfDays] ON [dbo].[TeamDetails]
(
	[NumberOfDays] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NumberOfNights]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [NumberOfNights] ON [dbo].[TeamDetails]
(
	[NumberOfNights] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NumTeamMemb]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [NumTeamMemb] ON [dbo].[TeamDetails]
(
	[NumTeamMemb] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PartnershipID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [PartnershipID] ON [dbo].[TeamDetails]
(
	[PartnershipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ProjectID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [ProjectID] ON [dbo].[TeamDetails]
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamDetailsTeamDetailsID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamDetailsTeamDetailsID] ON [dbo].[TeamDetails]
(
	[TeamDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamDetailsTeamID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamDetailsTeamID] ON [dbo].[TeamDetails]
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamDetailsTeamMemberID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamDetailsTeamMemberID] ON [dbo].[TeamDetails]
(
	[TeamMemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamDetailsTeamTypeID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamDetailsTeamTypeID] ON [dbo].[TeamDetails]
(
	[TeamTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamPartnerProfileID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamPartnerProfileID] ON [dbo].[TeamDetails]
(
	[TeamPartnerProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [LanguageID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [LanguageID] ON [dbo].[TeamMember]
(
	[SecondLanguage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [LocalTeamMemberID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [LocalTeamMemberID] ON [dbo].[TeamMember]
(
	[TeamMemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PreviousProjectsID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [PreviousProjectsID] ON [dbo].[TeamMember]
(
	[PreviousProjects] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [SkillsID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [SkillsID] ON [dbo].[TeamMember]
(
	[SkillsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamID] ON [dbo].[TeamMember]
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamMemberTypeID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamMemberTypeID] ON [dbo].[TeamMember]
(
	[TeamMemberTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [SkillLevelID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [SkillLevelID] ON [dbo].[TeamMemberSkills]
(
	[SkillLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamMemberSkillsSkillsID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamMemberSkillsSkillsID] ON [dbo].[TeamMemberSkills]
(
	[SkillsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamMemberSkillsTeamMemberID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamMemberSkillsTeamMemberID] ON [dbo].[TeamMemberSkills]
(
	[TeamMemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamMemberTypeID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamMemberTypeID] ON [dbo].[TeamMemberType]
(
	[TeamMemberTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamPartnerProfileTeamID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamPartnerProfileTeamID] ON [dbo].[TeamPartnerProfile]
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamID] ON [dbo].[TeamTrackInfo]
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamMemberTypeID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamMemberTypeID] ON [dbo].[TeamTrackInfo]
(
	[TeamMemberTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [TeamTypeID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [TeamTypeID] ON [dbo].[TeamType]
(
	[TeamTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CountryID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [CountryID] ON [dbo].[WWCoordinator]
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NumberOfTeams]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [NumberOfTeams] ON [dbo].[WWCoordinator]
(
	[NumberOfTeams] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [StatusID]    Script Date: 10/22/2020 11:43:01 PM ******/
CREATE NONCLUSTERED INDEX [StatusID] ON [dbo].[WWCoordinator]
(
	[CoordStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Airport] ADD  DEFAULT ((0)) FOR [CountryID]
GO
ALTER TABLE [dbo].[CheckSolicitud] ADD  DEFAULT ((0)) FOR [CheckAmount]
GO
ALTER TABLE [dbo].[CheckSolicitud] ADD  DEFAULT ((0)) FOR [USD]
GO
ALTER TABLE [dbo].[CheckSolicitud] ADD  DEFAULT ((0)) FOR [LocalCurrency]
GO
ALTER TABLE [dbo].[CheckSolicitud] ADD  DEFAULT ((0)) FOR [ExchangeRate]
GO
ALTER TABLE [dbo].[CheckSolicitud] ADD  DEFAULT ((0)) FOR [ProjectID]
GO
ALTER TABLE [dbo].[ChurchName] ADD  DEFAULT ((0)) FOR [DistrictID]
GO
ALTER TABLE [dbo].[Country] ADD  DEFAULT ((0)) FOR [FieldID]
GO
ALTER TABLE [dbo].[CurrencyType] ADD  DEFAULT ((0)) FOR [CountryID]
GO
ALTER TABLE [dbo].[ExchangeRate] ADD  DEFAULT ((0)) FOR [ExchangeRate]
GO
ALTER TABLE [dbo].[ExchangeRate] ADD  DEFAULT ((0)) FOR [CurrencyTypeID]
GO
ALTER TABLE [dbo].[Field] ADD  DEFAULT ((0)) FOR [RegionID]
GO
ALTER TABLE [dbo].[Hotel] ADD  DEFAULT ((0)) FOR [CountryID]
GO
ALTER TABLE [dbo].[Hotel] ADD  DEFAULT ((0)) FOR [R&R]
GO
ALTER TABLE [dbo].[LocalCoordinator] ADD  DEFAULT ((0)) FOR [DistrictID]
GO
ALTER TABLE [dbo].[Meals] ADD  CONSTRAINT [DF__Meals__DaysForTh__1AD3FDA4]  DEFAULT ((0)) FOR [DaysForThisMeal]
GO
ALTER TABLE [dbo].[Meals] ADD  CONSTRAINT [DF__Meals__MealCost__1BC821DD]  DEFAULT ((0)) FOR [MealCost]
GO
ALTER TABLE [dbo].[Meals] ADD  CONSTRAINT [DF__Meals__HowManyEa__1CBC4616]  DEFAULT ((0)) FOR [HowManyEating]
GO
ALTER TABLE [dbo].[Partnerships] ADD  CONSTRAINT [DF__Partnersh__TeamI__76969D2E]  DEFAULT ((0)) FOR [TeamID]
GO
ALTER TABLE [dbo].[Partnerships] ADD  CONSTRAINT [DF__Partnersh__Selec__787EE5A0]  DEFAULT ((0)) FOR [SelectedPartnerID]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__WWCoord__3E1D39E1]  DEFAULT ((0)) FOR [WWCoordID]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Project__40058253]  DEFAULT ((0)) FOR [ProjectTypeID]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Distric__40F9A68C]  DEFAULT ((0)) FOR [DistrictID]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Distric__41EDCAC5]  DEFAULT ((0)) FOR [DistrictBudgetCurrent]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Distric__42E1EEFE]  DEFAULT ((0)) FOR [DistrictBudgetLast]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__FEMcurr__43D61337]  DEFAULT ((0)) FOR [FEMcurrent]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__FEMlast__44CA3770]  DEFAULT ((0)) FOR [FEMlast]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Members__45BE5BA9]  DEFAULT ((0)) FOR [MembersLast]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Members__46B27FE2]  DEFAULT ((0)) FOR [MembersCurrent]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__AvgAtte__47A6A41B]  DEFAULT ((0)) FOR [AvgAttendanceLast]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__AvgAtte__489AC854]  DEFAULT ((0)) FOR [AvgAttendanceCurr]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__TempleC__498EEC8D]  DEFAULT ((0)) FOR [TempleCapacity]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__RoofWid__4A8310C6]  DEFAULT ((0)) FOR [RoofWidth]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__RoofLen__4B7734FF]  DEFAULT ((0)) FOR [RoofLength]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Propert__4C6B5938]  DEFAULT ((0)) FOR [PropertyWidth]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Propert__4D5F7D71]  DEFAULT ((0)) FOR [PropertyLength]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Photos__4E53A1AA]  DEFAULT ((0)) FOR [Photos]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Digital__4F47C5E3]  DEFAULT ((0)) FOR [Digital]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__LotLayo__503BEA1C]  DEFAULT ((0)) FOR [LotLayout]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Project__51300E55]  DEFAULT ((0)) FOR [ProjectPlans]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__MoneyRa__5224328E]  DEFAULT ((0)) FOR [MoneyRaised]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__MoneyIn__531856C7]  DEFAULT ((0)) FOR [MoneyInvested]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Money12__540C7B00]  DEFAULT ((0)) FOR [Money12Months]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__TitleTo__55009F39]  DEFAULT ((0)) FOR [TitleToProperty]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Propert__55F4C372]  DEFAULT ((0)) FOR [PropertyDeededToChurch]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Buildin__56E8E7AB]  DEFAULT ((0)) FOR [BuildingPermitNeeded]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Buildin__57DD0BE4]  DEFAULT ((0)) FOR [BuildingPermitApproved]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__PastorA__58D1301D]  DEFAULT ((0)) FOR [PastorApproved]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__ChurchB__59C55456]  DEFAULT ((0)) FOR [ChurchBoardApproved]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Treasur__5AB9788F]  DEFAULT ((0)) FOR [TreasureApproved]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__SuperAp__5BAD9CC8]  DEFAULT ((0)) FOR [SuperApproval]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Distric__5CA1C101]  DEFAULT ((0)) FOR [DistrictSecretaryApproval]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Distric__5D95E53A]  DEFAULT ((0)) FOR [DistrictTreasureApproval]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Distric__5E8A0973]  DEFAULT ((0)) FOR [DistrictPriority]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__TyTPrio__607251E5]  DEFAULT ((0)) FOR [TyTPriority]
GO
ALTER TABLE [dbo].[Project] ADD  CONSTRAINT [DF__Project__Country__6166761E]  DEFAULT ((0)) FOR [CountryID]
GO
ALTER TABLE [dbo].[ProjectNotes] ADD  DEFAULT ((0)) FOR [ProjectID]
GO
ALTER TABLE [dbo].[ProjectPhotos] ADD  DEFAULT ((0)) FOR [ProjectID]
GO
ALTER TABLE [dbo].[ProjectType] ADD  DEFAULT ((0)) FOR [ListOrder]
GO
ALTER TABLE [dbo].[SkillLevel] ADD  CONSTRAINT [DF__SkillLeve__Skill__7B264821]  DEFAULT ((0)) FOR [SkillsID]
GO
ALTER TABLE [dbo].[SSMA$District$local] ADD  DEFAULT ((0)) FOR [CountryID]
GO
ALTER TABLE [dbo].[Supers] ADD  DEFAULT ((0)) FOR [DistrictID]
GO
ALTER TABLE [dbo].[Supers] ADD  DEFAULT (N'0') FOR [SuperMobile]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Total__13F1F5EB]  DEFAULT ((0)) FOR [TotalDailyFunds]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__NumTe__14E61A24]  DEFAULT ((0)) FOR [NumTeamMemb]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__TeamM__15DA3E5D]  DEFAULT ((0)) FOR [TeamMemberID]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__TeamT__16CE6296]  DEFAULT ((0)) FOR [TeamTypeID]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Numbe__17C286CF]  DEFAULT ((0)) FOR [NumberOfDays]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Numbe__18B6AB08]  DEFAULT ((0)) FOR [NumberOfNights]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Proje__19AACF41]  DEFAULT ((0)) FOR [ProjectID]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__TeamI__1A9EF37A]  DEFAULT ((0)) FOR [TeamID]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Dista__1B9317B3]  DEFAULT ((0)) FOR [DistanceToRR]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Dista__1C873BEC]  DEFAULT ((0)) FOR [DistanceToProject]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Hotel__1D7B6025]  DEFAULT ((0)) FOR [HotelID]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Count__1F63A897]  DEFAULT ((0)) FOR [CountryID]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Airpo__2057CCD0]  DEFAULT ((0)) FOR [AirportID]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Proje__2334397B]  DEFAULT ((0)) FOR [ProjectMoney]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Partn__24285DB4]  DEFAULT ((0)) FOR [PartnershipID]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__TeamP__251C81ED]  DEFAULT ((0)) FOR [TeamPartnerProfileID]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__TeamH__2610A626]  DEFAULT ((0)) FOR [TeamHost]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__CulBr__2704CA5F]  DEFAULT ((0)) FOR [CulBroker]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Truck__27F8EE98]  DEFAULT ((0)) FOR [TruckDriver]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__BusDr__28ED12D1]  DEFAULT ((0)) FOR [BusDriver]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Trans__29E1370A]  DEFAULT ((0)) FOR [Translator]
GO
ALTER TABLE [dbo].[TeamDetails] ADD  CONSTRAINT [DF__TeamDetai__Struc__2AD55B43]  DEFAULT ((0)) FOR [StructureDelivery]
GO
ALTER TABLE [dbo].[TeamMember] ADD  CONSTRAINT [DF__TeamMembe__Langu__3EDC53F0]  DEFAULT ((0)) FOR [SecondLanguage]
GO
ALTER TABLE [dbo].[TeamMember] ADD  CONSTRAINT [DF__TeamMembe__Skill__3FD07829]  DEFAULT ((0)) FOR [SkillsID]
GO
ALTER TABLE [dbo].[TeamMember] ADD  CONSTRAINT [DF__TeamMembe__TeamM__40C49C62]  DEFAULT ((0)) FOR [TeamMemberTypeID]
GO
ALTER TABLE [dbo].[TeamMember] ADD  CONSTRAINT [DF__TeamMembe__TeamL__41B8C09B]  DEFAULT ((0)) FOR [TeamLeader]
GO
ALTER TABLE [dbo].[TeamMember] ADD  CONSTRAINT [DF__TeamMembe__TeamI__43A1090D]  DEFAULT ((0)) FOR [TeamID]
GO
ALTER TABLE [dbo].[TeamMemberSkills] ADD  DEFAULT ((0)) FOR [TeamMemberID]
GO
ALTER TABLE [dbo].[TeamMemberSkills] ADD  DEFAULT ((0)) FOR [SkillsID]
GO
ALTER TABLE [dbo].[TeamMemberSkills] ADD  DEFAULT ((0)) FOR [SkillLevelID]
GO
ALTER TABLE [dbo].[TeamPartnerProfile] ADD  CONSTRAINT [DF__TeamPartn__TeamI__3F115E1A]  DEFAULT ((0)) FOR [TeamID]
GO
ALTER TABLE [dbo].[TeamPartnerProfile] ADD  CONSTRAINT [DF__TeamPartn__Proje__40058253]  DEFAULT ((0)) FOR [ProjectedTerm]
GO
ALTER TABLE [dbo].[TeamTrackInfo] ADD  DEFAULT ((0)) FOR [TeamID]
GO
ALTER TABLE [dbo].[TeamTrackInfo] ADD  DEFAULT ((0)) FOR [TeamHost]
GO
ALTER TABLE [dbo].[TeamTrackInfo] ADD  DEFAULT ((0)) FOR [TruckDriver]
GO
ALTER TABLE [dbo].[TeamTrackInfo] ADD  DEFAULT ((0)) FOR [BusDriver]
GO
ALTER TABLE [dbo].[TeamTrackInfo] ADD  DEFAULT ((0)) FOR [Translator]
GO
ALTER TABLE [dbo].[TeamTrackInfo] ADD  DEFAULT ((0)) FOR [ToolDriver]
GO
ALTER TABLE [dbo].[TeamTrackInfo] ADD  DEFAULT ((0)) FOR [StructureDelivery]
GO
ALTER TABLE [dbo].[TeamType] ADD  DEFAULT ((0)) FOR [ListOrder]
GO
ALTER TABLE [dbo].[WWCoordinator] ADD  DEFAULT ((0)) FOR [NumberOfTeams]
GO
ALTER TABLE [dbo].[WWCoordinator] ADD  DEFAULT ((0)) FOR [RegionID]
GO
ALTER TABLE [dbo].[WWCoordinator] ADD  DEFAULT ((0)) FOR [MaxHostingTeams]
GO
ALTER TABLE [dbo].[WWCoordinator] ADD  DEFAULT ((0)) FOR [CoordStatusID]
GO
ALTER TABLE [dbo].[CheckSolicitud]  WITH CHECK ADD  CONSTRAINT [FK_CheckSolicitud_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Project] ([ProjectID])
GO
ALTER TABLE [dbo].[CheckSolicitud] CHECK CONSTRAINT [FK_CheckSolicitud_Project]
GO
ALTER TABLE [dbo].[ChurchName]  WITH CHECK ADD  CONSTRAINT [FK_ChurchName_SSMA$District$local] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[SSMA$District$local] ([DistrictID])
GO
ALTER TABLE [dbo].[ChurchName] CHECK CONSTRAINT [FK_ChurchName_SSMA$District$local]
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_Country_Field] FOREIGN KEY([FieldID])
REFERENCES [dbo].[Field] ([FieldID])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_Country_Field]
GO
ALTER TABLE [dbo].[CurrencyType]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyType_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([CountryID])
GO
ALTER TABLE [dbo].[CurrencyType] CHECK CONSTRAINT [FK_CurrencyType_Country]
GO
ALTER TABLE [dbo].[ExchangeRate]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeRate_CurrencyType] FOREIGN KEY([CurrencyTypeID])
REFERENCES [dbo].[CurrencyType] ([CurrencyTypeID])
GO
ALTER TABLE [dbo].[ExchangeRate] CHECK CONSTRAINT [FK_ExchangeRate_CurrencyType]
GO
ALTER TABLE [dbo].[Field]  WITH CHECK ADD  CONSTRAINT [FK_Field_Region] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Region] ([RegionID])
GO
ALTER TABLE [dbo].[Field] CHECK CONSTRAINT [FK_Field_Region]
GO
ALTER TABLE [dbo].[LocalCoordinator]  WITH CHECK ADD  CONSTRAINT [FK_LocalCoordinator_SSMA$District$local] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[SSMA$District$local] ([DistrictID])
GO
ALTER TABLE [dbo].[LocalCoordinator] CHECK CONSTRAINT [FK_LocalCoordinator_SSMA$District$local]
GO
ALTER TABLE [dbo].[Meals]  WITH CHECK ADD  CONSTRAINT [FK_Meals_TeamDetails] FOREIGN KEY([TeamDetailsID])
REFERENCES [dbo].[TeamDetails] ([TeamDetailsID])
GO
ALTER TABLE [dbo].[Meals] CHECK CONSTRAINT [FK_Meals_TeamDetails]
GO
ALTER TABLE [dbo].[Partnerships]  WITH CHECK ADD  CONSTRAINT [FK_Partnerships_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[Partnerships] CHECK CONSTRAINT [FK_Partnerships_Team]
GO
ALTER TABLE [dbo].[Partnerships]  WITH CHECK ADD  CONSTRAINT [FK_Partnerships_Team1] FOREIGN KEY([SelectedPartnerID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[Partnerships] CHECK CONSTRAINT [FK_Partnerships_Team1]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_ChurchName] FOREIGN KEY([ChurchID])
REFERENCES [dbo].[ChurchName] ([ChurchID])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_ChurchName]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([CountryID])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Country]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_ProjectType] FOREIGN KEY([ProjectTypeID])
REFERENCES [dbo].[ProjectType] ([ProjectTypeId])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_ProjectType]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_SSMA$District$local] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[SSMA$District$local] ([DistrictID])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_SSMA$District$local]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_WWCoordinator] FOREIGN KEY([WWCoordID])
REFERENCES [dbo].[WWCoordinator] ([WWcoordID])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_WWCoordinator]
GO
ALTER TABLE [dbo].[ProjectNotes]  WITH CHECK ADD  CONSTRAINT [FK_ProjectNotes_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Project] ([ProjectID])
GO
ALTER TABLE [dbo].[ProjectNotes] CHECK CONSTRAINT [FK_ProjectNotes_Project]
GO
ALTER TABLE [dbo].[ProjectPhotos]  WITH CHECK ADD  CONSTRAINT [FK_ProjectPhotos_Project1] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Project] ([ProjectID])
GO
ALTER TABLE [dbo].[ProjectPhotos] CHECK CONSTRAINT [FK_ProjectPhotos_Project1]
GO
ALTER TABLE [dbo].[SkillLevel]  WITH CHECK ADD  CONSTRAINT [FK_SkillLevel_Skills] FOREIGN KEY([SkillsID])
REFERENCES [dbo].[Skills] ([SkillsID])
GO
ALTER TABLE [dbo].[SkillLevel] CHECK CONSTRAINT [FK_SkillLevel_Skills]
GO
ALTER TABLE [dbo].[SSMA$District$local]  WITH CHECK ADD  CONSTRAINT [FK_SSMA$District$local_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([CountryID])
GO
ALTER TABLE [dbo].[SSMA$District$local] CHECK CONSTRAINT [FK_SSMA$District$local_Country]
GO
ALTER TABLE [dbo].[Supers]  WITH CHECK ADD  CONSTRAINT [FK_Supers_SSMA$District$local] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[SSMA$District$local] ([DistrictID])
GO
ALTER TABLE [dbo].[Supers] CHECK CONSTRAINT [FK_Supers_SSMA$District$local]
GO
ALTER TABLE [dbo].[TeamDetails]  WITH CHECK ADD  CONSTRAINT [FK_TeamDetails_Airport] FOREIGN KEY([AirportID])
REFERENCES [dbo].[Airport] ([AirportID])
GO
GO
ALTER TABLE [dbo].[TeamDetails] CHECK CONSTRAINT [FK_TeamDetails_Airport]
GO
ALTER TABLE [dbo].[TeamDetails]  WITH CHECK ADD  CONSTRAINT [FK_TeamDetails_Hotel] FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotel] ([HotelID])
GO
ALTER TABLE [dbo].[TeamDetails] CHECK CONSTRAINT [FK_TeamDetails_Hotel]
GO
ALTER TABLE [dbo].[TeamDetails]  WITH CHECK ADD  CONSTRAINT [FK_TeamDetails_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Project] ([ProjectID])
GO
ALTER TABLE [dbo].[TeamDetails] CHECK CONSTRAINT [FK_TeamDetails_Project]
GO
ALTER TABLE [dbo].[TeamDetails]  WITH CHECK ADD  CONSTRAINT [FK_TeamDetails_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[TeamDetails] CHECK CONSTRAINT [FK_TeamDetails_Team]
GO
ALTER TABLE [dbo].[TeamDetails]  WITH CHECK ADD  CONSTRAINT [FK_TeamDetails_TeamMember] FOREIGN KEY([TeamMemberID])
REFERENCES [dbo].[TeamMember] ([TeamMemberID])
GO
ALTER TABLE [dbo].[TeamDetails] CHECK CONSTRAINT [FK_TeamDetails_TeamMember]
GO
ALTER TABLE [dbo].[TeamDetails]  WITH CHECK ADD  CONSTRAINT [FK_TeamDetails_TeamType1] FOREIGN KEY([TeamTypeID])
REFERENCES [dbo].[TeamType] ([TeamTypeID])
GO
ALTER TABLE [dbo].[TeamDetails] CHECK CONSTRAINT [FK_TeamDetails_TeamType1]
GO
ALTER TABLE [dbo].[TeamMember]  WITH CHECK ADD  CONSTRAINT [FK_TeamMember_Language] FOREIGN KEY([SecondLanguage])
REFERENCES [dbo].[Language] ([LanguageID])
GO
ALTER TABLE [dbo].[TeamMember] CHECK CONSTRAINT [FK_TeamMember_Language]
GO
ALTER TABLE [dbo].[TeamMember]  WITH CHECK ADD  CONSTRAINT [FK_TeamMember_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[TeamMember] CHECK CONSTRAINT [FK_TeamMember_Team]
GO
ALTER TABLE [dbo].[TeamMember]  WITH CHECK ADD  CONSTRAINT [FK_TeamMember_TeamMemberType] FOREIGN KEY([TeamMemberTypeID])
REFERENCES [dbo].[TeamMemberType] ([TeamMemberTypeID])
GO
ALTER TABLE [dbo].[TeamMember] CHECK CONSTRAINT [FK_TeamMember_TeamMemberType]
GO
ALTER TABLE [dbo].[TeamMemberSkills]  WITH CHECK ADD  CONSTRAINT [FK_TeamMemberSkills_Skills] FOREIGN KEY([SkillsID])
REFERENCES [dbo].[Skills] ([SkillsID])
GO
ALTER TABLE [dbo].[TeamMemberSkills] CHECK CONSTRAINT [FK_TeamMemberSkills_Skills]
GO
ALTER TABLE [dbo].[TeamMemberSkills]  WITH CHECK ADD  CONSTRAINT [FK_TeamMemberSkills_TeamMember] FOREIGN KEY([TeamMemberID])
REFERENCES [dbo].[TeamMember] ([TeamMemberID])
GO
ALTER TABLE [dbo].[TeamMemberSkills] CHECK CONSTRAINT [FK_TeamMemberSkills_TeamMember]
GO
ALTER TABLE [dbo].[TeamPartnerProfile]  WITH CHECK ADD  CONSTRAINT [FK_TeamPartnerProfile_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[TeamPartnerProfile] CHECK CONSTRAINT [FK_TeamPartnerProfile_Team]
GO
ALTER TABLE [dbo].[TeamTrackInfo]  WITH CHECK ADD  CONSTRAINT [FK_TeamTrackInfo_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[TeamTrackInfo] CHECK CONSTRAINT [FK_TeamTrackInfo_Team]
GO
ALTER TABLE [dbo].[WWCoordinator]  WITH CHECK ADD  CONSTRAINT [FK_WWCoordinator_Region] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Region] ([RegionID])
GO
ALTER TABLE [dbo].[WWCoordinator] CHECK CONSTRAINT [FK_WWCoordinator_Region]
GO
/****** Object:  StoredProcedure [dbo].[AddTeamMember]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE        PROC [dbo].[AddTeamMember] (
	@NTMFName					NVARCHAR(255),
	@NTMPhoneNumber				NVARCHAR(255),
	@NTMCountry					NVARCHAR(255),
	@NTMDistrict				NVARCHAR(255),
	@NTMPreviousProjects		INT,
	@NTMSecondLanguage			NVARCHAR(50),
	@NTMSkillsID				INT,
	@NTMTeamMemberTypeID		INT,
	@NTMTeamLeader				INT,
	@NTMTeamID					INT,
	@NTMLastTrip				DATE,
	@NTMMale					INT,
	@NTMFemale					INT,
	@NTMSpouseOnTeam			INT,				
	@NTMPassPortExp				DATE,
	@NTMFoodAllergies			NVARCHAR(255),
	@NTMMedicalAllergies		NVARCHAR(255),
	@NTMDPI						NVARCHAR(255),
	@NTMEmail					NVARCHAR(255)
)
AS
BEGIN
IF NOT EXISTS (SELECT * FROM TeamMember WHERE FName = @NTMFName AND Email = @NTMEmail)
BEGIN
	INSERT INTO TeamMember(FName, PhoneNumber, Country, District, PreviousProjects, SecondLanguage, SkillsID, TeamMemberTypeID, TeamLeader
	,TeamID, LastTrip,  Male, Female, SpouseOnTeam, PassPortExp, FoodAllergies, MedicalAllergies, DPI, Email)
	VALUES (@NTMFName, @NTMPhoneNumber, @NTMCountry, @NTMDistrict, @NTMPreviousProjects, @NTMSecondLanguage, @NTMSkillsID, @NTMTeamMemberTypeID,
	@NTMTeamLeader, @NTMTeamID, @NTMLastTrip, @NTMMale, @NTMFemale, @NTMSpouseOnTeam, @NTMPassPortExp, @NTMFoodAllergies,
	@NTMMedicalAllergies, @NTMDPI, @NTMEmail) 
	UPDATE TeamDetails
	SET
		NumTeamMemb = NumTeamMemb + 1
	WHERE TeamID = @NTMTeamID
	INSERT INTO TeamMemberSkills(TeamMemberID, SkillsID)
	VALUES (SCOPE_IDENTITY(),  @NTMSkillsID)
END
ELSE
BEGIN --This record exists, update it 
	UPDATE TeamMember
	SET					
	FName                   = @NTMFName,						
	PhoneNumber			    = @NTMPhoneNumber,
	Country					= @NTMCountry,
	District				= @NTMDistrict,
	PreviousProjects		= @NTMPreviousProjects,
	SecondLanguage			= @NTMSecondLanguage,
	SkillsID				= @NTMSkillsID,
	TeamMemberTypeID		= @NTMTeamMemberTypeID,
	TeamLeader				= @NTMTeamLeader,
	TeamID					= @NTMTeamID,
	LastTrip				= @NTMLastTrip,
	Male					= @NTMMale,
	Female					= @NTMFemale,
	SpouseOnTeam			= @NTMSpouseOnTeam,
	PassPortExp				= @NTMPassPortExp,
	FoodAllergies			= @NTMFoodAllergies,
	MedicalAllergies		= @NTMMedicalAllergies,
	DPI						= @NTMDPI,
	Email					= @NTMEmail
WHERE Email = @NTMEmail AND FName = @NTMFName AND PhoneNumber = @NTMPhoneNumber
RETURN 1
END
END
GO
/****** Object:  StoredProcedure [dbo].[AssignTeam]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE          PROC [dbo].[AssignTeam] (
	@TeamID		INT,
	@ProjectID  INT
)
AS
BEGIN
Declare @LeaderID	INT
Declare @TeamProjCount INT
SET @LeaderID =  (SELECT TeamMemberID
FROM TeamMember
WHERE TeamID = @TeamID AND TeamLeader = 1)
SET @TeamProjCount = (SELECT COUNT(*) FROM TeamDetails WHERE TeamID = @TeamID)
IF (@TeamProjCount > 1)
BEGIN
	SELECT 'More than one matching record found. Results Are: '
	SELECT * FROM TeamDetails WHERE TeamID = @TeamID
RETURN 0
END
ELSE
BEGIN
UPDATE TeamDetails
SET 
	CancelTeam = 1,
	 ProjectID = 0 
WHERE ProjectID = @ProjectID
UPDATE TeamDetails					--update teamdetails ID
SET									--choose which TeamDetailsID to Update
		ProjectID = @ProjectID
WHERE TeamID = @TeamID
IF NOT EXISTS(SELECT * FROM TeamDetails WHERE TeamID = @TeamID or ProjectID = @ProjectID)
BEGIN
INSERT INTO TeamDetails(ProjectID, TeamID) VALUES(@ProjectID, @TeamID)
END
ELSE
BEGIN
INSERT INTO TeamDetails(CountryID) 
SELECT 
	[CountryID]
FROM Project WHERE ProjectID = @ProjectID
RETURN 1
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[AuthenticateUser]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE       PROC [dbo].[AuthenticateUser] (
	@user nvarchar(64), 
	@pass nvarchar(64))
AS
BEGIN
	DECLARE @TESTSALT			NVARCHAR(64)
	DECLARE @TESTPASS			NVARCHAR(64)
	DECLARE @RESULT				NVARCHAR(64)
	DECLARE @RESCONVERTER		NVARCHAR(64)

SELECT @TESTSALT = userSalt, @TESTPASS = userPassword
FROM userInfo
WHERE userName = @user 
SELECT @TESTSALT
SET @RESULT = @pass + @TESTSALT
SELECT @RESULT
SET @RESCONVERTER = (HASHBYTES('SHA2_512',@RESULT))
SELECT @RESCONVERTER
IF NOT EXISTS(
	(SELECT TOP(1)
	[userID], 
	[userName],
	[userPassword],
	[userEmail],
	[userClearanceLevel]
	FROM userInfo
	WHERE 
    userName = @user
	AND 
	userPassword = @RESCONVERTER))
		BEGIN
			SELECT @user 
			SELECT @RESCONVERTER
			SELECT ('FAIL')
			RETURN 0 --Fail
			END
ELSE
		BEGIN
			SELECT @user
			SELECT @RESCONVERTER
			SELECT ('SUCCESS')
			RETURN 1 --Success
		END
END


GO
/****** Object:  StoredProcedure [dbo].[CancelledTeams]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE       PROC [dbo].[CancelledTeams] 
AS
BEGIN
SELECT DISTINCT
TeamDetails.[TeamID],
[TeamName],
[ChurchName],
[District],
[LeaderEmail],
[LeaderName],
[Partership],
[CancelTeam]
FROM Team INNER JOIN TeamDetails ON (Team.TeamID = TeamDetails.TeamID)
WHERE CancelTeam = 1
END

GO
/****** Object:  StoredProcedure [dbo].[createNewProject]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE                 PROC [dbo].[createNewProject](
		@NewWWCoorID						INT,
		@NewDateRecieved					DATE,
		@NewLinkToWWsite					NVARCHAR(255),
		@NewUserPermission					NVARCHAR(255),
		@NewProjectTypeID					INT,
		@NewDistrictID						INT,
		@NewCityName						NVARCHAR(255),
		@NewPastorName						NVARCHAR(MAX),
		@NewPastorPhone						NVARCHAR(MAX),
		@NewLocationLink					NVARCHAR(255),
		@NewDistanceFromDistrictOff			NVARCHAR(255),
		@NewDistrictBudgetCurrent			MONEY,
		@NewDistrictBudgetLast				MONEY,
		@NewFEMCurrent						MONEY,
		@NewFEMLast							MONEY,
		@NewDateOrganized					DATE,
		@NewMembersLast						INT,
		@NewMembersCurrent					INT,
		@NewAvgAttendanceLast				INT,
		@NewAvgAttendanceCurent				INT,
		@NewProjectDesc						NVARCHAR(MAX),
		@NewTempleCapacity					INT,
		@NewRoofWidth						INT,
		@NewRoofLength						INT,
		@NewBriefDescriptionConst			NVARCHAR(MAX),
		@NewPropertyWidth					INT,
		@NewPropertyLength					INT,
		@NewPhotos							INT,
		@NewDigital							INT,
		@NewLotLayout						INT,
		@NewProjectPlans					INT,
		@NewMoneyRaised						MONEY,
		@NewMoneyInvested					MONEY,
		@NewMoney12Months					MONEY,
		@NewProjectNeed						NVARCHAR(MAX),
		@NewTitleToProperty					INT,
		@NewPropertyDeededToChurch			INT,
		@NewBuildingPermitNeeded			INT,
		@NewBuildingPermitApproved			INT,
		@NewPastorApproved					INT,
		@NewChurchBoardApproved				INT,
		@NewTreasureApproved				INT,
		@NewTreasureApprovedDate			DATE,
		@NewSuperApproval					INT,
		@NewSuperApprovalDate				DATE,
		@NewDistrictSecretaryApproval		INT,
		@NewDistrictTreasureApproval	    INT,
		@NewDistrictTreasureApprovalDate	Date,
		@NewDistrictPriority				INT,
		@NewTyTapproved						INT,
		@NewTyTPriority						INT,
		@NewProjectCompleted				INT,
		@NewWwLink							NVARCHAR(255),
		@NewPhotoLocation					NVARCHAR(255),
		@NewPermitStart						DATE,
		@NewPermitEnd						DATE,
		@NewCountryID						INT
)
AS
BEGIN
INSERT INTO Project( 
WWCoordID, 
DateReceived, 
LinkToWWsite, 
UserPermission, 
ProjectTypeID, 
DistrictID, 
CityName, 
PastorName, 
PastorPhone,
LocationLink, 
DistanceFromDistrictOff, 
DistrictBudgetCurrent, 
DistrictBudgetLast, 
FEMcurrent, 
FEMlast, 
DateOrganized, 
MembersLast, 
MembersCurrent, 
AvgAttendanceLast, 
AvgAttendanceCurr, 
ProjectDesc, 
TempleCapacity, 
RoofWidth, 
RoofLength, 
BriefDescriptionConst, 
PropertyWidth, 
PropertyLength, 
Photos,
Digital, 
LotLayout, 
ProjectPlans, 
MoneyRaised, 
MoneyInvested, 
Money12Months, 
ProjectNeed, 
TitleToProperty, 
PropertyDeededToChurch, 
BuildingPermitNeeded, 
BuildingPermitApproved, 
PastorApproved, 
ChurchBoardApproved, 
TreasureApproved, 
TreasureApprovalDate, 
SuperApproval, 
SuperApprovalDate, 
DistrictSecretaryApproval,
DistrictTreasureApproval, 
DistrictTreasureApprovalDate, 
DistrictPriority, 
TyTapproved, 
TyTPriority, 
ProjectCompleted, 
Wwlink, 
PhotoLocation, 
PermitStart, 
PermitEnd, 
CountryID
)
VALUES( 
@NewWWCoorID, 
@NewDateRecieved, 
@NewLinkToWWSite, 
@NewUserPermission, 
@NewProjectTypeID,
@NewDistrictID, 
@NewCityName, 
@NewPastorName, 
@NewPastorPhone, 
@NewLocationLink, 
@NewDistanceFromDistrictOff, 
@NewDistrictBudgetCurrent, 
@NewDistrictBudgetLast, 
@NewFEMcurrent, 
@NewFEMlast, 
@NewDateOrganized, 
@NewMembersLast, 
@NewMembersCurrent, 
@NewAvgAttendanceLast, 
@NewAvgAttendanceCurent, 
@NewProjectDesc, 
@NewTempleCapacity, 
@NewRoofWidth,
@NewRoofLength, 
@NewBriefDescriptionConst, 
@NewPropertyWidth, 
@NewPropertyLength, 
@NewPhotos, 
@NewDigital, 
@NewLotLayout, 
@NewProjectPlans, 
@NewMoneyRaised,
@NewMoneyInvested, 
@NewMoney12Months, 
@NewProjectNeed, 
@NewTitleToProperty, 
@NewPropertyDeededToChurch, 
@NewBuildingPermitNeeded, 
@NewBuildingPermitApproved,
@NewPastorApproved, 
@NewChurchBoardApproved, 
@NewTreasureApproved, 
@NewTreasureApprovedDate, 
@NewSuperApproval, 
@NewSuperApprovalDate, 
@NewDistrictSecretaryApproval,
@NewDistrictTreasureApproval,
@NewDistrictTreasureApprovalDate,
@NewDistrictPriority, 
@NewTyTApproved, 
@NewTyTPriority, 
@NewProjectCompleted, 
@NewWwlink, 
@NewPhotoLocation, 
@NewPermitStart, 
@NewPermitEnd, 
@NewCountryID)
END
GO
/****** Object:  StoredProcedure [dbo].[createNewTeam]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE               PROC [dbo].[createNewTeam](
	@NewTeamName			   NVARCHAR(255),
	@NewChurchName			   NVARCHAR(255),              
	@NewDistrict			   NVARCHAR(255),
	@NewLeaderEmail			   NVARCHAR(255),
	@NewLeaderName			   NVARCHAR(255),
	@NewPartership			   INT
)	
AS
BEGIN
SET @NewTeamName =		CONVERT(NVARCHAR(255), @NewTeamName)
SET @NewChurchName =	CONVERT(NVARCHAR(255), @NewChurchName)
SET @NewDistrict =		CONVERT(NVARCHAR(255), @NewDistrict)
SET @NewLeaderEmail =	CONVERT(NVARCHAR(255), @NewLeaderEmail)
SET @NewLeaderName =	CONVERT(NVARCHAR(255), @NewLeaderName)
SET @NewPartership =	CONVERT(INT, @NewPartership)

INSERT INTO Team (TeamName, ChurchName, District, LeaderEmail, LeaderName, Partership)
	VALUES(@NewTeamName, @NewChurchName, @NewDistrict, @NewLeaderEmail, @NewLeaderName, @NewPartership)
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteCTteam]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE             PROC [dbo].[DeleteCTteam]( 
	@NewTeamID				INT --pk, not editable
)	
AS
BEGIN
SET	@NewTeamID = CONVERT(INT, @NewTeamID)
DELETE TOP(1) FROM Team
WHERE TeamID = @NewTeamID
SELECT '[...TEAM DELETED...]'

END
GO
/****** Object:  StoredProcedure [dbo].[DeleteProject]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE             PROC [dbo].[DeleteProject]( 
	@NewProjectID			INT --pk, not editable
)	
AS
BEGIN
UPDATE TeamDetails
SET 
ProjectID = 0
WHERE ProjectID = @NewProjectID
DELETE FROM Project WHERE ProjectID = @NewProjectID
END 
GO
/****** Object:  StoredProcedure [dbo].[DeleteRecord]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE         PROC [dbo].[DeleteRecord](
	@NewTeamDetailsID		INT,--pk, not editab
	@NewProjectID			INT,               -- -- 
	@NewTeamID				INT, --pk, not editable
	@NewTID					INT			--
)	
AS
BEGIN
SET @NewTeamDetailsID = CONVERT(INT, @NewTeamDetailsID)
SET @NewProjectID = CONVERT(INT, @NewProjectID)
SET	@NewTeamID = CONVERT(INT, @NewTeamID)
SET @NewTID = CONVERT(INT, @NewTID)



DELETE TOP(1) FROM TeamMember
WHERE @NewTID = TeamMemberID AND @NewTID IS NOT NULL

DELETE TOP(1) FROM TeamDetails	
WHERE TeamDetailsID = @NewTeamDetailsID


DELETE TOP(1) FROM Team
WHERE TeamID = @NewTeamID


DELETE TOP(1) FROM Project
WHERE ProjectID = @NewProjectID 

SELECT '[...RECORD DELETED...]'

END


GO
/****** Object:  StoredProcedure [dbo].[DeleteTeam]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE           PROC [dbo].[DeleteTeam]( 
	@NewTeamID				INT --pk, not editable
)	
AS
BEGIN
SET	@NewTeamID = CONVERT(INT, @NewTeamID)
SELECT '[...TEAM DELETED...]'
DELETE FROM TeamMemberSkills WHERE (TeamMemberID = (SELECT TeamMemberID FROM TeamMember WHERE TeamID = @NewTeamID))
DELETE FROM TeamMember WHERE TeamID = @NewTeamID
DELETE FROM TeamDetails WHERE TeamID = @NewTeamID
DELETE FROM TeamPartnerProfile WHERE TeamID = @NewTeamID
END 
GO
/****** Object:  StoredProcedure [dbo].[DeleteTeamMember]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE             PROC [dbo].[DeleteTeamMember]( 
	@NewTeamMemberID			INT --pk, not editable
)	
AS
BEGIN
DECLARE @TEAMID  INT
SET @TEAMID = (SELECT TeamID FROM TeamMember Where TeamMemberID = @NewTeamMemberID)
DELETE FROM TeamMemberSkills WHERE TeamMemberID = @NewTeamMemberID
DELETE FROM TeamMember WHERE TeamMemberID = @NewTeamMemberID
UPDATE TeamDetails 
SET NumTeamMemb = NumTeamMemb - 1

WHERE TeamID = @TeamID
DECLARE @VALID INT
SET @VALID = (SELECT NumTeamMemb FROM TeamDetails Where TeamID = @TeamID) 
IF @VALID < 1
BEGIN 
DELETE FROM TeamDetails WHERE TeamID = @TeamID
END 
END
GO
/****** Object:  StoredProcedure [dbo].[EditCTteam]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE             PROC [dbo].[EditCTteam](
	@NewTeamID				   INT,--pk, not editable
	@NewTeamName			   NVARCHAR(255),
	@NewChurchName			   NVARCHAR(255),              
	@NewDistrict			   NVARCHAR(255),
	@NewLeaderEmail			   NVARCHAR(255),
	@NewLeaderName			   NVARCHAR(255),
	@NewPartership			   INT,
	@NewCancelled			   INT
)	
AS
BEGIN
SET @NewTeamID =		CONVERT(INT, @NewTeamID)
SET @NewTeamName =		CONVERT(NVARCHAR(255), @NewTeamName)
SET @NewChurchName =	CONVERT(NVARCHAR(255), @NewChurchName)
SET @NewDistrict =		CONVERT(NVARCHAR(255), @NewDistrict)
SET @NewLeaderEmail =	CONVERT(NVARCHAR(255), @NewLeaderEmail)
SET @NewLeaderName =	CONVERT(NVARCHAR(255), @NewLeaderName)
SET @NewPartership =	CONVERT(INT, @NewPartership)
SET @NewCancelled =		CONVERT(INT, @NewCancelled)
UPDATE Team
SET 
	TeamName     =   @NewTeamName,
	ChurchName   =   @NewChurchName,
	District     =   @NewDistrict,
	LeaderEmail  =   @NewLeaderEmail,
	LeaderName   =   @NewLeaderName,
	Partership   =   @NewPartership
WHERE TeamID     =   @NewTeamID
UPDATE TeamDetails
SET 
	CancelTeam = @NewCancelled
WHERE TeamID = @NewTeamID  
END
GO
/****** Object:  StoredProcedure [dbo].[EditFunds]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE         PROC [dbo].[EditFunds](
	@NewTeamDetailsID		   INT,--pk, not editable
	@NewProjectFundsRecieved   BIT, 	 --
	@NewCancelTeam			   INT, --              --
	@NewProjectMoney		   MONEY --             --            --
)	
AS
BEGIN
SET @NewTeamDetailsID = CONVERT(INT, @NewTeamDetailsID)
SET @NewProjectFundsRecieved = CONVERT(BIT, @NewProjectFundsRecieved)
SET @NewCancelTeam = CONVERT(INT, @NewCancelTeam)
SET @NewProjectMoney = CONVERT(MONEY, @NewProjectMoney)

UPDATE TeamDetails
SET ProjectFundsReceived = @NewProjectFundsRecieved,
	CancelTeam =			   @NewCancelTeam,
	ProjectMoney =			 @NewProjectMoney
WHERE TeamDetailsID = @NewTeamDetailsID


END
GO
/****** Object:  StoredProcedure [dbo].[EditMemberTeam]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE          PROC [dbo].[EditMemberTeam] (
	@TMID		INT,
	@TeamID		INT
)
AS
BEGIN
UPDATE TeamMember
SET
	TeamID = @TeamID
WHERE TeamMemberID = @TMID
UPDATE TeamDetails
SET
	NumTeamMemb = NumTeamMemb + 1
WHERE TeamID = @TeamID
END
GO
/****** Object:  StoredProcedure [dbo].[EditProject]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE               PROC [dbo].[EditProject](
		@NewProjectID						INT,
		@NewWWCoorID						INT,
		@NewDateRecieved					DATE,
		@NewLinkToWWsite					NVARCHAR(255),
		@NewUserPermission					NVARCHAR(255),
		@NewProjectTypeID					INT,
		@NewDistrictID						INT,
		@NewCityName						NVARCHAR(255),
		@NewPastorName						NVARCHAR(MAX),
		@NewPastorPhone						NVARCHAR(MAX),
		@NewLocationLink					NVARCHAR(255),
		@NewDistanceFromDistrictOff			NVARCHAR(255),
		@NewDistrictBudgetCurrent			MONEY,
		@NewDistrictBudgetLast				MONEY,
		@NewFEMCurrent						MONEY,
		@NewFEMLast							MONEY,
		@NewDateOrganized					DATE,
		@NewMembersLast						INT,
		@NewMembersCurrent					INT,
		@NewAvgAttendanceLast				INT,
		@NewAvgAttendanceCurent				INT,
		@NewProjectDesc						NVARCHAR(MAX),
		@NewTempleCapacity					INT,
		@NewRoofWidth						INT,
		@NewRoofLength						INT,
		@NewBriefDescriptionConst			NVARCHAR(MAX),
		@NewPropertyWidth					INT,
		@NewPropertyLength					INT,
		@NewPhotos							INT,
		@NewDigital							INT,
		@NewLotLayout						INT,
		@NewProjectPlans					INT,
		@NewMoneyRaised						MONEY,
		@NewMoneyInvested					MONEY,
		@NewMoney12Months					MONEY,
		@NewProjectNeed						NVARCHAR(MAX),
		@NewTitleToProperty					INT,
		@NewPropertyDeededToChurch			INT,
		@NewBuildingPermitNeeded			INT,
		@NewBuildingPermitApproved			INT,
		@NewPastorApproved					INT,
		@NewChurchBoardApproved				INT,
		@NewTreasureApproved				INT,
		@NewTreasureApprovedDate			DATE,
		@NewSuperApproval					INT,
		@NewSuperApprovalDate				DATE,
		@NewDistrictSecretaryApproval		INT,
		@NewDistrictTreasureApproval		INT,
		@NewDistrictTreasureApprovalDate	DATE,
		@NewDistrictPriority				INT,
		@NewTyTapproved						INT,
		@NewTyTPriority						INT,
		@NewProjectCompleted				INT,
		@NewWwLink							NVARCHAR(255),
		@NewPhotoLocation					NVARCHAR(255),
		@NewPermitStart						DATE,
		@NewPermitEnd						DATE,
		@NewCountryID						INT
)
AS
BEGIN
UPDATE Project
SET
	WWCoordID							=	@NewWWCoorID,
	DateReceived						=	@NewDateRecieved,
	LinkToWWsite						=   @NewLinkToWWsite,
	UserPermission						=   @NewUserPermission,
	ProjectTypeID						=   @NewProjectTypeID,
	DistrictID							=	@NewDistrictID,
	CityName							=	@NewCityName,
	PastorName							=	@NewPastorName,
	PastorPhone							=	@NewPastorPhone,
	LocationLink						=	@NewLocationLink,
	DistanceFromDistrictOff				=   @NewDistanceFromDistrictOff,
	DistrictBudgetCurrent				=	@NewDistrictBudgetCurrent,
	DistrictBudgetLast					=	@NewDistrictBudgetLast,
	FEMcurrent							=	@NewFEMCurrent,
	FEMlast								=	@NewFEMLast,
	DateOrganized						=	@NewDateOrganized,
	MembersLast							=	@NewMembersLast,
	MembersCurrent						=	@NewMembersCurrent,
	AvgAttendanceLast					=	@NewAvgAttendanceLast,
	AvgAttendanceCurr					=	@NewAvgAttendanceCurent,
	ProjectDesc							=	@NewProjectDesc,
	TempleCapacity						=	@NewTempleCapacity,
	RoofWidth							=	@NewRoofWidth,
	RoofLength							=	@NewRoofLength,
	BriefDescriptionConst				=	@NewBriefDescriptionConst,
	PropertyWidth						=	@NewPropertyWidth,
	PropertyLength						=	@NewPropertyLength,
	Photos								=	@NewPhotos,
	Digital								=	@NewDigital,
	LotLayout							=	@NewLotLayout,
	ProjectPlans						=	@NewProjectPlans,
	MoneyRaised							=	@NewMoneyRaised,
	MoneyInvested						=	@NewMoneyInvested,
	Money12Months						=	@NewMoney12Months,
	ProjectNeed							=	@NewProjectNeed,
	TitleToProperty						=	@NewTitleToProperty,
	PropertyDeededToChurch				=	@NewPropertyDeededToChurch,
	BuildingPermitNeeded				=	@NewBuildingPermitNeeded,
	BuildingPermitApproved				=	@NewBuildingPermitApproved,
	PastorApproved						=	@NewPastorApproved,
	ChurchBoardApproved					=	@NewChurchBoardApproved,
	TreasureApproved					=	@NewTreasureApproved,
	TreasureApprovalDate				=	@NewTreasureApprovedDate,
	SuperApproval						=	@NewSuperApproval,
	SuperApprovalDate					=	@NewSuperApprovalDate,
	DistrictSecretaryApproval			=	@NewDistrictSecretaryApproval,
	DistrictTreasureApproval			=	@NewDistrictTreasureApproval,
	DistrictTreasureApprovalDate		=	@NewDistrictTreasureApprovalDate,
	DistrictPriority					=	@NewDistrictPriority,
	TyTapproved							=	@NewTyTapproved,
	TyTPriority							=	@NewTyTPriority,
	ProjectCompleted					=	@NewProjectCompleted,
	Wwlink								=	@NewWwLink,
	PhotoLocation						=	@NewPhotoLocation,
	PermitStart							=	@NewPermitStart,
	PermitEnd							=	@NewPermitEnd,
	CountryID							=	@NewCountryID
WHERE ProjectID = @NewProjectID
END
GO
/****** Object:  StoredProcedure [dbo].[EditRecord]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE       PROC [dbo].[EditRecord](
	@NewTeamDetailsID		INT,--pk, not editable
	@NewTeamName			NVARCHAR (255), 	 --
	@NewNumTeamMemb			INT,                --
	@NewProjectID			INT,               --
	@NewArrivalDate			DATE,            --
	@NewDepartDate			DATE,                  --
	@NewCountryID			INT,        -- 
	@NewTeamID				INT, --pk, not editable
	@NewChurchID			INT,              --
	@NewFName				NVARCHAR (255),	--
	@NewMaxima				INT,				--
	@NewArriveFlightNumber	NVARCHAR (255),	--
	@NewDepartFlightNumber  NVARCHAR (255),  --
	@NewCancelTeam			INT, --
	@NewProjectMoney		MONEY, -- 
	@NewTID					INT			--
)	
AS
BEGIN
SET @NewTeamDetailsID = CONVERT(INT, @NewTeamDetailsID)
SET @NewTeamName = CONVERT(NVARCHAR (255), @NewTeamName)
SET @NewNumTeamMemb = CONVERT(INT, @NewNumTeamMemb) 
SET @NewProjectID = CONVERT(INT, @NewProjectID)
SET @NewArrivalDate = CONVERT(DATE, @NewArrivalDate)
SET @NewDepartDate = CONVERT(DATE, @NewDepartDate)
SET @NewCountryID = CONVERT(INT , @NewCountryID) 
SET	@NewTeamID = CONVERT(INT, @NewTeamID)
SET @NewChurchID = CONVERT(INT, @NewChurchID)
SET @NewFName = CONVERT(NVARCHAR (255), @NewFName)
SET @NewMaxima = CONVERT(INT,  @NewMaxima)
SET @NewArriveFlightNumber = CONVERT(NVARCHAR (255), @NewArriveFlightNumber)
SET @NewDepartFlightNumber = CONVERT(NVARCHAR (255), @NewDepartFlightNumber)
SET @NewCancelTeam = CONVERT(INT, @NewCancelTeam)	
SET @NewProjectMoney = CONVERT(MONEY, @NewProjectMoney)
IF @NewTID = NULL
	SET @NewFName = NULL
ELSE 
	SET @NewFName = @NewFName

UPDATE TeamMember
SET FName = @NewFName
WHERE @NewTID = TeamMemberID AND @NewTID IS NOT NULL

UPDATE TeamDetails	
SET				NumTeamMemb = @NewNumTeamMemb,
				   CountryID =  @NewCountryID,
					ProjectID = @NewProjectID, 
				 ArriveDate = @NewArrivalDate, 
				  DepartDate = @NewDepartDate, 
				  CancelTeam = @NewCancelTeam,  
  ArriveFlightNumber = @NewArriveFlightNumber,
  DepartFlightNumber = @NewDepartFlightNumber,
						  Maxima = @NewMaxima,
			  ProjectMoney = @NewProjectMoney
WHERE TeamDetailsID = @NewTeamDetailsID


UPDATE Team
SET TeamName = @NewTeamName
WHERE TeamID = @NewTeamID


UPDATE Project
SET ChurchID = @NewChurchID
WHERE ProjectID = @NewProjectID 
Return 0
END
GO
/****** Object:  StoredProcedure [dbo].[EditTeam]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE             PROC [dbo].[EditTeam](
	@NewTeamID				   INT,--pk, not editable
	@NewTeamName			   NVARCHAR(255),
	@NewChurchName			   NVARCHAR(255),              
	@NewDistrict			   NVARCHAR(255),
	@NewLeaderEmail			   NVARCHAR(255),
	@NewLeaderName			   NVARCHAR(255),
	@NewPartership			   INT,
	@NewCancelled			   INT
)	
AS
BEGIN
SET @NewTeamID =		CONVERT(INT, @NewTeamID)
SET @NewTeamName =		CONVERT(NVARCHAR(255), @NewTeamName)
SET @NewChurchName =	CONVERT(NVARCHAR(255), @NewChurchName)
SET @NewDistrict =		CONVERT(NVARCHAR(255), @NewDistrict)
SET @NewLeaderEmail =	CONVERT(NVARCHAR(255), @NewLeaderEmail)
SET @NewLeaderName =	CONVERT(NVARCHAR(255), @NewLeaderName)
SET @NewPartership =	CONVERT(INT, @NewPartership)
SET @NewCancelled =		CONVERT(INT, @NewCancelled)
UPDATE Team
SET 
	TeamName     =   @NewTeamName,
	ChurchName   =   @NewChurchName,
	District     =   @NewDistrict,
	LeaderEmail  =   @NewLeaderEmail,
	LeaderName   =   @NewLeaderName,
	Partership   =   @NewPartership
WHERE TeamID     =   @NewTeamID
UPDATE TeamDetails
SET 
	CancelTeam = @NewCancelled
WHERE TeamID = @NewTeamID  
END
GO
/****** Object:  StoredProcedure [dbo].[EditTeamDetails]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE         PROC [dbo].[EditTeamDetails](
	@NewTeamDetailsID		INT,--pk, not editable
	@NewTotalDailyFunds		MONEY,                --
	@NewNumTemMemb			INT,--
	@NewTeamMemberID		INT,
	@NewTeamTypeID			INT,
	@NewNumberOfDays		INT,
	@NewNumberOfNights		INT, 
	@NewArriveFlightNumber	NVARCHAR(255),--
	@NewArriveTime			DATETIME2(7),  
	@NewArriveDate			DATE,--
	@NewDepartTime			DATETIME2(7),
	@NewDepartDate			DATE,
	@NewDepartAirline			NVARCHAR(255),
	@NewDepartFlightNumber  NVARCHAR(255),
	@NewDistanceToRR		INT,
	@NewDistanceToProject	INT,
	@NewHotelID				INT,
	@NewCountryID			INT,
	@NewAirportID			INT,
	@NewTeamRegistration	INT, --bool
	@NewInsurance			INT, -- bool
	@NewMaxima				INT,	--bool
	@NewProjectMoney		MONEY,
	@NewPartnershipID		INT,
	@NewPartnerProfileID	INT,
	@NewTeamHost			INT, --bool
	@NewCulBroker			INT, --bool?
	@NewTruckDriver			INT, --bool
	@NewBusDriver			INT,  --bool
	@NewTranslator			INT, --bool
	@NewStructureDelivery	INT, --bool
	@NewCancelTeam			INT, --bool
	@NewProjectFundsReceived INT --bool
)	
AS
BEGIN
UPDATE TeamDetails
SET
	TotalDailyFunds = @NewTotalDailyFunds,
	NumTeamMemb = @NewNumTemMemb,
	TeamMemberID = @NewTeamMemberID,
	TeamTypeID = @NewTeamTypeID,
	NumberOfDays = @NewNumberOfDays,
	NumberOfNights = @NewNumberOfNights,
	ArriveFlightNumber = @NewArriveFlightNumber,
	ArriveTime = @NewArriveTime,
	ArriveDate = @NewArriveDate,
	DepartTime = @NewDepartTime,
	DepartDate = @NewDepartDate,
	DepartAirline = @NewDepartAirline,
	DepartFlightNumber = @NewDepartFlightNumber,
	DistanceToRR = @NewDistanceToRR,
	DistanceToProject = @NewDistanceToProject,
	HotelID = @NewHotelID,
	CountryID = @NewCountryID,
	AirportID = @NewAirportID,
	TeamRegistration = @NewTeamRegistration,
	Insurance = @NewInsurance,
	Maxima = @NewMaxima,
	ProjectMoney = @NewProjectMoney,
	PartnershipID = @NewPartnershipID,
	TeamPartnerProfileID = @NewPartnerProfileID,
	TeamHost = @NewTeamHost,
	CulBroker = @NewCulBroker,
	Translator = @NewTranslator,
	StructureDelivery = @NewStructureDelivery,
	CancelTeam = @NewCancelTeam,
	ProjectFundsReceived = @NewProjectFundsReceived
WHERE TeamDetailsID = @NewTeamDetailsID
	
END
GO
/****** Object:  StoredProcedure [dbo].[EditTeamMember]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE               PROC [dbo].[EditTeamMember](
	@EMTID						INT,
	@EMFName					NVARCHAR(255),
	@EMPhoneNumber				NVARCHAR(255),
	@EMCountry					NVARCHAR(255),
	@EMDistrict					NVARCHAR(255),
	@EMPreviousProjects			INT,
	@EMSecondLanguage			NVARCHAR(50),
	@EMSkillsID					INT,
	@EMTeamMemberTypeID			INT,
	@EMTeamLeader				INT,
	@EMTeamID					INT,
	@EMLastTrip					DATE,
	@EMMale						INT,
	@EMFemale					INT,
	@EMSpouseOnTeam				INT,				
	@EMPassPortExp				DATE,
	@EMFoodAllergies			NVARCHAR(255),
	@EMMedicalAllergies			NVARCHAR(255),
	@EMDPI						NVARCHAR(255),
	@EMEmail					NVARCHAR(255)
)
AS
BEGIN --This record exists, update it 
	UPDATE TeamMember
	SET					
	FName                   = @EMFName,						
	PhoneNumber			    = @EMPhoneNumber,
	Country					= @EMCountry,
	District				= @EMDistrict,
	PreviousProjects		= @EMPreviousProjects,
	SecondLanguage			= @EMSecondLanguage,
	SkillsID				= @EMSkillsID,
	TeamLeader				= @EMTeamLeader,
	LastTrip				= @EMLastTrip,
	Male					= @EMMale,
	Female					= @EMFemale,
	SpouseOnTeam			= @EMSpouseOnTeam,
	PassPortExp				= @EMPassPortExp,
	FoodAllergies			= @EMFoodAllergies,
	MedicalAllergies		= @EMMedicalAllergies,
	DPI						= @EMDPI,
	Email					= @EMEmail
WHERE TeamMemberID = @EMTID
IF ((SELECT TeamID FROM TeamMember WHERE TeamMemberID = @EMTID) != @EMTeamID)
BEGIN
UPDATE TeamDetails
	SET NumTeamMemb = NumTeamMemb - 1
WHERE TeamID = (SELECT TeamID FROM TeamMember WHERE TeamMemberID = @EMTID)
UPDATE TeamDetails
	SET NumTeamMemb = NumTeamMemb + 1
WHERE TeamID =  @EMTeamID
UPDATE TeamMember
	SET	TeamID = @EMTeamID
WHERE TeamMemberID = @EMTID
RETURN 0
END
END
GO
/****** Object:  StoredProcedure [dbo].[ExpectedFunds]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE         PROC [dbo].[ExpectedFunds] 
AS
BEGIN
SELECT DISTINCT TeamDetails.TeamDetailsID, 
		TeamDetails.ProjectFundsReceived, 
		TeamDetails.CancelTeam, 	
		TeamDetails.ProjectMoney, 
		TeamDetails.ArriveDate, 
		Team.TeamName,
		Team.TeamID
		FROM (Team 
		INNER JOIN TeamDetails ON Team.TeamID = TeamDetails.TeamID) WHERE 
		(((TeamDetails.ProjectFundsReceived)=0) AND ((TeamDetails.CancelTeam)=0))  
END
GO
/****** Object:  StoredProcedure [dbo].[ProjectsByDistrict]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE       PROC [dbo].[ProjectsByDistrict] 
AS
BEGIN
SELECT 
	[SSMA$District$local].[DistrictName], 
	[TeamDetails].[ArriveDate], 
	[Country].[CountryName]
FROM Country 
INNER JOIN (TeamDetails RIGHT JOIN (SSMA$District$local INNER JOIN Project ON SSMA$District$local.DistrictID = Project.DistrictID) 
	ON TeamDetails.ProjectID = Project.ProjectID) 
	ON Country.CountryID = SSMA$District$local.CountryID
GROUP BY SSMA$District$local.DistrictName, TeamDetails.ArriveDate, Country.CountryName
HAVING (TeamDetails.ArriveDate)>(DATEADD(day, -15, GETDATE()))
END

GO
/****** Object:  StoredProcedure [dbo].[ProjectTeamTables]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROC [dbo].[ProjectTeamTables] 
AS
BEGIN
DROP TABLE IF EXISTS ##ProjectMoneyRequested
--projectMoneyRequested query text
SELECT DISTINCT Project.ProjectID AS ProjectID, Sum(CheckSolicitud.USD) AS SumOfUSD, CheckSolicitud.SolicitudDate AS SD
INTO ##ProjectMoneyRequested 
FROM TeamDetails INNER JOIN (CheckSolicitud INNER JOIN Project ON CheckSolicitud.ProjectID = Project.ProjectID) 
ON TeamDetails.ProjectID = CheckSolicitud.ProjectID
GROUP BY Project.ProjectID, CheckSolicitud.SolicitudDate
--SELECT * FROM #Project
SELECT 
	TeamDetails.TeamDetailsID AS TeamDetailsID, 
	Team.TeamName AS TeamName, 
	TeamDetails.NumTeamMemb AS NumTeamMemb, 
	TeamDetails.ProjectID AS ProjectID, 
	TeamDetails.ArriveDate AS ArrivalDate, 
	TeamDetails.DepartDate AS DepartDate, 
	Country.CountryName AS CountryName, 
	Team.TeamID AS TeamID, 
	Project.ChurchID AS ChurchID, 
	TeamMember.FName AS FName, 
	TeamMember.TeamMemberID AS TID,
	TeamDetails.Maxima AS Maxima, 
	TeamDetails.ArriveFlightNumber AS ArriveFlightNumber, 
	TeamDetails.DepartFlightNumber AS DepartFlightNumber, 
	TeamDetails.CancelTeam AS CancelTeam, 
	##ProjectMoneyRequested.SumOfUSD AS SumOfUSD,
	TeamDetails.ProjectMoney AS ProjectMoney
	FROM (TeamMember RIGHT JOIN (((Team INNER JOIN TeamDetails ON Team.TeamID = TeamDetails.TeamID) 
LEFT JOIN Country ON TeamDetails.CountryID = Country.CountryID) 
LEFT JOIN Project ON TeamDetails.ProjectID = Project.ProjectID) 
	ON TeamMember.TeamMemberID = TeamDetails.TeamHost) 
LEFT JOIN ##ProjectMoneyRequested ON Project.ProjectID = ##ProjectMoneyRequested.ProjectID 
WHERE (((TeamDetails.ArriveDate)>(DATEADD(day, -15, GETDATE())) And ((TeamDetails.Maxima) = 0)))
	OR
	  (((TeamDetails.ArriveDate)>(DATEADD(day, -15, GETDATE())) And (TeamDetails.CancelTeam = 0) And ((TeamDetails.Maxima) = 1)))
ORDER BY TeamDetails.ArriveDate 
END

GO
/****** Object:  StoredProcedure [dbo].[registerUser]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE      PROC [dbo].[registerUser] (
	@newUser  NVARCHAR(64), 
	@newPass  NVARCHAR(64),
	@newEmail NVARCHAR(64))
AS
BEGIN
IF  EXISTS(
	(SELECT TOP(1) 
	[userID], 
	[userName],
	[userPassword],
	[userEmail],
	[userClearanceLevel],
	[userSalt]
	FROM userInfo
	WHERE 
    userName = @newUser
	))
		BEGIN
			SELECT('This Username is in use. Please try a new username')
			RETURN 0 --Fail
		END
ELSE
		BEGIN --create salt
			-- salt and resulting pass variables
			DECLARE @SALT		  NVARCHAR(64)	
			DECLARE @RESULT		  NVARCHAR(64)
			DECLARE @RESCONVERTER VARBINARY(64)
			DECLARE @RESCONVERTERPASS	VARCHAR(64)
			--variables for the salt
			DECLARE @SEED	INT
			DECLARE @REP	INT
			DECLARE @NOW	DATETIME

			SET @NOW = CONVERT(DATETIME,DATEADD(DAY,4,GETDATE()))
			SET @SEED = (DATEPART(hh, @NOW) *1000) + (DATEPART(mi, @NOW) *10) + (DATEPART(s, @NOW) *1000000) + (DATEPART(ms, @NOW) * 10000)
			SET @SALT = CHAR(ROUND((RAND(@SEED) * 87.0)+ 64, 3))
			SET @REP = 1
			
			WHILE (@REP < 50)
			BEGIN
				SET @SALT = @SALT + CHAR(ROUND((RAND() * 87.0) , 64, 3))
				SET @REP = @REP + 1
			END

			
			SET @RESULT = @newPass + @SALT 
			SELECT @RESULT
			SET @RESCONVERTER = (HASHBYTES('SHA2_512',@RESULT))
			SELECT  @RESCONVERTER
			INSERT INTO userInfo(userSalt, userName, userPassword, userEmail, userClearanceLevel) 
			VALUES(@SALT, @newUser, @RESCONVERTER, @newEmail, 0) 

			RETURN 1 --Success
		END
END

GO
/****** Object:  StoredProcedure [dbo].[ViewAllMembers]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE         PROC [dbo].[ViewAllMembers] 
AS
BEGIN
SELECT * FROM TeamMember WHERE TeamMemberID != 0
END
GO
/****** Object:  StoredProcedure [dbo].[ViewProjects]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE         PROC [dbo].[ViewProjects] 
AS
BEGIN
SELECT * FROM Project WHERE ProjectID != 0
END
GO
/****** Object:  StoredProcedure [dbo].[ViewTeamMembers]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE         PROC [dbo].[ViewTeamMembers](
@TeamID			INT
)
AS
BEGIN
SELECT * FROM TeamMember WHERE TeamID = @TeamID
END
GO
/****** Object:  StoredProcedure [dbo].[ViewTeams]    Script Date: 10/22/2020 11:43:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE       PROC [dbo].[ViewTeams] 
AS
BEGIN
SELECT * FROM Team WHERE TeamID != 0
END
GO
USE [master]
GO
ALTER DATABASE [mission2Go] SET  READ_WRITE 
GO
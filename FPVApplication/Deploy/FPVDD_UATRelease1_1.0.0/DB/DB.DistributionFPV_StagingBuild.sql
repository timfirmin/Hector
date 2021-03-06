USE [DistributionFPV]
GO
/****** Object:  Table [staging].[DistributionMissingMinutes]    Script Date: 11/07/2018 16:26:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DistributionMissingMinutes]') AND type in (N'U'))
BEGIN
CREATE TABLE [staging].[DistributionMissingMinutes](
	[DistributionGroupCode] [varchar](50) NULL,
	[DistributionCode] [varchar](50) NULL,
	[Society] [varchar](50) NULL,
	[StationId] [varchar](50) NULL,
	[MasterStationId] [varchar](50) NULL,
	[MinutesMissingData] [decimal](18, 3) NULL,
	[MinutesCarryForwards] [decimal](18, 3) NULL,
	[MinutesTotal] [decimal](18, 3) NULL,
	[RevenueMissingData] [decimal](18, 3) NULL,
	[RevenueCarryForwards] [decimal](18, 3) NULL,
	[RevenueTotal] [decimal](18, 3) NULL,
	[InsertTimeStamp] [datetime2](2) NULL,
	[InsertLoadId] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [staging].[DistributionMusicMinutes]    Script Date: 11/07/2018 16:26:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DistributionMusicMinutes]') AND type in (N'U'))
BEGIN
CREATE TABLE [staging].[DistributionMusicMinutes](
	[DistributionGroupCode] [varchar](50) NOT NULL,
	[DistributionCode] [varchar](50) NOT NULL,
	[Society] [varchar](50) NOT NULL,
	[StationID] [varchar](50) NOT NULL,
	[MasterStationId] [varchar](50) NULL,
	[ProgrammeForecast] [decimal](18, 3) NULL,
	[NonProgrammeForecast] [decimal](18, 3) NULL,
	[CommercialForecast] [decimal](18, 3) NULL,
	[LateDataForecast] [decimal](18, 3) NULL,
	[TotalForecast] [decimal](18, 3) NULL,
	[InsertLoadId] [int] NOT NULL,
	[InsertTimeStamp] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [staging].[DistributionPlanningRevenue]    Script Date: 11/07/2018 16:26:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DistributionPlanningRevenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [staging].[DistributionPlanningRevenue](
	[TM1BaseRevenueKey] [int] IDENTITY(1,1) NOT NULL,
	[CompanyCode] [varchar](50) NULL,
	[AccountCodeEL1] [varchar](50) NULL,
	[AccountDescrEL1] [varchar](150) NULL,
	[AccountCodeEL2] [varchar](50) NULL,
	[AccountDescrEL2] [varchar](150) NULL,
	[PlanningScenario] [varchar](50) NULL,
	[PlanningPeriod] [varchar](50) NULL,
	[PlanningYear] [varchar](50) NULL,
	[PlanningFilePeriodSeq] [int] NULL,
	[PlanningPeriodFirstDay] [datetime2](2) NULL,
	[TM1CategoryOnlineBroadcast] [varchar](150) NULL,
	[TM1BroadcastGroup] [varchar](150) NULL,
	[ValueGBP] [money] NULL,
	[TM1PlanningFileLogKey] [int] NULL,
	[InsertLoadId] [int] NULL,
	[InsertTimeStamp] [datetime] NULL,
 CONSTRAINT [PK_BaseRevenue] PRIMARY KEY CLUSTERED 
(
	[TM1BaseRevenueKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [staging].[DistributionPublicReception]    Script Date: 11/07/2018 16:26:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DistributionPublicReception]') AND type in (N'U'))
BEGIN
CREATE TABLE [staging].[DistributionPublicReception](
	[DistributionGroupCode] [varchar](50) NULL,
	[DistributionCode] [varchar](50) NULL,
	[Society] [varchar](50) NULL,
	[StationId] [varchar](50) NULL,
	[MasterStationId] [varchar](50) NULL,
	[CustomerCode] [varchar](50) NULL,
	[TotalPRAllocation] [decimal](18, 3) NULL,
	[InsertTimeStamp] [datetime2](2) NULL,
	[InsertLoadId] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [staging].[DistributionSampleDates]    Script Date: 11/07/2018 16:26:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DistributionSampleDates]') AND type in (N'U'))
BEGIN
CREATE TABLE [staging].[DistributionSampleDates](
	[DistributionGroupCode] [varchar](50) NULL,
	[DistributionCode] [varchar](50) NULL,
	[Society] [varchar](50) NULL,
	[StationId] [varchar](50) NULL,
	[MasterStationId] [varchar](50) NULL,
	[SongsProgrammeSampleDates] [decimal](18, 3) NULL,
	[NonSongProgrammeSampleDates] [decimal](18, 3) NULL,
	[CommercialSampleDates] [decimal](18, 3) NULL,
	[CommercialForecastPercentage] [decimal](18, 3) NULL,
	[InsertTimeStamp] [datetime2](2) NULL,
	[InsertLoadId] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [staging].[MasterDistributionGroup]    Script Date: 11/07/2018 16:26:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[MasterDistributionGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [staging].[MasterDistributionGroup](
	[ID] [int] NOT NULL,
	[MUID] [uniqueidentifier] NOT NULL,
	[VersionName] [nvarchar](50) NOT NULL,
	[VersionNumber] [int] NOT NULL,
	[Version_ID] [int] NOT NULL,
	[VersionFlag] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NULL,
	[Code] [nvarchar](250) NOT NULL,
	[ChangeTrackingMask] [int] NOT NULL,
	[HectorInScope] [nvarchar](100) NULL,
	[LicensingPeriod] [nvarchar](100) NULL,
	[LicensingPeriodStart] [nvarchar](100) NULL,
	[LicensingPeriodEnd] [nvarchar](100) NULL,
	[FPVCalculatedMonth] [nvarchar](100) NULL,
	[AnnualReconciliation] [nvarchar](100) NULL,
	[EnterDateTime] [datetime2](3) NOT NULL,
	[EnterUserName] [nvarchar](100) NULL,
	[EnterVersionNumber] [int] NULL,
	[LastChgDateTime] [datetime2](3) NOT NULL,
	[LastChgUserName] [nvarchar](100) NULL,
	[LastChgVersionNumber] [int] NULL,
	[ValidationStatus] [nvarchar](250) NULL,
	[InsertLoadId] [int] NULL,
	[InsertTimeStamp] [datetime2](3) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [staging].[MasterDistributionPeriod]    Script Date: 11/07/2018 16:26:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[MasterDistributionPeriod]') AND type in (N'U'))
BEGIN
CREATE TABLE [staging].[MasterDistributionPeriod](
	[ID] [int] NOT NULL,
	[MUID] [uniqueidentifier] NOT NULL,
	[VersionName] [nvarchar](50) NOT NULL,
	[VersionNumber] [int] NOT NULL,
	[Version_ID] [int] NOT NULL,
	[VersionFlag] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NULL,
	[Code] [nvarchar](250) NOT NULL,
	[ChangeTrackingMask] [int] NOT NULL,
	[MainMini] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[StartDate] [nvarchar](100) NULL,
	[EndDate] [nvarchar](100) NULL,
	[EnterDateTime] [datetime2](3) NOT NULL,
	[EnterUserName] [nvarchar](100) NULL,
	[EnterVersionNumber] [int] NULL,
	[LastChgDateTime] [datetime2](3) NOT NULL,
	[LastChgUserName] [nvarchar](100) NULL,
	[LastChgVersionNumber] [int] NULL,
	[ValidationStatus] [nvarchar](250) NULL,
	[InsertLoadId] [int] NULL,
	[InsertTimeStamp] [datetime2](3) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [staging].[MasterPlanningScenario]    Script Date: 11/07/2018 16:26:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[MasterPlanningScenario]') AND type in (N'U'))
BEGIN
CREATE TABLE [staging].[MasterPlanningScenario](
	[PlanningYear] [varchar](50) NULL,
	[PlanningScenario] [varchar](50) NULL,
	[ScenarioFirstArrivedDate] [datetime2](2) NULL,
	[ScenarioExpectedSignOffDate] [datetime2](2) NULL,
	[ScenarioLatestForYearFlag] [varchar](1) NULL,
	[InsertLoadId] [int] NULL,
	[InsertTimeStamp] [datetime2](3) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [staging].[MasterStation]    Script Date: 11/07/2018 16:26:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[MasterStation]') AND type in (N'U'))
BEGIN
CREATE TABLE [staging].[MasterStation](
	[Code] [nvarchar](250) NULL,
	[BroadcasterDomain] [nvarchar](250) NULL,
	[DistributionGroup] [nvarchar](250) NULL,
	[LicencedStatus] [nvarchar](250) NULL,
	[MCPSLicenceType] [nvarchar](250) NULL,
	[RightType] [nvarchar](250) NULL,
	[Diversity] [nvarchar](100) NULL,
	[LowRevenue] [nvarchar](100) NULL,
	[CensusOrSampled] [nvarchar](100) NULL,
	[CodaCustomerCode] [nvarchar](100) NULL,
	[CashOutCode] [nvarchar](100) NULL,
	[StationAdminRate] [decimal](38, 2) NULL,
	[PublicReceptionAdminRate] [decimal](38, 2) NULL,
	[PRSHedgedRate] [nvarchar](100) NULL,
	[Name] [nvarchar](250) NULL,
	[InsertLoadId] [int] NULL,
	[InsertTimeStamp] [datetime2](7) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DistributionMusicMinutes]    Script Date: 11/07/2018 16:26:52 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[staging].[DistributionMusicMinutes]') AND name = N'IX_DistributionMusicMinutes')
CREATE NONCLUSTERED INDEX [IX_DistributionMusicMinutes] ON [staging].[DistributionMusicMinutes]
(
	[DistributionGroupCode] ASC,
	[DistributionCode] ASC,
	[StationID] ASC,
	[Society] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DF_DistributionMissingMinutes_InsertTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [staging].[DistributionMissingMinutes] ADD  CONSTRAINT [DF_DistributionMissingMinutes_InsertTimeStamp]  DEFAULT (getdate()) FOR [InsertTimeStamp]
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DF_DistributionMusicMinutes_InsertTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [staging].[DistributionMusicMinutes] ADD  CONSTRAINT [DF_DistributionMusicMinutes_InsertTimeStamp]  DEFAULT (getdate()) FOR [InsertTimeStamp]
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DF_BaseRevenueTM1_InsertTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [staging].[DistributionPlanningRevenue] ADD  CONSTRAINT [DF_BaseRevenueTM1_InsertTimeStamp]  DEFAULT (getdate()) FOR [InsertTimeStamp]
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DF_DistributionPublicReception_InsertTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [staging].[DistributionPublicReception] ADD  CONSTRAINT [DF_DistributionPublicReception_InsertTimeStamp]  DEFAULT (getdate()) FOR [InsertTimeStamp]
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DF_DistributionSampleDates_InsertTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [staging].[DistributionSampleDates] ADD  CONSTRAINT [DF_DistributionSampleDates_InsertTimeStamp]  DEFAULT (getdate()) FOR [InsertTimeStamp]
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DF_MasterDistributionGroup_InsertTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [staging].[MasterDistributionGroup] ADD  CONSTRAINT [DF_MasterDistributionGroup_InsertTimeStamp]  DEFAULT (getdate()) FOR [InsertTimeStamp]
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DF_MasterDistributionPeriod_InsertTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [staging].[MasterDistributionPeriod] ADD  CONSTRAINT [DF_MasterDistributionPeriod_InsertTimeStamp]  DEFAULT (getdate()) FOR [InsertTimeStamp]
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DF_MasterPlanningScenario_InsertTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [staging].[MasterPlanningScenario] ADD  CONSTRAINT [DF_MasterPlanningScenario_InsertTimeStamp]  DEFAULT (getdate()) FOR [InsertTimeStamp]
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[staging].[DF_MasterStation_InsertTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [staging].[MasterStation] ADD  CONSTRAINT [DF_MasterStation_InsertTimeStamp]  DEFAULT (getdate()) FOR [InsertTimeStamp]
END

GO

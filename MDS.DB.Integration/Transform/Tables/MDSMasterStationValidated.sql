CREATE TABLE [Transform].[MDSMasterStationValidated](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoadId] [int] NULL,
	[RuleId] [int] NULL,
	[Data] [nvarchar](max) NULL,
	[DataRowCount] [int] NULL,
	[LogDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

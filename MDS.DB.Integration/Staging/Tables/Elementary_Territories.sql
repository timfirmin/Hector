CREATE TABLE [Staging].[Elementary_Territories](
	[CODE]            [varchar](5)  NOT NULL,
	[NAME]            [varchar](60) NOT NULL,
	[ABBREV]          [varchar](10) NOT NULL,
	[TIS_CODE]        decimal(4,0)  NULL,
	[ELT_CODE_SHARE]  [varchar](5)  NOT NULL,
	[ROLLUP_ELT_CODE] [varchar](5)  NULL,
	LoadID            int            NOT NULL,
	SysStartTime      datetime       NOT NULL,
	SysEndTime        datetime       NULL
) ON [PRIMARY]

GO



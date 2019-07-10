CREATE TABLE [Staging].[CG_Ref_Codes](
	[RV_DOMAIN]       [varchar](100) NOT NULL,
	[RV_LOW_VALUE]    [varchar](240) NOT NULL,
	[RV_HIGH_VALUE]   [varchar](240) NULL,
	[RV_ABBREVIATION] [varchar](240) NULL,
	[RV_MEANING]      [varchar](240) NULL,
	LoadID            int            NOT NULL,
	SysStartTime      datetime       NOT NULL,
	SysEndTime        datetime       NULL
) ON [PRIMARY]

GO



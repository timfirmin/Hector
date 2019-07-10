CREATE TABLE [Staging].[MCPS_Licence_Types](
	[SURR_ID]     decimal(12,0)  NOT NULL,
	[NAME]        [varchar](60)  NOT NULL,
	[DESCRIPTION] [varchar](500) NULL,
	LoadID        int            NOT NULL,
	SysStartTime  datetime       NOT NULL,
	SysEndTime    datetime       NULL
) ON [PRIMARY]

GO



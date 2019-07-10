CREATE TABLE [Clean].[MCPS_Licence_Types](
	[SURR_ID]     decimal(12,0)  NOT NULL,
	[NAME]        [varchar](60)  NOT NULL,
	[DESCRIPTION] [varchar](500) NULL,
	LoadID        int            NOT NULL,
	SysStartTime  datetime       NOT NULL,
	SysEndTime    datetime       NULL,
	RejectRow_YN  [varchar](1)   NOT NULL
) ON [PRIMARY]

GO



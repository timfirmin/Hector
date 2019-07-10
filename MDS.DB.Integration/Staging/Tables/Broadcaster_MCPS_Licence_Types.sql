CREATE TABLE [Staging].[Broadcaster_MCPS_Licence_Types](
	[SURR_ID]             decimal(12,0)  NOT NULL,
	[BRO_TP_SURR_ID]      decimal(12,0)  NOT NULL,
	[EFFECTIVE_FROM_DATE] datetime       NOT NULL,
	[EFFECTIVE_TO_DATE]   datetime       NULL,
	[MLTY_SURR_ID]        decimal(12,0)  NOT NULL,
	LoadID                int            NOT NULL,
	SysStartTime          datetime       NOT NULL,
	SysEndTime            datetime       NULL
) ON [PRIMARY]

GO



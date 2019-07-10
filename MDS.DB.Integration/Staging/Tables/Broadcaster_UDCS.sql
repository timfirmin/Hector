CREATE TABLE [Staging].[Broadcaster_UDCS](
	[BRO_TP_SURR_ID]         decimal(12,0)  NOT NULL,
	[DC_SURR_ID]             decimal(12,0)  NOT NULL,
	[START_DATE]             datetime       NOT NULL,
	[END_DATE]               datetime       NULL,
	[USED_FOR_PURPOSE]       [varchar](1)   NOT NULL,
	[PERFORMANCE_START_DATE] datetime       NULL,
	[PERFORMANCE_END_DATE]   datetime       NULL,
	[BND_SURR_ID]            decimal(12,0)  NULL,
	[MBRG_SURR_ID]           decimal(12,0)  NULL,
	LoadID                   int            NOT NULL,
	SysStartTime             datetime       NOT NULL,
	SysEndTime               datetime       NULL
) ON [PRIMARY]

GO



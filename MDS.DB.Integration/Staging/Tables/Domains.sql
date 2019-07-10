CREATE TABLE [Staging].[Domains](
	[SURR_ID]                 decimal(12,0)  NOT NULL,
	[NAME]                    [varchar](100) NOT NULL,
	[CREATED_BY_EMPL_SURR_ID] decimal(12,0)  NOT NULL,
	[CREATED_DTM]             datetime       NOT NULL,
	[UPDATED_BY_EMPL_SURR_ID] decimal(12,0)  NULL,
	[UPDATED_DTM]             datetime       NULL,
	LoadID                    int            NOT NULL,
	SysStartTime              datetime       NOT NULL,
	SysEndTime                datetime       NULL
) ON [PRIMARY]

GO



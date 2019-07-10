CREATE TABLE [Staging].[Usage_Distribution_Codes](
	[CODE]                           [varchar](5)  NOT NULL,
	[SURR_ID]                        decimal(12,0) NOT NULL,
	[PARTIAL_DISTRIBUTION_PERMITTED] [varchar](1)  NOT NULL,
	[USAGE_TYPE]                     [varchar](5)  NOT NULL,
	[POINTS_CALCULATION_ROUTINE]     [varchar](10) NULL,
	[INACTIVE_DATE]                  datetime      NULL,
	[DESCRIPTION]                    [varchar](60) NULL,
	[GC_CSC_TABLE]                   [varchar](5)  NULL,
	[GC_CSC_CODE]                    [varchar](5)  NULL,
	[SOC_SURR_ID]                    decimal(12,0) NULL,
	[ANALOGOUS_FLAG_YN]              [varchar](1)  NOT NULL,
	[CLASSICAL_FLAG_YN]              [varchar](1)  NOT NULL,
	[MIN_EVENT_ROYALTY_AMOUNT]       decimal(14,4) NULL,
	[MAX_EVENT_ROYALTY_AMOUNT]       decimal(14,4) NULL,
	[ROLLUP_FLAG_YN]                 [varchar](1)  NOT NULL,
	[LAST_UPDATED_DATE]              datetime      NULL,
	[EXTRACT_WACU_YN]                [varchar](1)  NULL,
	[ALLOW_CARRY_FORWARD_YN]         [varchar](1)  NOT NULL,
	[LIFELINE_SEQ_ORDER]             decimal(12,0) NULL,
	[LICENCE_TYPE]                   [varchar](5)  NOT NULL,
	[DEFAULT_NOTIONAL_VALUE]         decimal(16,6) NULL,
	[MECH_DIST_INT_FILE_TYPE]        [varchar](10) NULL,
	[GEOD_LIB_WEIGHTING]             int           NULL,
	[GEOD_EXCLUDE_US_Y]              [varchar](1)  NULL,
	[VALIDATE_CONFLICTS_Y]           [varchar](1)  NULL,
	[LIVE_CONCERT_SERVICE_Y]         [varchar](1)  NULL,
	[LIVE_GIGS_AND_CLUBS_Y]          [varchar](1)  NULL,
	LoadID                           int           NOT NULL,
	SysStartTime                     datetime      NOT NULL,
	SysEndTime                       datetime      NULL
) ON [PRIMARY]

GO



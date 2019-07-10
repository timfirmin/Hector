CREATE TABLE [FPV].[LicenceGroupHistory] (
    [LicenceGroupCode]      VARCHAR (20)    NOT NULL,
    [DistributionGroupCode] VARCHAR (20)    NULL,
    [LicenceGroupName]      VARCHAR (100)   NULL,
    [SocietySplitPercent]   DECIMAL (18, 3) NULL,
    [RevenueApportionment]  VARCHAR (1)     NULL,
    [IsExcluded]            BIT             NULL,
    [SysStartTime]          DATETIME2 (7)   NOT NULL,
    [SysEndTime]            DATETIME2 (7)   NOT NULL,
    [CodaCustomerCode]      VARCHAR (100)   CONSTRAINT [LGh_CodaCustomerCode] DEFAULT ('unknown') NULL,
    [HedgedRate]            VARCHAR (100)   CONSTRAINT [LGh_HedgedRate] DEFAULT ('unknown') NULL,
	    [NewFiledAdded]            VARCHAR (100)                               CONSTRAINT [LGh_NewFiledAdded] DEFAULT ('unknown') NULL
);


GO
CREATE CLUSTERED INDEX [ix_LicenceGroupHistory]
    ON [FPV].[LicenceGroupHistory]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);


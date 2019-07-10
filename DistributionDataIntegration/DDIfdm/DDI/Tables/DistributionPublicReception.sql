CREATE TABLE [DDI].[DistributionPublicReception] (
    [DistributionPublicReceptionKey] BIGINT          NULL,
    [DistributionGroupCode]          VARCHAR (50)    NULL,
    [DistributionCode]               VARCHAR (50)    NULL,
    [CompanyCode]                    VARCHAR (50)    NULL,
    [StationCode]                    VARCHAR (50)    NULL,
    [StationName]                    VARCHAR (100)   NULL,
    [MasterStationId]                VARCHAR (50)    NULL,
    [TotalPRAllocation]              DECIMAL (18, 3) NULL,
    [Comment]                        VARCHAR (255)   NULL,
    [FileLogKey]                     INT             NULL,
    [InsertTimeStamp]                DATETIME2 (2)   CONSTRAINT [DF_DistributionPublicReception_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]                   INT             NULL,
    [InsertBy]                       VARCHAR (150)   CONSTRAINT [DF_DistributionPublicReception_InsertBy] DEFAULT (suser_sname()) NULL
);










GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DistributionPublicReception]
    ON [DDI].[DistributionPublicReception]([DistributionPublicReceptionKey] ASC) WITH (IGNORE_DUP_KEY = ON);




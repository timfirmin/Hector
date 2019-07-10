CREATE TABLE [DDIstaging].[DistributionPublicReception] (
    [DistributionGroupCode] VARCHAR (150) NULL,
    [DistributionCode]      VARCHAR (150) NULL,
    [CompanyCode]           VARCHAR (150) NULL,
    [StationCode]           VARCHAR (150) NULL,
    [StationName]           VARCHAR (150) NULL,
    [Comment]               VARCHAR (500) NULL,
    [TotalPRAllocation]     VARCHAR (150) NULL,
    [StagingRowValidFlag]   VARCHAR (1)   CONSTRAINT [DF_DistributionPublicReception_StagingRowValidFlag] DEFAULT ('Y') NULL,
    [FileLogKey]            INT           NULL,
    [InsertTimeStamp]       DATETIME2 (2) CONSTRAINT [DF_DistributionPublicReception_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]          INT           NULL,
    [InsertBy]              VARCHAR (150) CONSTRAINT [DF_DistributionPublicReception_InsertBy] DEFAULT (suser_sname()) NULL
);








CREATE TABLE [staging].[DistributionPublicReception] (
    [DistributionGroupCode] VARCHAR (50)    NULL,
    [DistributionCode]      VARCHAR (50)    NULL,
    [Society]               VARCHAR (50)    NULL,
    [StationId]             VARCHAR (50)    NULL,
    [MasterStationId]       VARCHAR (50)    NULL,
    [TotalPRAllocation]     DECIMAL (18, 3) NULL,
    [Comment]               VARCHAR (255)   NULL,
    [InsertTimeStamp]       DATETIME2 (2)   CONSTRAINT [DF_DistributionPublicReception_InsertTimeStamp] DEFAULT (getdate()) NULL,
    [InsertLoadId]          INT             NULL
);






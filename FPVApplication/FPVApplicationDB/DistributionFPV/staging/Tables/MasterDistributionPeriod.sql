CREATE TABLE [staging].[MasterDistributionPeriod] (
    [ID]              INT            NOT NULL,
    [Name]            NVARCHAR (250) NULL,
    [Code]            NVARCHAR (250) NOT NULL,
    [MainMini]        NVARCHAR (100) NULL,
    [StartDate]       NVARCHAR (100) NULL,
    [EndDate]         NVARCHAR (100) NULL,
    [InsertLoadId]    INT            NULL,
    [InsertTimeStamp] DATETIME2 (3)  CONSTRAINT [DF_MasterDistributionPeriod_InsertTimeStamp] DEFAULT (getdate()) NULL
);
GO


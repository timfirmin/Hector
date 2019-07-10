CREATE TABLE [FPV].[MasterUDCHistory] (
    [StationID]          VARCHAR (20)  NOT NULL,
    [UDCCode]            VARCHAR (20)  NOT NULL,
    [UDCDescription]     VARCHAR (100) NOT NULL,
    [UsedForPurposeDesc] VARCHAR (50)  NOT NULL,
    [TimeBand]           VARCHAR (50)  NOT NULL,
    [UpdatedBy]          VARCHAR (100) NOT NULL,
    [UpdateComment]      VARCHAR (255) NULL,
    [SysStartTime]       DATETIME2 (7) NOT NULL,
    [SysEndTime]         DATETIME2 (7) NOT NULL
);


GO


GO

GO



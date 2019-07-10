CREATE TABLE [FPV].[FPVCalculationEvent] (
    [FPVCalculationEventID] INT           IDENTITY (1, 1) NOT NULL,
    [DistributionGroupCode] VARCHAR (20)  NOT NULL,
    [DistributionCode]      VARCHAR (20)  NOT NULL,
    [Society]               VARCHAR (10)  NOT NULL,
    [SysDateTime]           DATETIME2 (7) CONSTRAINT [DF_FPVCalculationEvent_SysTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [Comment]               VARCHAR (255) NULL,
    [UpdatedBy]             VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([FPVCalculationEventID] ASC)
);


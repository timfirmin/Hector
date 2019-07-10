CREATE TABLE [FPV].[CalculationGroupUDCHistory] (
    [DistributionGroupCode] VARCHAR (20)    NOT NULL,
    [DistributionCode]      VARCHAR (20)    NOT NULL,
    [Society]               VARCHAR (20)    NOT NULL,
    [StationID]             VARCHAR (20)    NOT NULL,
    [UDCCode]               VARCHAR (20)    NOT NULL,
    [UDCDescription]        VARCHAR (100)   NOT NULL,
    [UsedForPurposeDesc]    VARCHAR (50)    NOT NULL,
    [TimeBand]              VARCHAR (50)    NOT NULL,
    [PeakSplitPercent]      DECIMAL (12, 5) NULL,
    [UpdatedBy]             VARCHAR (100)   NOT NULL,
    [UpdateComment]         VARCHAR (255)   NULL,
    [SysStartTime]          DATETIME2 (7)   NOT NULL,
    [SysEndTime]            DATETIME2 (7)   NOT NULL
);








GO



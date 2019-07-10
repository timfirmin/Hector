CREATE TABLE [FPV].[FPVCalculationHistory] (
    [FPVCalculationEventID] INT             NOT NULL,
    [StationID]             VARCHAR (20)    NOT NULL,
    [FPVCalculationDefID]   INT             NOT NULL,
    [CalculationValue]      DECIMAL (18, 3) NULL,
    [CalculationStatus]     VARCHAR (20)    NOT NULL,
    [SysCalcTime]           DATETIME2 (7)   NOT NULL,
    [UpdateComments]        VARCHAR (255)   NULL,
    [UpdatedBy]             VARCHAR (100)   NULL,
    [SysStartTime]          DATETIME2 (7)   NOT NULL,
    [SysEndTime]            DATETIME2 (7)   NOT NULL
);






GO
CREATE CLUSTERED INDEX [ix_FPVCalculationHistory]
    ON [FPV].[FPVCalculationHistory]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);


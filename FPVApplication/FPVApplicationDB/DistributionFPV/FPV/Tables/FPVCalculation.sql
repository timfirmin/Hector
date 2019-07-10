CREATE TABLE [FPV].[FPVCalculation] (
    [FPVCalculationEventID] INT                                         NOT NULL,
    [StationID]             VARCHAR (20)                                NOT NULL,
    [FPVCalculationDefID]   INT                                         NOT NULL,
    [CalculationValue]      DECIMAL (18, 3)                             NULL,
    [CalculationStatus]     VARCHAR (20)                                NOT NULL,
    [SysCalcTime]           DATETIME2 (7)                               CONSTRAINT [DF_FPVCalculation_SysCalcTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [UpdateComments]        VARCHAR (255)                               NULL,
    [UpdatedBy]             VARCHAR (100)                               NULL,
    [SysStartTime]          DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_FPVCalculation_SysStartTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]            DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_FPVCalculation_SysEndTime] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    PRIMARY KEY CLUSTERED ([FPVCalculationEventID] ASC, [StationID] ASC, [FPVCalculationDefID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[FPV].[FPVCalculationHistory], DATA_CONSISTENCY_CHECK=ON));






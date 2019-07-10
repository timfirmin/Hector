CREATE TABLE [staging].[DistributionMusicMinutes] (
    [DistributionGroupCode] VARCHAR (50)    NOT NULL,
    [DistributionCode]      VARCHAR (50)    NOT NULL,
    [Society]               VARCHAR (50)    NOT NULL,
    [StationID]             VARCHAR (50)    NOT NULL,
    [MasterStationId]       VARCHAR (50)    NULL,
    [ProgrammeForecast]     DECIMAL (18, 3) NULL,
    [NonProgrammeForecast]  DECIMAL (18, 3) NULL,
    [CommercialForecast]    DECIMAL (18, 3) NULL,
    [TotalInPeriodForecast] DECIMAL (18, 3) NULL,
    [LateDataForecast]      DECIMAL (18, 3) NULL,
    [TotalForecast]         DECIMAL (18, 3) NULL,
    [HighPeakPercent]       DECIMAL (12, 5) NULL,
    [LowPeakPercent]        DECIMAL (12, 5) NULL,
    [NonPeakPercent]        DECIMAL (12, 5) NULL,
    [Comment]               VARCHAR (255)   NULL,
    [InsertLoadId]          INT             NOT NULL,
    [InsertTimeStamp]       DATETIME        CONSTRAINT [DF_DistributionMusicMinutes_InsertTimeStamp] DEFAULT (getdate()) NOT NULL
);










GO
CREATE NONCLUSTERED INDEX [IX_DistributionMusicMinutes]
    ON [staging].[DistributionMusicMinutes]([DistributionGroupCode] ASC, [DistributionCode] ASC, [StationID] ASC, [Society] ASC);


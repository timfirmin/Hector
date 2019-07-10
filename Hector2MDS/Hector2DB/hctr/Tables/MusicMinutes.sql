CREATE TABLE [hctr].[MusicMinutes] (
    [MusicMinutesKey]       INT           NOT NULL,
    [DistributionCode]      VARCHAR (50)  NULL,
    [StationCode]           VARCHAR (50)  NULL,
    [StationName]           VARCHAR (150) NULL,
    [MusicReportingGroup]   VARCHAR (50)  NULL,
    [SampleOrCensus]        VARCHAR (50)  NULL,
    [MusicStation]          VARCHAR (50)  NULL,
    [Category]              VARCHAR (50)  NULL,
    [Threshold]             VARCHAR (50)  NULL,
    [Finalised]             VARCHAR (50)  NULL,
    [ProgrammeForecast]     VARCHAR (50)  NULL,
    [NonProgrammeForecast]  VARCHAR (50)  NULL,
    [CommercialForecast]    VARCHAR (50)  NULL,
    [TotalInPeriodForecast] VARCHAR (50)  NULL,
    [LateDataForecast]      VARCHAR (50)  NULL,
    [TotalForecast]         VARCHAR (50)  NULL,
    [InsertLoadId]          INT           NOT NULL,
    [InsertTimeStamp]       DATETIME      NOT NULL
);


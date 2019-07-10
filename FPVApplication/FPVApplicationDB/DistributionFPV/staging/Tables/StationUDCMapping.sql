CREATE TABLE [staging].[StationUDCMapping] (
    [StationUDCCode]           NVARCHAR (250) NOT NULL,
    [UDCCode]                  NVARCHAR (250) NULL,
    [UDCDescription]           NVARCHAR (250) NULL,
    [MasterStationId]          NVARCHAR (250) NULL,
    [MasterStationDescription] NVARCHAR (250) NULL,
    [UsedForPurpose]           NVARCHAR (100) NULL,
    [TimeBand]                 NVARCHAR (250) NULL,
    [MappingStatusFlag]        NVARCHAR (250) NULL,
    [EnterDateTime]            DATETIME2 (3)  NOT NULL,
    [EnterUserName]            NVARCHAR (100) NULL,
    [EnterVersionNumber]       INT            NULL,
    [LastChgDateTime]          DATETIME2 (3)  NOT NULL,
    [LastChgUserName]          NVARCHAR (100) NULL,
    [LoadId]                   INT            NOT NULL,
    [InsertTimeStamp]          DATETIME       CONSTRAINT [DF_StationUDCMapping_InsertTimeStamp] DEFAULT (getdate()) NULL
);


﻿CREATE TABLE [staging].[LicencePeriodScenarios] (
    [LicencePeriodScenarioCode] NVARCHAR (250) NULL,
    [Society]                   NVARCHAR (100) NULL,
    [DistributionGroup]         NVARCHAR (250) NULL,
    [DistributionCode]          NVARCHAR (250) NULL,
    [LicencePeriod01]           NVARCHAR (250) NULL,
    [LicencePeriod02]           NVARCHAR (250) NULL,
    [LicencePeriod03]           NVARCHAR (250) NULL,
    [LicencePeriod04]           NVARCHAR (250) NULL,
    [LicencePeriod05]           NVARCHAR (250) NULL,
    [LicencePeriod06]           NVARCHAR (250) NULL,
    [LicencePeriod07]           NVARCHAR (250) NULL,
    [LicencePeriod08]           NVARCHAR (250) NULL,
    [LicencePeriod09]           NVARCHAR (250) NULL,
    [LicencePeriod10]           NVARCHAR (250) NULL,
    [LicencePeriod11]           NVARCHAR (250) NULL,
    [LicencePeriod12]           NVARCHAR (250) NULL,
    [EnterDateTime]             DATETIME2 (3)  NOT NULL,
    [EnterUserName]             NVARCHAR (100) NULL,
    [LastChgDateTime]           DATETIME2 (3)  NOT NULL,
    [LastChgUserName]           NVARCHAR (100) NULL,
    [InsertTimeStamp]           DATETIME       CONSTRAINT [DF_LicencePeriodScenarios_InsertTimeStamp] DEFAULT (getdate()) NOT NULL,
    [InsertLoadId]              INT            NOT NULL
);

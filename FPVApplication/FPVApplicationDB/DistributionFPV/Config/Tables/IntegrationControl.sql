CREATE TABLE [Config].[IntegrationControl] (
    [IntegrationId]            INT           NOT NULL,
    [IntegrationName]          VARCHAR (150) NULL,
    [IntegrationDescription]   VARCHAR (200) NULL,
    [ControlPackage]           VARCHAR (200) NULL,
    [UpdateProcedure]          VARCHAR (200) NULL,
    [LastUpdateTimeStamp]      DATETIME2 (7) CONSTRAINT [DF_IntegrationControl_LastUpdateTimeStamp] DEFAULT ('01/01/1900') NULL,
    [LastUpdateInsertRowCount] INT           CONSTRAINT [DF_IntegrationControl_LastUpdateInsertRowCount] DEFAULT ((0)) NULL,
    [LastUpdateLoadId]         INT           NULL,
    [ValidFlag]                VARCHAR (150) CONSTRAINT [DF_IntegrationControl_ValidFlag] DEFAULT ('Y') NULL,
    [AddedBy]                  VARCHAR (150) CONSTRAINT [DF_IntegrationControl_AddedBy] DEFAULT (suser_sname()) NULL,
    [InsertTimeStamp]          DATETIME2 (7) CONSTRAINT [DF_IntegrationControl_InsertTimeStamp] DEFAULT (getdate()) NULL
);






GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_IntegrationControl]
    ON [Config].[IntegrationControl]([IntegrationName] ASC) WITH (IGNORE_DUP_KEY = ON);


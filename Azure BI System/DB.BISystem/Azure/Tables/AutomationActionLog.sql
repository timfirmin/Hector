CREATE TABLE [Azure].[AutomationActionLog] (
    [ActionId]          INT              IDENTITY (1, 1) NOT NULL,
    [ObjectName]        VARCHAR (255)    NOT NULL,
    [ActionName]        VARCHAR (255)    NOT NULL,
    [ActionDescription] VARCHAR (255)    NOT NULL,
    [InsertedDate]      DATETIME         NULL,
    [UpdatedDate]       DATETIME         NULL,
    [Result]            INT              NULL,
    [OperationID]       UNIQUEIDENTIFIER NULL,
    PRIMARY KEY CLUSTERED ([ActionId] ASC)
);


CREATE TABLE [Control].[EntityProcessStream] (
    [EntityProcessStreamId] INT          IDENTITY (1, 1) NOT NULL,
    [EntityId]              INT          NOT NULL,
    [ProcessStream]         VARCHAR (50) NOT NULL,
    [LoadProcess]           VARCHAR (50) NULL,
    [LoadStatusTypeId]      INT          NOT NULL,
    [LoadId]                INT          NOT NULL,
    CONSTRAINT [pkcEntityProcessStreamId] PRIMARY KEY CLUSTERED ([EntityProcessStreamId] ASC)
);


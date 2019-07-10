CREATE TABLE [Config].[Variable] (
    [VariableId] INT           NOT NULL,
    [Name]       VARCHAR (100) NOT NULL,
    [Value]      VARCHAR (50)  NOT NULL,
    [Type]       VARCHAR (20)  NOT NULL,
    PRIMARY KEY CLUSTERED ([VariableId] ASC)
);


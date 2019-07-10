CREATE TABLE [Config].[Parameter] (
    [ParmaterId]         INT           IDENTITY (1, 1) NOT NULL,
    [ParamaterCode]      VARCHAR (10)  NULL,
    [ParamaterShortDesc] VARCHAR (20)  NULL,
    [ParamaterDesc]      VARCHAR (50)  NULL,
    [ParameterType]      VARCHAR (20)  NULL,
    [ParameterValue]     NVARCHAR (50) NULL,
    [ParameterDataType]  VARCHAR (30)  NULL,
    CONSTRAINT [pkcParameter] PRIMARY KEY CLUSTERED ([ParmaterId] ASC)
);


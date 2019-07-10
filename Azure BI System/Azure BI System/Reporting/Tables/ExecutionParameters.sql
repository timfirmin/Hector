CREATE TABLE [Reporting].[ExecutionParameters] (
    [ExecutionParameterID] UNIQUEIDENTIFIER NOT NULL,
    [Name]                 NVARCHAR (2000)  NOT NULL,
    [Value]                NVARCHAR (MAX)   NOT NULL,
    [ExecutionLogID]       UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([ExecutionParameterID] ASC) ON [PRIMARY]
) TEXTIMAGE_ON [PRIMARY];

GO

ALTER TABLE [Reporting].[ExecutionParameters]
    ADD DEFAULT (newid()) FOR [ExecutionParameterID];


GO
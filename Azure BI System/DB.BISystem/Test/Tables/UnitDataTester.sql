CREATE TABLE [Test].[UnitDataTester] (
    [ExecutionParameterId] INT             NOT NULL,
    [Name]                 NVARCHAR (2000) NOT NULL,
    [Value]                NVARCHAR (MAX)  NOT NULL,
    [ExecutionLogId]       INT             NOT NULL,
    [CreatedBy]            VARCHAR (25)    NOT NULL,
    [CreatedDate]          DATETIME        NOT NULL,
    [UpdatedBy]            VARCHAR (25)    NOT NULL,
    [UpdatedDate]          DATETIME        NOT NULL,
    [RowVersion]           VARCHAR (25)    NOT NULL
);


CREATE TABLE [Test].[ValidationTestExecution] (
    [ValidationTestExecutionId] INT           IDENTITY (1, 1) NOT NULL,
    [LoadId]                    INT           NOT NULL,
    [ValidationTestId]          SMALLINT      NOT NULL,
    [TestStatus]                VARCHAR (4)   NOT NULL,
    [SourceResult]              VARCHAR (30)  NOT NULL,
    [TargetResult]              VARCHAR (30)  NOT NULL,
    [ExecutionTime]             DATETIME      NOT NULL,
    [CreatedBy]                 VARCHAR (128) NOT NULL
);


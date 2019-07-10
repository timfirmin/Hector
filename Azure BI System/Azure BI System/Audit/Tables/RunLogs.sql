CREATE TABLE [Audit].[RunLogs] (
    [RunLogId]    INT             IDENTITY (1, 1) NOT NULL,
    [Event]       NVARCHAR (4000) NOT NULL,
    [When]        DATETIME        NOT NULL,
    [RecCount]    INT             NULL,
    [CreatedBy]   [sysname]       DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate] DATETIME        DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]   [sysname]       DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate] DATETIME        DEFAULT (getdate()) NOT NULL,
    [RowVersion]  ROWVERSION      NOT NULL
);


CREATE TABLE [Audit].[ErrorInstanceLog] (
    [ErrorInstanceLogId] INT             IDENTITY (1, 1) NOT NULL,
    [EventInstanceType]  VARCHAR (50)    NOT NULL,
    [ErrorLogId]         INT             NOT NULL,
    [ErrorCode]          VARCHAR (100)   NOT NULL,
    [ErrorString]        NVARCHAR (4000) NOT NULL,
    [StatusId]           TINYINT         NOT NULL,
    [RuleNumber]         INT             NOT NULL,
    [TableInError]       VARCHAR (100)   NOT NULL,
    [FiledInError]       VARCHAR (100)   NOT NULL,
    [ValueInError]       NVARCHAR (100)  NOT NULL,
    [CreatedBy]          [sysname]       DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]        DATETIME        DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]          [sysname]       DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]        DATETIME        DEFAULT (getdate()) NOT NULL,
    [RowVersion]         ROWVERSION      NOT NULL,
    PRIMARY KEY CLUSTERED ([ErrorInstanceLogId] ASC),
    CONSTRAINT [fkErrorInstanceLog_ErrorLog] FOREIGN KEY ([ErrorLogId]) REFERENCES [Audit].[ErrorLog] ([ErrorLogId])
);


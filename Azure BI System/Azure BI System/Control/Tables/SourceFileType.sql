CREATE TABLE [Control].[SourceFileType] (
    [SourceFileTypeId]   INT			IDENTITY(1,1) NOT NULL,
    [Code]               VARCHAR (10)   NOT NULL,
    [Description]        VARCHAR (2000) NOT NULL,
    [Name]               VARCHAR (100)  NOT NULL,
    [Direction]          VARCHAR (4)    NOT NULL,
    [32BitStageRequired] SMALLINT       DEFAULT ((0)) NULL,
    [Collection]         VARCHAR (10)   NULL,
    CONSTRAINT [pkcSourceFileTypeId] PRIMARY KEY CLUSTERED ([SourceFileTypeId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ixuCode]
    ON [Control].[SourceFileType]([Code] ASC);


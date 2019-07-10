CREATE TABLE [Reporting].[SourceTypes] (
    [SourceType] INT           IDENTITY (1, 1) NOT NULL,
    [Name]       NVARCHAR (20) NOT NULL,
    CONSTRAINT [PK__SourceType] PRIMARY KEY CLUSTERED ([SourceType] ASC) ON [PRIMARY]
);
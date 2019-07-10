CREATE TABLE [Control].[PatternMatchType] (
    [PatternMatchTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [Name]               NVARCHAR (20) NOT NULL,
    CONSTRAINT [pkcPatternMatchType] PRIMARY KEY CLUSTERED ([PatternMatchTypeId] ASC)
);


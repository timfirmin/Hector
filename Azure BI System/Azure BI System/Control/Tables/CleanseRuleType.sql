CREATE TABLE [Control].[CleanseRuleType] (
    [CleanseRuleTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (20) NOT NULL,
    CONSTRAINT [pkcCleanseRuleType] PRIMARY KEY CLUSTERED ([CleanseRuleTypeId] ASC)
);


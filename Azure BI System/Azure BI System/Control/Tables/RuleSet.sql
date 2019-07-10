CREATE TABLE [Control].[RuleSet] (
    [RuleSetId] INT           IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (20) NOT NULL,
    [Version]   INT           NOT NULL,
    CONSTRAINT [pkcRuleSet] PRIMARY KEY CLUSTERED ([RuleSetId] ASC)
);


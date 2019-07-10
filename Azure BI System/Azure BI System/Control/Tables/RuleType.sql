CREATE TABLE [Control].[RuleType] (
    [RuleTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [Name]       NVARCHAR (50) NOT NULL,
    CONSTRAINT [pkcRuleTypeId] PRIMARY KEY CLUSTERED ([RuleTypeId] ASC)
);


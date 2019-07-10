CREATE TABLE [Control].[DataQualityRule] (
    [DataQualityRuleId] INT           IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (25) NOT NULL,
    [Logic]             NVARCHAR (50) NOT NULL,
    [RuleTypeId]        INT           NOT NULL,
    CONSTRAINT [pkcDateQualityRule] PRIMARY KEY CLUSTERED ([DataQualityRuleId] ASC),
    CONSTRAINT [fkDataQualityRule_RuleType] FOREIGN KEY ([RuleTypeId]) REFERENCES [Control].[RuleType] ([RuleTypeId])
);


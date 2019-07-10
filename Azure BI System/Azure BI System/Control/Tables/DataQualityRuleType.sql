CREATE TABLE [Control].[DataQualityRuleType] (
    [DataQualityRuleTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [Name]                  NVARCHAR (20) NOT NULL,
    CONSTRAINT [pkcDateQualityRuleType] PRIMARY KEY CLUSTERED ([DataQualityRuleTypeId] ASC)
);


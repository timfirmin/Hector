CREATE TABLE [Control].[RuleSetObject] (
    [RuleSetObjectId] INT IDENTITY (1, 1) NOT NULL,
    [RuleSetId]       INT NOT NULL,
    [ObjectId]        INT NOT NULL,
    CONSTRAINT [pkcRuleSetObject] PRIMARY KEY CLUSTERED ([RuleSetObjectId] ASC),
    CONSTRAINT [fkRuleSetObject_RuleSet] FOREIGN KEY ([RuleSetId]) REFERENCES [Control].[RuleSet] ([RuleSetId])
);


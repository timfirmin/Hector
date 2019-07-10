CREATE TABLE [Control].[CleanseRule] (
    [CleanseRuleId]      INT            IDENTITY (1, 1) NOT NULL,
    [DataQualityRuleId]  INT            NOT NULL,
    [Name]               NVARCHAR (20)  NOT NULL,
    [ObjectId]           INT            NOT NULL,
    [PatternMatchTypeId] INT            NOT NULL,
    [CleanseTypeId]      INT            NOT NULL,
    [Criteria]           NVARCHAR (255) NULL,
    [CleanseTypeValue]   NVARCHAR (255) NULL,
    CONSTRAINT [pkcCleanseRule] PRIMARY KEY CLUSTERED ([CleanseRuleId] ASC)
);


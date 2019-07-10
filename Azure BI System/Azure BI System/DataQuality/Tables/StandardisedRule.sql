CREATE TABLE [DataQuality].[StandardiseRule] (
    [StandardiseRuleId]    INT           NOT NULL,
    [DataQualityRuleId]    VARCHAR (100) NOT NULL,
    [ColumnName]           VARCHAR (50)  NOT NULL,
    [PatternMatchType]     VARCHAR (20)  NOT NULL,
    [Criteria]             VARCHAR (50)  NOT NULL,
    [StandardiseType]      VARCHAR (20)  NOT NULL,
    [StandardiseTypeValue] VARCHAR (20)  NOT NULL,
    [EntityTypeID]         VARCHAR (20)  NOT NULL,
    PRIMARY KEY CLUSTERED ([StandardiseRuleId] ASC)
);
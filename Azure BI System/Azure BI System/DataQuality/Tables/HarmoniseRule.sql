CREATE TABLE [DataQuality].[HarmoniseRule] (
    [HarmoniseRuleId] INT          NOT NULL,
    [ColumnName]      VARCHAR (50) NOT NULL,
    [CleanseType]     VARCHAR (20) NOT NULL,
    [EntityTypeID]    VARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([HarmoniseRuleId] ASC)
);

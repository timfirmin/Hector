CREATE TABLE [Config].[MDSBusinessRules] (
    [RuleId]               INT           IDENTITY (1, 1) NOT NULL,
    [EnitytName]           VARCHAR (150) NULL,
    [AttributeName]        VARCHAR (150) NULL,
    [RuleDescription]      VARCHAR (200) NOT NULL,
    [RuleUdf]              VARCHAR (300) NULL,
    [DataType]             VARCHAR (150) NULL,
    [IsNullable]           VARCHAR (150) NULL,
    [LookupEnitity]        VARCHAR (150) NULL,
    [DefaultValue]         VARCHAR (150) NULL,
    [PermittedValues]      VARCHAR (150) NULL,
    [NotificationTemplate] VARCHAR (300) NULL,
    [RuleType]             VARCHAR (50)  NULL,
    [RuleActiveYN]         VARCHAR (50)  CONSTRAINT [DF_MDSBusinessRules_RuleActiveYN] DEFAULT ('Y') NULL
);
GO


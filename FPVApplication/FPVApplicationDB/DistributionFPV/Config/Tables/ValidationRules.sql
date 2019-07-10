CREATE TABLE [Config].[ValidationRules] (
    [RuleId]               INT           IDENTITY (1, 1) NOT NULL,
    [AbacusTableName]      VARCHAR (150) NULL,
    [AttributeCheckName]   VARCHAR (150) NULL,
    [RuleDescription]      VARCHAR (200) NULL,
    [RuleUdf]              VARCHAR (300) NULL,
    [NotificationTemplate] VARCHAR (300) NULL,
    [ValidationType]       VARCHAR (50)  NULL,
    [AddedBy]              VARCHAR (150) CONSTRAINT [DF_AbacusBusinessRules_AddedBy] DEFAULT (suser_sname()) NULL,
    [InsertTimeStamp]      DATETIME2 (7) CONSTRAINT [DF_AbacusBusinessRules_InsertTimeStamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AbacusBusinessRules] PRIMARY KEY CLUSTERED ([RuleId] ASC)
);




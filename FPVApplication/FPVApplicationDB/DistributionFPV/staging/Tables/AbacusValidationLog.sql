CREATE TABLE [staging].[AbacusValidationLog] (
    [ID]                 INT            IDENTITY (1, 1) NOT NULL,
    [LoadId]             INT            NULL,
    [RuleId]             INT            NULL,
    [ValidationData]     NVARCHAR (MAX) NULL,
    [ValidationRowCount] INT            NULL,
    [AddedBy]            VARCHAR (150)  CONSTRAINT [DF_AbacusValidationLog_AddedBy] DEFAULT (suser_sname()) NULL,
    [InsertTimeStamp]    DATETIME2 (7)  CONSTRAINT [DF_AbacusValidationLog_InsertTimeStamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AbacusValidationLog] PRIMARY KEY CLUSTERED ([ID] ASC)
);


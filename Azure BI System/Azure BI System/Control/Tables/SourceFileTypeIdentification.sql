CREATE TABLE [Control].[SourceFileTypeIdentification] (
    [SourceFileTypeIdentificationId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [SourceFileTypeId]               INT           NOT NULL,
    [StringMatch]                    VARCHAR (500) NOT NULL,
    [Operator]                       VARCHAR (50)  NOT NULL,
    [RuleOrder]                      INT           NULL,
    [BitwiseOperator]                VARCHAR (10)  NULL,
    [RowVersion]                     ROWVERSION    NOT NULL,
    CONSTRAINT [pkcSourceFileTypeIdentificationId] PRIMARY KEY CLUSTERED ([SourceFileTypeIdentificationId] ASC)
);


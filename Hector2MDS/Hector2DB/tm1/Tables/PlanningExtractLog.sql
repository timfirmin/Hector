CREATE TABLE [tm1].[PlanningExtractLog] (
    [PlanningExtractReferenceKey] INT           IDENTITY (1, 1) NOT NULL,
    [ExtractFileName]             VARCHAR (150) NULL,
    [ExtractFileLocation]         VARCHAR (150) NULL,
    [ExtractRowCount]             INT           NULL,
    [ImportSuccessYN]             VARCHAR (50)  NULL,
    [ImportTimeStamp]             DATETIME      CONSTRAINT [DF_PlanningExtractReference_ImportTimeStamp] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PlanningExtractReference] PRIMARY KEY CLUSTERED ([PlanningExtractReferenceKey] ASC)
);


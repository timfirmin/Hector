CREATE TABLE [TabularControl].[ProcessLevel] (
    [ProcessLevelId]	TINYINT			IDENTITY (1, 1) NOT NULL,
    [Name]				VARCHAR (128)	NOT NULL,
    CONSTRAINT [pkTabularControlProcessLevel] PRIMARY KEY CLUSTERED ([ProcessLevelId] ASC)
);


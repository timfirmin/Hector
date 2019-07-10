CREATE TABLE [TabularControl].[ProcessStatus] (
    [ProcessStatusId]	TINYINT			IDENTITY (1, 1) NOT NULL,
    [Name]				VARCHAR (128)	NOT NULL,
    CONSTRAINT [pkTabularControlStatus] PRIMARY KEY CLUSTERED ([ProcessStatusId] ASC)
);


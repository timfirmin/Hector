CREATE TABLE [Reporting].[RequestTypes] (
    [RequestType] INT           IDENTITY (100, 1) NOT NULL,
    [Name]        NVARCHAR (20) NOT NULL,
    CONSTRAINT [PK__RequestTypes] PRIMARY KEY CLUSTERED ([RequestType] ASC) ON [PRIMARY]
);
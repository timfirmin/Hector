CREATE TABLE [Control].[EventActionType] (
    [EventActionTypeId] INT            IDENTITY (1, 1) NOT NULL,
    [Name]              VARCHAR (100)  NULL,
    [Description]       VARCHAR (1000) NULL,
    [CreatedBy]         [sysname]      DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]       DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]         [sysname]      DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]       DATETIME       DEFAULT (getdate()) NOT NULL,
    [RowVersion]        ROWVERSION     NOT NULL,
    CONSTRAINT [pkcEventActionTypeId] PRIMARY KEY CLUSTERED ([EventActionTypeId] ASC)
);


CREATE TABLE [Control].[Application] (
    [ApplicationId]       SMALLINT      IDENTITY (1, 1) NOT NULL,
    [Name]               VARCHAR (250)  NOT NULL,
    [Code]               VARCHAR (80)   NOT NULL,
    [Description]        VARCHAR (4000) NULL,
    [Priority]           VARCHAR (80)   NULL,
    [UpTimeHours]        INT		    NULL,
	[ETLType]            VARCHAR (80)   NULL,
	[WarehouseType]      VARCHAR (80)   NULL,
	[Prefix]			 VARCHAR (80)	NOT NULL,
    [CreatedBy]          [sysname]      DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]        DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]          [sysname]      DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]        DATETIME       DEFAULT (getdate()) NOT NULL,   
    CONSTRAINT [pkcApplication] PRIMARY KEY CLUSTERED ([ApplicationId] ASC)
);




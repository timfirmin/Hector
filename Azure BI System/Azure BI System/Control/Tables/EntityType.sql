CREATE TABLE [Control].[EntityType] (
    [EntityTypeId]       SMALLINT       IDENTITY (1, 1) NOT NULL,
    [ParentEntityTypeId] SMALLINT       NULL,
	[ApplicationId]		 SMALLINT		NOT NULL,
	[IsSourceEntity]	 BIT			NOT NULL,
	[HasMultipleSourceFile] BIT			NOT NULL,
    [Name]               VARCHAR (50)   NOT NULL,
    [Code]               VARCHAR (80)   NOT NULL,
    [Description]        VARCHAR (4000) NULL,
    [Schema]             VARCHAR (80)   NULL,
    [Table]              VARCHAR (80)   NOT NULL, --changed to NOT NULL, after UK has been created
    [CreatedBy]          [sysname]      DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]        DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]          [sysname]      DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]        DATETIME       DEFAULT (getdate()) NOT NULL,
    [RowVersion]         ROWVERSION     NOT NULL 
	CONSTRAINT [pkcEntityType] PRIMARY KEY CLUSTERED ([EntityTypeId] ASC),
	CONSTRAINT uc_NameApplicationId UNIQUE (Name, ApplicationId, [IsSourceEntity]),
	CONSTRAINT uc_CodeApplicationId UNIQUE (Code, ApplicationId, [IsSourceEntity]),
	CONSTRAINT uc_TableNameApplicationId UNIQUE ([Table], ApplicationId, [Schema])
);




CREATE TABLE [Control].[FileExtensionType] (
    [FileExtensionTypeId] SMALLINT       IDENTITY (1, 1) NOT NULL,
    [FileTypeGroupId]     INT            NOT NULL,
    [FileExtension]       NVARCHAR (255) NULL,
    [Description]         VARCHAR (100)  NOT NULL,
    [IsCompressed]        BIT            NOT NULL,
    [CreatedBy]           [sysname]      DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]         DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]           [sysname]      DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]         DATETIME       DEFAULT (getdate()) NOT NULL,
    [RowVersion]          ROWVERSION     NOT NULL,
    CONSTRAINT [pkcFileExtensionType] PRIMARY KEY CLUSTERED ([FileExtensionTypeId] ASC),
    CONSTRAINT [fkFileExtensionType_FileTypeGroup] FOREIGN KEY ([FileTypeGroupId]) REFERENCES [Control].[FileTypeGroup] ([FileTypeGroupId])
);


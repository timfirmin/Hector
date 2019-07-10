CREATE TABLE [DataQuality].[DataIntegrityType] (
    [IntegrityTypeId] INT            IDENTITY (1, 1) NOT NULL,
    [Code]            CHAR (1)       NULL,
    [Name]            VARCHAR (100)  NULL,
    [Description]     VARCHAR (2000) NULL,
    PRIMARY KEY CLUSTERED ([IntegrityTypeId] ASC)
);


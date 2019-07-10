CREATE TABLE [Test].[ValidationType] (
    [ValidationTypeId]   TINYINT        NOT NULL,
    [ValidationTypeName] VARCHAR (200)  NOT NULL,
    [CreatedBy]          NVARCHAR (128) DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]        DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]          NVARCHAR (128) DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]        DATETIME       DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([ValidationTypeId] ASC)
);


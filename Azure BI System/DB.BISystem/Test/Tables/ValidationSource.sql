CREATE TABLE [Test].[ValidationSource] (
    [ValidationSourceId]   TINYINT        NOT NULL,
    [ValidationSourceName] VARCHAR (50)   NOT NULL,
    [CreatedBy]            NVARCHAR (128) DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]          DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]            NVARCHAR (128) DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]          DATETIME       DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([ValidationSourceId] ASC)
);


CREATE TABLE [Test].[ValidationTest] (
    [ValidationTestId]    SMALLINT       NOT NULL,
    [ValidationTypeId]    TINYINT        NOT NULL,
    [ValidationSourceId]  TINYINT        NOT NULL,
    [SourceObject]        VARCHAR (4000) NOT NULL,
    [TargetObject]        VARCHAR (4000) NOT NULL,
    [PackageName]         VARCHAR (200)  NOT NULL,
    [WarningPercent]      DECIMAL (5, 2) NOT NULL,
    [HaltPercent]         DECIMAL (5, 2) NOT NULL,
    [EnableWarning]       BIT            NOT NULL,
    [EnableHalt]          BIT            NOT NULL,
    [ValidationTestName]  VARCHAR (200)  NULL,
    [ValidationTestNotes] VARCHAR (500)  NULL,
    [CreatedBy]           NVARCHAR (128) DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]         DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]           NVARCHAR (128) DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]         DATETIME       DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([ValidationTestId] ASC)
);


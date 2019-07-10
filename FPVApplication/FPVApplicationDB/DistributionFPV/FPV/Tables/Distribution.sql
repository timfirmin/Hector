CREATE TABLE [FPV].[Distribution] (
    [DistributionCode]           NVARCHAR (250) NOT NULL,
    [DistributionDescription]    NVARCHAR (250) NULL,
    [DistributionType]           NVARCHAR (100) NULL,
    [DistributionYear]           NVARCHAR (4)   NULL,
    [DistributionStartDate]      DATETIME       NULL,
    [DistributionEndDate]        DATETIME       NULL,
    [DistributionLatestScenario] VARCHAR (50)   NULL,
    [InsertLoadId]               INT            NULL,
    [InsertTimeStamp]            DATETIME2 (7)  NULL
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [PK_Distribution]
    ON [FPV].[Distribution]([DistributionCode] ASC);


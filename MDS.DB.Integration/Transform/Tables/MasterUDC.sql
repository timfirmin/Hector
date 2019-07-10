CREATE TABLE [Transform].[MasterUDC] (
    [MasterUDCKey]         DECIMAL (12) NOT NULL,
    [MasterUDCCode]        VARCHAR (5)  NOT NULL,
    [MasterUDCDescription] VARCHAR (60) NOT NULL,
    [InactiveDate]         DATETIME     NULL,
    [SysStartTime]         DATETIME     NULL,
    [SysEndTime]           DATETIME     NULL,
    [LoadId]               INT          NOT NULL
);


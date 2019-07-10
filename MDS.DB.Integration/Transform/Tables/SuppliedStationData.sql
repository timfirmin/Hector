CREATE TABLE [Transform].[SuppliedStationData] (
    [SuppliedStationKey]     BIGINT        IDENTITY (1, 1) NOT NULL,
	[SuppliedStationName]    VARCHAR (250) NULL,
    [SuppliedStationCode]    VARCHAR (250) NULL,
    [SuppliedStationSource]  VARCHAR (25)  NULL,
    [SuppliedStationMDsCode] VARCHAR (25)  NULL,
    [NewRecordFlag]          VARCHAR (1)   NULL,
    [LoadId]                 INT           NULL,
    [SysStartTime]           DATETIME      NULL,
    [SysEndTime]             DATETIME      NULL
);


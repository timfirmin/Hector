CREATE TABLE [TM1Control].[RunMode] (
    [RunModeKey]      INT      IDENTITY (10000, 1) NOT NULL,
    [RunModeValue]    INT      CONSTRAINT [DF_CurrentRunMode_RunModeValue] DEFAULT ((0)) NOT NULL,
    [RunModeType]     AS       (case [RunModeValue] when (0) then 'Blob Load' when (1) then 'Direct File Load' else 'Unknown' end),
    [UpdateTimeStamp] DATETIME CONSTRAINT [DF_RunMode_UpdateTimeStamp] DEFAULT (getdate()) NULL
);


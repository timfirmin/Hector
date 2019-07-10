CREATE TABLE [Transform].[Broadcaster] (
    [BroadcasterKey]            BIGINT        NOT NULL,
    [BroadcasterCode]           VARCHAR (10)  NULL,
    [BroadcasterName]           VARCHAR (60)  NULL,
    [RightTypeCode]             VARCHAR (60)  NULL,
    [AudioPolicyMain]           VARCHAR (60)  NULL,
    [AudioPolicyCommercial]     VARCHAR (60)  NULL,
    [MainSampleDays]            INT           NULL,
    [CommercialSampleDays]      INT           NULL,
    [LicencedStatus]            VARCHAR (60)  NULL,
    [CustomerAccountNo]         VARCHAR (20)  NULL,
    [NewRecordFlag]             VARCHAR (1)   NULL,
    [MDS_BroadcasterName]       VARCHAR (100) NULL,
    [MDS_RightTypeCode]         VARCHAR (60)  NULL,
    [MDS_AudioPolicyMain]       VARCHAR (60)  NULL,
    [MDS_AudioPolicyCommercial] VARCHAR (60)  NULL,
    [MDS_MainSampleDays]        INT           NULL,
    [MDS_CommercialSampleDays]  INT           NULL,
    [MDS_LicencedStatus]        VARCHAR (60)  NULL,
    [MDS_CustomerAccountNo]     VARCHAR (20)  NULL,
    [LoadId]                    INT           NULL,
    [SysStartTime]              DATETIME      NULL,
    [SysEndTime]                DATETIME      NULL,
    [UpdateTimeStamp]           DATETIME      NULL
);


















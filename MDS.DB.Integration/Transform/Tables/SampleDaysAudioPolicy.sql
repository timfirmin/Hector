CREATE TABLE [Transform].[SampleDaysAudioPolicy] (
    [StationId]                NVARCHAR (250)  NOT NULL,
    [DistributionCode]         NVARCHAR (250)  NULL,
    [DistributionGroup]        NVARCHAR (250)  NULL,
    [BroadcasterName]          NVARCHAR (250)  NOT NULL,
    [MainSampleDays]           DECIMAL (38, 2) NULL,
    [MDSMainSampleDays]        DECIMAL (38, 2) NULL,
    [CommercialSampleDays]     DECIMAL (38, 2) NULL,
    [MDSCommercialSampleDays]  DECIMAL (38, 2) NULL,
    [AudioPolicyMain]          VARCHAR (20)    NOT NULL,
    [MDSAudioPolicyMain]       VARCHAR (20)    NULL,
    [AudioPolicyCommercial]    VARCHAR (20)    NOT NULL,
    [MDSAudioPolicyCommercial] VARCHAR (20)    NULL,
    [TotalSampleDays]          DECIMAL (38, 2) NULL,
    [DeltaFlag]                VARCHAR (1)     NULL,
    [LoadId]                   INT             NOT NULL,
    [SysStartTime]             DATETIME        NOT NULL,
    [SysEndTime]               DATETIME        NULL
);


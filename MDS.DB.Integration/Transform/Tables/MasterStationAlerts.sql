CREATE TABLE [Transform].[MasterStationAlerts] (
    [ParentLoadId]              BIGINT        NULL,
    [SourceSystem]              VARCHAR (60)  NULL,
    [action]                    VARCHAR (60)  NULL,
    [BroadcasterKey]            BIGINT        NOT NULL,
    [BroadcasterCode]           VARCHAR (10)  NULL,
    [BroadcasterName]           VARCHAR (100) NULL,
    [RightTypeCode]             VARCHAR (60)  NULL,
    [LicencedStatus]            VARCHAR (60)  NULL,
    [AudioPolicyMain]           VARCHAR (60)  NULL,
    [AudioPolicyCommercial]     VARCHAR (60)  NULL,
    [MainSampleDays]            INT           NULL,
    [CommercialSampleDays]      INT           NULL,
    [CustomerAccountNo]         VARCHAR (20)  NULL,
    [MDS_BroadcasterName]       VARCHAR (100) NULL,
    [MDS_RightTypeCode]         VARCHAR (60)  NULL,
    [MDS_AudioPolicyMain]       VARCHAR (60)  NULL,
    [MDS_AudioPolicyCommercial] VARCHAR (60)  NULL,
    [MDS_MainSampleDays]        INT           NULL,
    [MDS_CommercialSampleDays]  INT           NULL,
    [MDS_CustomerAccountNo]     VARCHAR (20)  NULL,
    [MDS_LicencedStatus]        VARCHAR (60)  NULL,
    [SysStartTime]              DATETIME      NULL,
    [SysEndTime]                DATETIME      NULL,
    [LoadId]                    INT           NULL,
    [MDSValidationIssue]        VARCHAR (1)   NULL,
    [MDSValidationErrorMessage] VARCHAR (200) NULL,
    [MDSRowInsert]              VARCHAR (1)   NULL,
    [MDSRowUpdate]              VARCHAR (1)   NULL,
    [MDSEnterDateTime]          DATETIME      NULL,
    [MDSLastChgDateTime]        DATETIME      NULL
);








GO


CREATE TABLE [Staging].[BroadcastSampleDays] (
    [BroadcastDomain]    NVARCHAR (250)  NOT NULL,
    [ThirdPartyPathName] NVARCHAR (1500) NOT NULL,
    [StationId]          NVARCHAR (250)  NOT NULL,
    [BroadcasterName]    NVARCHAR (250)  NOT NULL,
    [UsedForPurpose]     NVARCHAR (20)   NOT NULL,
    [DateMonthKey]       INT             NOT NULL,
    [SampleDays]         DECIMAL (38, 2) NULL,
    [InsertLoadId]       INT             NULL,
    [InsertTimeStamp]    DATETIME        NOT NULL
);


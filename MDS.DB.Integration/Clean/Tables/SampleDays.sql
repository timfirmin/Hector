CREATE TABLE [Clean].[SampleDays] (
    [StationId]       NVARCHAR (250)  NOT NULL,
    [BroadcasterName] NVARCHAR (250)  NOT NULL,
    [UsedForPurpose]  NVARCHAR (20)   NOT NULL,
    [DateMonthKey]    INT             NOT NULL,
    [SampleDays]      DECIMAL (38, 2) NULL,
    [LoadID]          INT             NOT NULL,
    [SysStartTime]    DATETIME        NOT NULL,
    [SysEndTime]      DATETIME        NULL,
    [RejectRow_YN]    VARCHAR (1)     NOT NULL
);


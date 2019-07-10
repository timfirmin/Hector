CREATE TABLE [Clean].[Peak_Bands] (
    [SURR_ID]      DECIMAL (12) NOT NULL,
    [NAME]         VARCHAR (60) NULL,
    [RejectRow_YN] VARCHAR (1)  NULL,
    [LoadID]       INT          NOT NULL,
    [SysStartTime] DATETIME     NOT NULL,
    [SysEndTime]   DATETIME     NULL
);


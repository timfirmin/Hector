CREATE TABLE [Transform].[BroadcasterUDCMapping] (
    [BroadcasterUDCKey]             BIGINT          NULL,
    [BroadcasterUDCCode]            VARCHAR (12)    NOT NULL,
    [BroadcasterDomain]             VARCHAR (100)   NOT NULL,
    [BroadcasterThirdPartyID]       DECIMAL (12)    NOT NULL,
    [StationID]                     VARCHAR (6)     NOT NULL,
    [StationName]                   VARCHAR (60)    NOT NULL,
    [UDCUsedForPurposeCode]         VARCHAR (1)     NULL,
    [UDCUsedForPurposeDescription]  VARCHAR (240)   NOT NULL,
    [UDCTimeBand]                   VARCHAR (60)    NOT NULL,
    [UDCKey]                        DECIMAL (12)    NOT NULL,
    [UDCCode]                       VARCHAR (5)     NOT NULL,
    [UDCDescription]                VARCHAR (60)    NOT NULL,
    [BroadcasterUDCStartDate]       DATETIME        NOT NULL,
    [PerformanceStartDate]          DATETIME        NULL,
    [PerformanceEndDate]            DATETIME        NULL,
    [LatestUDGID]                   DECIMAL (12)    NULL,
    [LatestUDGDistributionDate]     DATETIME2 (7)   NULL,
    [LatestUDGPerformanceStartDate] DATETIME2 (7)   NULL,
    [LatestUDGPerformanceEndDate]   DATETIME2 (7)   NULL,
    [PRSPerformanceFPVInPounds]     DECIMAL (16, 6) NULL,
    [PRSMechanicalFPVInPounds]      DECIMAL (16, 6) NULL,
    [LoadId]                        INT             NOT NULL,
    [SysStartTime]                  DATETIME        NOT NULL,
    [SysEndTime]                    DATETIME        NULL
);






﻿CREATE TABLE [Clean].[Usage_Distribution_Groups] (
    [SURR_ID]                      DECIMAL (12)    NOT NULL,
    [SUBMITTED_DATE]               DATETIME2 (7)   NULL,
    [NOTIONAL_VALUE_PER_POINT]     DECIMAL (16, 6) NULL,
    [TARGET_DISTRIBUTION_DATE]     DATETIME2 (7)   NULL,
    [DC_SURR_ID]                   DECIMAL (12)    NULL,
    [SUBMISSION_REQUESTED_DATE]    DATETIME2 (7)   NULL,
    [PERFORMANCE_END_DATE]         DATETIME2 (7)   NULL,
    [ACTUAL_VALUE_PER_POINT]       DECIMAL (16, 6) NULL,
    [ACTUAL_VALUE_ADDED_DATE]      DATETIME2 (7)   NULL,
    [PERFORMANCE_START_DATE]       DATETIME2 (7)   NULL,
    [DEADLINE_USAGE_RECEIPT_DATE]  DATETIME2 (7)   NULL,
    [PARTIALLY_SUBMITTED_FLAG]     VARCHAR (1)     NULL,
    [CASE_ACCESS_THRESHOLD]        DECIMAL (14, 4) NULL,
    [MECHANICAL_PM_ACTUAL_VALUE]   DECIMAL (16, 6) NULL,
    [MECHANICAL_PM_NOTIONAL_VALUE] DECIMAL (16, 6) NULL,
    [LAST_UPDATED_DATE]            DATETIME2 (7)   NULL,
    [RejectRow_YN]                 VARCHAR (1)     NULL,
    [LoadID]                       INT             NOT NULL,
    [SysStartTime]                 DATETIME        NOT NULL,
    [SysEndTime]                   DATETIME        NULL
);


CREATE TABLE [Staging].[BATCH_CONTROL] (
    [BATCH_ID]               DECIMAL (12) NOT NULL,
    [BATCH_PARAM_START_DATE] DATETIME     NOT NULL,
    [BATCH_PARAM_END_DATE]   DATETIME     NOT NULL,
    [BATCH_RUN_START_DATE]   DATETIME     NOT NULL,
    [BATCH_RUN_END_DATE]     DATETIME     NULL,
    [Batch_Status]           VARCHAR (50) NOT NULL,
    [Cube_Status]            VARCHAR (50) NOT NULL,
    [Extracted_p2p_y]        VARCHAR (1)  NULL,
    [LoadID]                 INT          NOT NULL,
    [SysStartTime]           DATETIME     NOT NULL,
    [SysEndTime]             DATETIME     NULL
);


CREATE TABLE [Clean].[Third_Parties] (
    [SURR_ID]                 DECIMAL (12) NOT NULL,
    [GC_SUPPLIER_GROUP_TABLE] VARCHAR (60) NULL,
    [GC_SUPPLIER_GROUP_CODE]  VARCHAR (60) NULL,
    [NAME]                    VARCHAR (60) NULL,
    [TP_SURR_ID]              INT          NULL,
    [FINANCE_CODE]            VARCHAR (60) NULL,
    [DN_ROOT_TP_SURR_ID]      INT          NULL,
    [RejectRow_YN]            VARCHAR (1)  NULL,
    [LoadID]                  INT          NOT NULL,
    [SysStartTime]            DATETIME     NOT NULL,
    [SysEndTime]              DATETIME     NULL
);


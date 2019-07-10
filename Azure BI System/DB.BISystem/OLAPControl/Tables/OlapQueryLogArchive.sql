CREATE TABLE [OLAPControl].[OlapQueryLogArchive] (
    [MSOLAP_Database]   NVARCHAR (255)  COLLATE Latin1_General_CI_AS_KS_WS NULL,
    [MSOLAP_ObjectPath] NVARCHAR (4000) COLLATE Latin1_General_CI_AS_KS_WS NULL,
    [MSOLAP_User]       NVARCHAR (255)  COLLATE Latin1_General_CI_AS_KS_WS NULL,
    [Dataset]           NVARCHAR (4000) COLLATE Latin1_General_CI_AS_KS_WS NULL,
    [StartTime]         DATETIME        NULL,
    [Duration]          BIGINT          NULL
);


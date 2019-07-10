CREATE TABLE [SSIS].[projects] (
    [project_id]             BIGINT             IDENTITY (1, 1) NOT NULL,
    [folder_id]              BIGINT             NOT NULL,
    [name]                   [sysname]          NOT NULL,
    [description]            NVARCHAR (1024)    NULL,
    [project_format_version] INT                NULL,
    [deployed_by_sid]        VARBINARY (85)     NOT NULL,
    [deployed_by_name]       NVARCHAR (128)     NOT NULL,
    [last_deployed_time]     DATETIMEOFFSET (7) NOT NULL,
    [created_time]           DATETIMEOFFSET (7) NOT NULL,
    [object_version_lsn]     BIGINT             NOT NULL,
    [validation_status]      CHAR (1)           NOT NULL,
    [last_validation_time]   DATETIMEOFFSET (7) NULL
);


CREATE TABLE [SSIS].[environments] (
    [environment_id]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [environment_name] [sysname]       NOT NULL,
    [folder_id]        BIGINT          NOT NULL,
    [description]      NVARCHAR (1024) NULL
);


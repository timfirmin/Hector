CREATE TABLE [SSIS].[packages] (
    [package_id]   BIGINT           NULL,
    [project_id]   BIGINT           NOT NULL,
    [name]         NVARCHAR (260)   NOT NULL,
    [package_guid] UNIQUEIDENTIFIER NOT NULL,
    [description]  NVARCHAR (1024)  NULL
);


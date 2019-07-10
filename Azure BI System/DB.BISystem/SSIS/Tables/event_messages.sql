CREATE TABLE [SSIS].[event_messages] (
    [event_message_id]    BIGINT             NOT NULL,
    [operation_id]        BIGINT             NOT NULL,
    [message_time]        DATETIMEOFFSET (7) NOT NULL,
    [message_type]        SMALLINT           NOT NULL,
    [message_source_type] SMALLINT           NULL,
    [message]             NVARCHAR (MAX)     NULL,
    [extended_info_id]    BIGINT             NULL,
    [package_name]        NVARCHAR (260)     NULL,
    [event_name]          NVARCHAR (1024)    NULL,
    [message_source_name] NVARCHAR (4000)    NULL,
    [message_source_id]   NVARCHAR (38)      NULL,
    [subcomponent_name]   NVARCHAR (4000)    NULL,
    [package_path]        NVARCHAR (MAX)     NULL,
    [execution_path]      NVARCHAR (MAX)     NULL,
    [threadID]            INT                NULL,
    [message_code]        INT                NULL
);


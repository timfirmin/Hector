CREATE TABLE [SSIS].[execution_parameter_values] (
    [execution_parameter_id] BIGINT         IDENTITY (1, 1) NOT NULL,
    [execution_id]           BIGINT         NOT NULL,
    [object_type]            SMALLINT       NOT NULL,
    [parameter_data_type]    NVARCHAR (128) NOT NULL,
    [parameter_name]         [sysname]      NOT NULL,
    [parameter_value]        NVARCHAR (MAX) NULL,
    [sensitive]              BIT            NOT NULL,
    [required]               BIT            NOT NULL,
    [value_set]              BIT            NOT NULL,
    [runtime_override]       BIT            NOT NULL
);


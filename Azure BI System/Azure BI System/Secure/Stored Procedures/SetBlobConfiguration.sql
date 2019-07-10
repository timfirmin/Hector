CREATE PROCEDURE [Secure].[SetBlobConfiguration]
    @pName            VARCHAR (100),
    @pDescription     VARCHAR (250),
    @pValue           VARCHAR (250)
AS
BEGIN
/*
 *	Inserts configuration for accessing BLOB storage
 */
	INSERT INTO [Secure].[Configurations]
		([Name], [Description], [Value], [CreatedAt])
	VALUES
	    (@pName, @pDescription, @pValue, SYSDATETIME());
END
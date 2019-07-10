/****** Check if [Secure].[Configurations] exist for azpmsblbu001 blob storage ******/
DECLARE @ConfigurationEntriesCount int = 0;
SELECT @ConfigurationEntriesCount = Count(*) FROM [Secure].[Configurations];

IF (@ConfigurationEntriesCount = 0)
BEGIN
  PRINT 'Deleting old key'
  DELETE FROM [Secure].[Configurations] 
  WHERE [Name] = 'ProdBlobKey' --to be replaced by the existing name from the secureConfigurations
   
  PRINT 'Inserting Secure.Configuration entry';
  EXEC [Secure].[SetBlobConfiguration]
    @pName = 'ProdBlobKey', --to be replaced by the existing name from the secureConfigurations
    @pDescription = 'ProdBlobKey', --to be replaced by the existing name from the secureConfigurations
    @pValue = ''; --BlobKey to replace with the production blob key
END;
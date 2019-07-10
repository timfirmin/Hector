/****** Check if [Secure].[Configurations] exist for azpmsblbu001 blob storage ******/
DECLARE @ConfigurationEntriesCount int = 0;
SELECT @ConfigurationEntriesCount = Count(*) FROM [Secure].[Configurations];

IF (@ConfigurationEntriesCount = 0)
BEGIN
  PRINT 'Deleting old key'
  DELETE FROM [Secure].[Configurations] 
  WHERE [Name] = 'UATBlobKey'
   
  PRINT 'Inserting Secure.Configuration entry';
  EXEC [Secure].[SetBlobConfiguration]
    @pName = 'UATBlobKey',
    @pDescription = 'UATBlobKey',
    @pValue = 'vYSkZRSx4UuhZxYIcU4Zus4Ev3ie65EKshqyUBgmqe+av9DdHiRHPA3SaIuOhEMsUJzemUiZYjy75umi/gxBdg=='; --BlobKey to replace
END;
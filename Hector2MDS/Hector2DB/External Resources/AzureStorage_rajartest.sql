CREATE EXTERNAL DATA SOURCE [AzureStorage_rajartest]
    WITH (
    TYPE = HADOOP,
    LOCATION = N'wasbs://rajartest@azpmsblbd001.blob.core.windows.net',
    CREDENTIAL = [AzureStorageCredential]
    );


workflow Call-StoredProcWithoutParameters
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [String]
        $AzureLoggingUserName,
        
        [Parameter(Mandatory=$true)]
        [String]   
        $AzureLoggingPassword,

        [Parameter(Mandatory=$true)]
        [String]
        $AzureLoggingServerName,

        [Parameter(Mandatory=$true)]
        [String]
        $AzureLoggingDatabase,

        [Parameter(Mandatory=$true)]
        [String]
		$StoredProcedureName,

        [Parameter(Mandatory=$false)]
        [Int]
		$MaxRetryCount = 3,

        [Parameter(Mandatory=$false)]
        [Int]
		$TableIndex = 0
	)

    ## Retrieve our logging database connection variables
    $QueryResultSet = InlineScript
    {
        $stopLoop = $false;
        [int] $retryCount = 0;
        do
        {
            ## Gets current time stamp for logging purpose
            $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss.000";
            try
            {
                ## Connect to our Azure SQL database, BI System
                $AzureSQLDBConnection = New-Object System.Data.SqlClient.SqlConnection;
                $AzureSQLDBConnection.ConnectionString = "Server = $using:AzureLoggingServerName; Database = $using:AzureLoggingDatabase; User ID = $using:AzureLoggingUserName; Password = $using:AzureLoggingPassword;";

        		Write-Output $AzureSQLDBConnection.ConnectionString;

        		$AzureSQLDBConnection.Open();

                ## Create a command to retrieve our errors
                $AzureSQLDBCommand = New-Object System.Data.SqlClient.SqlCommand;
                $AzureSQLDBCommand.Connection = $AzureSQLDBConnection;
                $AzureSQLDBCommand.CommandText = $using:StoredProcedureName;
        		$AzureSQLDBCommand.CommandType = [System.Data.CommandType]'StoredProcedure';

                $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($AzureSQLDBCommand);

                $Components = New-Object System.Data.DataSet;
                [Void] $SqlAdapter.Fill($Components);
                
                ## Close our SQL connection
                $AzureSQLDBConnection.Close();

                $stopLoop = $true;
            }
            catch
            {
                ## Assume errors will be network connection caused by PaaS. Retry 3 times before quitting.
                if ($retryCount -gt $MaxRetryCount) 
                {
                    ## Stops loop if retrying did not work
                    $stopLoop = $true;
                    Write-Verbose "$time - Failed to insert after $($MaxRetryCount) attempts, stopping...";
                }
                else 
                {
                    $retryCount++;
                    Write-Verbose "$time - ERROR: $($_.Exception.Message)";
                    Write-Verbose "$time - Retrying attempt $($retryCount)...";
                }
            }
        }
        while ($stopLoop -eq $False);

        ## Returns Table specified by TableIndex from inline script (only one table allowed)
        $result = $Components.Tables[$TableIndex];
        Write-Output $result;
    } 
    ## returns reusult table from this workflow
    return $QueryResultSet;
}
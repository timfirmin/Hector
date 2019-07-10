<#
.SYNOPSIS
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    Executes stored procedure against target server specified in connection string with no results returned

.PARAMETER ConnectionString
    Mandatory: Specifies target server connection string

    e.g. $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;"

.PARAMETER StoredProcedureName
    Mandatory: Specifies stored procedure name to exectue

    e.g. Azure.MyStoredProcedure

.PARAMETER StoredProcedureParameters
    Optional: Array of the parameteres for the stored procedure

.EXAMPLE
    # result - do not return any value for Non-Query SP calls;

    $result = ExecuteStoredProcedureNonQuery `
        -connectionString $BISystemConnectionString `
        -StoredProcedureName "[Azure].[InsertJobStartLog]" `
        -StoredProcedureParameters @(
        @{
            'ParameterName' = '@JobId';
            'Direction'=[System.Data.ParameterDirection]'Input';
            'DbType'=[System.Data.DbType]::Int32;
            'Value'=$Job.JobId;
        },
        @{
            'ParameterName' = '@OperationId';
            'Direction'=[System.Data.ParameterDirection]'Input';
            'DbType'=[System.Data.DbType]::String;
            'Value'= $OperationId;
        }
     ); 
.NOTES
    ORIGINAL AUTHOR: Piotr Starczynski 2017-03-16
#>

workflow ExecuteStoredProcedureNonQuery
{

    param (
        [parameter(Mandatory=$true)]
        [string] $ConnectionString,

        [parameter(Mandatory=$true)]
        [string] $StoredProcedureName,

        [parameter(Mandatory=$false)]
        [object[]] $StoredProcedureParameters,

        [parameter(Mandatory=$false)]
        [int32] $MaxRetryCount = 3
    )

    ## Assign Empty array if StoredProcedure do not contain any parameters
    if($StoredProcedureParameters -eq $null)
    {
        $StoredProcedureParameters = @();
    }

    ## Encapsulates SQL SP Call in stored procedure (Required to call from workflow)
    $ComponentsRequiredForTheJob = InlineScript
    {
        $stopLoop = $false;
        $retryCount = 0;
        do
        {
            ## Gets current time for logging purpose
            $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss.000";
            try
            {      
                ## Connect to our Azure SQL database, BI System
                $ComponentsAzureSQLDBConnection = New-Object System.Data.SqlClient.SqlConnection;
                $ComponentsAzureSQLDBConnection.ConnectionString = $using:ConnectionString;
        	    $ComponentsAzureSQLDBConnection.Open();

                ## Create a command to retrieve our errors
                $ComponentsAzureSQLDBCommand = New-Object System.Data.SqlClient.SqlCommand;
                $ComponentsAzureSQLDBCommand.Connection = $ComponentsAzureSQLDBConnection;
                $ComponentsAzureSQLDBCommand.CommandText = $using:StoredProcedureName;
        	    $ComponentsAzureSQLDBCommand.CommandType = [System.Data.CommandType]'StoredProcedure';
                
                ## Iterates over parameters array and add each of them to the command object
                if($using:StoredProcedureParameters.count -gt 0)
                {
                    foreach($parameter in $using:StoredProcedureParameters)
                    {
                        ## maps object parameter to Data.SqlClient.SqlParameter
                        $CommandParameter = new-object System.Data.SqlClient.SqlParameter;
                        $CommandParameter.ParameterName = $parameter.ParameterName;
                        $CommandParameter.Direction = $parameter.Direction;
                        $CommandParameter.DbType = $parameter.DbType;
                        $CommandParameter.Value = $parameter.Value;
                        
                        ## Add  current parameter to the command
                        $ComponentsAzureSQLDBCommand.Parameters.Add($CommandParameter) >> $null;
                    }
                }

                ## Executes query
                $ComponentsAzureSQLDBCommand.ExecuteNonQuery();

                ## Close the connection
                $ComponentsAzureSQLDBConnection.Close();
            }
            catch
            {
                ## Holds retry logic for calling the stored procedure
                if ($retryCount -gt $MaxRetryCount) 
                { 
                    ## Stops retrynig to call SP if maximum count reached 
                    $stopLoop = $true;
                    ## Loggs to verbose output
                    Write-Verbose "$time - Failed to insert after 2 attempts, stopping...";
                }
                else 
                { 
                    $retryCount++;
                    ## Loggs to verbose output
                    Write-Verbose "$time - ERROR: $($_.Exception.Message)";
                    Write-Verbose "$time - Retrying attempt $retryCount...";
                    throw;
                }
            }
            ## Stops loop if the SP call was successful
            $stopLoop = $true;
        }
        while ($stopLoop -eq $False);
    };
}


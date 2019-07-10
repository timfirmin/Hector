<#
.SYNOPSIS
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    Executes stored procedure against target server specified in connection string with result returned

.PARAMETER ConnectionString
    Mandatory: Specifies target server connection string

    e.g. $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;"

.PARAMETER StoredProcedureName
    Mandatory: Specifies stored procedure name to exectue

    e.g. Azure.MyStoredProcedure

.PARAMETER StoredProcedureParameters
    Optional: Array of the parameteres for the stored procedure
          
.PARAMETER TableIndex
    Optional: $TableIndex = 0 (default)

    Specifies which result set should workflow return (if query returns more tha one table). It can only return one table at once.

.PARAMETER MaxRetryCount
    Optional

    Specifies max retry count for stored procedure call if error happens

.EXAMPLE
    #result- holds a result table from the dataset specified by table index

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

workflow ExecuteStoredProcedureQuery
{     
    param (
        [parameter(Mandatory=$true)]
        [string] $ConnectionString,

        [parameter(Mandatory=$true)]
        [string] $StoredProcedureName,

        [parameter(Mandatory=$False)]
        [object[]] $StoredProcedureParameters,

        [parameter(Mandatory=$false)]
        [int32] $TableIndex = 0,

        [parameter(Mandatory=$false)]
        [int32] $MaxRetryCount = 3
    );

    ## Assign Empty array if StoredProcedure do not contain any parameters
    if($StoredProcedureParameters -eq $null)
    {
        $StoredProcedureParameters = @();
    }

    ## Wraps SQL SP call in inline script (not possible direct call from workflow)
    $Result = InlineScript
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
                $AzureSQLDBConnection = New-Object System.Data.SqlClient.SqlConnection;
                $AzureSQLDBConnection.ConnectionString = $using:ConnectionString;
 		        $AzureSQLDBConnection.Open();

                ## Create a command object taht would store what Stored Procedure we call
                $AzureSQLDBCommand = New-Object System.Data.SqlClient.SqlCommand;
                $AzureSQLDBCommand.Connection = $AzureSQLDBConnection;
                $AzureSQLDBCommand.CommandText = $using:StoredProcedureName;
 		        $AzureSQLDBCommand.CommandType = [System.Data.CommandType]'StoredProcedure';
                
                ## Iterates over passed parameters array and add each of them to the command variable
                if($using:StoredProcedureParameters.count -gt 0)
                {
                    foreach($parameter in $using:StoredProcedureParameters)
                    {
                        $CommandParameter = new-object System.Data.SqlClient.SqlParameter;
                        $CommandParameter.ParameterName = $parameter.ParameterName;
                        $CommandParameter.Direction = $parameter.Direction;
                        $CommandParameter.DbType = $parameter.DbType;
                        $CommandParameter.Value = $parameter.Value;
                        $AzureSQLDBCommand.Parameters.Add($CommandParameter) >> $null;
                    }
                }

                ## Performs call to the BISystem and capture the result set (can return multiple tables) 
                $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($AzureSQLDBCommand);
                $DataSetResult = New-Object System.Data.DataSet;
                [Void] $SqlAdapter.Fill($DataSetResult);
                
                ## Close our SQL connection
                $AzureSQLDBConnection.Close();
                
                ## Retruns value from the inline script
                ## Returns single table from the DataSetResult specified by TableIndex (only one table can be returned) 
                Write-Output $DataSetResult.Tables[$using:TableIndex];
            }
            catch
            {
                ## Handles retry logic
                if ($retryCount -gt $MaxRetryCount) 
                { 
                    $stopLoop = $true;
                    ## logs to the verbose output
                    Write-Verbose "$time - Failed to insert after $($MaxRetryCount) attempts, stopping...";
                }
                else 
                { 
                    $retryCount++;
                    ## logs to the verbose output
                    Write-Verbose "$time - ERROR: $($_.Exception.Message)";
                    Write-Verbose "$time - Retrying attempt $($retryCount)...";

                    ## Rethrows orginal exception
                    throw;
                }
            }
            ## Stops loop if the call was successfull
            $stopLoop = $true;
        }
        while ($stopLoop -eq $False);
    };
    ## Returns result from workflow
    return $Result;
};
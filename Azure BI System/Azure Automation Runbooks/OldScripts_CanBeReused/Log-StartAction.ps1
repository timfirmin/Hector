<#
.SYNOPSIS 
    Azure Automation logging function to output logs to screen and store in database.

.DESCRIPTION
    Inserts record that proves start of an action agains Object 

    Depends on the following Automation Assets:
        > AzureLoggingUserName - defines the username to connect to a SQL server
        > AzureLoggingPassword (encrypted) - defines the password to connect to a SQL server
        > AzureLoggingServerName - defines the SQL server to connect to
        > AzureLoggingDatabaseName - defines the database to connect to for logging
        
.PARAMETER ObjectName
    Indicates object name gains which the action is taking place. e.g. database name

.PARAMETER ActionName
    Indicates the name of the action that is taking the place agains object e.g. scaling

.PARAMETER ActionDescription
    Indicates Action description e.g. Scaling database BI-ADW-D01 to 500DWU

.PARAMETER ActionResult
    Indicates the result of the action represented as integer e.g. 1-running, 2-success, 3-failed etc.

.PARAMETER OperationID
    Optional: a guid of parent process to use for operation tracking.

.NOTES
    AUTHOR: PS
    LASTEDIT: Oct. 12, 2016 
#>

workflow Log-StartAction
{
    param (
       [Parameter(Mandatory=$True)]
       [string] $ObjectName,

       [Parameter(Mandatory=$True)]
       [string] $ActionName,

       [Parameter(Mandatory=$True)]
       [string] $ActionDescription,

       [Parameter(Mandatory=$True)]
       [int] $ActionResult,

       [Parameter(Mandatory=$False)]
       [string] $OperationID
    )

    ## Retrieve our logging database connection variables
    $AzureLoggingUserName = Get-AutomationVariable -Name "AzureLoggingUserName"
    $AzureLoggingPassword = Get-AutomationVariable -Name "AzureLoggingPassword"
    $AzureLoggingServerName = Get-AutomationVariable -Name "AzureLoggingServerName"
    $AzureLoggingDatabase = Get-AutomationVariable -Name "AzureLoggingDatabaseName"
    

    ## Builds up connection string
    $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;"
                
    if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid()
    }

    Write-Output ""
    Write-Output "#Log-StartAction for $ActionName Started"

    ## Call stored procedure Azure.InsertAction
    $result = ExecuteStoredProcedureNonQuery `
	    -connectionString $BISystemConnectionString `
	    -StoredProcedureName "[Azure].[InsertAction]" `
	    -StoredProcedureParameters @(
            @{
                'ParameterName' = '@ObjectName';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::string;
                'Value'=$ObjectName;
            },
            @{
                'ParameterName' = '@ActionName';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::string;
                'Value'= $ActionName;
            },
            @{
                'ParameterName' = '@ActionDescription';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::string;
                'Value'=$ActionDescription;
            },
            @{
                'ParameterName' = '@Result';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::Int32;
                'Value'= $ActionResult;
            },
            @{
                'ParameterName' = '@OperationID';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::string;
                'Value'= $OperationID;
            }
         );

    Write-Output "#Log-StartAction for $ActionName Completed."
    Write-Output ""
}
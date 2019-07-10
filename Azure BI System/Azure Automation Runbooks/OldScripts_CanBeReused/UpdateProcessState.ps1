<#
.SYNOPSIS
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    calls stored procedure taht updates automation Process State in BISystem Process Table

.PARAMETER ProcessId
    Mandatory: ProcessId of the process that you want to update

.PARAMETER ProcessStateId
    Mandatory: Id of the process state of the process that you want to update

.NOTES
    ORIGINAL AUTHOR: PS 2017-03-24
#>
workflow UpdateProcessState
{
    param (
       [Parameter(Mandatory=$True)]
       [Int32] $ProcessId,

       [Parameter(Mandatory=$True)]
       [Int32] $ProcessStateId
    )
  
   ## Retrieve logging database connection variables and creates connection string
   $AzureLoggingUserName   = Get-AutomationVariable -Name "AzureLoggingUserName";
   $AzureLoggingPassword   = Get-AutomationVariable -Name "AzureLoggingPassword";
   $AzureLoggingServerName = Get-AutomationVariable -Name "AzureLoggingServerName";
   $AzureLoggingDatabase   = Get-AutomationVariable -Name "AzureLoggingDatabaseName";
   
   $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;"

   ## Executes update stored procedure on Process to update Process state
   $result = ExecuteStoredProcedureNonQuery `
     -ConnectionString $BISystemConnectionString `
     -StoredProcedureName "[Azure].[UpdateProcessState]" `
     -StoredProcedureParameters @(
            @{
                'ParameterName'='@ProcessId';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::Int32;
                'Value'=$ProcessId;
            },
            @{
                'ParameterName'='@ProcessStateId';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::Int32;
                'Value'=$ProcessStateId;
            }
        );
    Write-Output "Process $($ProcessId) is now in $($ProcessStateId).";
}
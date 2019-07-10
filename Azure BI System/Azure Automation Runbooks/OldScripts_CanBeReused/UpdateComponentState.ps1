<#
.SYNOPSIS
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    calls stored procedure that updates automation component State in BISystem Component Table

.PARAMETER ComponentId
    Mandatory: Id of the the component that you want to update

.PARAMETER ComponentStateId
    Mandatory: Id of the Component State that you want to update your component to

.NOTES
    ORIGINAL AUTHOR: PS 2017-03-24
#>
workflow UpdateComponentState
{
    param (
       [Parameter(Mandatory=$True)]
       [Int32] $ComponentId,

       [Parameter(Mandatory=$True)]
       [Int32] $ComponentStateId
    )

   ## Retrieve logging database connection variables and creates connection string
   $AzureLoggingUserName   = Get-AutomationVariable -Name "AzureLoggingUserName";
   $AzureLoggingPassword   = Get-AutomationVariable -Name "AzureLoggingPassword";
   $AzureLoggingServerName = Get-AutomationVariable -Name "AzureLoggingServerName";
   $AzureLoggingDatabase   = Get-AutomationVariable -Name "AzureLoggingDatabaseName";
   
   $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;"

    ## Executes update stored procedure on Component to update ComponentState
    $result = ExecuteStoredProcedureNonQuery `
         -ConnectionString $BISystemConnectionString `
         -StoredProcedureName '[Azure].[UpdateComponentState]' `
         -StoredProcedureParameters @(
            @{
                'ParameterName'='@ComponentId';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::Int32;
                'Value'=$ComponentId;
            },
            @{
                'ParameterName'='@ComponentStateId';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::Int32;
                'Value'=$ComponentStateId;
            }
        );
        
    Write-Output "Component $($ComponentId) is now in the $($ComponentStateId).";
};
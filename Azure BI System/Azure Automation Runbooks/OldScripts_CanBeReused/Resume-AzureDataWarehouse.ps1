<#
.SYNOPSIS 
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    Resumes Azure Data Warehouse from Pause 

.PARAMETER AutomationAccountCredential
    Mandatory: a string that specifies name that is used to connect to Resource Manager

.PARAMETER AzureDatabaseResourceGroupName
    Mandatory: a string that specifies resource group name that resumed database is in

.PARAMETER AzureServerName
    Mandatory: a string that specifies server name that resumed database is creaded on

.PARAMETER AzureDatabase
    Mandatory: a string that sepcifies database name to be resumed.

.PARAMETER OperationID
    Optional: a guid to use for operation tracking. One is generated if not provided

.NOTES
    ORIGINAL AUTHOR: PS 2016-10-13
    
    ActionResult 1 -starting action
    ActionResult 2 -sucess
    ActionResult 3 -failure
#>

workflow Resume-AzureDataWarehouse
{
    param (
       [Parameter(Mandatory=$True)]
       [string] $AutomationAccountCredential,

       [Parameter(Mandatory=$True)]
       [string] $AzureDatabaseResourceGroupName,
        
       [Parameter(Mandatory=$True)]
       [string] $AzureServerName,

       [Parameter(Mandatory=$True)]
       [string] $AzureDatabase, 

       [Parameter(Mandatory=$False)]
       [string] $OperationID
    )

    if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid();
    }

    ## Setup for action specific variables
    $ActionName = "Resuming ADW";
    $ActionDescription = "Resuming Azure Datawarehouse from paused state";
    $ObjectName = "$($AzureLoggingServerName).$($AzureLoggingDatabase)";
	
    try
    {
        ## Logging Scaling Action as as running   
        Log-StartAction -ObjectName $ObjectName -ActionName $ActionName -ActionDescription $ActionDescription -ActionResult 1 -OperationID $OperationID; #ActionResult 1 - Starting action

        Write-Output ""
	    Write-Output "# Starting to Resume Azure Datawarehouse";

        ## Get the credential with the above name from the Automation Asset store
        $Credential = Get-AutomationPSCredential -Name $AutomationAccountCredential;
        if(!$Credential) {
            Log-EndAction  -ObjectName $ObjectName -ActionName $ActionName -ActionResult 3;
            Throw "Could not find an Automation Credential Asset named '${Credential}'. Make sure you have created one in this Automation Account.";
        }

        ## Connect to your Azure Account
        Add-AzureRmAccount -Credential $Credential;

        Write-Output "";
        Write-Output "Starting Azure Data Warehouse...";
        
        ## Starting ADW
        Resume-AzureRmSqlDatabase –ResourceGroupName $AzureDatabaseResourceGroupName –ServerName $AzureServerName -DatabaseName $AzureDatabase;
        
        Write-Output "";

        ## Logging Scaling Action as a success
        Log-EndAction  -ObjectName $ObjectName -ActionName $ActionName -ActionResult 2; #ActionResult 2 - Success
    }
    catch
    {
        ## Logging Scaling Action as a failure
        Write-Output "Error ocured during starting Azure DW";
        Log-EndAction  -ObjectName $ObjectName -ActionName $ActionName -ActionResult 3; #ActionResult 3 - Error
    }
    Write-Output "# Resuming Azure Datawarehouse Completed";
    Write-Output "";
}
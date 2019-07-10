<#
.SYNOPSIS 
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    Pauses Azure Data Warehouse

.PARAMETER AutomationAccountCredential
    Mandatory: a string that specifies name that is used to connect to Resource Manager

.PARAMETER AzureDatabaseResourceGroupName
    Mandatory: a string that specifies resource group name that pausing database is in

.PARAMETER AzureServerName
    Mandatory: a string that specifies server name that pausing database is creaded on

.PARAMETER AzureDatabase
    Mandatory: a string that sepcifies database name to be pausing.

.PARAMETER OperationID
    Optional: a guid to use for operation tracking. One is generated if not provided

.NOTES
    ORIGINAL AUTHOR: PS 2016-10-13

    ActionResult 1 -starting action
    ActionResult 2 -sucess
    ActionResult 3 -failure
#>

workflow Pause-AzureDataWarehouse
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
    $ActionName = "Stopping ADW";
    $ActionDescription = "Stopping Azure Data Warehouse";
    $ObjectName = "$($AzureLoggingServerName).$($AzureLoggingDatabase)";
	
    ## Get the credential with the above name from the Automation Asset store
    $Credential = Get-AutomationPSCredential -Name $AutomationAccountCredential;

    ## Tries to retrieve credential from  azure autmoation assets
    if(!$Credential) {
        Log-EndAction  -ObjectName ("$SqlServerName.$DatabaseName") -ActionName $ActionName -ActionResult 3
        Throw "Could not find an Automation Credential Asset named '${Credential}'. Make sure you have created one in this Automation Account.";
    }

    Write-Output ""
	Write-Output "# Starting to Pause Azure Datawarehouse";

    ## Logging Stopping Action as as running   
    Log-StartAction -ObjectName $ObjectName -ActionName $ActionName -ActionDescription $ActionDescription -ActionResult 1 -OperationID $OperationID; ## ActionResult 1 - Starting action

    try
    {
        ## Connect to your Azure Account
        Add-AzureRmAccount -Credential $Credential;

        Write-Output "";
        Write-Output "Stopping Azure Data Warehouse...";
        
        ## Stopping ADW
        Suspend-AzureRmSqlDatabase –ResourceGroupName $AzureDatabaseResourceGroupName –ServerName $AzureServerName -DatabaseName $AzureDatabase;
        
        Write-Output "";

        ## Logging Stopping Action as a success
        Log-EndAction  -ObjectName $ObjectName -ActionName $ActionName -ActionResult 2; ## ActionResult 1 - Success
    }
    catch
    {
        ## Logging StoppingAction as a failure
        Write-Output "Error ocured during Stopping Azure DW";
        Log-EndAction  -ObjectName $ObjectName -ActionName $ActionName -ActionResult 3; ## ActionResult 1 - Failure
    }
    Write-Output "# Stopping Azure Datawarehouse Completed";
    Write-Output "";
}
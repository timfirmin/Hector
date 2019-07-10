<#  
.SYNOPSIS  
    Turns on/off (depending on IsShutdownMode flag) Virtual machine specified by VMName that is a part of ResourceGroupName
  
.DESCRIPTION  
    This runbook enables one shutdown or start up a VM.
    
.PARAMETER AzureAdminCredentialAssetName
    Specifies credential name in Azure Automation Asset Credential that stores user name and password for the user that can modify the state of VM in ResourceGroup.

.PARAMETER OperationID  
    Optional parameter that indicates operation guid that connects Sql logs in BISystem with runbook executions.

.PARAMETER VMResourceGroupName
    Specifies name of the Resource Group that the virtual is part of. 
 
.PARAMETER VMName
    Specifies name of the virtual machine to be start-up/shutdown.
.PARAMETER IsShutdownMode 

.EXAMPLE  
  Shutdown-Start-ARM-VM-Single -AzureAdminCredentialAssetName "AssetCredentialName" -VMResourceGroupName "AZI-RG-WINDOWS" -VMName "AZI-MS-SIS-D001" -IsShutdownMode $True

.NOTES
    Action logging:
    #ActionResult 1 - Action Started
    #ActionResult 2 - Success
    #ActionResult 3 - Failure
#> 

workflow Shutdown-Start-ARM-VM-Single
{
	Param
    (
		[Parameter(Mandatory=$true)]
        [String]
		$AzureAdminCredentialAssetName,

		[Parameter(Mandatory=$false)]
        [String]
		$OperationID,

        [Parameter(Mandatory=$true)]
        [String]
		$VMResourceGroupName,

        [Parameter(Mandatory=$true)]
        [String]
        $VMName,

        [Parameter(Mandatory=$true)]
        [Boolean]
		$IsShutdownMode
	)

    ## setup variables
    $RunbookName = "Shutdown-Start-ARM-VM-Single";
 
    ## Sets action logging variables depending on IsShutdownMode
    $ActionName = "";
    $ActionDescription = "";

    ## Sets variables depending if it is for VM shutdown/startup
    if($IsShutdownMode -eq $True)
    {
        Write-Output "$RunbookName runbook is running in SHUTDOWN VM Mode.";
        $ActionName = "Stop VM";
        $ActionDescription = "Stoping $VMName Virtual Machine.";
    }
    else
    {
        Write-Output "Shutdown-Start-ARM-VM-Single runbook is running in STARTUP VM Mode.";
        $ActionName = "Start VM";
        $ActionDescription = "Starting $VMName Virtual Machine.";
    };

    ## Creates new operationId if not passed from parent runbook
    if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid();
    }
    
    ## Logging Action as running 
    Log-StartAction -ObjectName $VMName -ActionName $ActionName  -ActionDescription $ActionDescription -ActionResult 1 -OperationID $OperationID;

    ## Execution block
    try
    { 
	    ## Get the credential with the above name from the Automation Asset store
        $AzureAdminCredential = Get-AutomationPSCredential -Name $AzureAdminCredentialAssetName;
        if(!$AzureAdminCredential) 
        {
            Throw "Could not find credential named $AzureAdminCredentialAssetName in automation account->asset->credentials.";
        }
    
        ## Connect to your Azure Account
        Write-SQLLog -Level 3 -Message "Attempting to use $AzureAdminCredentialAssetName as the credential." -RunbookName $RunbookName -OperationID $OperationID;
	    Add-AzureRmAccount -Credential $AzureAdminCredential;
	    Write-SQLLog -Level 3 -Message "Connected to Azure Account." -RunbookName $RunbookName -OperationID $OperationID;
    
        
        ## Gets the instance of VirtualMachine and encapsulate it in the vm variable
        
	    $vmInstance = Get-AzureRmVM -Name $VMName -ResourceGroupName $VMResourceGroupName;
    
	    if(!$vmInstance) 
        {
            Throw "Could not find an VM named $VMName in Resource Group $VMResourceGroupName. Please ensure VM exists in specified resource group name or credential provided has sufficient access.";
        }
        
	    Write-SQLLog -Level 3 -Message "Found VM named $VMName, proceeding to attempt $ActionName." -RunbookName $RunbookName -OperationID $OperationID;
        
        
	    if($IsShutdownMode -eq $True){
	    	Write-SQLLog -Level 2 -Message "Stopping $($VMName) in Resource Group $VMResourceGroupName." -RunbookName $RunbookName -OperationID $OperationID;		
	    	Stop-AzureRmVm -Name $VMName -ResourceGroupName $VMResourceGroupName -Force;
            Write-Output "Executing shut down...";
	    }
	    else
        {
	    	Write-SQLLog -Level 2 -Message "Starting $($VMName) in Resource Group $VMResourceGroupName." -RunbookName $RunbookName -OperationID $OperationID;		
	    	Start-AzureRmVm -Name $VMName -ResourceGroupName $VMResourceGroupName;
            Write-Output "Executing start";
	    }

        ## Logging Action as successful
        Log-EndAction -ObjectName $VMName -ActionName $ActionName -ActionResult 2;
        Write-Output "$RunbookName runbook finished execution without errors.";
    }
    catch
    {
        ## Logging Action as failed
        Log-EndAction -ObjectName $VMName -ActionName $ActionName -ActionResult 3;
        Write-Error ("Failed to $($ActionName) " + $_)
        Write-Output "$RunbookName runbook finished execution with errors.";
        throw;
    }
}
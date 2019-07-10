workflow Shutdown-Start-ARM-VMs-Parallel
{
		Param(
		[Parameter(Mandatory=$true)]
        [String]
		$ResourceGroupName,
		[Parameter(Mandatory=$true)]
        [Boolean]
		$Shutdown,
		[Parameter(Mandatory=$true)]
        [String]
		$AzCredential,
		[Parameter(Mandatory=$false)]
        [String]
		$OperationID
	)
	
	if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid()
    }
	
	#The name of the Automation Credential Asset this runbook will use to authenticate to Azure.
    $CredentialAssetName = $AzCredential;
	
	#Get the credential with the above name from the Automation Asset store
    $Cred = Get-AutomationPSCredential -Name $CredentialAssetName;
    if(!$Cred) {
        Throw "Could not find an Automation Credential Asset named '${CredentialAssetName}'. Make sure you have created one in this Automation Account."
    }

    #Connect to your Azure Account
	Add-AzureRmAccount -Credential $Cred;
	
	$vms = Get-AzureRmVM -ResourceGroupName $ResourceGroupName;
	
	Foreach -Parallel ($vm in $vms){
		
		if($Shutdown){
			Write-SQLLog -Level 2 -Message "Stopping $($vm.Name)" -RunbookName "Shutdown-Start-ARM-VMs-Parallel" -OperationID $OperationID;		
			Stop-AzureRmVm -Name $vm.Name -ResourceGroupName $ResourceGroupName -Force;
		
			
		}
		else{
			Write-SQLLog -Level 2 -Message "Starting $($vm.Name)" -RunbookName "Shutdown-Start-ARM-VMs-Parallel" -OperationID $OperationID;		
			Start-AzureRmVm -Name $vm.Name -ResourceGroupName $ResourceGroupName;
		}
	}
}
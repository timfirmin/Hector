workflow Set-SetVMTags
{
    Param(
		[Parameter(Mandatory=$true)]
        [String]
		$AzCredential,
        [Parameter(Mandatory=$true)]
        [String]
		$VMName,
        [Parameter(Mandatory=$true)]
        [String]
		$ResourceGroupName,
        [Parameter(Mandatory=$true)]
        [String]
        $TagName,
        [Parameter(Mandatory=$true)]
        [String]
        $TagValue,
		[Parameter(Mandatory=$true)]
        [String]
		$Remove,
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
        Throw "Could not find an Automation Credential Asset named ${CredentialAssetName}. Make sure you have created one in this Automation Account."
    }
	
	Write-SQLLog -Level 3 -Message "Attempting to use ${Cred} as the credential" -RunbookName "Shutdown-Start-ARM-VM-Single" -OperationID $OperationID;
	
    #Connect to your Azure Account
	Add-AzureRmAccount -Credential $Cred;
	
	Write-SQLLog -Level 3 -Message "Connected to Azure Account" -RunbookName "Shutdown-Start-ARM-VM-Single" -OperationID $OperationID;
	
    $vm = Get-AzureRmResource -Name $VMName -ResourceGroupName $ResourceGroupName
	$tags = $vm.Tags;

    Write-Output $tags;

    $scriptOutput = inlinescript{

    $Newtags = $Using:tags;

    If($Using:Remove -eq "Yes"){
        $Newtags = $Newtags| where{-NOT $_.ContainsValue("bIStandard")}
    }
    Else {
        If($Newtags.ContainsValue("bIStandard")){
            foreach ($element in $Newtags)
            {
                If($element.ContainsValue("bIStandard"))
                {
                    foreach ($entry in $element)
                    {
                        if($entry.ContainsKey("Value"))
                        {
                            $entry.Set_Item("Value","Yes")
                        }
                    }
                }

            }
        }
        Else {
            $Newtags += @(@{Name="Name";Value="bIStandard"},@{Name="Value";Value="Yes"})
        }
}
       return $Newtags;

    }

    Write-Output $scriptOutput

    Set-AzureRmResource -ResourceId $vm.ResourceId -Tags $Newtags -Force
}



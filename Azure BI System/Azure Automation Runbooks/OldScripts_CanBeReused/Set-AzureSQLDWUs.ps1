<#  
.SYNOPSIS  
    Vertically scale (up or down) an Azure SQL Database   
  
.DESCRIPTION  
    This runbook encapsulates scaling vertically scale (up or down) an Azure SQL DataWarehouse using Azure Automation for webhook call.
    Can also  be called from another webhook 
    
.PARAMETER WebHookData
    Mandatory:

    Must contain JSON object that have child parameteres listed before

SqlServerName 
    Name of the Azure SQL Database server (Ex: bzb98er9bp) 
      
DatabaseName  
    Target Azure SQL DataWarehouse name

PerfLevel  
    Desired performance level {DW100, DW200, DW500, DW2000} 
 
 $ResourceGroup 
    Specifies resource group of the ADW

$Operationid
    Specifies guid that identifes process

.PARAMETER Credential  
    Credentials Name that specifies asset credentials for $SqlServerName stored as an Azure Automation credential asset  
    When using in the Azure Automation UI, please enter the name of the 
    credential asset for the "Credential" parameter
    
.EXAMPLE  
  
.NOTES  
    Gallery Author: Joseph Idziorek - Last Updated: 11/22/2014
    PRS Author: Adatis - SAW, 2016-09-15  
#> 

workflow Set-AzureSQLDWUs
{
    param
    (
        [parameter(Mandatory=$true)] 
        [string] $Credential,

        [object]$WebHookData
	)

    ## Deserialize variables from JSON object
	$Inputs = ConvertFrom-JSON $webhookdata.RequestBody;

    $ResourceGroup = $Inputs.ResourceGroup;
    $SqlServerName = $Inputs.SqlServerName;
    $DatabaseName = $Inputs.DatabaseName;
    $PerfLevel = $Inputs.PerfLevel;
    $OperationID  = $Inputs.OperationID;

    ## Asignes OperationID if null
	if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid().ToString();
    }

    ## Calls Scale up runbook and pass parameters deserialized from JSON
    Scale-ADW-Single -Credential $Credential -ResourceGroup $ResourceGroup -SqlServerName $SqlServerName -DatabaseName $DatabaseName -PerfLevel $PerfLevel -OperationID $OperationID;
}
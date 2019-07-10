<#  
.SYNOPSIS  
    Vertically scale (up or down) an Azure SQL Database   
  
.DESCRIPTION  
    This runbook enables one to vertically scale (up or down) an Azure SQL DataWarehouse using Azure Automation. 

.PARAMETER Credential  
    Credentials for $SqlServerName stored as an Azure Automation credential asset  
    When using in the Azure Automation UI, please enter the name of the 
    credential asset for the "Credential" parameter

.PARAMETER ResourceGroup 
    Name of the Azure SQL Database server (Ex: bzb98er9bp)

.PARAMETER SqlServerName 
    Name of the Azure SQL Database server (Ex: bzb98er9bp) 

.PARAMETER SqlServerName 
    Name of the Azure SQL Database server (Ex: bzb98er9bp) 
      
.PARAMETER DatabaseName  
    Target Azure SQL DataWarehouse name

.PARAMETER PerfLevel  
    Desired performance level {DW100, DW200, DW500, DW2000} 
    
.EXAMPLE  
    Set-AzureSqlDatabaseEdition
        -ResourceGroupName AZE-RG-BI-DEV
        -SqlServerName azp-ms-sql-d002 
        -DatabaseName BI-ADW-D01
        -PerfLevel DW500
        -Credential myCredential 
  
.NOTES  
    Gallery Author: Joseph Idziorek - Last Updated: 11/22/2014
    PRS Author: Adatis - SAW, 2016-09-15  

    #ActionResult 1 - Action Started
    #ActionResult 2 - Success
    #ActionResult 3 - Failure
#> 

workflow Scale-ADW-Single
{
    param
    (
        [parameter(Mandatory=$true)] 
        [string] $Credential,

        [parameter(Mandatory=$true)] 
        [string] $ResourceGroup,

        [parameter(Mandatory=$true)] 
        [string] $SqlServerName,

        [parameter(Mandatory=$true)] 
        [string] $DatabaseName,

        [parameter(Mandatory=$true)] 
        [string] $PerfLevel,

        #Unique ID for this execution
        [parameter(Mandatory=$false)]
        [string] $OperationID
	)

	if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid();
    }

    ## Assigning local variables 
    $ActionName = "Scaling";
    $ActionDescription = "Scaling $DatabaseName To $PerfLevel";
    $ObjectName = "$SqlServerName.$DatabaseName";

    Write-Output "";
    Write-Output "# $ActionDescription";
    
    ## Logging that scaling w changed state to "in progress"
    Log-StartAction -ObjectName $ObjectName -ActionName $ActionName -ActionDescription $ActionDescription -ActionResult 1 -OperationID $OperationID; #ActionResult 1 - Action Started

    Write-Output "# $ActionDescription Started";

    ## Get the credential with the above name from the Automation Asset store
    $Cred = Get-AutomationPSCredential -Name $Credential;
    if(!$Cred) {
        Log-EndAction  -ObjectName $ObjectName -ActionName $ActionName -ActionResult 3;
        Throw "Could not find an Automation Credential Asset named '${Credential}'. Make sure you have created one in this Automation Account.";
    }

    ## Connects Azure Account by using retrieved credentials
    Add-AzureRmAccount -Credential $Cred;

    try
    {
        ## Set the new edition/performance level
        Set-AzureRmSqlDatabase -ResourceGroupName $ResourceGroup -DatabaseName $DatabaseName -ServerName $SqlServerName.ToLower() -RequestedServiceObjectiveName $PerfLevel;
        Write-Output "";
        
        ## Logging that scaling was successfull
        Log-EndAction  -ObjectName $ObjectName -ActionName $ActionName -ActionResult 2; #ActionResult 2 - Success
    }
    catch 
    {
        ## Logging that scaling was failed
        Log-EndAction  -ObjectName $ObjectName -ActionName $ActionName -ActionResult 3; #ActionResult 3 - Failure

        Write-Output "Error hapend"
        $errorMessage = $_.Exception.Message;
        Write-SQLLog -Level 2 -Message "Error Scaling $Using:DatabaseName - $Using:errorMessage" -RunbookName "Set-AzureSqlDatabaseEdition" -OperationID $OperationID;
        Write-Output = "Error Scaling $Using:DatabaseName - $Using:errorMessage";	
        Throw "Error Scaling $Using:DatabaseName - $Using:errorMessage";
    }
    Write-Output "# $ActionDescription Finished";
    Write-Output "";
}
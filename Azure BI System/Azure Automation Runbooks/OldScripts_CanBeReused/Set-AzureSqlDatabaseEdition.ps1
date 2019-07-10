<#  
.SYNOPSIS  
    Vertically scale (up or down) an Azure SQL Database   
  
.DESCRIPTION  
    This runbook enables one to vertically scale (up or down) an Azure SQL DataWarehouse using Azure Automation. 
    
.PARAMETER SqlServerName 
    Name of the Azure SQL Database server (Ex: bzb98er9bp) 
      
.PARAMETER DatabaseName  
    Target Azure SQL DataWarehouse name

.PARAMETER PerfLevel  
    Desired performance level {DW100, DW200, DW500, DW2000} 
 
.PARAMETER Credential  
    Credentials for $SqlServerName stored as an Azure Automation credential asset  
    When using in the Azure Automation UI, please enter the name of the 
    credential asset for the "Credential" parameter
    
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
#> 

workflow Set-AzureSqlDatabaseEdition
{
    param
    (
        #Name of the Resource Group the database belongs to
        [parameter(Mandatory=$true)] 
        [string] $ResourceGroup,

        # Name of the Azure SQL Database server (Ex: bzb98er9bp)
        [parameter(Mandatory=$true)] 
        [string] $SqlServerName,

        # Target Azure SQL Database name 
        [parameter(Mandatory=$true)] 
        [string] $DatabaseName,

        # Desired performance level {Basic, S0, S1, S2, P1, P2, P3}
        [parameter(Mandatory=$true)] 
        [string] $PerfLevel,

        # Credentials for $SqlServerName stored as an Azure Automation credential asset
        # When using in the Azure Automation UI, please enter the name of the credential asset for the "Credential" parameter
        [parameter(Mandatory=$true)] 
        [string] $Credential,

        #Unique ID for this execution
        [parameter(Mandatory=$false)]
        [string] $OperationID
	)
	
	if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid();
    }

    Write-Output "Begin vertical scaling script..."

    #Get the credential with the above name from the Automation Asset store
    $Cred = Get-AutomationPSCredential -Name "$Using:Credential";
    if(!$Cred) {

        Throw "Could not find an Automation Credential Asset named '${Credential}'. Make sure you have created one in this Automation Account.";
    }

    #Connect to your Azure Account
    Add-AzureRmAccount -Credential $Cred;

    #try{
        # Set the new edition/performance level
        Set-AzureRmSqlDatabase -ResourceGroupName $Using:ResourceGroup -DatabaseName $Using:DatabaseName -ServerName $Using:SqlServerName -RequestedServiceObjectiveName $Using:PerfLevel;
    #}
    #catch {
    #    $errorMessage = $Error[0].Exception;
    #    #Write-SQLLog -Level 2 -Message "Error Scaling $Using:DatabaseName - $Using:errorMessage" -RunbookName "Set-AzureSqlDatabaseEdition" -OperationID $OperationID;		
    #    Throw "Error Scaling $Using:DatabaseName - $Using:errorMessage";
    #}
    
    # Output final status message
    #Write-SQLLog -Level 2 -Message "Successfully scaled $Using:DatabaseName to $Using:PerfLevel" -RunbookName "Set-AzureSqlDatabaseEdition" -OperationID $OperationID;		
    Write-Output "Scaled the performance level of $Using:DatabaseName to $Using:PerfLevel";
    Write-Output "Completed vertical scale";
}
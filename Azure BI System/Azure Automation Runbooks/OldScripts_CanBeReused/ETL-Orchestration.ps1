
<#
.SYNOPSIS 
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    Utilizes an Azure SQL database to provide a trigger flag - if this trigger is set, call another powershell script to start the VM

.PARAMETER LoadStream
    Indicates the BI Load process to be kicked off. At the time of writing there will only be one, but this can be extended as required

.PARAMETER OperationID
    Optional: a guid to use for operation tracking. One is generated if not provided

.NOTES
    ORIGINAL AUTHOR: Simon Whiteley 2016-04-26
#>

workflow ETL-Orchestration
{
    param (
       [Parameter(Mandatory=$True)]
       [string] $LoadStream = "Statement",
       [Parameter(Mandatory=$False)]
       [string] $OperationID
    )
	
	Write-Output "Starting Script"
    
    # Retrieve our logging database connection variables
    $AzureLoggingUserName   = Get-AutomationVariable -Name "AzureLoggingUserName"
    $AzureLoggingPassword   = Get-AutomationVariable -Name "AzureLoggingPassword"
    $AzureLoggingServerName = Get-AutomationVariable -Name "AzureLoggingServerName"
    $AzureLoggingDatabase   = Get-AutomationVariable -Name "AzureLoggingDatabaseName"
    $AzureLoggingTableName  = Get-AutomationVariable -Name "AzureLoggingTableName"

    if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid()
    }
    
    $TriggerFlag = InlineScript {
        $stopLoop = $false
        [int]$retryCount = "0"
        do 
        {
            $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss.000"

            try
            {
                # Connect to our Azure SQL database
                $AzureSQLDBConnection = New-Object System.Data.SqlClient.SqlConnection
                $AzureSQLDBConnection.ConnectionString = "Server = $using:AzureLoggingServerName; Database = $using:AzureLoggingDatabase; User ID = $using:AzureLoggingUserName; Password = $using:AzureLoggingPassword;"
                
				#Write-Output $AzureSQLDBConnection.ConnectionString

				$AzureSQLDBConnection.Open();

                # Create a command to retrieve our errors
                $AzureSQLDBCommand = New-Object System.Data.SqlClient.SqlCommand
                $AzureSQLDBCommand.Connection = $AzureSQLDBConnection
                $AzureSQLDBCommand.CommandText = "Azure.GetLoadStartFlag"
				$AzureSQLDBCommand.CommandType = [System.Data.CommandType]'StoredProcedure';
				
				$outParameter = new-object System.Data.SqlClient.SqlParameter;
			    $outParameter.ParameterName = "@Trigger";
			    $outParameter.Direction = [System.Data.ParameterDirection]'Output';
			    $outParameter.DbType = [System.Data.DbType]'Boolean';
				
				$AzureSQLDBCommand.Parameters.Add($outParameter) >> $null;
				
                # Execute our command
                $AzureSQLDBCommand.ExecuteNonQuery() | Out-Null
        		
				$Trigger = $AzureSQLDBCommand.Parameters["@Trigger"].Value;
				#Write-Output "Stored Procedure returned: $Trigger"
					 
                # Close our SQL connection
                $AzureSQLDBConnection.Close() | Out-Null

                $stopLoop = $true
            }
            catch
            {
                if ($retryCount -gt 2) { 
                    $stopLoop = $true 
                    Write-Output "$time - Failed to insert after 2 attempts, stopping..."
                }
                else { 
                    $retryCount++
                    Write-Output "$time - ERROR: $($_.Exception.Message)"
                    Write-Output "$time - Retrying attempt $retryCount..."
                }
            }
        }
        while ($stopLoop -eq $False);
		
		$Trigger
    }
		Write-Output "But Trigger Variable now says: $TriggerFlag"
		if($TriggerFlag -eq $True)
		{
			Write-Output "ETL Triggered - Starting ETL Orchestration Load";
			try{
				Shutdown-Start-ARM-VM-Single -VMName "AZI-MS-SIS-D001" -OperationID $OperationID -ResourceGroupName "AZE-RG-BI-DEV"	-shutdown $false -AzCredential "SAWDev";		
				Write-SQLLog -OperationID $OperationID -Message "ETL Load Triggered successfully" -RunbookName "ETL-Orchestration" -Level 3;
			}
			catch {
				Write-Output "$time - ERROR: $($_.Exception.Message)";
			}	
		}
		else {
			
			Write-SQLLog -OperationID $OperationID -Message "No Trigger within BISystem - indicates that no load is required. Terminating Load process" -RunbookName "ETL-Orchestration" -Level 3;
		}	
		
}
#EndRegion
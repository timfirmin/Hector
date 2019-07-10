<#  
.SYNOPSIS  
    Acquire components for scheduled shutdown from BISystem. Issue shutdown command to each
  
.DESCRIPTION  
    This runbook enables one to orchestrate the downtime of an Azure estate using metadata driven tables
    Depends on:
    Asset variables:
        AzureLoggingUserName - name of the user that have a right to read/write loggs to loging table
        AzureLoggingPassword - password(encrypted) of the user that have a right to read/write loggs to loging table
        AzureLoggingServerName - name of the server name used for logging
        AzureLoggingDatabaseName - name of the database used for logging
    
    Asset credentials:
        AzureCredentialName- Specifies azure asset credential name that will perform actions on components


.PARAMETER ScheduleName 
    Name of the schedule being run (ie: Schedule-Shutdown-2000hrs)

.PARAMETER AzureCredentialName
    Specifies azure asset credential name that will perform actions on components

.PARAMETER OperationID
    Specifies operational guid

.EXAMPLE  
    Schedule-Shutdown
        -ScheduleName Shutdown2000hrs
        -AzureCredentialName 'CredentialNameFromAsset'
  
.NOTES  
    PRS Author: Adatis - SAW, 2017-01-08  
#> 

workflow Run-Uptime-Schedule
{
    param
    (
        [parameter(Mandatory=$true)] 
        [string] $ScheduleName,

        [parameter(Mandatory=$true)] 
        [string] $AzureCredentialName,
        
        #Unique ID for this execution
        [parameter(Mandatory=$false)]
        [string] $OperationID

    )

    Write-Output "Running Schedule for: $ScheduleName";
    try
    {
        ## Generate OperationID if not passed by other process
        if(!$OperationID)
        {
            $OperationID = [GUID]::NewGuid().ToString();
        }

        ## Setup variables
        $AzureAdminName = Get-AutomationVariable -Name "AzureCredentialName";

        ## Retrieve our logging database connection asset variables
        $AzureLoggingUserName   = Get-AutomationVariable -Name "AzureLoggingUserName";
        $AzureLoggingPassword   = Get-AutomationVariable -Name "AzureLoggingPassword";
        $AzureLoggingServerName = Get-AutomationVariable -Name "AzureLoggingServerName";
        $AzureLoggingDatabase   = Get-AutomationVariable -Name "AzureLoggingDatabaseName";
       
        $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;";

        ## Get all Scheduled component as request to BISystem
        $ScheduleComponents = ExecuteStoredProcedureQuery `
            -connectionString $BISystemConnectionString `
            -StoredProcedureName "[Azure].[GetScheduledComponents]" `
            -StoredProcedureParameters @(
            @{
                'ParameterName' = '@AutomationJob';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::Int32;
                'Value'=$ScheduleName;
            }
         );

        ## Iterate over available componentActions 
        Write-Output "Number of Components:$($ScheduleComponents.Rows.Count)";
        foreach ($Shedule in $ScheduleComponents)
        {
            ## Displays in the console current component action
            Write-Output "  ### Component $($ComponentName) ###";
            Write-Output "";
            Write-Output "  Parameters";
            Write-Output "  Action: $Shedule.Action";
            Write-Output "  ComponentType: $Shedule.ComponentType";
            Write-Output "  ComponentName: $Shedule.ComponentName";

            ## Called when component is a Virtual Machine
            if ($Shedule.ComponentType -eq "SQLVM")
            {
                If ($Shedule.Action -eq "Shutdown")
                {
                    Write-Output "Shuting down";
                    Shutdown-Start-ARM-VM-Single `
                        -VMName $Shedule.ComponentName `
                        -OperationID $OperationID `
                        -VMResourceGroupName $Shedule.ResourceGroup `
                        -AzureAdminCredentialAssetName $AzureAdminCredentialName `
                        -IsShutdownMode $true;
                }
                if($Shedule.Action -eq "Start")
                {
                    Write-Output "Starting";
                    Shutdown-Start-ARM-VM-Single `
                        -VMName $Shedule.ComponentName `
                        -OperationID $OperationID `
                        -VMResourceGroupName $Shedule.ResourceGroup `
                        -AzureAdminCredentialAssetName $AzureAdminCredentialName `
                        -IsShutdownMode $false;
                }
            }

            ## The Component is an Azure DataWarehouse, call the Pause/Resume job as necessary 
            if ($Shedule.ComponentType -eq "SQLDW")
            {        
                If ($Shedule.Action -eq "Shutdown")
                {
                    Write-Output "Component is a SQLDW - Pause";
                    Pause-AzureDataWarehouse `
                        -OperationID $OperationID `
                        -AutomationAccountCredential $AzureAdminCredentialName `
                        -AzureServerName $Shedule.ComponentServer `
                        -AzureDatabase $Shedule.ComponentName `
                        -AzureDatabaseResourceGroupName $Shedule.ResourceGroup;
                }
                if($Shedule.Action -eq "Start")
                {
                    Write-Output "Component is a SQLDW - Resume";  
                    Resume-AzureDataWarehouse `
                        -OperationID $OperationID `
                        -AutomationAccountCredential $AzureAdminCredentialName `
                        -AzureServerName $Shedule.ComponentServer `
                        -AzureDatabase $Shedule.ComponentName `
                        -AzureDatabaseResourceGroupName $Shedule.ResourceGroup;
                }
            }
        ## End foreach components loop
        }
    ## End try block
    }
    catch
    {
        ## Gathers error message
        $FailedItem = $_.Exception.ItemName;
        $ErrorMessage = $_.Exception.Message;
        $MessageBody = "$($FailedItem) has thrown an exception with the following message: $($ErrorMessage)";
        
        ## Sends Email with the error message
        Send-EmailNotification `
		    -OperationID $OperationId `
		    -MessageBody $MessageBody `
		    -NotificationLevel 'WARN';
    }

}

        
     


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
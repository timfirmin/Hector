<#
.SYNOPSIS 
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    Orchestration Scripts that is responsible for turning off servicess after load is finished and there is nothing to process.

.PARAMETER OperationID
    Optional: a guid to use for operation tracking. One is generated if not provided

.NOTES
    ORIGINAL AUTHOR: Simon Whiteley 2016-04-26
#>

workflow ETL-ProcessEnd
{
    param (
       [Parameter(Mandatory=$False)]
       [string] $OperationID
    )

	Write-Output "#Started ETL-ProcessEnd Script";
    
    try
    {
        ## Asigns operation id if not assigned
        if(!$OperationID)
        {
            $OperationID = [GUID]::NewGuid();
        }

        ## Retrieve asset creadentials name that is used to perform action on components
        $AzureCredentialName = Get-AutomationVariable -Name "AzureCredentialName";

        ## Retrieve logging database connection from asset variables variables and assigns BISystem connection string
        $AzureLoggingUserName   = Get-AutomationVariable -Name "AzureLoggingUserName";
        $AzureLoggingPassword   = Get-AutomationVariable -Name "AzureLoggingPassword";
        $AzureLoggingServerName = Get-AutomationVariable -Name "AzureLoggingServerName";
        $AzureLoggingDatabase   = Get-AutomationVariable -Name "AzureLoggingDatabaseName";

        $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;";

        ## Get JobId that should be updated as done
        $JobsThatAreReadyForShutDown = Call-StoredProcWithoutParameters `
        	-StoredProcedureName "[Azure].[GetJobReadyForShutDown]" `
        	-AzureLoggingDatabase $AzureLoggingDatabase `
        	-AzureLoggingPassword $AzureLoggingPassword `
        	-AzureLoggingServerName $AzureLoggingServerName `
        	-AzureLoggingUserName $AzureLoggingUserName;

        ## Get list of components that can be shutdown for this Job ##
        Write-Output "";
        Write-Output "Jobs that are ready for shut down";
        Write-Output "Number of jobs to shut down: $($JobsThatAreReadyForShutDown.Rows.count)";
        Write-Output "";

        ## Loops over Jobs that are ready to process
        Foreach($Job in $JobsThatAreReadyForShutDown)
        {
            if ($Job.JobId -ne $null) 
            {
                ## Displays information about the currently processed job
                Write-Output "### JOB $($Job.JobId) ###";
                Write-Output "Current Job Parameters:";
                Write-Output "SourceFileId: $($Job.SourceFileId)";
                Write-Output "ApplicationId: $($Job.ApplicationId)";
                Write-Output "JobId: $($Job.JobId) ";

                Write-Output "Logging Job as shuting down components";

                ## Update Job that closing process start to began
                $result = ExecuteStoredProcedureNonQuery `
        	        -connectionString $BISystemConnectionString `
        	        -StoredProcedureName "[Azure].[UpdateJobEntriesAsFinishing]" `
        	        -StoredProcedureParameters @(
                        @{
                            'ParameterName' = '@JobId';
                            'Direction'=[System.Data.ParameterDirection]'Input';
                            'DbType'=[System.Data.DbType]::Int32;
                            'Value'=$Job.JobId;
                        },
                        @{
                            'ParameterName' = '@OperationId';
                            'Direction'=[System.Data.ParameterDirection]'Input';
                            'DbType'=[System.Data.DbType]::String;
                            'Value'= $OperationId;
                        },
                        @{
                            'ParameterName' = '@Status';
                            'Direction'=[System.Data.ParameterDirection]'Input';
                            'DbType'=[System.Data.DbType]::Int32;
                            'Value'= 6; ## mark components as starting for closing
                        }
                     );

                ## Get Componentes associated with the job that are not required for other jobs and can be shut down
                $ComponentsReadyToBeShutDownForCurrentJob = ExecuteStoredProcedureQuery `
        	        -connectionString $BISystemConnectionString `
        	        -StoredProcedureName "[Azure].[GetJobComponentsReadyForShutDown]" `
        	        -StoredProcedureParameters @(
                        @{
                            'ParameterName' = '@JobId';
                            'Direction'=[System.Data.ParameterDirection]'Input';
                            'DbType'=[System.Data.DbType]::Int32;
                            'Value'=$Job.JobId;
                        }
                     );

                ## Iterates over each component and shuts down all components that are not required for any job       
                Write-Output "Components that will be shut down";
                Write-Output "Number of components: $($ComponentsReadyToBeShutDownForCurrentJob.Rows.count)";
                Write-Output "";

                Foreach ($Component in $ComponentsReadyToBeShutDownForCurrentJob)
                {
                    Write-Output "";
                    Write-Output "  ### COMPONENT $($Component.ComponentName) ###";

                    ## Displays current component parameters
                    Write-Output "  Component Parameters:";
                    Write-Output "  ComponentType: $($Component.ComponentType);";
                    Write-Output "  ComponentName: $($Component.ComponentName);";
                    Write-Output "  ResourceGroup: $($Component.ResourceGroup);";
                    Write-Output "  ComponentServer: $($Component.ComponentServer);";

                    ## Check if component is Virtual Machine
                    If ($Row.ComponentType -eq "SQLVM")
                    {
                        ## The component is a virtual machine so call the Start-Stop VM job
                        Write-Output "Component is a VM";        
                        # Shutdown-Start-ARM-VM-Single  `   
                        #     -VMName $($Row.ComponentName) `
                        #     -OperationID $OperationID `
                        #     -VMResourceGroupName $($Row.ResourceGroup) `
                        #     -IsShutdownMode $($true) `
                        #     -AzureAdminCredentialAssetName $AzureCredentialName;
                    }
                
                    ## Checks if component is Azure Data Wareshouse
                    If ($Row.ComponentType -eq "SQLDW")
                    {
                        ## The Component is an Azure Data Warehouse, call the pause job
                        Write-output "Component is a SQLDW - pause";             
                        # Pause-AzureDataWarehouse  `
                        #     -OperationID $OperationID  `
                        #     -AutomationAccountCredential $AzureCredentialName  `
                        #     -AzureServerName $($Row.ComponentServer)  `
                        #     -AzureDatabase $($Row.ComponentName)  `
                        #     -AzureDatabaseResourceGroupName $($Row.ResourceGroup);
                    }
                    Write-Output "  ### COMPONENT END ###";
                    Write-Output "";
                ## End Component loop
                }

                ## Log into Azure.JobLog that the Job has ended successfully
                Write-Output "Updating JobLog as done"
                $result = ExecuteStoredProcedureNonQuery `
        	        -connectionString $BISystemConnectionString `
        	        -StoredProcedureName "[Azure].[UpdateJobEntriesAsFinished]" `
        	        -StoredProcedureParameters @(
                     @{
                        'ParameterName' = '@JobId';
                        'Direction'=[System.Data.ParameterDirection]'Input';
                        'DbType'=[System.Data.DbType]::Int32;
                        'Value'=$Job.JobId;
                     },
                     @{
                        'ParameterName' = '@OperationId';
                        'Direction'=[System.Data.ParameterDirection]'Input';
                        'DbType'=[System.Data.DbType]::String;
                        'Value'= $OperationId;
                     },
                     @{
                        'ParameterName' = '@Status';
                        'Direction'=[System.Data.ParameterDirection]'Input';
                        'DbType'=[System.Data.DbType]::Int32;
                        'Value'= 4; ## Shutting down of the components has finished
                     });
            ## End If
            Write-Output "### JOB END ###";
            Write-Output "";
            } 
        ## End of Job loop
        }
    }
    catch
    {
        ## Caputres error messsage and encapsulate it in email body
        $FailedItem = $_.Exception.ItemName;
        $ErrorMessage = $_.Exception.Message;
        $MessageBody = "$($FailedItem) has thrown an exception with the following message: $($ErrorMessage)";
        
        ## Sends notification on failure
        Send-EmailNotification `
		    -OperationID $OperationId `
		    -MessageBody $MessageBody `
		    -NotificationLevel 'WARN';
    }
## End of Workflow
}



    

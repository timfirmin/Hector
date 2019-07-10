<#
.SYNOPSIS
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    Utilizes an Azure SQL database to provide a trigger flag - if this trigger is set, call another powershell script to start the VM

.PARAMETER OperationID
    Optional: a guid to use for operation tracking. One is generated if not provided

.NOTES
    ORIGINAL AUTHOR: SW 2016-04-26
#>

workflow ETL-ProcessStart
{
    param (

       [Parameter(Mandatory=$False)]
       [string] $OperationID
    )

    try
    {
	    Write-Output "#Started ETL-ProcessStart Script";

        if(!$OperationID)
        {
            $OperationID = [GUID]::NewGuid();
        }

        ## Retrieve logging database connection variables and creates connection string
        $AzureLoggingUserName   = Get-AutomationVariable -Name "AzureLoggingUserName";
        $AzureLoggingPassword   = Get-AutomationVariable -Name "AzureLoggingPassword";
        $AzureLoggingServerName = Get-AutomationVariable -Name "AzureLoggingServerName";
        $AzureLoggingDatabase   = Get-AutomationVariable -Name "AzureLoggingDatabaseName";
        
        $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;"

        ## Retrive credentials used to operate on components
        $AzureCredentialName = Get-AutomationVariable -Name "AzureCredentialName";
           
        ## Get Jobs ready to be processed and reset source file table flag
        $JobsReadyToProcess = Call-StoredProcWithoutParameters `
	    	-StoredProcedureName "[Azure].[GetFinancialJobsReadyToProcess]" `
	    	-AzureLoggingDatabase $AzureLoggingDatabase `
	    	-AzureLoggingPassword $AzureLoggingPassword `
	    	-AzureLoggingServerName $AzureLoggingServerName `
	    	-AzureLoggingUserName $AzureLoggingUserName;

        Write-Output "Amount of jobs: $($JobsReadyToProcess.Rows.count)";
        $result = ExecuteStoredProcedureNonQuery `
            -connectionString $BISystemConnectionString `
            -StoredProcedureName "[Azure].[InsertJobStartLog]" `
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
                    'Value'=$OperationID;
                }
            );

        ## Iterates over existing jobs and perform action on their components
        foreach($Job in $JobsReadyToProcess)
        {
            ## This is to remove first row from the dataset table that always comes empty
            if ($Job.JobId -ne $null) 
            {
                Write-Output "### JOB $($Job.JobId) ###";
                Write-Output "Current Job Parameters:";
                Write-Output "SourceFileId: $($Job.SourceFileId)";
                Write-Output "ApplicationId: $($Job.ApplicationId)";
                Write-Output "JobId: $($Job.JobId) ";
                    
                ## Set Job as starting components 
                Write-Output "Writing to JobLog as Started"


                ## Get Componentes associated with the job that are not currently in use but are required
                $ComponentsRequiredForTheJob = ExecuteStoredProcedureQuery `
            	        -connectionString $BISystemConnectionString `
            	        -StoredProcedureName "[Azure].[GetDisabledComponentsRequiredForETL]" `
            	        -StoredProcedureParameters @(
                        @{
                            'ParameterName' = '@JobId';
                            'Direction'=[System.Data.ParameterDirection]'Input';
                            'DbType'=[System.Data.DbType]::Int32;
                            'Value'=$Job.JobId;
                        }
                     );
                 
                ## Start up all components that are required for the job       
                Write-Output "Required Components that should be run:";
                Write-Output "Number of components: $($ComponentsRequiredForTheJob.Rows.count)";
                Write-Output "";
                
                ## Loop over all the Components 
                foreach ($Component in $ComponentsRequiredForTheJob)
                {
                    ## Starts Component Output block 
                    Write-Output "  ### COMPONENT $($Component.ComponentName) ###";
                    
                    ## Displays current component parameters
                    Write-Output "  Component Parameters:";
                    Write-Output "  ComponentType: $($Component.ComponentType);";
                    Write-Output "  ComponentName: $($Component.ComponentName);";
                    Write-Output "  ResourceGroup: $($Component.ResourceGroup);";
                    Write-Output "  ComponentServer: $($Component.ComponentServer);";
                    
                    ## Checks if component is a Virtual Machine
                    If ($Component.ComponentType -eq "SQLVM")
                    {
                        Write-Output "Component is a VM";                       
                        # Shutdown-Start-ARM-VM-Single `
                        #     -VMName $($Component.ComponentName) `
                        #     -OperationID $OperationID `
                        #     -VMResourceGroupName $($Component.ResourceGroup) `
                        #     -IsShutdownMode $($false) `
                        #     -AzureAdminCredentialAssetName $AzureCredentialName;
                    }
                
                    ## Checks if component is a Azure Data Warehouse
                    if ($Component.ComponentType -eq "SQLDW")
                    {
                        Write-output "Component is a SQLDW - starting ADW";
                        # Resume-AzureDataWarehouse `
                        #     -OperationID $OperationID `
                        #     -AutomationAccountCredential $AzureCredentialName `
                        #     -AzureServerName $($Component.ComponentServer) `
                        #     -AzureDatabase $($Component.ComponentName) `
                        #     -AzureDatabaseResourceGroupName $($Component.ResourceGroup);
                    }
                    
                    ## Checks if component is a SQLAgentJob
                    if ($Component.ComponentType -eq "SQLAgentJob")
                    {
                        ## Insert new entry in in JobReadyForETLLog that job is ready for ETL
                        Write-Output "Log that Job is Ready For ETL"
                        $result = ExecuteStoredProcedureNonQuery `
            	                -connectionString $BISystemConnectionString `
            	                -StoredProcedureName "[Azure].[InsertJobReadyForEtlLog]" `
            	                -StoredProcedureParameters @(
                                @{
                                    'ParameterName' = '@JobId';
                                    'Direction'=[System.Data.ParameterDirection]'Input';
                                    'DbType'=[System.Data.DbType]::Int32;
                                    'Value'=$Job.JobId;
                                }
                             );
                    }

                    ## Ends Component Output block
                    Write-Output "  ### COMPONENT END ###";
                    Write-Output "";
                }
                
                ## Updates JobLog that Job is ready for ETL to start
                Write-Output "Writing to JobLog as Started"
                $result = ExecuteStoredProcedureNonQuery `
            	        -connectionString $BISystemConnectionString `
            	        -StoredProcedureName "[Azure].[UpdateJobStartLog]" `
            	        -StoredProcedureParameters @(
                        @{
                            'ParameterName' = '@JobId';
                            'Direction'=[System.Data.ParameterDirection]'Input';
                            'DbType'=[System.Data.DbType]::Int32;
                            'Value'=$Job.JobId;
                        }
                    );
                Write-Output "### JOB END ###";
                Write-Output "";
            }
        }
    }
    catch 
    {
        ## Captures error messages and format the error message
        $FailedItem = $_.Exception.ItemName;
        $ErrorMessage = $_.Exception.Message;
        $MessageBody = "$($FailedItem) has thrown an exception with the following message: $($ErrorMessage)";
        
        ## Sends email notification with the error
        Send-EmailNotification `
		    -OperationID $OperationId `
		    -MessageBody $MessageBody `
		    -NotificationLevel 'WARN';
    }
} 



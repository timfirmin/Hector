<#
.SYNOPSIS
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    Make process componets at dessired state for specified time

.PARAMETER OperationID
    Optional: a guid to use for operation tracking. One is generated if not provided

.NOTES
    ORIGINAL AUTHOR: PS 2017-03-23
#>

workflow ProcessStart
{
    param (

       [Parameter(Mandatory=$False)]
       [string] $OperationID
    )

    Write-Output "#Started ETL-ProcessStart Script";
    ## Capture script start time and inherit script hour
    [System.DateTime] $ScriptStartTime = [System.DateTime]::UtcNow; 
    $ScheduledTime = "$($ScriptStartTime.Hour):00"; 
    #$ScheduledTime = "8:00" - TEST Only - DesiredComponentStateTime from Azure.ProcessComponent table.
    
    if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid();
    }

    ## Retrieve logging database connection variables and creates connection string 
    $AzureLoggingUserName   = Get-AutomationVariable -Name "AzureLoggingUserName";
    $AzureLoggingPassword   = Get-AutomationVariable -Name "AzureLoggingPassword";
    $AzureLoggingServerName = Get-AutomationVariable -Name "AzureLoggingServerName";
    $AzureLoggingDatabase   = Get-AutomationVariable -Name "AzureLoggingDatabaseName";
    
    $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;";

    ## Retrive credentials used to operate on components
    $AzureCredentialName = Get-AutomationVariable -Name "AzureCredentialName";
    
    ## Get Process and components that desired state change is now   
    $ProcessComponents = ExecuteStoredProcedureQuery `
        -connectionString $BISystemConnectionString `
        -StoredProcedureName "[Azure].[GetProcessComponentDesiredStateForTime]" `
        -StoredProcedureParameters @(
            @{
                'ParameterName' = '@DesiredStateTimeStart';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::String;
                'Value'=$ScheduledTime;
            },
            @{
                'ParameterName' = '@DesiredStateTimeEnd';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::String;
                'Value'=$ScheduledTime;
            }
        );
    
    Write-Output "Amount of Processes Retrieved: $($ProcessComponents.Rows.count)";
    
    ## Group Components by process
    $ProcessesComponentsGroups = $ProcessComponents | Group-Object ProcessId;
        
    ## Iterates over existing Processes and updated state of the process
    foreach($ProcessComponentGroup in $ProcessesComponentsGroups)
    {
        ## Assigns components
        [Int32] $ProcessId = [convert]::ToInt32($ProcessComponentGroup.Name,10);
        $Components = $ProcessComponentGroup.Group;
    
        Write-Output "### PROCESS $($ProcessId) ###";
        Write-Output "Number of components for Process: $($Components.Rows.count)";
        Write-Output "";
        
        ## Update Process State to Process waiting for the components
        Write-Output "Updating process state to: Preparing Components.";
        UpdateProcessState -ProcessId $ProcessId -ProcessStateId 2; ## Preparing Components
    
        #Iterates over process components and make sure that they are in the correct state 
        foreach ($Component in $Components)
        {
            ## Starts Component Output block 
            Write-Output "  ### COMPONENT $($Component.ComponentName) ###";
    
            ## Displays current component parameters
            Write-Output "  Component Parameters:";
            Write-Output "  ComponentId: $($Component.ComponentId);";
            Write-Output "  ComponentStateId: $($Component.StateId);";
            Write-Output "  DesiredComponentStateId: $($Component.DesiredComponentStateId);";
            Write-Output "  ComponentType: $($Component.TypeName);";
            Write-Output "  ComponentName: $($Component.Name);";
            Write-Output "  ResourceGroup: $($Component.ResourceGroup);";
            Write-Output "  ComponentServer: $($Component.Server);";
            Write-Output ""
    
            if ($Component.StateId -ne $component.DesiredComponentStateId)
            {
                Write-Output "Changing Component State";
                If ($Component.TypeName -eq "VM")
                {
                    Write-Output "Component is a VM";
                    if($Component.DesiredComponentStateId -eq 4) ## Running
                    {
                        try
                        {
                            ## Update Component state to Starting
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 3; ## Starting
    
                            Shutdown-Start-ARM-VM-Single `
                                -VMName $($Component.ComponentName) `
                                -OperationID $OperationID `
                                -VMResourceGroupName $($Component.ResourceGroup) `
                                -IsShutdownMode $($false) `
                                -AzureAdminCredentialAssetName $AzureCredentialName;
    
                            ## Update Component state to Running
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 4; ## Running
                        }
                        catch
                        {
                            ## Update Component state to Failed
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 6; ## Failed
                        }
                    }
                    elseif($Component.DesiredComponentStateId -eq 2)
                    {
                        try
                        {
                            ## Update Component state to Stopping
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 5; ## Stopping
                     
                            Shutdown-Start-ARM-VM-Single `
                                -VMName $($Component.ComponentName) `
                                -OperationID $OperationID `
                                -VMResourceGroupName $($Component.ResourceGroup) `
                                -IsShutdownMode $($true) `
                                -AzureAdminCredentialAssetName $AzureCredentialName;
                            
                            ## Update Component step to Stopped
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 2; ## Stopped
                        }
                        catch
                        {
                            ## Update Component step to Failed
                           UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 6; ## Failed
                        }
                    }
                    else
                    {
                        Write-Output "NotImplementedException - Handling Desired state has not been implemented in the runbook.";
                    } 
                }
                <# Out of scope
                elseif ($Component.TypeName -eq "Azure DB")
                {
                    ## Runs if Component is Azure DB
                    if($Component.DesiredComponentStateId -eq 4) ## ETL Ready
                    {
                        try
                        {
                            ## Update component as starting 
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 3; ## Starting
    
                            ## Turn on Azure DB
                            Write-Output "Turn on Azure DB";
                            #TODO: Implement runbook

                            ## Update component as starting 
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 4; ## Running
                        }
                        catch
                        {
                            ## Update component as failed
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 6; ## failed
                        }
                    }
                    elseif($Component.DesiredComponentStateId -eq 2)
                    {
    
                        try
                        {
                            ## Update component as starting 
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 5; ## Stopping
    
                            ### Turn off Azure DB
                            Write-Output "Turn off Azure DB";
                            #TODO: Implement runbook
    
                            ### Update component as stopped 
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 4; ## Stoped
                        }
                        catch
                        {
                            ## Update component as failed
                            UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 3; ## failed
                        }
                    }
                    else
                    {
                        Write-Output "NotImplementedException - Handling Desired state has not been implemented in the runbook.";
                    }
                }
                #>
                elseif ($Component.TypeName -eq "SQLAgentJob")
                {
                    ## Checks if component is a SQLAgentJob
                    Write-Output "SQLAgentJob";
                    if($Component.DesiredComponentStateId -eq 4) ## Desired component is ETL Ready and State is stopped
                    {
                        ## Update component as starting 
                        UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 3; ## Starting
                    }
                    else
                    {
                        Write-Output "NotImplementedException - Handling Desired state has not been implemented in the runbook.";
                    }               
                }
                else
                {
                }                       
            }
            Write-Output "  ### COMPONENT END ###";
            Write-Output "";
        }
        Write-Output "### PROCESS END ###";
        Write-Output "";
    }
} 
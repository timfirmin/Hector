<#
.SYNOPSIS
    Azure Automation for the primary PRS BI ETL Architecture

.DESCRIPTION
    Shutdown unused processes components

.PARAMETER OperationID
    Optional: a guid to use for operation tracking. One is generated if not provided

.NOTES
    ORIGINAL AUTHOR: PS 2017-03-27
#>
workflow ProcessEnd
{
     param (

       [Parameter(Mandatory=$False)]
       [string] $OperationID
    )

	Write-Output "#Started ProcessEnd Script";

    if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid();
    }

    ## Retrive asset variable AzureCredentialName that specify name of the asset credentials used to change state of the components.
    $AzureCredentialName = Get-AutomationVariable -Name "AzureCredentialName";

    ## Retrieve logging database connection variables and creates connection string
    $AzureLoggingUserName   = Get-AutomationVariable -Name "AzureLoggingUserName";
    $AzureLoggingPassword   = Get-AutomationVariable -Name "AzureLoggingPassword";
    $AzureLoggingServerName = Get-AutomationVariable -Name "AzureLoggingServerName";
    $AzureLoggingDatabase   = Get-AutomationVariable -Name "AzureLoggingDatabaseName"; 
    $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;";

    ## Get ProcessComponents that are ready to be shutdown
    $ProcessComponents = ExecuteStoredProcedureQuery -connectionString $BISystemConnectionString -StoredProcedureName "[Azure].[GetComponentsReadyForShutDown]";

    if($ProcessComponents.count -gt 0)
    {
        ## Group Components by process
        $ProcessesComponentsGroups = $ProcessComponents | Group-Object ProcessId;
            
        Write-Output "Amount of Processes Retrieved: $($ProcessesComponentsGroups.Count)";
    
        ## Iterates over existing Processes and updated state of the process
        foreach($ProcessComponentGroup in $ProcessesComponentsGroups)
        {
            ## Assigns components
            [Int32] $ProcessId = [convert]::ToInt32($ProcessComponentGroup.Name,10);
            $Components = $ProcessComponentGroup.Group;

            Write-Output "### PROCESS $($ProcessId) ###";
            Write-Output "Number of components for Process: $($Components.Rows.count)";
            Write-Output "";
            
            ## Update Process State to: Process Components stopping
            Write-Output "Updating process state to: Process Components stopping.";
            UpdateProcessState -ProcessId $ProcessId -ProcessStateId 5; ## Releasing components
    
            ## Iterates over process components and make sure that they are in the correct state 
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
        
                If ($Component.TypeName -eq "VM")
                {
                    try
                    {
                        ## Update Component state to Stopping
                        UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 5; ## Stopping
                        
                        #Write-Output "TURNING OFF VM...";
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
                <# Out of scope
                elseif ($Component.TypeName -eq "Azure DB")
                {
                    try
                    {
                       ## Update component as starting 
                        UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 5; ## Stopping
    
                        ### Turn off Azure DB
                        Write-Output "TURNING OFF Azure DB...";
    
                        ## Update component as stopped 
                        UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 2; ## Stoped
                    }
                    catch
                    {
                        ## Update component as failed
                        UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 6; ## failed
                    }                     
                }
                #>
                elseif ($Component.TypeName -eq "SQLAgentJob")
                {
                    ## Checks if component is a SQLAgentJob
                    Write-Output "SQLAgentJob";
                    try
                    {
                        ## Update component as stopped 
                        UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 2; ## Stopped
                    }
                    catch
                    {
                        UpdateComponentState -ComponentId $Component.ComponentId -ComponentStateId 6; ## Failed
                    }
                }               
                else
                {
                    Write-Output "$($Component.TypeName) is not supported"
                }                                 
                Write-Output "  ### COMPONENT END ###";
                Write-Output "";
            }
            
            ## Updates Process state to process components ready
            Write-Output "Updating process state to: Stopped."
            UpdateProcessState -ProcessId $ProcessId -ProcessStateId 1; ## Stopped
        
            Write-Output "### PROCESS END ###";
            Write-Output "";
        }
    }
    else
    {
        Write-Output "Amount of Processes Retrieved: 0";
    }
};
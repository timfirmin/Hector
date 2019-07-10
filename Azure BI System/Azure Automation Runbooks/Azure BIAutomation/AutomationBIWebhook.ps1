workflow AutomationBIWebhook
{
    Param (
        [object]$WebHookData
    )

    #---------------------------------------
    #Logging
    $BISystemConnectionString = Get-AutomationVariable -Name '$BIAutomation_BISystemConnectionString';
        ExecuteStoredProcedureNonQuery `
                -connectionString $BISystemConnectionString `
                -StoredProcedureName "Azure.InsertRunbookExecutionLog" `
                -StoredProcedureParameters @(
                @{
                    'ParameterName' = '@Name';
                    'Direction'=[System.Data.ParameterDirection]'Input';
                    'DbType'=[System.Data.DbType]::String;
                    'Value'="AutomationBIWebhook";
                },
                @{
                    'ParameterName' = '@Status';
                    'Direction'=[System.Data.ParameterDirection]'Input';
                    'DbType'=[System.Data.DbType]::Int16;
                    'Value'= 1;
                }
             );
    #---------------------------------------

    Write-Output "$(Get-Date) - ### Starting execution of AutomationBIWebhook runbook.";
    $RunbookName = "AutomationBI";


    ## Gets parameters from the webhook body
    if ($WebHookData -ne $null)
    {
        ## Getting Json data from Request Body and converting to body object
        $WebhookDataObject = ConvertFrom-JSON $webhookdata.RequestBody;

        ## Obtain Process name from webhook
        Write-Output "$(Get-Date) - Obtaining webhook data - ProcessName: $($WebhookDataObject.ProcessName)";
        $ProcessName = $WebhookDataObject.ProcessName;
        Write-Output "$(Get-Date) - Obtaining webhook data - ScheduleDate: $($WebhookDataObject.ScheduleDate)";
        $ScheduleDate = $WebhookDataObject.ScheduleDate;

        $AccountName = "AZP-MS-AUT-P002-CostManagement - Runbooks";
        $ResourceGroupName = "AZP-RG-AUTOMATION";

        ## Executes StartStop runnbook with the parameters
        $params = @{"ProcessName"=$ProcessName;"ScheduleDate"=$ScheduleDate;};
        Write-Output "$(Get-Date) - # Starting execution of $($RunbookName) runbook.";
        
        $CredentialAssetName = "cmCredential";
        $Cred = Get-AutomationPSCredential -Name $CredentialAssetName;

        if($Cred -ne $null)
        {
            Add-AzureRmAccount -Credential $Cred
            
            try
            {
                AutomationBI -ProcessName $ProcessName -ScheduleDate $ScheduleDate; 
                Write-Output "$(Get-Date) -Sucessfully run AutomationBI runbook with ProcessName:$($ProcessName), Date: $($ScheduleDate)";
            }
            catch
            {
                Write-Output "$(Get-Date) -Exception was raised when trying to call AutomationBI runbook with ProcessName:$($ProcessName), Date: $($ScheduleDate)";
                throw;
            }
        }
        else
        {
            Write-Output "$(Get-Date) - Can not identify load credentials named $($CredentialAssetName)";
        }
        
        Write-Output "$(Get-Date) - # Execution of $($RunbookName) runbook- Succeded";
    }
    else
    {
        Write-Output "$(Get-Date) - # Execution of $($RunbookName) runbook- Failed";
        throw "Exception happended during the execution of the script.";
    }
    
    Write-Output "$(Get-Date) - ### Execution of AutomationBIWebhook runbook finished.";

    #---------------------------------------
     #Logging
    ExecuteStoredProcedureNonQuery `
                -connectionString $BISystemConnectionString `
                -StoredProcedureName "Azure.InsertRunbookExecutionLog" `
                -StoredProcedureParameters @(
                @{
                    'ParameterName' = '@Name';
                    'Direction'=[System.Data.ParameterDirection]'Input';
                    'DbType'=[System.Data.DbType]::String;
                    'Value'="AutomationBIWebhook";
                },
                @{
                    'ParameterName' = '@Status';
                    'Direction'=[System.Data.ParameterDirection]'Input';
                    'DbType'=[System.Data.DbType]::Int16;
                    'Value'= 2;
                }
             );
    #---------------------------------------
    Write-Output $Result;
}
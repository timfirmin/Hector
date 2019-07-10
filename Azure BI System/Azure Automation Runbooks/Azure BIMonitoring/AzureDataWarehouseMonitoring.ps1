workflow AzureDataWarehouseMonitoring
{
    Write-Output "### $(Get-Date) - Script AzureDataWarehouseMonitoring is starting";

    ## Obtain variables from Assets 
    [String] $BISystemConnectionString = Get-AutomationVariable -Name "BIAutomation_BISystemConnectionString";
    [Int32] $CheckTimeSpanInMinutes = Get-AutomationVariable -Name "BIMonitoring_CheckTimeSpanInMinutes";

    ## Setup Local Config Variales
    $CredentialAssetName =  "cmCredential"; 
    $AzureDataWarehouseConnectionStringTemplate ="Server=%SERVER_NAME%.database.windows.net;Database=%DATABASE_NAME%;User ID=%USER%;Password=%PASSWORD%;Trusted_Connection=False;Encrypt=True;";

    $SMTPsender = "svc-AZP-MS-AUT-P002@prsformusic.com";

    $IsMonitoringActiveAssetVariableName = "BIMonitoring_IsActive";
    $IsMonitoringAcive = Get-AutomationVariable -Name $IsMonitoringActiveAssetVariableName;

    if ($IsMonitoringAcive -eq $null)
    {
        Write-Output "$(Get-Date) - Flag $($IsMonitoringActiveAssetVariableName) could not be found in Automation Assets.";
        $IsMonitoringAcive = $false;
    }

    ## Setup Proxy user in ADW to execute Check query about active queries
    $ADWProxyUser =  @{ UserName = "PRSBIDevValidation"; Password = "%KU&£RI&*U*(N$£Iii7C"};
    #$ADWProxyUser =  @{ UserName = 'PRS\SQLProxyBIDev'; Password = 'G927cr!952sY$Tdek*v9fz3'};

    ## Get the credential with the above name from the Automation Asset store
    $Cred = Get-AutomationPSCredential -Name $CredentialAssetName;
    if(!$Cred)
    {
        Write-Output "$(Get-Date) - Could not find an Automation Credential Asset named '$($CredentialAssetName)'. Make sure you have created one in this Automation Account.";
    }
    else
    {
        Write-Output "$(Get-Date) - Credentials okay";
    }

    ## Iniatilize list of Details datawarehouses for notification receipients
    $NotificationDetails = @();

    ## Check if monitoring is active
    if ($IsMonitoringAcive -eq $true)
    {
        ## Obtain list of ADW
        $AzureDataWarehouses = ExecuteStoredProcedureQuery `
            -connectionString $BISystemConnectionString `
            -StoredProcedureName "[Azure].[GetComponentsByType]" `
            -StoredProcedureParameters @(
            @{
                'ParameterName' = "@ComponentTypeName";
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::String;
                'Value'="Azure Data Warehouse"; ## Needs to be consistent with Azure.ComponentType table for Azure Data Warehouse type
            }
        );

        Write-Output "$(Get-Date) - Found: $($AzureDataWarehouses.Rows) Azure Data Warehouses";

        ## Login to Azure Account
        Write-Output "$(Get-Date) - Connecting to Azure Account...";
        Add-AzureRmAccount -Credential $Cred;
        Write-Output "$(Get-Date) - Connected.";

        ## Interate over returned azure data $AzureDataWarehouses
        foreach($AzureDataWarehouse in $AzureDataWarehouses)
        {
            $CurrentAzureDataWarehouseParameters = @{
                    'ResourceGroupName' = $AzureDataWarehouse.ResourceGroup;
                    'ServerName' = $AzureDataWarehouse.ServerName.ToLower(); ##required to be lowercase
                    'DatabaseName' = $AzureDataWarehouse.DatabaseName; ##required to be lowercase
                }  

            ## Get the current status and performance level of the ADW
            Write-Output "$(Get-Date) - Obtaining ADW Statues and Performance for $($AzureDataWarehouse.ServerName) ADW.";
            [String] $AzureDataWarehouseStatus = (Get-AzureRmSqlDatabase @CurrentAzureDataWarehouseParameters | Select Status).Status;
            [String] $AzureDataWarehousePerformance = (Get-AzureRmSqlDatabase @CurrentAzureDataWarehouseParameters | Select CurrentServiceObjectiveName).CurrentServiceObjectiveName;    
            Write-Output "$(Get-Date) - Performance level: $($AzureDataWarehousePerformance)";
            Write-Output "$(Get-Date) - $($AzureDataWarehouse.DatabaseName) ADW status is $($AzureDataWarehouseStatus)"; 
            if($AzureDataWarehouseStatus -eq "Online")
            {
                 ## Check Performance Level
                [String] $IdlePerformanceLevel = "DW200"; ## TODO: Move this to be part of the query (level per ADW) or Asset variable(One generic)
                Write-Output "$(Get-Date) - Comparing current performance level with Notification Performance Level.";
                if($AzureDataWarehousePerformance -ne $IdlePerformanceLevel)
                {
                    ## Generate ADW Connection string    
                    $AzureDataWarehouseConnectionString = $AzureDataWarehouseConnectionStringTemplate `
                        -Replace "%SERVER_NAME%", $AzureDataWarehouse.ServerName `
                        -Replace "%DATABASE_NAME%", $AzureDataWarehouse.DatabaseName `
                        -Replace "%USER%", $ADWProxyUser.UserName `
                        -Replace "%PASSWORD%", $ADWProxyUser.Password;   
                    #Write-Output "ADW Connection string: $($AzureDataWarehouseConnectionString)";  

                    ## Check Azure Data Warehouse if there were active queries withing specified period of time
                    Write-Output "$(Get-Date) - Checking $($AzureDataWarehouse.DatabaseName) if there were active queries within last $($CheckTimeSpanInMinutes) minutes";
                    [Int32] $ActiveQueryWithinCheckTimeSpanInMinutes = -9;   
                    try
                    {
                        ## Reuturns amount of active queries within specified period of time by @CheckTimeSpanInMinutes sql parameter
                        $ActiveQueryWithinCheckTimeSpanInMinutes = InlineScript
                        {
                            $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
                            $SqlConnection.ConnectionString = $using:AzureDataWarehouseConnectionString;
                            $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
                            ## Query that reuturns amount of active queries within specified period of time by @CheckTimeSpanInMinutes sql parameter
                            $SqlQuery="`
                                SELECT Count(*) `
                                FROM sys.dm_pdw_exec_requests r `
                                    JOIN sys.dm_pdw_exec_sessions s ON s.[session_id] = r.[session_id] `
                                WHERE r.[session_id] <> session_id() `
                                    AND ([end_time] > DATEADD(minute,-@CheckTimeSpanInMinutes,sysutcdatetime()) `
                                    OR [end_time] IS NULL) `
                                    AND s.[status] <> 'Closed' `
                                    AND ISNULL(r.[Label],'NULL') <> 'Azure.CheckActiveQueriesCount' `
                                OPTION (LABEL='Azure.CheckActiveQueriesCount');";
                            $SqlCmd.CommandText = $SqlQuery;
                            $SqlCmd.Connection = $SqlConnection;
                            $SqlCmd.CommandType = [System.Data.CommandType]'Text';   
                            $CheckTimeSpanInMinutesParameter = new-object System.Data.SqlClient.SqlParameter;
                            $CheckTimeSpanInMinutesParameter.ParameterName = "@CheckTimeSpanInMinutes";
                            $CheckTimeSpanInMinutesParameter.Direction = [System.Data.ParameterDirection]'Input';
                            $CheckTimeSpanInMinutesParameter.DbType = [System.Data.DbType]::Int32;
                            $CheckTimeSpanInMinutesParameter.Value = $using:CheckTimeSpanInMinutes;
                            $SqlCmd.Parameters.Add($CheckTimeSpanInMinutesParameter) >> $null;   
                            $SqlConnection.Open();
                            $Result = $SqlCmd.ExecuteScalar();
                            $SqlConnection.Close();
                            Write-Output $Result;
                        }
                    }
                    catch
                    {
                        Write-Output "$(Get-Date) - Checking of active queries failed.";
                    }    
                    if($ActiveQueryWithinCheckTimeSpanInMinutes -eq 0)
                    {
                        ## Gets Notification Receipients
                        Write-Output "$(Get-Date) - Getting Notification Receipients.";
                        $NotificationReceipients = ExecuteStoredProcedureQuery `
                            -connectionString $BISystemConnectionString `
                            -StoredProcedureName "[Azure].[GetNotificationReceipients]" `
                            -StoredProcedureParameters @();

                        foreach($Receipient in $NotificationReceipients)
                        {
                            Write-Output "$(Get-Date) - Adding Receipient to notification list: $($Receipient.Email), $($AzureDataWarehouse.DatabaseName), $($AzureDataWarehousePerformance)";
                            ## Add Receipient to list of Receipients that will be notified
                            $NotificationDetails += @{ ReceipientName = $Receipient.Name; ReceipientEmail=$Receipient.Email; DatabaseName = $AzureDataWarehouse.DatabaseName; DatabasePerformance = $AzureDataWarehousePerformance };
                        }
                    }
                    else
                    {
                        Write-Output "$(Get-Date) - There was $($ActiveQueryWithinCheckTimeSpanInMinutes) active queries in ADW in last $($CheckTimeSpanInMinutes) minutes - Skiping notifying as ADW is considered as in use.";
                    }
                }
            }
            else
            {
                Write-Output "$(Get-Date) - Azure Data Warehouse $($AzureDataWarehouse.DatabaseName) is off.";
            }
        }
    }
    else
    {
        ## Monitoring is not active message
        Write-Output "Monitoring is not active. Check $($IsMonitoringActiveAssetVariableName) variable flag";
    }
    ## Send Emails to the list
    foreach ($NotificationDetail in $NotificationDetails )
    {
        ## Sends notification to the people for notification list for all ADW
        ## This can be extended to group by $NotificationDetail.Email and send one email per Receipient   
        Write-Output "$(Get-Date) - Sending Notification to $($NotificationDetail.ReceipientEmail) - $($NotificationDetail.DatabaseName)";
        if($NotificationDetail.ReceipientEmail -ne $null)
        {
            $SMTPrecipient = $NotificationDetail.ReceipientEmail
            $SMTPbody = New-Object System.Collections.Generic.List[System.Object]
            $SMTPsubject = "Azure Data Warehouse Monitoring - $($NotificationDetail.DatabaseName) - $(Get-Date)";
            
            ## This could be replaced by HTML
            $SMTPbody += "Hi $($NotificationDetail.ReceipientName)`n`r";
            $SMTPbody += "`n`r";
            $SMTPbody += "Azure Data Warehouse - $($NotificationDetail.DatabaseName) is Online and scaled to $($NotificationDetail.DatabasePerformance), but has not been used for last $($CheckTimeSpanInMinutes) minutes.`n`r";
            $SMTPbody += "`n`r";
            $SMTPbody += "Thank You`n`r";
            $SMTPbody += "BIMonitoringTeam";

            Send-MailMessage -To $SMTPRecipient -From $SMTPSender -Subject $SMTPsubject -Body $SMTPbody -UseSSL -Port 587 -SMTPserver 'smtp.office365.com' -Credential $Cred
        }
        else
        {
            Write-Output "$(Get-Date) - Exception occured. Receipent Email is null.";
        }
    }

    Write-Output "### $(Get-Date) - Script AzureDataWarehouseMonitoring is finished";
}
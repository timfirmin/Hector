workflow AutomationBIOff
{
    #Setup/Get variables
    $ShouldAutomationRun = Get-AutomationVariable -Name 'BIAutomation_ShouldAutomationRun';
    $BISystemConnectionString = Get-AutomationVariable -Name '$BIAutomation_BISystemConnectionString';
    $ScheduleDate = Get-Date;
    $CurrentTime =  Get-Date -format "HH:mm:ss";

    #Check if Automation should runbook
    if($ShouldAutomationRun)
    {
        #Query BISystem to check Shutdown window - Only way to support output parameters
        $IsWithinShutdownWindow = $null; ## TODO: To be refactored to do BISystemCall
        $IsWithinShutdownWindow = InlineScript{
            $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
            $SqlConnection.ConnectionString = $using:BISystemConnectionString;
            $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
            $SqlCmd.CommandText = "[Azure].[CheckTimeIfInShutdownWindow]"
            $SqlCmd.Connection = $SqlConnection
            $SqlCmd.CommandType = [System.Data.CommandType]'StoredProcedure';

            #Input Parameter
            $AssertedTimeParameter = new-object System.Data.SqlClient.SqlParameter;
            $AssertedTimeParameter.ParameterName = "@AssertedTime";
            $AssertedTimeParameter.Direction = [System.Data.ParameterDirection]'Input';
            $AssertedTimeParameter.DbType = [System.Data.DbType]'Time';
            $AssertedTimeParameter.Value = $using:CurrentTime;

            #Output Parameter
            $InShutdownWindowParameter = new-object System.Data.SqlClient.SqlParameter;
            $InShutdownWindowParameter.ParameterName = "@InShutdownWindow";
            $InShutdownWindowParameter.Direction = [System.Data.ParameterDirection]'Output';
            $InShutdownWindowParameter.DbType = [System.Data.DbType]'Boolean';

            $SqlCmd.Parameters.Add($AssertedTimeParameter) >> $null;
            $SqlCmd.Parameters.Add($InShutdownWindowParameter) >> $null;

            $SqlConnection.Open();
            $result = $SqlCmd.ExecuteNonQuery();
            $IsWithinShutdownWindowResult = $SqlCmd.Parameters["@InShutdownWindow"].Value;
            $SqlConnection.Close();
            Write-Output $IsWithinShutdownWindowResult;
        }
        Write-Output "IsWithinShutdownWindow:$($IsWithinShutdownWindow)";

        if($IsWithinShutdownWindow)
        {
            #Query BISystem to get components that can be swithced off 
            Write-Output "$(Get-Date) - Query BISystem to get components that can be swithced off.";
            
            $ResourcesTags = ExecuteStoredProcedureQuery `
                -connectionString $BISystemConnectionString `
                -StoredProcedureName "[Azure].[GetComponentsForShutdown]" `
                -StoredProcedureParameters @(
                    @{
                        'ParameterName' = '@Date';
                        'Direction'=[System.Data.ParameterDirection]'Input';
                        'DbType'=[System.Data.DbType]::Date;
                        'Value'= $ScheduleDate;
                    }
                );

            Write-Output "$(Get-Date) - Returned $($ResourcesTags.Rows.Count) Tags.";
            #Iterate over all components and call StartStop runbook with the switch off flag set to true
            foreach($ResourceTag in $ResourcesTags)
            {
                try
                {
                    Write-Output "$(Get-Date) - Running StartStop Runbook for $($ResourceTag.ComponentTag) to switch components off.";
                     #StartStop -Shutdown $true -$Tag $ResourceTag.ComponentTag
                }
                catch
                {
                    Write-Output "$(Get-Date) - Running StartStop Runbook for $($ResourceTag.ComponentTag) to switch components off Failed.";
                };
            };
        }
        else
        {
            #Skip execution of the shut down as it is outside of should down window
            Write-Output "$(Get-Date) - Current time is outside shutdown window, please check current shutdown window in BISystem.";
        }
    }
    else
    {
        #Display message that automation has been overrided in the 
        Write-Output "$(Get-Date) - Automation skept execution as BIAutomation_ShouldAutomationRun environment variable has been overrided to: $($ShouldAutomationRun)";
    }
    #Call Start stop runbook for all tags that can be switched off
}



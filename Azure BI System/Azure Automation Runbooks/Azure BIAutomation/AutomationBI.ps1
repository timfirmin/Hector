workflow AutomationBI
{
    ## Definition of the parameters
    Param (
        [Parameter(Mandatory=$True)]
        [string] $ProcessName,

        [Parameter(Mandatory=$True)]
        [DateTime] $ScheduleDate
    )
    $RunbookNameForLog = "AutomtionBI";

    ##Get -ExecutionId
    [String] $ExecutionId = [GUID]::NewGuid()

    #$ScheduleDate = Get-Date;
    Write-Output "$(Get-Date) - ### Starting Script: AutomationBI";

    ## Current Parameters
    Write-Output "$(Get-Date) - Execution Parameters-ProcessName: $($ProcessName)";
    Write-Output "$(Get-Date) - Execution Parameters-ScheduleDate: $($ScheduleDate)";

    ## Getting variables from Assets
    Write-Output "$(Get-Date) - Getting variables from Assets.";
    $ShouldAutomationRun = Get-AutomationVariable -Name 'BIAutomation_ShouldAutomationRun';
    $BISystemConnectionString = Get-AutomationVariable -Name '$BIAutomation_BISystemConnectionString';
    #$BISystemConnectionString ='Server=azp-ms-sql-d002.database.windows.net;Database=BISystemDev;User ID=PRSBIDevValidation;Password=%KU&£RI&*U*(N$£Iii7C';

    ## Log event in BISystem
    LogEvent -Status 2 -ExecutionId $ExecutionId -EventMessage "Starting Script for ProcessName: $($ProcessName) ,ScheduleDate: $($ScheduleDate)" -SenderName "AutomtionBI";

    if($ShouldAutomationRun -eq $true)
    {
        Write-Output "$(Get-Date) - Asset Variable BIAutomation_ShouldAutomationRun is set to $($ShouldAutomationRun)- Script will run.";

        ## Gets list of resources to Turn On for a process defined by ProcessName
        Write-Output "$(Get-Date) - Geting list of resources from BISystem."
        $ResourcesTags = ExecuteStoredProcedureQuery `
            -connectionString $BISystemConnectionString `
            -StoredProcedureName "[Azure].[GetProcessComponents]" `
            -StoredProcedureParameters @(
            @{
                'ParameterName' = '@ProcessName';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::String;
                'Value'=$ProcessName;
            },
            @{
                'ParameterName' = '@Date';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::String;
                'Value'= $ScheduleDate;
            }
        );

        Write-Output "$(Get-Date) - Returned $($ResourcesTags.Rows.Count) Tags.";
        try
        {
            foreach($ResourceTag in $ResourcesTags)
            {
                [String] $CurrentTag = $ResourceTag.ComponentTag
                Write-Output "$(Get-Date) - Executing StartStop Runbook for $($CurrentTag) to switch components on.";
                Write-Output 'Starting StartStop for'
                <#
                StartStop `
                    -Tag $CurrentTag `
                    -Credential 'cmCredential' `
                    -shutdown $false `
                    -weekendOverride $false;
                    
                #>
                Write-Output "$(Get-Date) - Executed StartStop Runbook for $($CurrentTag) to switch components on.";
            };

            ## Update status -Success
            Write-Output "$(Get-Date) - Updating status of the schedule - Success";
            ExecuteStoredProcedureNonQuery `
                -connectionString $BISystemConnectionString `
                -StoredProcedureName "[Azure].[UpdateProcessScheduleStatus]" `
                -StoredProcedureParameters @(
                @{
                    'ParameterName' = '@ProcessName';
                    'Direction'=[System.Data.ParameterDirection]'Input';
                    'DbType'=[System.Data.DbType]::String;
                    'Value'=$ProcessName;
                },
                @{
                    'ParameterName' = '@Date';
                    'Direction'=[System.Data.ParameterDirection]'Input';
                    'DbType'=[System.Data.DbType]::Date;
                    'Value'= $ScheduleDate;
                },
                @{
                    'ParameterName' = '@Status';
                    'Direction'=[System.Data.ParameterDirection]'Input';
                    'DbType'=[System.Data.DbType]::Int32;
                    'Value'= 2;
                }
             );
        }
        catch
        {
            ## Update status -Failure
            Write-Output "$(Get-Date) - Updating status of the schedule-Failure.";
            ExecuteStoredProcedureNonQuery `
                -connectionString $BISystemConnectionString `
                -StoredProcedureName "[Azure].[UpdateProcessScheduleStatus]" `
                -StoredProcedureParameters @(
                    @{
                        'ParameterName' = '@ProcessName';
                        'Direction'=[System.Data.ParameterDirection]'Input';
                        'DbType'=[System.Data.DbType]::String;
                        'Value'=$ProcessName;
                    },
                    @{
                        'ParameterName' = '@Date';
                        'Direction'=[System.Data.ParameterDirection]'Input';
                        'DbType'=[System.Data.DbType]::Date;
                        'Value'= $ScheduleDate;
                    },
                    @{
                        'ParameterName' = '@Status';
                        'Direction'=[System.Data.ParameterDirection]'Input';
                        'DbType'=[System.Data.DbType]::Int32;
                        'Value'= 3;
                    }
                );
            ## Log event in BISystem
            LogEvent -Status 3 -ExecutionId $ExecutionId -EventMessage "Error happend while swithing on one of the tags." -SenderName "AutomtionBI";
        }
    }
    else
    {
        Write-Output "$(Get-Date) - Asset Variable BIAutomation_ShouldAutomationRun is set to $($ShouldAutomationRun) or null- Script will skip.";
    }
    ## Log event in BISystem
    LogEvent -Status 2 -ExecutionId $ExecutionId -EventMessage "Finished Script for ProcessName: $($ProcessName) , $($ScheduleDate)" -SenderName "AutomtionBI";

    Write-Output "$(Get-Date) - ### End of script:AutomationBI."
}
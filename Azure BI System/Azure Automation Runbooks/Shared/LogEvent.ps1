workflow LogEvent
{
    Param (
        [Parameter(Mandatory=$True)]
        [String] $SenderName,

        [Parameter(Mandatory=$True)]
        [String] $ExecutionId,

        [Parameter(Mandatory=$True)]
        [String] $EventMessage,

        [Parameter(Mandatory=$True)]
        [Int] $Status
    )

    Write-Output "$(Get-Date) - ### Starting Script: LogEvent";

    ## Current Parameters
    Write-Output "$(Get-Date) - Logging Message to BISystem. RunbookName: $($SenderName)";
    Write-Output "$(Get-Date) - Logging Message to BISystem. ExecutionId: $($ExecutionId)";  
    Write-Output "$(Get-Date) - Logging Message to BISystem. Message: $($EventMessage)";
    Write-Output "$(Get-Date) - Logging Message to BISystem. Status: $($Status)";

    $BISystemConnectionString = Get-AutomationVariable -Name '$BIAutomation_BISystemConnectionString';

    ##TODO Retry Logic to be added if required
    try
    {
        ExecuteStoredProcedureNonQuery `
            -connectionString $BISystemConnectionString `
            -StoredProcedureName "Azure.InsertEventLog" `
            -StoredProcedureParameters @(
            @{
                'ParameterName' = '@SenderName';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::String;
                'Value'=$SenderName;
            },
            @{
                'ParameterName' = '@ExecutionId';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::String;
                'Value'=$ExecutionId;
            },
            @{
                'ParameterName' = '@EventMessage';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::String;
                'Value'=$EventMessage;
            },
            @{
                'ParameterName' = '@Status';
                'Direction'=[System.Data.ParameterDirection]'Input';
                'DbType'=[System.Data.DbType]::Int16;
                'Value'= 1;
            }
        );
        Write-Output "$(Get-Date) - ### Finished Script: LogEvent - Success";
    }
    catch
    {
        Write-Output "$(Get-Date) - ### Finished Script: LogEvent - Failure";
    }
}
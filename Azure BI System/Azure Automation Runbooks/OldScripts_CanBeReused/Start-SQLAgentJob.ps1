<#
.SYNOPSIS 
    Azure Automation to start the given SQL Agent Job on the default SSIS Orchestration Server for this Automation account

.DESCRIPTION
   Simply connects to the given SSIS server, runs a stored procedure to issue a start command to a given SQL Agent job. Could be improved with further error handing and "in-flight" detection

.PARAMETER JobName
    The Agent Job to be executed
    TestAA


.NOTES
    ORIGINAL AUTHOR: Simon Whiteley 2016-10-12
#>

workflow Start-SQLAgentJob
{

param (
    [Parameter(Mandatory=$True)] 
    [string]
    $SqlAgentJobName,

    [Parameter(Mandatory=$True)]
    [String]
    $SSISUserName,

    [Parameter(Mandatory=$True)]
    [String]
    $SSISPassword,

    [Parameter(Mandatory=$True)]
    [String]
    $SSISServerName,

    [Parameter(Mandatory=$True)]
    [string]
    $SSISDatabaseName
)


#First we need to find the last execution of the job to make sure we're checking for the most recent results
#This is due to a limitation with the SQL table msdb.dbo.sysjobhistory which will not have any record of the
#job until after it has completed at least one step



<##  Setting local variables ##>
$ActionName = "Start SqlAgentJob";
$ActionDescription = "Starting SQLAgent Job name $SqlAgentJobName";

$Result = InlineScript
{
    
    ##  Parameters passed:
    Write-Output "Parameters passed:";
    Write-Output "SqlAgentJobName: $using:SqlAgentJobName";
    Write-Output "SSISUserName: $using:SSISUserName";
    Write-Output "SSISPassword: $using:SSISPassword";
    Write-Output "SSISServerName: $using:SSISServerName";
    Write-Output "SSISDatabaseName: $using:SSISDatabaseName";

    <## TEST VARIABLE ONLY!!!! ##>
    $sqlAgentJobResult = 0; #TODO: TO DELETE

    # Connect to our SSISDB where the job lives
    $AzureSQLDBConnection = New-Object System.Data.SqlClient.SqlConnection;
    $AzureSQLDBConnection.ConnectionString = "Server= $using:SSISServerName; Database= $using:SSISDatabaseName; User ID= $using:SSISUserName; Password= $using:SSISPassword;";

    Write-Output $AzureSQLDBConnection.ConnectionString
    try 
    {
        # Open new SQL Connection 
        $AzureSQLDBConnection.Open();

        ## Create Command Obj For Agent Job 
        $sqlCommand = $AzureSQLDBConnection.CreateCommand();
        $sqlCommand.CommandText = "EXEC dbo.sp_start_job N'$using:SqlAgentJobName'";
        write-output $sqlCommand.CommandText

        ## Exec Command For Agent Job
        $sqlAgentJobResult = $sqlCommand.ExecuteScalar(); 
        write-output $sqlAgentJobResult

        ## Checks if sql agent Job was started corectly 
        if($sqlAgentJobResult -ne 0)
        {
            throw [System.IO.Exception] "Running Sql Agent named $SqlAgentJobName has failed failed with Error number: $sqlAgentJobResult.";
        }

        <## Log Scaling Action as a success ##>
        #Log-EndAction  -ObjectName $SSISServerName -ActionName $ActionName -ActionResult 2;
    }
    catch [Exception] 
    {
        $AzureSQLDBConnection.Close();

        <## Log Scaling Action as a failed ##>
        #Log-EndAction  -ObjectName $SSISServerName -ActionName $ActionName -ActionResult 3;

        Write-Error $_.Exception.Message;
        
        <## Rethrow original exeption ##>
        throw;
        
        #return $_.Exception.Message;
    }

    <## Close Connection ##>
    $AzureSQLDBConnection.Close();
}
write-output $Result
}


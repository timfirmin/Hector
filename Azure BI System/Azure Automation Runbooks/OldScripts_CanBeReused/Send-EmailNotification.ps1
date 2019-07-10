<#  
.SYNOPSIS  
    Sends email to group of stakeholders
  
.DESCRIPTION  
    Uses BISystem configuration data to define a group of stakeholders and constructs an email to be send to this group

.PARAMETER MessageBody
    Mandatory:
    The message to be sent within the notification email body

.PARAMETER NotificationLevel
    Mandatory:
    This defines the group of stakeholders that should be included in the notification, driven by BISystem configuration tables
    Accepted values:
        INFO
        WARN

.PARAMETER $OperationID
    Optional:
    Specifies guid that identifies root runbook

.PARAMETER
    Optional:
    Spcifies time between resends

.EXAMPLE  
  
.NOTES  
    PRS Author: Adatis - SAW, 2016-09-15

    Action Logging:
    ActionResult 1 -starting action
    ActionResult 2 -sucess
    ActionResult 3 -failure
#> 
workflow Send-EmailNotification
{
        param (
        [parameter(Mandatory=$true)]
        [string] $MessageBody,

        [parameter(Mandatory=$true)]
        [string] $NotificationLevel,
        
        ## Unique ID for this execution
        [parameter(Mandatory=$false)]
        [string] $OperationID,

        [parameter(Mandatory=$false)]
        [Int32] $ResendOnFailureTimeInSec = 60

    )

    ## Generate OperationID if not passed by other process
    if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid().ToString();
    }

    ## Retrieve our logging database connection variables
    $AzureLoggingUserName   = Get-AutomationVariable -Name "AzureLoggingUserName";
    $AzureLoggingPassword   = Get-AutomationVariable -Name "AzureLoggingPassword";
    $AzureLoggingServerName = Get-AutomationVariable -Name "AzureLoggingServerName";
    $AzureLoggingDatabase   = Get-AutomationVariable -Name "AzureLoggingDatabaseName";

    $BISystemConnectionString = "Server = $AzureLoggingServerName; Database = $AzureLoggingDatabase; User ID = $AzureLoggingUserName; Password = $AzureLoggingPassword;";

    ## Assigns local variables
    $ObjectName = "$($SqlServerName).$($DatabaseName)";
    $ActionName = "Sending Email";
    $ActionDescription = "Sending Email notification";

    try
    {
        ## Logs action for sending email
        Log-StartAction -ObjectName $ObjectName -ActionName $ActionName -ActionDescription $ActionDescription -ActionResult 1 -OperationID $OperationID; #ActionResult 1 - Starting action

        ## Run a BISystem stored proc to return the configuration parameters for this given run
        Write-Output "Fetching SMTP Configuration from BISystem";
        $result = ExecuteStoredProcedureQuery `
            -connectionString $BISystemConnectionString `
            -StoredProcedureName "[Azure].[GetConfiguration]" `
            -StoredProcedureParameters @(
                @{
                    'ParameterName' = '@Configuration';
                    'Direction'=[System.Data.ParameterDirection]'Input';
                    'DbType'=[System.Data.DbType]::String;
                    'Value'= $NotificationLevel;
                }
            );

        Write-Output "Shredding config variables from return dataset";

        ## Loop through the resultset to shred the configuration variables into local variables for later use
        foreach ($Conf in $result)
        {   
                ## Determine which config item we are on and set the relevant variable
                switch -casesensitive ($Conf.ConfigItem) 
                    { 
                        "SMTPServer"  { $SMTPServer = $Conf.Value; }
                        "SMTPPort" { $SMTPPort = $Conf.Value; }
                        "MsgTo" { $MsgTo = $Conf.Value; }
                        "MsgFrom" { $MsgFrom = $Conf.Value;  }
                        "MsgSubject" {  $MsgSubject = $Conf.Value; }
                        "EmailTemplate" { $MsgBody = $Conf.Value; }
                        "SMTPUserName" { $SMTPUserName = $Conf.Value; }
                        "SMTPPassword" { $SMTPPassword = ConvertTo-SecureString $Conf.Value -AsPlainText -Force }
                        default {""}
                    };
        }

        if ($SMTPUserName -eq $null)
        {
            Throw "There is no SMTPUserName configuration in Configuration table";
        }

        if ($SMTPPassword -eq $null)
        {
            Throw "There is no SMTPPassword configuration in Configuration table";
        }

        if ($SMTPServer -eq $null)
        {
            Throw "There is no SMTPServer configuration in Configuration table";
        }

        if ($SMTPPort -eq $null)
        {
            Throw "There is no SMTPPort configuration in Configuration table";
        }

        if ($MsgTo -eq $null)
        {
            Throw "There is no MsgTo configuration in Configuration table";
        }

        if ($MsgFrom -eq $null)
        {       
            Throw "There is no MsgFrom configuration in Configuration table";
        }

        if ($MsgSubject -eq $null)
        {
            Throw "There is no MsgSubject configuration in Configuration table";
        }

        if ($MsgBody -eq $null)
        {
            Throw "There is no MsgBody configuration in Configuration table";
        }

        Write-Output "Inserting message body into email template";
        ## Embedd our notification message within the HTML Email template body, looking specifically for "%TEXTMARKER"
        $EmailMessage = InlineScript
        {
                $MsgBod = $using:MsgBody;
                $MessageBod = $using:MessageBody;
                $MsgBod.Replace("%TEXTMARKER%", $MessageBod);
        }
     
        ## Creating credentials from configuration properties
        $Credential = New-Object `
	        -TypeName System.Management.Automation.PSCredential `
	        -ArgumentList $SMTPUserName, $SMTPPassword;

        ## Try send the email notification using the supplied string and the configuration variables
        try
        {
            Write-Output "Attempting to send email";

            Send-MailMessage `
                -BodyAsHtml $EmailMessage `
                -Credential $Credential `
                -From $MsgFrom `
                -Subject $MsgSubject `
                -To $MsgTo `
                -Port $SMTPPort `
                -SMTP $SMTPServer `
                -UseSsL `
                -ErrorAction Stop; # In case of error goto catch block

            Write-Output "Mail Notification sent successfully";
        }
        catch
        {
            ## retries sending email once when first time failed

            Write-Output "Sending Email Failed."; 
            Write-Output "Trying to resend Email...";

            Sleep -s $ResendOnFailureTimeInSec;
            Send-MailMessage `
                -BodyAsHtml $EmailMessage `
                -Credential $Credential `
                -From $MsgFrom `
                -Subject $MsgSubject `
                -To $MsgTo `
                -Port $SMTPPort `
                -SMTP $SMTPServer `
                -UseSsL `
                -ErrorAction Stop; # In case of error goto catch block

            Write-Output "Mail Notification re-sent successfully"; 
        }

        ## LogsEnd Action 
        Log-EndAction  -ObjectName $ObjectName -ActionName $ActionName -ActionResult 2;
    }
    catch
    {
        Write-Output "Mail Notification failed";
        ## Logs End Action
        Log-EndAction  -ObjectName $ObjectName -ActionName $ActionName -ActionResult 3;
    }
}
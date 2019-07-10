<#  
.SYNOPSIS   
     Send email containing multiple attachments using optionally using secure SMTP 
.DESCRIPTION  

This runbook sends email with multiple attachments through SMTP or secure SMTP. The attached 
files are constructed in-memory which eliminates the need to use workarounds like leveraging 
'temp' folders on sandbox machines executing runbooks to copy the files first and then use full 
paths to files with 'Send-EmailMessage' cmdlet. The common use case of this runbook is to attach 
files predominately containing text data (example: csv,txt etc files). 

Prereq:     
    1. Automation PS Credential Asset with userid and password to smtp service. 
    
.PARAMETER EmailFrom  
    String email address that will be used as sender
    Example: no-reply@domain.com 
  
.PARAMETER EmailTo 
    String email address of destination  
    Example: target@domain.com

.PARAMETER EmailServer 
    String SMTP server address
    Example: smtp.live.com

.PARAMETER EmailPort 
    String SMTP server port number
    Example: 587
         
.PARAMETER EmailSubject
    String Subject of mail message
    
.PARAMETER EmailFileNames
     Multi-Dimensional Array (String) - Contain name of attached files
     Example: ["Data.csv","ReadMe.txt"]

.PARAMETER EmailFileContents
     Multi-Dimensional Array (String) - Content attach files
     Example: ["vmsize,vmname,servicename","The attached file contain list of vms"]

.PARAMETER EmailCredName 
    String - Name of PS Credential asset
    Example: SMTPCredential


.EXAMPLE  
  Send-EmailWithAttachments "no-reply@domain.com" "target@domain.com" "smtp.live.com" "587" "[VM-GOVERNENCE] List of non-iaas vms" "PFA" $CsvFileNames $csvFileContents (Get-Credential)

.NOTES  
    Author: Razi Rais  
    Website: www.razibinrais.com
    Last Updated: 4/10/2015   

    Updated: Will Parry
    Last Updated: 26/10/2017   
#>

workflow Send-Email
{
    param (
        [Parameter(Mandatory=$true,Position=0)][string]$EmailFrom,
        [Parameter(Mandatory=$true,Position=1)][string[]]$EmailTo,
        [Parameter(Mandatory=$false,Position=2)][string[]]$EmailCc,
        [Parameter(Mandatory=$false,Position=3)][string]$EmailServer = "smtp.office365.com",
        [Parameter(Mandatory=$false,Position=4)][string]$EmailPort = "587",
        [Parameter(Mandatory=$false,Position=5)][boolean]$EmailUseSSL = $true,
        [Parameter(Mandatory=$true,Position=6)][string]$EmailSubject,
        [Parameter(Mandatory=$true,Position=7)][string]$EmailBody,
        [Parameter(Mandatory=$false,Position=8)][string[]]$EmailFileNames,
        [Parameter(Mandatory=$false,Position=9)][string[]]$EmailFileContents,
        [Parameter(Mandatory=$true,Position=10)][string]$EmailCredName,
        [Parameter(Mandatory=$false,Position=11)][string]$EmailPriority = "Low"
    )

    Write-Output "Getting Automation PS Credential."
    Write-Output "from $EmailCredName"
    $cred = Get-AutomationPSCredential -Name $EmailCredName
    if ($cred) {Write-Output "Credential retrieval successful."} else {Write-Warning "Credential retrieval failed."}

    Write-Output "Starting InlineScript."
    inlinescript 
    {
        # Create Attachment File Contents "String"
        Write-Output "Creating Attachment File Contents."
        if ($Using:EmailFileContents) { $strFiles =  $Using:EmailFileContents }

        # Create Mail Addresses - Sender
        Write-Output "Creating Mail Addresses - Sender."
        $sender = New-Object System.Net.Mail.MailAddress($Using:EmailFrom) 

        # Create Message Object
        Write-Output "Creating Message Object."
        $message = New-Object System.Net.Mail.MailMessage
        
        # Add Sender / From Email Address
        Write-Output "Adding From Email Address."
        $message.Sender = $sender
        $message.From = $sender

        # Enumerate ForEach To Recipient
        Write-Output "Creating To Recipients."
        foreach($lrecipient in $Using:EmailTo)
        {
            $recipient = New-Object System.Net.Mail.MailAddress($lrecipient, "Recipient") 
    
            # Add the To Recipient
            $message.To.Add($recipient)
        }

        # Enumerate ForEach CC Recipient
        Write-Output "Creating CC Recipients."
        foreach($lccrecipient in $Using:EmailCc)
        {
            $recipient = New-Object System.Net.Mail.MailAddress($lccrecipient, "Recipient") 
    
            # Add the CC Recipient
            $message.CC.Add($recipient)
        }

        # Set Message Subject
        Write-Output "Adding Message Subject."
        $message.Subject = $Using:EmailSubject
        
        # Set Message Priority - not sure at what level this priority is set or honoured
        Write-Output "Adding Message Priority."
        $message.Priority = [System.Net.Mail.MailPriority]::($Using:EmailPriority)

        # Set Message Body
        Write-Output "Adding Message Body."
        $message.Body = $Using:EmailBody

        # If File Attachments
        if ($strFiles)
        {
            # Enumerate File Attachements
            Write-Output "Adding File Attachments."
            $count = 0;
            foreach($fileName in $Using:EmailFileNames)
            {
                # Prepare file attachment. Create a memory stream
                $memoryStream = New-Object IO.MemoryStream
                [Byte[]]$contentAsBytes = [Text.Encoding]::UTF8.GetBytes($strFiles[$count])
                $memoryStream.Write($contentAsBytes, 0, $contentAsBytes.Length)
                # Set the position to the beginning of the stream.
                [Void]$memoryStream.Seek(0, 'Begin')
                # Create attachment
                $contentType = New-Object Net.Mime.ContentType -Property @{
                    MediaType = [Net.Mime.MediaTypeNames+Application]::Octet
                    Name = $fileName
                }
                $attachment = New-Object Net.Mail.Attachment $memoryStream, $contentType
    
                # Add the attachment
                $message.Attachments.Add($attachment)
            
                $count++;
            }
        }
        $message | select *

        # Create SmtpClient Object
        Write-Output "Creating SmtpClient Object."
        Write-Output "Using EnableSsl is $Using:EmailUseSSL"
        Write-Output "Using Credentials are $Using:cred"
        $smtpClient = New-Object System.Net.Mail.smtpClient($Using:EmailServer,$Using:EmailPort)
        $smtpClient.EnableSsl = $Using:EmailUseSSL
        $smtpClient.Credentials = $Using:cred 
        $smtpClient | select *
        
        # Send Message via SmtpClient
        Write-Output "Sending message via SmtpClient."
        $smtpClient.Send($message)
    }
}

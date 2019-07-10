<#
.SYNOPSIS 
    Sets up the connection to an Azure subscription

.DESCRIPTION
    This runbook sets up a connection to an Azure subscription.

    Depends on the following Azure Runbooks:
        > Write-SQLLog
            URL: http://gallery.technet.microsoft.com/Azure-Automation-SQL-d898babb

    Depends on the following Automation Assets:
        > WKAzureDefaultSubName - Automation Variable asset defining the default subscription 
            name to connect to in the event none is passed as a parameter
        > WKAzureAccount - Automation Credential asset containing Azure connection credentials

.PARAMETER SubscriptionName
    Optional: subscription name to use for the current Azure operations

.PARAMETER OperationID
    Optional: a guid to use for operation tracking. One is generated if not provided

.EXAMPLE
    Connect-WKAzure

.EXAMPLE
    Connect-WKAzure -SubscriptionName "Pay-As-You-Go"

.NOTES
    AUTHOR: Wes Kroesbergen
    LASTEDIT: Oct. 18, 2014 
#>

workflow Connect-WKAzure
{
    Param
    (   
        [Parameter(Mandatory=$false)]
        [String] $SubscriptionName,
        [Parameter(Mandatory=$false)]
        [String] $operationID
    )

    $subName = ""

    if(!$OperationID)
    {
        $OperationID = [GUID]::NewGuid()
    }
    if(!$SubscriptionName)
    {
        # Grab our Azure subscription name
        $subName = Get-AutomationVariable -Name "WKAzureDefaultSubName"
    }
    else {$subName = $SubscriptionName}

    # Grab the credential to use to authenticate to Azure. 
	$cred = Get-AutomationPSCredential -Name "WKAzureAccount"    

    Write-SQLLog -Level 7 -Message "Connecting to Azure..." -RunbookName "Connect-WKAzure" -OperationID $operationID
	# Connect to Azure
	InlineScript {Add-AzureAccount -Credential $using:cred | Out-Null}
    
	# Select the Azure subscription you want to work against
	InlineScript {Select-AzureSubscription -SubscriptionName $using:subName -Verbose:$false | Out-Null }
    Write-SQLLog -Level 7 -Message "Connection to Azure completed!" -RunbookName "Connect-WKAzure" -OperationID $operationID
}
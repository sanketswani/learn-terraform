Param(
    [Int32]$newRUs
)

$automationAccount = "automation-account-001"
$ResourceGroup = "rg-new-weu-nonprod-002"
$accountName = "cosmos-mongo-account-002"
$databaseName = "mydb"
$collectionName = "testColl"

# Ensures you do not inherit an AzContext in your runbook
$null = Disable-AzContextAutosave -Scope Process

# Connect using a Managed Service Identity
try {
    $AzureConnection = (Connect-AzAccount -Identity).context
}
catch {
    Write-Output "There is no system-assigned user identity. Aborting." 
    exit
}

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureConnection.Subscription -DefaultProfile $AzureConnection

Write-Output "================ Updating RUs of collection ========"

# Get cosmos db
Update-AzCosmosDBMongoDBCollectionThroughput -ResourceGroupName $ResourceGroup -AccountName $accountName -DatabaseName $databaseName -Name $collectionName -AutoscaleMaxThroughput $newRUs -DefaultProfile $AzureContext

Write-Output "================ Updated RUs of collection ========="


Write-Output "Account ID of current context: " $AzureContext.Account.Id
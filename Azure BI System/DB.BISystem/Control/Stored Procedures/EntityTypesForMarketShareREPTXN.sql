CREATE PROCEDURE Control.EntityTypesForMarketShareREPTXN

AS 

SELECT EntityTypeID, [Name] FROM Control.EntityType where applicationId = 5
AND [NAME] IN (
'OrcCreationComponent'
,'OrcUsageHeader'
,'OrcUsageComponent'
,'OrcInvoiceUsageComponents'
,'OrcWorkContributorBridge'
,'OrcContributor'
,'OrcAudioVisualContributor'
,'OrcUsageRoyaltyTransactions')


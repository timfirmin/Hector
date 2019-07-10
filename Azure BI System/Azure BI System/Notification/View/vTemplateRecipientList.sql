CREATE view [notification].[vTemplateRecipientList]
as
with recipients as (
	select t.[templateID],r.[recipientEmail],r.[recipientName],r.[friendlyName]
	from [notification].[recipient] r
	join [notification].[templateRecipient] tr on tr.recipientID = r.recipientID
	join [notification].[template] t on t.[templateID] = tr.[templateID] 
)

SELECT DISTINCT templateID
				, recipientList
				, '[' + left(recipientNameList,len(recipientNameList)-1) + ']' [recipientNameList]
				, '[' + left(friendlyNameList,len(friendlyNameList)-1) + ']' [friendlyNameList]
FROM recipients r1
CROSS APPLY ( SELECT [recipientEmail] + ';' 
                     FROM recipients r2
                     WHERE r2.templateID = r1.templateID 
                     ORDER BY [recipientEmail] 
                     FOR XML PATH('') )  D ( recipientList )
CROSS APPLY ( SELECT [recipientName] + ',' 
                     FROM recipients r3
                     WHERE r3.templateID = r1.templateID 
                     ORDER BY [recipientName] 
                     FOR XML PATH('') )  E ( recipientNameList )
CROSS APPLY ( SELECT [friendlyName] + ',' 
                     FROM recipients r4
                     WHERE r4.templateID = r1.templateID 
                     ORDER BY [recipientName] 
                     FOR XML PATH('') )  F ( friendlyNameList )


GO



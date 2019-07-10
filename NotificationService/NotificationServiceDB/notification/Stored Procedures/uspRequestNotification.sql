CREATE proc [notification].[uspRequestNotification]
@notificationTemplate varchar(100),
@notificationSubject nvarchar(255),
@notificationBody nvarchar(max),
@reportLink varchar(1000) = null
as
declare @retval int = 0

if exists (select templateID from [notification].[template] where [templateName]=@notificationTemplate)
begin
insert [notification].[notification]([templateID],[notificationSubject],[notificationBody],[reportLink],[suser_name])
select	[templateID]
		,@notificationSubject
		,@notificationBody
		,@reportLink
		,suser_name()
from	[notification].[template]
where	[templateName]=@notificationTemplate
if (@@rowcount=1) select @retval = 1
end
return @retval
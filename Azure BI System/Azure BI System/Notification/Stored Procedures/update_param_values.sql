
CREATE Procedure [notification].[update_param_values]
@notification_id int
as
--Last Update Tim Firmin 2019MAR08 Extended Dynamic SQL so notification id > 3 chars
declare @i int = 1
declare @param_name varchar(100)
declare @sql nvarchar(1000)

--clear down any existing params, and reseed the notification params for this notification
delete [notification].[notification_parameters] where [notification_id]=@notification_id
insert [notification].[notification_parameters]([notification_id],[placeholder_name],[parameter_name])
select	n.[notificationID],m.[placeholder_name],m.[parameter_name]
from [notification].[Notification] n
left join [notification].[template_parameter_mapping] m on m.[template_id]=n.[templateID]
where n.[notificationID]=@notification_id

--update parameter values
while @i <= (	select	max([parameter_ordinal]) 
				from [notification].[notification] n	
				join [notification].[template_parameter_mapping] m on m.[template_id]=n.[templateid]
				where n.[notificationid]=@notification_id)
begin
	--get the next parameter to process
	select @param_name = p.[parameter_name] 
	from [notification].[notification] n 
	join [notification].[template_parameter_mapping] p on p.[template_id]=n.[templateID]
	where p.[template_id]=n.[templateID]
	and p.[parameter_ordinal]=@i
	and n.[notificationID]=@notification_id

	select @sql = 'update p set parameter_value = json_value(n.[notificationData],''$.' + @param_name +''') from [notification].[notification_parameters] p join [notification].[notification] n on n.[notificationID]=p.[notification_id] where p.[parameter_name]=''' + @param_name +''' and n.[notificationID]=' + cast(@notification_id as varchar(6))
	exec sp_executesql @sql
	select @i = @i + 1
end


GO



CREATE proc [notification].[uspUpdateNotificationBody]
@notification_id int
as
declare @i int = 1
declare @notification_body nvarchar(Max)
declare @notification_template varchar(100)
declare @error_notification_body nvarchar(max)

select @notification_body= [notificationResponse] from [notification].[notification] where [notificationid]=@notification_id
select @notification_template = t.[templateName] from [notification].[notification] n join [notification].[template] t on t.templateID=n.templateid where [notificationid]=@notification_id
select @error_notification_body = '<html><head><style> body {  background-color: #D8D8D8;}table {    width:500;    font-family:"Segoe UI";   align="center";  }table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 25px;}</style></head>  <br><table id="t01">   <tr>    <th align="left"  bgcolor="white" ><h3>PRS BI Notification System</h3></th>    </p>  </tr>  <tr>    <td align="center" bgcolor="black" style="color: white;"><p><h3>Notification Failure</h3><br>The BI Notification System attempted to send you a notification.</br><br>An error has occurred while processing this notification.</br><p>&nbsp;</p><br>Please report this to the PRS BI Team.</br><br>Notification template: ' + @notification_template + '</br><br>Notification ID: ' + cast(@notification_id as varchar(10)) +'</br></td> </tr><tr><td align="center"  bgcolor="white" ><br></br></tr><tr>  <td bgcolor="#F2F3F4" style="color: #273746;"><h2>PRS BI Team</h2>  </td></tr></table></body></html>'

--extract notification parameters from json to table
exec [notification].[update_param_values] @notification_id

--determine number of iterations based on number of parameters expected in the template
while @i <= (	select	count([notification_id]) 
				from	[notification].[notification_parameters] n
				where	n.[notification_id]=@notification_id 
				)
begin
	select @notification_body=replace(@notification_body,p.[placeholder_name],p.[parameter_value])  
	from [notification].[notification_parameters] p
	where p.[notification_id]=@notification_id

	select @i=@i+1
end
update [notification].[notification]
set [notificationResponse]=isnull(@notification_body,@error_notification_body)
where [notificationid]=@notification_id




GO



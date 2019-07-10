CREATE PROCEDURE Azure.GetNotificationReceipients
	@Level TINYINT = NULL,
	@Enabled BIT = 1
AS
BEGIN
	SELECT 
		[NotificationReceipientId],
		[Name],
		[Email],
		[Enabled],
		[Level] 
	FROM Azure.NotificationReceipient n
	WHERE (@Level IS NULL OR n.[Level] = @Level)
	  AND n.[Enabled] = @Enabled;
END
CREATE PROCEDURE [Control].[GetEmailAddressForNotificationSeverity] (@NotificationSeverityId int, @NotificationMessageTypeId INT)
AS
BEGIN
	DECLARE @EmailAddresses nvarchar(max)

	SELECT
		@EmailAddresses = COALESCE(@EmailAddresses + '; ', '') + [SUBQUERY].[EmailId]
	FROM --SELECT * FROM 
	(SELECT
		[USERS].NotificationSubscriberID,
		[USERS].[IsDeleted],
		[USERS].[FirstName],
		[USERS].[LastName],
		[USERS].[EmailId],
		[USERS].[TextMessageNumber],
		[USERS].[InstantMessageID]
	FROM [Control].[NotificationDistibutionConfig] DSBN_CONFIG
	INNER JOIN [Control].[NotificationGroups] GROUPS
		ON DSBN_CONFIG.NotificationGroupID = GROUPS.NotificationGroupID
	INNER JOIN [Control].NotificationGroupMembers GROUP_MEMBERS
		ON GROUPS.NotificationGroupID = GROUP_MEMBERS.NotificationGroupID
	INNER JOIN [Control].NotificationSubscribers USERS
		ON GROUP_MEMBERS.NotificationSubscriberID = USERS.NotificationSubscriberID
	WHERE DSBN_CONFIG.IsGroupMessage = 1
	AND DSBN_CONFIG.IsDeleted = 0
	AND GROUPS.IsDeleted = 0
	AND GROUP_MEMBERS.IsDeleted = 0
	AND USERS.IsDeleted = 0
	AND DSBN_CONFIG.NotificationSeverityId = @NotificationSeverityId 
	AND USERS.NotificationMessageTypeId = @NotificationMessageTypeId
	UNION
	SELECT
		[USERS].NotificationSubscriberID,
		[USERS].[IsDeleted],
		[USERS].[FirstName],
		[USERS].[LastName],
		[USERS].[EmailId],
		[USERS].[TextMessageNumber],
		[USERS].[InstantMessageID]
	FROM [Control].[NotificationDistibutionConfig] DSBN_CONFIG
	INNER JOIN [Control].NotificationSubscribers USERS
		ON DSBN_CONFIG.NotificationSubscriberID = USERS.NotificationSubscriberID
	WHERE DSBN_CONFIG.IsGroupMessage = 0
	AND DSBN_CONFIG.IsDeleted = 0
	AND USERS.IsDeleted = 0
	AND DSBN_CONFIG.NotificationSeverityId = @NotificationSeverityId
	AND USERS.NotificationMessageTypeId = @NotificationMessageTypeId) SUBQUERY

	SELECT
		@EmailAddresses EMailAddresses
END

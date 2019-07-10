CREATE PROCEDURE [Azure].[InsertEventLog]
	@SenderName VARCHAR(100),
	@ExecutionId VARCHAR(255),
	@EventMessage VARCHAR(MAX),
	@Status int
AS
BEGIN
	INSERT INTO [Azure].[EventLog]
	(
		[SenderName],
		[ExecutionId],
		[EventMessage],
		[CreatedAt],
		[Status]
	)
	VALUES
	(
		@SenderName,
		@ExecutionId,
		@EventMessage,
		SYSDATETIME(),
		@Status
	);
END
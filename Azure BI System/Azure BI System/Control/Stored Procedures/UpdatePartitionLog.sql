CREATE PROCEDURE [Control].[UpdatePartitionLog]
	@intPartnerMaxLoadDate int,
	@intPartitionLoadId int,
	@bitSuccessLoad bit,
	@LoadID int
AS

Update [Control].[PartitionLoad]
	Set
		[MaxLoadDate] = @intPartnerMaxLoadDate
		,[LoadSuccessful] = @bitSuccessLoad
		,[LoadId] = @LoadID
Where
	PartitionLoadId = @intPartitionLoadId

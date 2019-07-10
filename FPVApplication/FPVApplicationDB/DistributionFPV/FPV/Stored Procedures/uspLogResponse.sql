CREATE proc [FPV].[uspLogResponse]
@RequestID int,
@type varchar(20),
@data nvarchar(max)
as
begin
declare @responseID int = -1

	begin try
		insert	[FPV].[ApplicationResponse] ([RequestID],[type],[data])
		values (@RequestID,@type,@data)
		select @responseID = scope_identity()
	end try
	begin catch
		select @responseID = -1	
	end catch
	return @responseID
end
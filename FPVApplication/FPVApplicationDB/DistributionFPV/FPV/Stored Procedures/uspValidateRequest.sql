



CREATE PROC [FPV].[uspValidateRequest]
@RequestID INT
AS
BEGIN
DECLARE @RequestCode VARCHAR(255)
DECLARE @ProcName VARCHAR(255)
DECLARE @ValidationCode INT=0
DECLARE @ValidationComments VARCHAR(255) = ''
DECLARE @RetVal INT = 0

	--CHECK THAT A REQUEST DEF EXISTS FOR THE REQUEST
	IF EXISTS (	SELECT	[ProcName] 
				FROM	[FPV].[ApplicationRequest] R
				JOIN	[FPV].[RequestDef] D ON D.[RequestType]=R.[RequestType] AND D.[RequestEntity]=R.[RequestEntity] 
				WHERE	R.[RequestID]=@RequestID
				)
	BEGIN
			----CHECK THE REQUEST HANDLING PROC DEFINED IN THE REQUEST DEF ACTUALLY EXISTS IN THE DB
			IF EXISTS (	SELECT	1 
						FROM	[FPV].[ApplicationRequest] R
						JOIN	[FPV].[RequestDef] D ON D.[RequestType]=R.[RequestType] AND D.[RequestEntity]=R.[RequestEntity] 
						WHERE	R.[RequestID]=@RequestID AND OBJECT_ID(D.ProcName) IS NOT NULL)
			BEGIN
			--	--VALIDATE REQUEST DATA
				IF EXISTS (SELECT	1 
							FROM	[FPV].[ApplicationRequest] R
							JOIN	[FPV].[RequestDef] D ON D.[RequestType]=R.[RequestType] AND D.[RequestEntity]=R.[RequestEntity] 
							WHERE	R.[RequestID]=@RequestID 
							AND		D.[ValidateData]=1
							)
				BEGIN
							IF (SELECT ISJSON([RequestData]) FROM [FPV].[ApplicationRequest] WHERE [RequestID]=@RequestID) != 1
							BEGIN
								SELECT @ValidationCode=-3,@ValidationComments='INVALID REQUEST DATA',@RetVal=0
							END 
							ELSE
							BEGIN
								SELECT @ValidationCode=2,@ValidationComments='VALID REQUEST',@RetVal=1
							END 
				END
				ELSE
				BEGIN
					SELECT @ValidationCode=1,@ValidationComments='VALID REQUEST',@RetVal=1
				END 				
			END
			ELSE --REQUEST HANDLING PROC DEFINED IN THE REQUEST DEF NOT EXISTS IN THE DB
			BEGIN
					SELECT @ValidationCode=-2,@ValidationComments='INVALID REQUEST PROC ' + D.ProcName ,@RetVal=0
					FROM [FPV].[ApplicationRequest] R
					JOIN [FPV].[RequestDef] D ON  D.[RequestType]=R.[RequestType] AND D.[RequestEntity]=R.[RequestEntity] 
			END
	END
	ELSE --REQUEST DEF NOT EXISTS FOR THE REQUEST
	BEGIN
		IF EXISTS (SELECT 1 FROM  [FPV].[ApplicationRequest] WHERE [RequestID]=@RequestID AND RequestType IS NOT NULL AND RequestEntity IS NOT NULL)
		BEGIN
			SELECT @ValidationCode=-1,@ValidationComments='INVALID REQUEST [' + RequestType + '][' + RequestEntity +']' ,@RetVal=0
			FROM  [FPV].[ApplicationRequest] 
			WHERE [RequestID]=@RequestID;

		END
		ELSE
		BEGIN
			SELECT @ValidationCode=-4,@ValidationComments='JSON NOT RECOGNISED [' + Request + ']',@RetVal=0
			FROM  [FPV].[ApplicationRequest] 
			WHERE [RequestID]=@RequestID;
		END
	END

	UPDATE [FPV].[ApplicationRequest] 
	SET [RequestValidationCode]=@ValidationCode,[RequestValidationComment]=@ValidationComments
	WHERE [RequestID]=@RequestID

	RETURN @RetVal
END
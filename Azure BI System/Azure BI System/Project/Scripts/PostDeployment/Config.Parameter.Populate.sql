SET IDENTITY_INSERT [Config].[Parameter] ON;
GO

MERGE INTO [Config].[Parameter] AS Tgt
USING 
	(
	VALUES
		(1,'ETLState', 'Holds ETL state', NULL, NULL, NULL ,'Ready')
	) 
	AS Src
	(
		[ParmaterId],      
		[ParamaterCode],      
		[ParamaterShortDesc], 
		[ParamaterDesc],      
		[ParameterType],      
		[ParameterValue],     
		[ParameterDataType]  
	)
	ON Tgt.ParmaterId = Src.ParmaterId

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[ParamaterCode]      = Src.[ParamaterCode],     
		[ParamaterShortDesc] = Src.[ParamaterShortDesc], 
		[ParamaterDesc]      = Src.[ParamaterDesc], 
		[ParameterType]      = Src.[ParameterType],     
		[ParameterValue]     = Src.[ParameterValue],    
		[ParameterDataType]  = Src.[ParameterDataType]  
-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[ParmaterId],      
			[ParamaterCode],      
			[ParamaterShortDesc], 
			[ParamaterDesc],      
			[ParameterType],      
			[ParameterValue],     
			[ParameterDataType]  	
		)
	VALUES
		(
			Src.[ParmaterId],	 
			Src.[ParamaterCode],     
			Src.[ParamaterShortDesc],
			Src.[ParamaterDesc], 
			Src.[ParameterType],     
			Src.[ParameterValue],    
			Src.[ParameterDataType]  
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Config].[Parameter] OFF;


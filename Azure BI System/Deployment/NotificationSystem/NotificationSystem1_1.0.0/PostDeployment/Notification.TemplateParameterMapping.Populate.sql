--SET IDENTITY_INSERT [notification].[template_parameter_mapping] ON;
GO
MERGE INTO [notification].[template_parameter_mapping] AS Tgt
USING 
	(VALUES

--	template_id	placeholder_name	parameter_name	parameter_ordinal
	(2,	'#NDate#',			'NDate',			 	1),
	(2,	'#New#',			'NewStations',          2),
	(2,	'#Updated#' ,		'UpdatedStations' ,     3),
	(2,	'#CRMUpdates#' ,	'CRMUpdates' ,          4),
	(2,	'#ReportLink#' ,    'ReportLink' ,          5)


	) AS Src
	(
		    template_id
		   ,placeholder_name
           ,parameter_name
           ,parameter_ordinal
          
	)
	ON Tgt.template_id = Src.template_id and Tgt.placeholder_name = Src.placeholder_name

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		template_id	        =	SRC.template_id,
		placeholder_name	=	SRC.placeholder_name,
		parameter_name	    =	SRC.parameter_name,
		parameter_ordinal	=	SRC.parameter_ordinal

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			template_id
		   ,placeholder_name
           ,parameter_name
           ,parameter_ordinal
          	
		)
	VALUES
		(
			SRC.template_id
		   ,SRC.placeholder_name
           ,SRC.parameter_name
           ,SRC.parameter_ordinal
        
		)


WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
--SET IDENTITY_INSERT [notification].[template_parameter_mapping] OFF;


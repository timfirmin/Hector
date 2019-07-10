

/*

exec [Config].[spReferenceEnvironmentFromSSISProject] 'MDSStationIntegration','Dev','MDS_StationIntegration_SourceToStage'
exec [Config].[spReferenceEnvironmentFromSSISProject] 'MDSStationIntegration','Dev','MDS_StationIntegration_StageToClean'
exec [Config].[spReferenceEnvironmentFromSSISProject] 'MDSStationIntegration','Dev','MDS_StationIntegration_LoadMDS'
exec [Config].[spReferenceEnvironmentFromSSISProject] 'MDSStationIntegration','Dev','MDS_StationIntegration_CleanToTransform'


*/


CREATE PROCEDURE [Config].[spReferenceEnvironmentFromSSISProject]
	@pFolderName NVARCHAR(255),
	@pEnvironmentName NVARCHAR(255),
	@pProjectName NVARCHAR(255)
AS
BEGIN
	SET NOCOUNT OFF;
	DECLARE @reference_id BIGINT;
	SET @reference_id = ISNULL((SELECT TOP(1) [reference_id]
						FROM [SSISDB].[internal].[environment_references] AS er
						LEFT JOIN [SSISDB].[internal].[projects] AS p
							ON p.[project_id] = er.[project_id]
						LEFT JOIN [SSISDB].[internal].[folders] AS f
							ON  p.[folder_id] = f.[folder_id]
						WHERE p.[name]				= @pProjectName
						  AND f.[name]				= @pFolderName
						  AND er.[environment_name]	= @pEnvironmentName),-1);

	IF @reference_id = -1
		BEGIN
			PRINT CONCAT('Adding ',@pEnvironmentName,' Environment Reference To ',@pFolderName,'.',@pProjectName,' Project.');
			/*** reference Environment to a project ***/
			EXEC [SSISDB].[catalog].[create_environment_reference] 
				@environment_name=@pEnvironmentName, 
				@reference_id=@reference_id OUTPUT, 
				@project_name=@pProjectName, 
				@folder_name=@pFolderName, 
				@reference_type=R;
		END
	ELSE
		BEGIN
			PRINT 'Reference already exists - Deleting';
			EXEC [SSISDB].[catalog].[delete_environment_reference] 
			    @reference_id=@reference_id;
			PRINT CONCAT('Adding ',@pEnvironmentName,' Environment Reference To ',@pFolderName,'.',@pProjectName,' Project.');
			/*** reference Environment to a project ***/
			EXEC [SSISDB].[catalog].[create_environment_reference] 
				@environment_name=@pEnvironmentName, 
				@reference_id=@reference_id OUTPUT, 
				@project_name=@pProjectName, 
				@folder_name=@pFolderName, 
				@reference_type=R;
		END
	PRINT 'EnvironmentReferenceId: ' + CONVERT(varchar(20),ISNULL(@reference_id,-1));

	SET NOCOUNT ON;
END;





GO



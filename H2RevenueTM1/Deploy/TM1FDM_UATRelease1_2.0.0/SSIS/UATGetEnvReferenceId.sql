SELECT  reference_id
  FROM  SSISDB.[catalog].environment_references er
        JOIN SSISDB.[catalog].projects p ON p.project_id = er.project_id
		JOIN SSISDB.[internal].[folders] f ON p.folder_id = f.folder_id
 WHERE  er.environment_name = 'Test'
   AND  p.name				= 'H2PlanningTM1'
   AND  f.name				= 'TM1FDM'


   --SELECT * FROM SSISDB.[catalog].projects
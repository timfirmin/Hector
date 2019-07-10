
CREATE VIEW [Audit].[vExecutionParameterValues]

AS

SELECT 
	execution_parameter_id
	,execution_id
	,object_type
	,parameter_data_type
	,parameter_name
	,parameter_value
	,sensitive
	,required
	,value_set
	,runtime_override

FROM [SSIS].execution_parameter_values
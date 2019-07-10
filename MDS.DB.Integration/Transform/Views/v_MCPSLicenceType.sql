CREATE VIEW Transform.v_MCPSLicenceType
AS

select  [MCPSLicenceCode],
	    [MCPSLicenceName],
	    [Description]
 from [Transform].[MCPSLicenceType]
CREATE FUNCTION [Transform].[udfCheckLicenceGroupChange] ()
RETURNS @StationList TABLE   
(  
    Code varchar(50)  NULL,  
    Name nvarchar(150) NULL,
	LicenceGroup nvarchar(150) NULL
)  
AS
BEGIN

	Declare @LastLoadId int,@PrevLoadId int;
	SELECT @LastLoadId = Max(LoadId) FROM [Transform].[MDS_MasterStation];
	SELECT @PrevLoadId = Max(LoadId) FROM [Transform].[MDS_MasterStation] Where LoadId < @LastLoadId;

	INSERT @StationList  
    SELECT L.[Code],
			   L.[Name],
			   L.LicenceGroup
		FROM  [Transform].[MDS_MasterStation] L LEFT OUTER JOIN
			  [Transform].[MDS_MasterStation] P ON L.CODE = P.CODE  
		Where  L.LicenceGroup <> P.LicenceGroup and
			  L.LoadId =@LastLoadId and P.LoadId =@PrevLoadId 

	RETURN
	
END
GO


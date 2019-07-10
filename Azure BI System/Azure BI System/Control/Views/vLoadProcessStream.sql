CREATE VIEW [Control].[vLoadProcessStream]
	AS 

	WITH Loads
	as
	(
	SELECT  LoadId GlobalLoadId,
			LoadId, 
			ParentLoadId
		FROM [Audit].[PackageLoad]
		WHERE PackageName = 'GlobalProcess.ProcessFeeds.dtsx'
	UNION ALL 
	SELECT  L.GlobalLoadId,
			PL.LoadId, 
			PL.ParentLoadId
		FROM [Audit].[PackageLoad] PL inner join
			Loads L on PL.ParentLoadId = L.LoadId
	)


	SELECT S.GlobalLoadId,
		S.[EntityId],
		EPS.[EntityProcessStreamId],
		EPS.[LoadProcess],
		EPS.[ProcessStream],
		S.[Name],
		S.[Schema],
		S.[Table]

	FROM
	(
		SELECT L.GlobalLoadId,
			E.[EntityId],
			MAX(EPS.[EntityProcessStreamId]) EntityProcessStreamId,
			ET.[Name],
			ET.[Schema],
			ET.[Table]
	
		FROM Loads L inner join
			[Control].[EntityProcessStream] EPS on L.LoadId = EPS.LoadId inner join
			[Control].[Entity] E on EPS.EntityId = E.EntityId inner join
			[Control].[EntityType] ET on E.EntityTypeId = ET.EntityTypeId

		GROUP BY L.GlobalLoadId,
			E.[EntityId],
			ET.[Name],
			ET.[Schema],
			ET.[Table]
	) S inner join
		Control.EntityProcessStream EPS on S.EntityProcessStreamId = EPS.EntityProcessStreamId
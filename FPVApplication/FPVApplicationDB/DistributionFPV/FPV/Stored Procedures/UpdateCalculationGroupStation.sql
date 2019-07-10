CREATE PROC [FPV].[UpdateCalculationGroupStation]
@UpdateGUID uniqueidentifier
AS
BEGIN
WITH MergeStations AS (
	SELECT [DistributionGroupCode]
			,[DistributionCode]
			,[Society]
			,[StationID]
			,[StationName]
			,[StationCategory]
			,[StationStatus]
			,[HedgePercent]
			,[PRAdminRate]
			,[GroupAdminRate]
			,[IsExcluded]
			,[UpdatedBy]
			,[UpdateComment]
	FROM [FPV].[StationUpdates]	
	WHERE [UpdateGUID]=@UpdateGUID
)
MERGE [FPV].[CalculationGroupStation] T
USING MergeStations S
ON T.[Society]=S.[Society]
AND T.[DistributionGroupCode]=S.[DistributionGroupCode]
AND T.[DistributionCode]=S.[DistributionCode]
AND T.[StationID]=S.[StationID]
WHEN NOT MATCHED THEN
INSERT ([DistributionGroupCode]
			,[DistributionCode]
			,[Society]
           ,[StationID]
           ,[StationName]
           ,[StationCategory]
		   ,[StationStatus]
           ,[GroupAdminRate]
           ,[HedgePercent]
           ,[PRAdminRate]
           ,[IsExcluded]
           ,[UpdatedBy]
           ,[UpdateComment])
VALUES (S.[DistributionGroupCode]
			,S.[DistributionCode]
			,S.[Society]
           ,S.StationID
           ,S.StationName
           ,S.StationCategory
		   ,S.StationStatus
           ,S.GroupAdminRate 
           ,S.HedgePercent 
           ,S.PRAdminRate 
           ,S.IsExcluded
           ,S.UpdatedBy 
           ,S.UpdateComment)

WHEN MATCHED AND (	T.[HedgePercent] != S.[HedgePercent]
					OR	
					T.[PRAdminRate] != S.[PRAdminRate]
					OR
					T.[GroupAdminRate] !=S.[GroupAdminRate]
					OR
					T.[IsExcluded] !=S.[IsExcluded]
					) THEN 
UPDATE SET T.[HedgePercent]=S.[HedgePercent]
			,T.[PRAdminRate]=S.[PRAdminRate]
			,T.[GroupAdminRate]=S.[GroupAdminRate]
			,T.[IsExcluded] =S.[IsExcluded];

DELETE [FPV].[StationUpdates];
END
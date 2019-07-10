CREATE PROCEDURE [Reporting].[ObtainAnalogyStationDetails]
	@LoadId Bigint

AS

SELECT [ParentLoadId]
      ,CASE WHEN [RecordFlag] = 'Update' THEN 'Updates'
	        WHEN [RecordFlag] =  'NoStation' THEN 'UnmatchedMasterStations'
			WHEN [RecordFlag] =  'NoAnalogy' THEN  'UnmatchedAnalogyStations'
		END AS Action
      ,[AnalogyStationKey]
      ,[Format]
      ,[FileStationID]
      ,[FileAnalogyStationID]
	  ,MDSStationName
	  ,MDSStationCode
      ,[RecordFlag]
	  ,SysStartTime
  FROM [Transform].[AnalogyStationAlerts]
  Where ParentLoadId = @LoadId
GO


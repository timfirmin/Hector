CREATE VIEW [Transform].[v_AnalogyStation]
AS
SELECT DISTINCT

 bcst.Code AS Code, 
bcst.Name AS StationName, 
asid.FileAnalogyStationID, 
asid.FileStationID AS SourceCode
FROM            Transform.AnalogyStation AS asid INNER JOIN
               [$(MDS)].[mdm].[Master_v_MasterStation] AS bcst ON asid.FileStationID = bcst.Code
WHERE        (asid.RecordFlag = 'Update') 
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Transform', @level1type = N'VIEW', @level1name = N'v_AnalogyStation';

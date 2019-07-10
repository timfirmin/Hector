--SELECT df.* FROM [BroadcastDataQualityMart].Dim.FileLog df
--INNER JOIN BISYstem_Paas.[Control].SourceFile bs ON bs.originalFileId = df.FileId
--AND bs.ApplicationID = 2 AND SourceFileId < -1

--UPDATE  [BroadcastDataQualityMart].Dim.FileLog
--SET FileId = bs.SourceFileID
--FROM [BroadcastDataQualityMart].Dim.FileLog df
--INNER JOIN BISYstem_Paas.[Control].SourceFile bs ON bs.originalFileId = df.FileId
--AND bs.ApplicationID = 2 AND SourceFileId < -1


SELECT df.* FROM [BroadcastDataQualityMart].Dim.FileLog df
INNER JOIN BISYstem_Paas.[Control].SourceFile bs ON bs.sourcefileid = df.FileId
AND bs.ApplicationID = 2 AND SourceFileId < -1


--SELECT * FROM BISYstem_Paas.[Control].SourceFile
--order by SourceFileId

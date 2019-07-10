CREATE PROCEDURE Reporting.ObtainFinanceCodesReport
AS 
SELECT	
  RecordType = 'Unmapped CodaCustomerCode',
  MasterStationName = mst.Name,
  MasterStationCode = mst.Code,
  MasterStation_CodaCustomerCode = mst.CodaCustomerCode_Code,
  MasterStation_CodaCustomerName = mst.CodaCustomerCode_Name
FROM	
  [$(MDS)].mdm.Master_v_MasterStation AS mst
LEFT JOIN [$(MDS)].mdm.Master_v_CodaCustomer AS ccu ON 
  mst.CodaCustomerCode_Code = ccu.Code
WHERE	
  (ccu.Code IS NULL OR ccu.Code = 'C9999')
;

GO
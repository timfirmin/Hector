
Create  Procedure rjr.spLoadRajarDataFromExternal
AS

Insert into [rjr].[RajarData]
(
     monthyear, 
	[Station_Group], 
	[Survey_Period] ,
	[Population_000],
	[Reach_000],
	[Reach_Percent],
	[Average_Hours_Per_Head],
	[Average_Hours_Per_Listener],
	[Total_Hours_000],
	[Listening_Share_In_TSA],
    [fileId],
	[fileNameShort],
	[rowNumber],
	[parentRowDescr],
	TimeStamps 
)
Select 
     replace (Replace([fileNameShort],'.csv',''),'rajar_quarterly_listening_report_to_','') as monthyear ,
	[Station_Group], 
	[Survey_Period] ,
	[Population_000],
	[Reach_000],
	[Reach_Percent],
	[Average_Hours_Per_Head],
	[Average_Hours_Per_Listener],
	[Total_Hours_000],
	[Listening_Share_In_TSA],
    [fileId],
	[fileNameShort],
	[rowNumber],
	[parentRowDescr],
	getdate () as TimeStamps 
  from [rjrstage].[Stage_Rajar] 


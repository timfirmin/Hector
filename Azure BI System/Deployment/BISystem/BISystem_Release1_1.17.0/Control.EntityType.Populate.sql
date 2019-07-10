SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]
	 -- IKFD - IFR -- Source To Stage
	    (971,	NULL,	14,		1,		0,		N'stgDeductionMatrix',		                 N'stgDeductionMatrix',		            N'DeductionMatrix_IKFD Source To Stage',			          	N'IFR',			    	N'stgDeductionMatrix',		                	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(972,	NULL,	14,		1,		0,		N'stgCodaFinancialData',		             N'stgCodaFinancialData',		        N'CodaFinancialData_IKFD Source To Stage',			          	N'IFR',			    	N'stgCodaFinancialData',		              	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(973,	NULL,	14,		1,		0,		N'stgDistributionCategory',		             N'stgDistributionCategory',		    N'DistributionCategory Source To Stage',			          	N'IFR',			    	N'stgDistributionCategory',		              	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(974,	NULL,	14,		1,		0,		N'stgETLForeignFinancialSummary',		     N'stgETLForeignFinancialSummary',	    N'ETLForeignFinancialSummary Source To Stage',			     	N'IFR',			    	N'stgETLForeignFinancialSummary',		      	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(975,	NULL,	14,		1,		0,		N'stgJobControl',		                     N'stgJobControl',		                N'JobControl Source To Stage',			                     	N'IFR',			    	N'stgJobControl',	                  	      	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(976,	NULL,	14,		1,		0,		N'stgSociety',		                         N'stgSociety',		                    N'Society Source To Stage',			                         	N'IFR',			    	N'stgSociety',	                  	         	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
	-- IKFD - IFR -- Stage to DWH
	    (977,	NULL,	14,		1,		0,		N'DimDeductionMatrix',		                 N'DimDeductionMatrix',		            N'DimDeductionMatrix Stage To DWH',		   					  	N'IFR',			    	N'DimDeductionMatrix',		               	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(978,	NULL,	14,		1,		0,		N'FactForeignFinancialSummary',		         N'FactForeignFinancialSummary',		N'FactForeignFinancialSummary Stage To DWH',			      	N'IFR',			    	N'FactForeignFinancialSummary',		       	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(979,	NULL,	14,		1,		0,		N'DimDistCategory',		                     N'DimDistCategory',	    	        N'DimDistCategory Stage to DWH',			                 	N'IFR',			    	N'DimDistCategory',		                	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(980,	NULL,	14,		1,		0,		N'FactCodaFinancialData',		             N'FactCodaFinancialData',		        N'FactCodaFinancialData  Stage to DWH',			            	N'IFR',			    	N'FactCodaFinancialData',		         	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(981,	NULL,	14,		1,		0,		N'DimBroadcaster',		                     N'DimBroadcaster',		                N'DimBroadcaster Stage To DWH',			                     	N'IFR',			    	N'DimBroadcaster',	                  	   	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(982,	NULL,	14,		1,		0,		N'DimSociety',		                         N'DimSociety',		                    N'DimSociety Stage to DWH',			                         	N'IFR',			    	N'DimSociety',	                  	      	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
   -- IKFD - IFR -- Stage to DWH
		(984,	NULL,	14,		1,		0,		N'MDSPaymentDetails',		                N'MDSPaymentDetails',		            N'Payment Details to MDS',									   	N'IFR',		     	    N'MDSPaymentDetails',	       	         	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(985,	NULL,	14,		1,		0,		N'MDSPaymentHeaders',		                N'MDSPaymentHeaders',	                N'MDSPaymentHeaders  to MDS',			                     	N'IFR',			    	N'MDSPaymentHeaders',	      	         	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
 -- IKFD - IFR -- MDS to DWH
		(1119,	NULL,	14,		1,		0,		N'MDSPaymentDetailsStage',		           N'MDSPaymentDetailsStage',	           N'Payment Details From MDS',									   	N'IFR',		     	    N'MDSPaymentDetailsStage',	       	      	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(1120,	NULL,	14,		1,		0,		N'MDSPaymentHeadersStage',		           N'MDSPaymentHeadersStage',	           N'PaymentHeaders  From MDS',		    	                     	N'IFR',			    	N'MDSPaymentHeadersStage',	      	      	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(1121,	NULL,	14,		1,		0,		N'MDSPaymentDetailsDWH',		           N'MDSPaymentDetailsDWH',	               N'Payment Details To DWH',									   	N'IFR',		     	    N'MDSPaymentDetailsDWH',	       	      	N'senay.yilmaz@prsformusic.com',		SYSDATETIME()),
		(1122,	NULL,	14,		1,		0,		N'MDSPaymentHeadersDWH',		           N'MDSPaymentHeadersDWH',	               N'PaymentHeaders  To DWH',		    	                     	N'IFR',			    	N'MDSPaymentHeadersDWH',	      	      	N'senay.yilmaz@prsformusic.com',		SYSDATETIME())

	) AS Src
	(
		 EntityTypeId
		,ParentEntityTypeId
		,ApplicationId
		,IsSourceEntity
		,[HasMultipleSourceFile]
		,Name
		,Code
		,[Description]
		,[Schema]
		,[Table]
		,[CreatedBy]
        ,[CreatedDate]
	)
	ON Tgt.EntityTypeId = Src.EntityTypeId

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[ApplicationId]			= Src.[ApplicationId],
		[IsSourceEntity]	    = Src.[IsSourceEntity],
		[HasMultipleSourceFile]	= Src.[HasMultipleSourceFile],
		[Name]					= Src.[Name],
		[Code]					= Src.[Code],
		[ParentEntityTypeId]	= Src.[ParentEntityTypeId],
		[Description]			= Src.[Description],
		[Schema]				= Src.[Schema],
		[Table]					= Src.[Table],
		[CreatedBy]				= Src.[CreatedBy],
        [CreatedDate]			= Src.[CreatedDate]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[EntityTypeId],
			[ApplicationId],
			[IsSourceEntity],
			[HasMultipleSourceFile],
			[Name],				
			[Code],				
			[ParentEntityTypeId],
			[Description],		
			[Schema],			
			[Table],				
			[CreatedBy],			
			[CreatedDate]		
		)
	VALUES
		(
			Src.[EntityTypeId],
			Src.[ApplicationId],
			Src.[IsSourceEntity],
			Src.[HasMultipleSourceFile],
			Src.[Name],
			Src.[Code],
			src.[ParentEntityTypeId],
			src.[Description],
			src.[Schema],
			src.[Table],
			src.[CreatedBy],			
			src.[CreatedDate]
		)
;
GO
SET IDENTITY_INSERT [Control].[EntityType] OFF;



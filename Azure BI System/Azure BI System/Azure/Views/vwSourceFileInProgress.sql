/* This is draft to be finished for all application scheduled/taken in the account by Azure Automation */
CREATE VIEW Azure.vwSourceFileInProgress
AS
WITH PlayToPayPreShareSourceFileInProgress
AS
(
	SELECT sf.* 
	FROM Control.SourceFile sf
	JOIN Control.Application a ON a.ApplicationId =sf.ApplicationId
	WHERE a.Code = 'BRDPTP'
	EXCEPT (
		SELECT * 
		FROM Control.SourceFile
		WHERE StageDate			IS NULL
		  AND CleanDate			IS NULL
		  AND TransformDate		IS NULL
		  AND WarehouseDate		IS NULL
		  AND OlapDate			IS NULL
	)
	EXCEPT (
		SELECT * 
		FROM Control.SourceFile
		WHERE StageDate			IS NOT NULL
		  AND CleanDate			IS NOT NULL
		  AND TransformDate		IS NOT NULL
		  AND WarehouseDate		IS NOT NULL
		  AND OlapDate			IS NOT NULL
	)
),
FinanceDataMartSourceFileInProgress 
AS
(
	SELECT sf.* 
	FROM Control.SourceFile sf
	JOIN Control.Application a ON a.ApplicationId =sf.ApplicationId
	WHERE a.Code = 'FDN'
	EXCEPT (
		SELECT * 
		FROM Control.SourceFile
		WHERE BlobUploadDate	IS NULL
		  AND StageDate			IS NULL
		  AND CleanDate			IS NULL
		  AND WarehouseDate		IS NULL
		  AND OlapDate			IS NULL
	)
	EXCEPT (
		SELECT * 
		FROM Control.SourceFile
		WHERE BlobUploadDate	IS NOT NULL
		  AND StageDate			IS NOT NULL
		  AND CleanDate			IS NOT NULL
		  AND WarehouseDate		IS NOT NULL
		  AND OlapDate			IS NOT NULL
	)
),
OnlineStatementSourceFileInProgress 
AS
(
	SELECT sf.* 
	FROM Control.SourceFile sf
		JOIN Control.Application a ON a.ApplicationId =sf.ApplicationId
	WHERE a.Code = 'DEOS'
	EXCEPT (
		SELECT * 
		FROM Control.SourceFile
		WHERE BlobUploadDate	IS NULL
		  AND StageDate			IS NULL
		  AND CleanDate			IS NULL
		  AND TransformDate		IS NULL
		  AND WarehouseDate		IS NULL
	)
	EXCEPT (
		SELECT * 
		FROM Control.SourceFile
		WHERE BlobUploadDate	IS NOT NULL
		  AND StageDate			IS NOT NULL
		  AND CleanDate			IS NOT NULL
		  AND TransformDate		IS NOT NULL
		  AND WarehouseDate		IS NOT NULL
	)
)
SELECT * 
FROM PlayToPayPreShareSourceFileInProgress

UNION ALL

SELECT * 
FROM FinanceDataMartSourceFileInProgress

UNION ALL

SELECT *
FROM OnlineStatementSourceFileInProgress

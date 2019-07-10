CREATE PROCEDURE [Test].[InsertValidationTestExecution]
(
	@LoadID INT,
	@ValidationTestId SMALLINT,
	@TestStatus VARCHAR(4),
	@SourceResult VARCHAR(30),
	@TargetResult VARCHAR(30)
)
	
AS


INSERT INTO Test.ValidationTestExecution (LoadId, ValidationTestId, TestStatus, SourceResult, TargetResult, ExecutionTime, CreatedBy)
VALUES (@LoadID, @ValidationTestId, @TestStatus, @SourceResult, @TargetResult, GETDATE(), suser_sname())

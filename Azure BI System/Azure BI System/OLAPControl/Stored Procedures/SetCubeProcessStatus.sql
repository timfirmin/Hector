CREATE PROC [OLAPControl].[SetCubeProcessStatus]

AS

	UPDATE OLAPControl.Cube
	SET RequiresProcess = 1

Create PROCEDURE usp_DeleteDepartment
(
	@DNumber INT
)
AS
BEGIN
	DECLARE @Pno int;
			SELECT @Pno (SELECT PNumber FROM Project WHERE DNum = @DNumber)
	
	UPDATE Employee SET Dno = NULL
	DELETE FROM Department WHERE Department.DNumber = @DNumber
	DELETE FROM Dept_Locations WHERE Dept_Locations.DNUmber = @DNumber
	DELETE FROM Project WHERE Project.DNum = @DNumber
	DELETE FROM Works_on WHERE Works_on.Pno = @Pno
	
	RETURN SCOPE_IDENTITY();
END
Create PROCEDURE usp_DeleteDepartment
(
	@DNumber INT
)
AS
BEGIN
	UPDATE Employee SET Dno = NULL WHERE Dno = @DNumber
	IF EXISTS (SELECT Pno FROM Works_on w JOIN Project p ON w.Pno = p.PNumber)
	BEGIN
		DELETE w FROM Works_on w
			JOIN Project p ON p.PNumber = w.Pno
			WHERE p.PNumber = w.Pno	
	END
	ELSE
		THROW 50006, 'TEMP FEJL',1;

	IF EXISTS (SELECT DNum FROM Project WHERE Project.DNum = @DNumber)
		DELETE FROM Project WHERE Project.DNum = @DNumber
	ELSE
		THROW 50005, 'Project with DNum does not EXIST!',1;

	IF EXISTS (SELECT DNUmber FROM Dept_Locations WHERE Dept_Locations.DNUmber = @DNumber)
		DELETE FROM Dept_Locations WHERE Dept_Locations.DNUmber = @DNumber
	ELSE
		THROW 50004, 'DNUmber does not EXIST!',1;

	IF EXISTs (SELECT DNumber FROM Department WHERE DNumber = @DNumber)
		DELETE FROM Department WHERE Department.DNumber = @DNumber
	ELSE
		THROW 50003, 'Department does not EXIST',1; 

END

--DELETE FROM Works_on WHERE 
	--DELETE FROM Project WHERE Project.DNum = @DNumber

	--DECLARE @tPno INT
	--	SELECT @tPno = PNumber FROM Project WHERE Project.DNum = @DNumber
	--IF EXISTS (SELECT DNumber FROM Department WHERE DNumber = @DNumber)
	--	SELECT @tPno = PNumber FROM Project WHERE Project.DNum = @DNumber
Create or alter PROCEDURE usp_DeleteDepartment
(
	@DNumber INT --Variable sent from cmd APP, is needed.
)
AS
BEGIN
	UPDATE Employee SET Dno = NULL WHERE Dno = @DNumber --Udates Employees Dno to be Null, now that the department is deleted

	--Check to find to the correct Works_on Pno, By Joining on the Project Table,
	--And getting the Project PNumber where the DNum is matching the chosen @DNumber.
	IF EXISTS (SELECT Pno FROM Works_on w JOIN Project p ON w.Pno = p.PNumber WHERE p.DNum = @DNumber) 
	BEGIN
		DELETE w FROM Works_on w --Deletes Works_on Where DNum is matching the chosen @DNumber.
			JOIN Project p ON p.PNumber = w.Pno
			WHERE p.PNumber = w.Pno	AND p.DNum = @DNumber
	END
	--ELSE
	--	THROW 50006, 'Works_on.Pno does not EXIST',1;

	IF EXISTS (SELECT DNum FROM Project WHERE Project.DNum = @DNumber) --Checks if Chosen @DNumber EXISTS, then deletes Project with the same DNum as @DNumber, from the Project Table.
		DELETE FROM Project WHERE Project.DNum = @DNumber
	--ELSE
	--	THROW 50005, 'Project with DNum does not EXIST!',1;

	IF EXISTS (SELECT DNUmber FROM Dept_Locations WHERE Dept_Locations.DNUmber = @DNumber) --Checks if Chosen @DNumber EXISTS, then deletes Dept_Locations with the same DNUmber as @DNumber, from the Dept_Locations Table.
		DELETE FROM Dept_Locations WHERE Dept_Locations.DNUmber = @DNumber
	--ELSE
	--	THROW 50004, 'DNUmber does not EXIST!',1;

	IF EXISTs (SELECT DNumber FROM Department WHERE DNumber = @DNumber) --Checks if Chosen @DNumber EXISTS, then deletes Department with the same DNumber as @DNumber, from the Department Table.
		DELETE FROM Department WHERE Department.DNumber = @DNumber
	--ELSE
	--	THROW 50003, 'Department does not EXIST',1; 

END
Create PROCEDURE usp_GetAllDepartments
AS
BEGIN
		SELECT *,
		(	
			SELECT COUNT(*) AS EmpCount
			FROM Employee
			WHERE Department.DNumber = Employee.Dno
		)
		AS EmpCount
		FROM Department
END
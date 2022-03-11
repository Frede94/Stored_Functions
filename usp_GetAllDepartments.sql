Create PROCEDURE usp_GetAllDepartments
AS
BEGIN
		SELECT *, --Select all from Department
		(	
			SELECT COUNT(*) AS EmpCount --Creates a temp Count of all employees in the department.
			FROM Employee
			WHERE Department.DNumber = Employee.Dno --Make sure it only for the correct Department
		)
		AS EmpCount
		FROM Department
END
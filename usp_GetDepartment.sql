create or alter PROCEDURE usp_GetDepartment
(
	@Dnumber INT --Variable sent from cmd APP, is needed.
)
AS
BEGIN
		SELECT * --Select all from Department
		FROM Department,
		(	
			SELECT COUNT(*) AS EmpCount --Creates a temp Count of all employees in the department.
			FROM Employee
			WHERE Employee.Dno = @Dnumber --Make sure it only for the correct Department
		)
		AS TempTable
		
		WHERE @Dnumber = DNumber --Instead of Getting all, this sets so we only get the chosen Department (@Dnumber)

		RETURN;
END
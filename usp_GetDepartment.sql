create PROCEDURE usp_GetDepartment
(
	@Dnumber INT
)
AS
BEGIN
		SELECT * 
		FROM Department,
		(	
			SELECT COUNT(*) AS EmpCount
			FROM Employee
			WHERE Employee.Dno = @Dnumber
		)
		AS TempTable
		
		WHERE @Dnumber = DNumber
END
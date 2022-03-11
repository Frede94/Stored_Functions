create PROCEDURE usp_UpdateDepartmentManager
(
	@DNumber INT,
	@MgrSSN INT
)
AS
BEGIN
	IF EXISTS (SELECT MgrSSN FROM Department WHERE MgrSSN = @MgrSSN)
		THROW 50008, 'This Employee is already a manager.',1;
	ELSE
	BEGIN
		UPDATE Department
		SET MgrSSN = @MgrSSN,
			MgrStartDate = GETDATE()
		Where DNumber = @DNumber
	END

	IF EXISTS (SELECT Dno FROM Employee WHERE SSN != @MgrSSN)-- AND Dno = @DNumber
	BEGIN
		UPDATE Employee
		SET SuperSSN = @MgrSSN
		WHERE Dno = @DNumber
	END

END
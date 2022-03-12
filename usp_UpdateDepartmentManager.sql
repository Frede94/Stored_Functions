create or alter PROCEDURE usp_UpdateDepartmentManager
(
	@DNumber INT, --Variable sent from cmd APP, is needed.
	@MgrSSN INT	--Variable sent from cmd APP, is needed.
)
AS
BEGIN
	IF EXISTS (SELECT MgrSSN FROM Department WHERE MgrSSN = @MgrSSN) --Checks if new MgrSSN is already and mgr. in another department .
		THROW 50008, 'This Employee is already a manager.',1; --If so throws an exception and stops.
	ELSE
	BEGIN --If MgrSSN is not already in use, in another department, it updates the MgrSSN in chosen Dnumber.
		UPDATE Department 
		SET MgrSSN = @MgrSSN, --Updates the MgrSSN to the new one.
			MgrStartDate = GETDATE() --Build in Function that get current date.
		Where DNumber = @DNumber --Check to make sure it, only change the chosen Dnumber
	END

	IF EXISTS (SELECT Dno FROM Employee WHERE SSN != @MgrSSN) --Checks if Employee is the mgr. To make sure we dont change the wrong SuperSSN
	BEGIN
		UPDATE Employee --IF not then it updates the SuperSSN to the new MgrSSN
		SET SuperSSN = @MgrSSN --Sets SuperSSN to new MgrSSN
		WHERE Dno = @DNumber --Check to make sure it, only change the chosen Dnumber
	END

END
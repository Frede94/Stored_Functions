IF OBJECT_ID('usp_CreateDepartment') IS NOT NULL
	DROP  PROCEDURE usp_CreateDepartment;	

Create PROCEDURE usp_CreateDepartment
(
	@DName NVARCHAR(50), --Variable sent from cmd APP, is needed.
	@MgrSSN INT --Variable sent from cmd APP, is needed.
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM Department WHERE DName = @DName) --Checks if DName is already in use.
		THROW 50001, 'DName already in use', 1 --First 50000 already in use 
	IF EXISTS (SELECT 1 FROM Department WHERE MgrSSN = @MgrSSN) --Checks if MrgSSN is already in use.
		THROW 50002, 'MgrSSN is already a Mgr', 1 --First 50000 already in use 

	DECLARE @DNumber int; --Declare a variable
		SELECT @DNumber = coalesce((select max(DNumber) + 1 from Department), 1) --Set @DNumber to 1+ of the highest existing DNumber.
		INSERT INTO Department(DName, DNumber, MgrSSN, MgrStartDate) --Insert the new Department with chosen variables and current date (GETDATE())
			VALUES (@DName, @DNumber, @MgrSSN, GetDate())

	RETURN SCOPE_IDENTITY(); -- Returns Identity from this Scope.
	--RETURN @@IDENTITY -- Returns latest Identity, Could be from another function/Procedure.
END

Create PROCEDURE usp_CreateDepartment
(
	@DName NVARCHAR(50),
	@MgrSSN INT
	--@MgrStartDate DATE
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM Department WHERE DName = @DName)
		THROW 50001, 'DName already in use', 1 --First 50000 already in use 
	IF EXISTS (SELECT 1 FROM Department WHERE MgrSSN = @MgrSSN)
		THROW 50002, 'MgrSSN is already a Mgr', 1 --First 50000 already in use 

	DECLARE @DNumber int;
		SELECT @DNumber = coalesce((select max(DNumber) + 1 from Department), 1)
		INSERT INTO Department(DName, DNumber, MgrSSN, MgrStartDate)
			VALUES (@DName, @DNumber, @MgrSSN, GetDate())

	RETURN SCOPE_IDENTITY(); -- Returns Identity from this Scope.
	--RETURN @@IDENTITY -- Returns latest Identity, Could be from another function/Procedure.
END
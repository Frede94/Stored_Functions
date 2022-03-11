create PROCEDURE usp_UpdateDepartmentName
(
	@DName NVARCHAR(50), --Variable sent from cmd APP, is needed.
	@DNumber INT --Variable sent from cmd APP, is needed.
)
AS
BEGIN
	IF EXISTS (SELECT DName From Department Where DName = @DName) --Check if Dname is already in use by another department.
		THROW 50006,'Name is already in use by another Department.',1; --If it's use it throws an exception
	ELSE
		UPDATE Department --If DName is not already in use, it updates the Department name.
		SET DName = @DName
		WHERE DNumber = @DNumber
END
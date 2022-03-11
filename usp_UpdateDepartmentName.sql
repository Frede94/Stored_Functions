create PROCEDURE usp_UpdateDepartmentName
(
	@DName NVARCHAR(50),
	@DNumber INT
)
AS
BEGIN
	IF EXISTS (SELECT DName From Department Where DName = @DName)
		THROW 50006,'Name is already in use by another Department.',1;
	ELSE
		UPDATE Department
		SET DName = @DName
		WHERE DNumber = @DNumber
END
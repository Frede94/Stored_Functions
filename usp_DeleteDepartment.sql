Create PROCEDURE usp_DeleteDepartment
(
	@DNumber INT
)
AS
BEGIN
	DELETE FROM Department Where DNumber = @DNumber
	RETURN SCOPE_IDENTITY();
END
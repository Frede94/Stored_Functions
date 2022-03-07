Create PROCEDURE UPS_CreateProject
(
	@PName NVARCHAR(50),
	@PLocation NVARCHAR(50),
	@DNum INT
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM Project WHERE PName = @PName)
		THROW 50001, 'PName already in use', 1 --First 50000 already in use 
	INSERT INTO Project(PName,PLocation,DNum)
		VALUES (@PName, @PLocation, @DNum)

	RETURN SCOPE_IDENTITY(); -- Returns Identity from this Scope.
	--RETURN @@IDENTITY -- Returns latest Identity, Could be from another function/Procedure.
END
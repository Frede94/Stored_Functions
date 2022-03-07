--Exercise 1 – Stored Procedure as Parameterized query

Create PROCEDURE usp_getEmployeeProjects
(
	@ssn numeric(9,0) = null
)
AS
select		PNumber, PName, DName, PLocation, SUM(Hours) AS SUM_Hours
from		Project
			JOIN Department on Project.DNum = Department.DNumber
			JOIN Works_on on Works_on.Pno = Project.PNumber
where		@ssn is null or Works_on.Essn = @ssn
group by	PNumber, PName, DName, PLocation  
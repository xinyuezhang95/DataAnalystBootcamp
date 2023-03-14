/*
Updating/ Deleting Data
*/

Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(Null, 'Holly', 'Flax', null, null),
(1013, 'Darryl', 'Philbin', null, 'Male')

select *
from EmployeeDemographics 

update EmployeeDemographics
set EmployeeID = 1012 
where FirstName = 'Holly' and LastName = 'Flax'

update EmployeeDemographics
set Age = 31, Gender = 'Female' 
where FirstName = 'Holly' and LastName = 'Flax'

delete from EmployeeDemographics
where EmployeeID = 1005
--there's no way to reverse the delete statement
--Delete statement can be changed from 'select *' statement -- safeguard
/*
Union, Union All
*/

--First Create another table to use
create table WarehouseEmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

Insert into WarehouseEmployeeDemographics VALUES
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

select * 
from EmployeeDemographics full outer join WarehouseEmployeeDemographics
on EmployeeDemographics.EmployeeID = WarehouseEmployeeDemographics.EmployeeID

select * 
from EmployeeDemographics
union
select * 
from WarehouseEmployeeDemographics

select * 
from EmployeeDemographics
union all
select * 
from WarehouseEmployeeDemographics

--The following statement works but it's wrong
--It works because the results have the same data type, like FirstName and JobTitle are both varchar(50), 
--age and salary are both int, and thus they can be connected using Union
--But this is wrong! So be careful when it comes to using Union. 
select EmployeeID, FirstName, Age
from EmployeeDemographics
union
select EmployeeID, JobTitle, Salary
from EmployeeSalary
order by EmployeeID
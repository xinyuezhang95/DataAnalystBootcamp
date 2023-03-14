/*
Aliasing
*/

select FirstName as Fname
from EmployeeDemographics 

select FirstName Fname
from EmployeeDemographics

select FirstName + ' ' + LastName as FullName
from EmployeeDemographics


select demo.EmployeeID
from EmployeeDemographics as demo


select demo.EmployeeID, sal.Salary
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID
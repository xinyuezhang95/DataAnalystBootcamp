/*
Inner Joins, Full/Left/Right/Outer Joins
*/

select * 
from EmployeeDemographics inner join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- join means inner join

select * 
from EmployeeDemographics full outer join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

select * 
from EmployeeDemographics left outer join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

select EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
from EmployeeDemographics inner join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

select EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
from EmployeeDemographics inner join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
where FirstName <> 'Michael'
order by Salary DESC

select JobTitle, avg(salary)
from EmployeeDemographics inner join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
where JobTitle = 'Salesman'
group by JobTitle
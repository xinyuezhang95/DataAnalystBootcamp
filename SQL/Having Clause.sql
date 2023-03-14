/*
Having Clause
*/

select JobTitle, count(JobTitle)
from EmployeeDemographics join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
group by JobTitle
having count(JobTitle) > 1

select JobTitle, avg(Salary)
from EmployeeDemographics join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
group by JobTitle
having avg(salary) > 45000
order by avg(salary)

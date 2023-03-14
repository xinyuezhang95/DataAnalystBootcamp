/*
CTEs: Common Table Expression; also called 'with queries'
*/

with CTE_Employee as (select demo.FirstName, demo.LastName, demo.Gender, sal.Salary, count(Gender) over (partition by Gender) as TotalGender,
avg(Salary) over (partition by Gender) as AvgSalary
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID
where salary > 45000
)
select FirstName, AvgSalary from CTE_Employee
--CTE is not stored anywhere
--select statement needs to be put directly after the cte created
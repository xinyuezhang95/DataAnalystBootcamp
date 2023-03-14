/*
Partition By -- a really powerful statement

Comparion with Group by: 
GROUP BY modifies the entire query, but PARTITION BY just works on a window function.

GROUP BY normally reduces the number of rows returned by rolling them up and calculating averages or sums for each row.
PARTITION BY does not affect the number of rows returned, but it changes how a window function's result is calculated.

*/

select demo.FirstName, demo.LastName, demo.Gender, sal.Salary, count(Gender) over (partition by Gender) as TotalGender
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID

select demo.FirstName, demo.LastName, demo.Gender, sal.Salary, count(Gender) as TotalGender
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID
group by FirstName, LastName, Gender, Salary

select demo.Gender, count(Gender) as TotalGender
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID
group by Gender
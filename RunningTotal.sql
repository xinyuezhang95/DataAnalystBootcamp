--select * from EmployeeSalary

select EmployeeID, JobTitle, Salary, 
sum(isNull(Salary, 0)) over (order by EmployeeID) as SumSalary
from EmployeeSalary
order by EmployeeID

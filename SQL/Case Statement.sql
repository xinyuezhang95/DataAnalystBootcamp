/*
Case Statement: categorize, label, calculate
*/

select FirstName, LastName, Age
from EmployeeDemographics
where Age is not null
order by Age

select FirstName, LastName, Age,
case
	when Age > 30 then 'Old'
	else 'Young'
end
from EmployeeDemographics
where Age is not null
order by Age

select FirstName, LastName, Age,
case
	when Age > 35 then 'Old'
	when Age between 30 and 35 then 'Young'
	else 'Baby'
end
from EmployeeDemographics
where Age is not null
order by Age

select FirstName, LastName, Age,
case
	when Age > 35 then 'Old'
	when Age = 38 then 'Stanley'
	else 'Baby'
end
from EmployeeDemographics
where Age is not null
order by Age

select FirstName, LastName, Age,
case
	when Age = 38 then 'Stanley'
	when Age > 35 then 'Old'
	else 'Baby'
end
from EmployeeDemographics
where Age is not null
order by Age

select FirstName, LastName, JobTitle, Salary,
case
	when JobTitle = 'Salesman' then Salary + (Salary * 0.1)
	when JobTitle = 'Accountant' then salary + (salary * 0.05)
	else Salary + (Salary * .03)
end as SalaryAfterRaise
from EmployeeDemographics join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

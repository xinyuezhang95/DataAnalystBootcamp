/* 
Select statement
*, Top, Distinct, Count, As, Max, Min, Avg 
*/

SELECT TOP 5 *
FROM EmployeeDemographics

select distinct (gender)
from EmployeeDemographics

select count(LastName) as LastNameCount
from EmployeeDemographics

select max(salary)
from EmployeeSalary

select min(salary)
from EmployeeSalary

select avg(salary)
from EmployeeSalary

select * from SQLTutorial.dbo.EmployeeSalary
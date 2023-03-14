/*
Temp Tables
*/

create table #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

select * from #temp_Employee

insert into #temp_Employee values (
'1001', 'HR', 45000)

insert into #temp_Employee 
select * from EmployeeSalary
--this is one of the big uses of temp table
--it doesn't need to be created every time like CTE

--how it is actually used:
drop table if exists #temp_employee2
create table #temp_employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

insert into #temp_employee2
select JobTitle, count(JobTitle), Avg(Age), Avg(Salary) 
from EmployeeDemographics join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
group by JobTitle

select * from #temp_employee2
--reduce run time, process speed and storage

--store procedure

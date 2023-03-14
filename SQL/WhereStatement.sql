/*
Where Statement
=, <>, <, >, And, Or, Like, Null, Not Null, In
*/

select * from EmployeeDemographics
where FirstName = 'Jim'

select * from EmployeeDemographics
where FirstName <> 'Jim'

select * from EmployeeDemographics
where Age > 30

select * from EmployeeDemographics
where Age >= 30

select * from EmployeeDemographics
where Age < 32

select * from EmployeeDemographics
where Age <= 32 and Gender = 'Male'

select * from EmployeeDemographics
where Age <= 32 or Gender = 'Male'

select * from EmployeeDemographics
where LastName like 'S%'

select * from EmployeeDemographics
where LastName like '%S%'

select * from EmployeeDemographics
where LastName like 's%o%'

select * from EmployeeDemographics
where FirstName is not null

select * from EmployeeDemographics
where FirstName in ('Jim', 'Michael') 
--a condense way to say equal statement
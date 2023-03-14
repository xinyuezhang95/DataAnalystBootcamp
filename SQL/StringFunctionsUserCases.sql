/*
String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
*/

--Drop Table EmployeeErrors;


CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

-- Using Trim, LTRIM, RTRIM

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors 
--Trim: get rid of both left and right sides

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 
--Rtrim: get rid of right sides

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 
--Ltrim: get rid of left sides


-- Using Replace

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors


-- Using Substring

select SUBSTRING(FirstName, 1, 3)
from EmployeeErrors

select SUBSTRING(FirstName, 3, 3)
from EmployeeErrors

--Alex, Alexander --> a fussy match: substring(firstname, 1, 4)
Insert into EmployeeDemographics VALUES
(1061, 'Toby', 'Zhang', 25, 'Male')

Select *
From EmployeeDemographics

Select *
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on err.FirstName = dem.FirstName

Select err.FirstName, dem.FirstName
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on err.FirstName = dem.FirstName

Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)
--better match: Gender, Age, date of birth

-- Using UPPER and lower

Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors
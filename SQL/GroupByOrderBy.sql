/*
Group By, Order By
*/

select Gender, count(Gender)
from EmployeeDemographics
group by Gender

select Gender, Age, count(Gender)
from EmployeeDemographics
group by Gender, Age

select Gender, Age, count(Gender)
from EmployeeDemographics
where Age > 31
group by Gender, Age

select Gender, count(Gender) as CountGender
from EmployeeDemographics
where Age > 31
group by Gender
order by CountGender DESC

SELECT * FROM EmployeeDemographics
ORDER BY Age DESC, Gender DESC

SELECT * FROM EmployeeDemographics
ORDER BY 4 desc, 5 desc
--number here means the # order of columns
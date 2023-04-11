/*

Explore covid data in SQL queries

*/

-- Step 0: Download data from https://ourworldindata.org/coronavirus
-- Make sure to select all time periods; Then import data from csv to SQL

-- Step 1: Check data to make sure we have the correct ones
select * 
from CovidDeaths
order by 3, 4;

select * 
from CovidVaccinations
order by 3, 4

-- Step 2: Select data that we are going to use
select location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
order by 1, 2;

-- Step 3: Looking at Total Cases vs Total Deaths
-- shows the likelihood of dying if you contract covid in your country
select location, date, total_cases, total_deaths, 
(convert(decimal(15,3), total_deaths)/(convert(decimal(15, 3), total_cases))) * 100 as DeathPercentage
from CovidDeaths
order by 1, 2;
--(self) Note 1: We can see that for Afghanistan, when date = 2021-04-30, the deathPercentage is about 4, 
--which means that as of April 30, 2021, 
--if u are in Afghanistan, u have a 4% chance of dying if you get COVID

--Note 2: I added the covert function in the above query
--because without convert, I got the error 'Operand data type varchar is invalid for divide operator'
--another way to convert is to use the cast() function

select location, date, total_cases, total_deaths, 
(convert(decimal(15,3), total_deaths)/(convert(decimal(15, 3), total_cases))) * 100 as DeathPercentage
from CovidDeaths
where location like '%states%'
order by 1, 2;
--We can see a peak of death percentage for United States at around the start of May, 2020

-- Step 4: Looking at Total Cases vs Population
-- shows whar percentage of population got covid
select location, date, population, total_cases, 
(convert(decimal(15,3), total_cases)/(convert(decimal(15, 3), population))) * 100 as PercentPopulationInfected
from CovidDeaths
where location like '%states%'
order by 1, 2;
--We can see that as of April, 2023, 10% of the US population got COVID

-- Step 5: Look at countries with highest infection rate compared to population
select location, population, max(total_cases) as HighestInfectionCount,
max(convert(decimal(15,3), total_cases)/(convert(decimal(15, 3), population))) * 100 as PercentPopulationInfected
from CovidDeaths
--where location like '%states%'
group by location, population
order by PercentPopulationInfected desc;

-- Step 6: Show countries with highest death count per population
select location, max(cast(total_deaths as int)) as HighestDeathCount
from CovidDeaths
--where location like '%states%'
where continent is not null
group by location
order by HighestDeathCount desc;
--some modifications/ exploration on the data:
-- (1). the datatype of total_deaths is nvarchar(225), and we need to convert it to integer
-- (2). some location is 'World', 'Asia', etc., so we need to filter this by 'where continent is not null'

select location, max(cast(total_deaths as int)) as HighestDeathCount
from CovidDeaths
--where location like '%states%'
where continent is null
group by location
order by HighestDeathCount desc;
--If we choose 'where continent is null', we can get all the summary data

-- Step 7: Let's break things down by continent
-- Show continents with the highest death count per population
select continent, max(cast(total_deaths as int)) as HighestDeathCount
from CovidDeaths
--where location like '%states%'
where continent is not null
group by continent
order by HighestDeathCount desc;

-- Step 8: Global numbers
select date, sum(new_cases) as TotalCases, sum(new_deaths) as TotalDeaths, 
(sum(new_deaths)/nullif(sum(new_cases), 0)) * 100 as DeathPercentage
from CovidDeaths
--where location like '%states%'
where continent is not null
group by date
order by 1, 2;
--add the nullif() function to avoid the error 'Divide by zero error encountered'

select date, sum(cast(total_cases as int)) as TotalCases, sum(cast(total_deaths as int)) as TotalDeaths, 
(sum(convert(decimal(15,3), total_deaths))/sum(convert(decimal(15, 3), total_cases))) * 100 as DeathPercentage
from CovidDeaths
--where location like '%states%'
where continent is not null
group by date
order by 1, 2;

--remove date
select sum(cast(total_cases as int)) as TotalCases, sum(cast(total_deaths as int)) as TotalDeaths, 
(sum(convert(decimal(15,3), total_deaths))/sum(convert(decimal(15, 3), total_cases))) * 100 as DeathPercentage
from CovidDeaths
--where location like '%states%'
where continent is not null
--group by date
order by 1, 2;

-- Step 9: join the two tables; looking at total population vs vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2, 3;
--for example, we can tell that for Canada, people started getting vaccinations since December 15, 2020

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/dea.population)*100 --Error! Need to use a temp table or a CTE
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
and dea.date < '2021-04-30'  --need to add a filter for date due to big amount of data
order by 2, 3;

-- Step 9.1: Use CTE
with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
and dea.date < '2021-04-30'  --need to add a filter for date due to big amount of data
--order by 2, 3
)
select *, (RollingPeopleVaccinated/Population) * 100
from PopvsVac

-- Step 9.2: Use Temp table
drop table if exists #PercentPopulationVaccinated
create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric, 
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
and dea.date < '2021-04-30'  --need to add a filter for date due to big amount of data
--order by 2, 3

select *, (RollingPeopleVaccinated/Population) * 100
from #PercentPopulationVaccinated

-- Step 10: Create view to store data for later visualizations
create view PercentPopulationVaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
and dea.date < '2021-04-30'  --need to add a filter for date due to big amount of data
--order by 2, 3

--ctrl + shift + R: to remove red lines!!!

select *
from PercentPopulationVaccinated;
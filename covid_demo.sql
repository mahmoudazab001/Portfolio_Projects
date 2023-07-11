select
 *
from
 [Portfolio Project]..covid_deaths
--where continent is not null
order by 4 desc

select
*
from
 [Portfolio Project]..covid_vaccinations

select
 location,date,population,total_cases,new_cases,total_deaths
from
 [Portfolio Project]..covid_deaths
order by 1,2

-- we needed to alter (total_cases,total_deaths) data type into float
  
alter table [Portfolio Project]..covid_deaths
alter column total_cases float

alter table [Portfolio Project]..covid_deaths
alter column total_deaths float

alter table [Portfolio Project]..covid_vaccinations
alter column people_vaccinated float

--total_cases vs total deaths

select
 location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as death_percentage
from
 [Portfolio Project]..covid_deaths
where location ='Egypt'
order by 1,2


--population vs total cases
--percentage of egypt's population that got infected
select
 location,date,population,total_cases, (total_cases/population)*100 as infection_percentage
from
 [Portfolio Project]..covid_deaths
where location ='Egypt'
order by 1,2


--country with the highest infection rate
select
 location,population,max(total_cases) as highest_infection_count,
  max(total_cases/population)*100 as population_inf_percentage
from
 [Portfolio Project]..covid_deaths
where continent is not null
group by location,population
order by population_inf_percentage desc

--country with highest death rate
select
 location,population,max(total_deaths) as highest_death_count,
  max(total_deaths/population)*100 as population_death_percentage
from
 [Portfolio Project]..covid_deaths
where continent is not null
group by location,population
order by population_death_percentage desc


--country with the higest death count
select
 location,max(total_deaths) as highest_death_count
from
 [Portfolio Project]..covid_deaths
where continent is not null
group by location
order by highest_death_count desc



--continunt breckdown;

---highest death rate/continent
select
 location,max(total_deaths) as highest_death_count,
  max(total_deaths/population)*100 as population_death_percentage
from
 [Portfolio Project]..covid_deaths
where continent is  null and 
  location not in ('World','Upper middle income','High income','Lower middle income','Low income')
group by location
order by population_death_percentage desc


---highest infection rate/continent
select
 location,max(total_cases) as highest_cases_count,
  max(total_cases/population)*100 as population_infection_percentage
from
 [Portfolio Project]..covid_deaths
where continent is  null and 
  location not in ('World','Upper middle income','High income','Lower middle income','Low income')
group by location
order by population_infection_percentage desc



--the effect of income on;

--death rate / infection rate
select
 location,population,max(total_deaths) as highest_death_count,
  max(total_deaths/population)*100 as population_death_percentage,
  max(total_cases) as highest_infection_count,
  max(total_cases/population)*100 as population_inf_percentage
from
 [Portfolio Project]..covid_deaths
where location in ('Upper middle income','High income','Lower middle income','Low income')
group by location,population
order by population_death_percentage desc


--total cases/day, deaths/day
select
 date,sum(new_cases) as total_patients_per_day ,sum(new_deaths) as total_deaths_per_day,
  sum(new_deaths)/SUM(new_cases)*100  as death_percentage
from
 [Portfolio Project]..covid_deaths
where continent is not null and 
 new_cases <> 0
group by date
order by 1 


--global total death percentage
Select 
 SUM(new_cases) as total_cases_global, SUM(new_deaths) as total_deaths_global, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage_global
From 
 [Portfolio Project]..covid_deaths
where continent is not null 
--Group By date
order by 1,2


--death percentage per year/total cases/total deaths
select
  year(date) as year,sum(new_cases) as total_new_patients_per_month ,sum(new_deaths) as total_new_deaths_per_month,
  sum(new_deaths)/SUM(new_cases)*100  as death_percentage
from
 [Portfolio Project]..covid_deaths
where continent is not null and 
 new_cases <> 0 
group by YEAR(date)
order by 1 

--death percentage per month/total cases/total deaths

--year 2020
select
  year(date) as year,month(date) as month ,sum(new_cases) as total_new_patients_per_month ,sum(new_deaths) as total_new_deaths_per_month,
  sum(new_deaths)/SUM(new_cases)*100  as death_percentage
from
 [Portfolio Project]..covid_deaths
where continent is not null and 
 new_cases <> 0 and date like '%2020%'
group by month(date),year(date)
order by 2

--year 2021
select
  year(date) as year,month(date) as month ,sum(new_cases) as total_new_patients_per_month ,sum(new_deaths) as total_new_deaths_per_month,
  sum(new_deaths)/SUM(new_cases)*100  as death_percentagee
from
 [Portfolio Project]..covid_deaths
where continent is not null and 
 new_cases <> 0 and date like '%2021%'
group by month(date),year(date)
order by 2

--year2022
select
  year(date) as year,month(date) as month ,sum(new_cases) as total_new_patients_per_month ,sum(new_deaths) as total_new_deaths_per_month,
  sum(new_deaths)/SUM(new_cases)*100  as death_percentage
from
 [Portfolio Project]..covid_deaths
where continent is not null and 
 new_cases <> 0 and date like '%2022%'
group by month(date),year(date)
order by 2

--year2023
select
  year(date) as year,month(date) as month ,sum(new_cases) as total_new_patients_per_month ,sum(new_deaths) as total_new_deaths_per_month,
  sum(new_deaths)/SUM(new_cases)*100  as death_percentage
from
 [Portfolio Project]..covid_deaths
where continent is not null and 
 new_cases <> 0 and date like '%2023%'
group by month(date),year(date)
order by 2 desc



-- exploring total population vs  vaccinations
select
 dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 SUM(convert(float,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as new_vaccination_count
from
 [Portfolio Project]..covid_deaths as dea
  join
 [Portfolio Project]..covid_vaccinations as vac
   on dea.location = vac.location
  and dea.date = vac.date
where dea.continent is not null
order by 2,3


--using CTE table to totalpopulation vs total vaccination

with PopVsVac (continent,location,date,population,new_vaccination,new_vaccination_count)
as
(
select
 dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 SUM(convert(float,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as new_vaccination_count
from
 [Portfolio Project]..covid_deaths as dea
  join
 [Portfolio Project]..covid_vaccinations as vac
   on dea.location = vac.location
  and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select
 *, max(new_vaccination_count/population)*100 as vacination_percentage
from
 PopVsVac
group by continent,location,date,population,new_vaccination,new_vaccination_count


--we can use a TEMP table as another solution to CTE 
--"just for demonstration purposes"

drop table if exists #population_vaccinated_percentage
create table #population_vaccinated_percentage
(
 Continent nvarchar(255),
 Location nvarchar(255),
 Date datetime,
 Population numeric,
 new_vaccinations numeric,
 new_vaccination_count numeric
)

insert into #population_vaccinated_percentage
select
 dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 SUM(convert(float,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as new_vaccination_count
from
 [Portfolio Project]..covid_deaths as dea
  join
 [Portfolio Project]..covid_vaccinations as vac
   on dea.location = vac.location
  and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

select
 *, max(new_vaccination_count/population)*100 as vacination_percentage
from
  #population_vaccinated_percentage
where continent is not null
group by continent,location,date,population,new_vaccinations,new_vaccination_count
order by 1,2


-- people vccinated vs people fully vaccinated

With VacVsFullyVac (location,total_people_vaccinated,total_people_fully_vaccinated ) 
as
(
select
 location, max(convert(float,people_vaccinated)) as total_people_vaccinated,
  max(convert(int,people_fully_vaccinated)) as total_people_fully_vaccinated
from
 [Portfolio Project]..covid_vaccinations 
where continent is not null
group by location
--order by 1
)
select
 *,(total_people_vaccinated-total_people_fully_vaccinated) as total_people_not_fully_vaccinated
from
 VacVsFullyVac
order by 1



--relation of life expectancy with

--hospital beds per thousand 
select
 location,population,hospital_beds_per_thousand,life_expectancy
from
 [Portfolio Project]..covid_vaccinations
where
 continent is not null
group by 
 location,population,hospital_beds_per_thousand,life_expectancy
order by
 4 desc


 --population_density
select
 location,population,population_density,life_expectancy
from
 [Portfolio Project]..covid_vaccinations
where
 continent is not null
group by 
 location,population,population_density,life_expectancy
order by
 4 desc



 --total people vaccinated
select
 location,population,max(people_vaccinated) as total_people_vaccinated,
 max(people_vaccinated/population)*100 as total_population_percentage,
 life_expectancy
from
 [Portfolio Project]..covid_vaccinations
where
 continent is not null
group by 
 location,population,life_expectancy
order by
 5 desc




--creating views

--population vs vaccination
create view population_vaccinated_percentage as 
select
 dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 SUM(convert(float,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as new_vaccination_count
from
 [Portfolio Project]..covid_deaths as dea
  join
 [Portfolio Project]..covid_vaccinations as vac
   on dea.location = vac.location
  and dea.date = vac.date
where dea.continent is not null
--order by 2,3


--number of patients,deaths in each month per year
create view patients_deaths_num_per_month as
select
  year(date) as year,month(date) as month,sum(new_cases) as total_new_patients_per_month ,sum(new_deaths) as total_new_deaths_per_month,
  sum(new_deaths)/SUM(new_cases)*100  as death_percentage
from
 [Portfolio Project]..covid_deaths
where continent is not null and 
 new_cases <> 0 
group by YEAR(date),MONTH(date)
--order by 1,2 

--statistics of people with different income levels
create view different_income_levels as
select
 dea.location,dea.population,max(total_deaths) as total_death_count,
  max(total_deaths/dea.population)*100 as population_death_percentage,
  max(total_cases) as total_infection_count,
  max(total_cases/dea.population)*100 as population_inf_percentage,
  max(vac.people_vaccinated) as total_people_vaccinated,
  max(vac.people_vaccinated/dea.population)*100 as population_vaccinations_percentage
from
  [Portfolio Project]..covid_deaths as dea
 join
  [Portfolio Project]..covid_vaccinations as vac
   on dea.location = vac.location
   and dea.population = vac.population
where dea.location in ('Upper middle income','High income','Lower middle income','Low income')
group by dea.location,dea.population
--order by population_death_percentage desc

--continent breakdown
create view continent_breakdown as 
select
 dea.location,dea.population,max(total_cases) as total_cases_count,
  max(total_cases/dea.population)*100 as population_infection_percentage,
  max(total_deaths) as total_death_count,
  max(total_deaths/dea.population)*100 as population_death_percentage,
  max(vac.people_vaccinated) as total_people_vaccinated,
  max(vac.people_vaccinated/dea.population)*100 as population_vaccinations_percentage
from
 [Portfolio Project]..covid_deaths as dea
 join
  [Portfolio Project]..covid_vaccinations as vac
   on dea.location = vac.location
   and dea.population = vac.population
where dea.continent is  null and 
  dea.location not in ('World','Upper middle income','High income','Lower middle income','Low income')
group by dea.location,dea.population
--order by population_death_percentage desc

--countries breakdown
create view country_breakdown as
select
 dea.location,dea.population,max(total_cases) as total_cases_count,
  max(total_cases/dea.population)*100 as population_infection_percentage,
  max(total_deaths) as total_death_count,
  max(total_deaths/dea.population)*100 as population_death_percentage,
  max(vac.people_vaccinated) as total_people_vaccinated,
  max(vac.people_vaccinated/dea.population)*100 as population_vaccinations_percentage
from
 [Portfolio Project]..covid_deaths as dea
 join
  [Portfolio Project]..covid_vaccinations as vac
   on dea.location = vac.location
   and dea.population = vac.population
where dea.continent is not null
group by dea.location,dea.population
--order by highest_death_count desc


--number of people not fully vaccinated
create view people_not_fully_vaccinated as
With VacVsFullyVac (location,total_people_vaccinated,total_people_fully_vaccinated ) 
as
(
select
 location, max(convert(float,people_vaccinated)) as total_people_vaccinated,
  max(convert(float,people_fully_vaccinated)) as total_people_fully_vaccinated
from
 [Portfolio Project]..covid_vaccinations 
where continent is not null
group by location
--order by 1
)
select
 *,(total_people_vaccinated-total_people_fully_vaccinated) as total_people_not_fully_vaccinated
from
 VacVsFullyVac
--order by 1





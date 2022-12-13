SELECT *
FROM PortfolioProject.dbo.Data1

SELECT *
FROM PortfolioProject.dbo.Data2

--number of rows in the dataset

SELECT COUNT(*)
FROM	PortfolioProject.dbo.Data1
SELECT COUNT(*)
FROM	PortfolioProject.dbo.Data2

SELECT *
FROM PortfolioProject.dbo.Data1
WHERE state IN ('Jharkhand', 'Bihar')

--population of India

SELECT  SUM(population) AS Population
from PortfolioProject.dbo.Data2

-- avg growth

SELECT state, AVG(growth)*100 AS avg_growth
FROM  PortfolioProject.dbo.Data1
GROUP BY State

--avg sex ratio

SELECT state, round(AVG(Sex_Ratio),0) AS avg_sex_ratio
FROM  PortfolioProject.dbo.Data1
GROUP BY State
ORDER BY avg_sex_ratio desc

--avg literacy rate

SELECT state, round(AVG(Literacy),0) AS avg_literacy_rate
FROM  PortfolioProject.dbo.Data1
GROUP BY State
HAVING round(AVG(Literacy),0) > 90
ORDER BY avg_literacy_rate desc


--top 3 states showing highest growth ratio

SELECT top 3 state, AVG(growth)*100 AS avg_growth
FROM  PortfolioProject.dbo.Data1
GROUP BY State
ORDER BY avg_growth desc

--bottom 3 state showing lowest sex ratio

SELECT top 3 state, round(AVG(Sex_Ratio),0) AS avg_sex_ratio
FROM  PortfolioProject.dbo.Data1
GROUP BY State
ORDER BY avg_sex_ratio asc


--top and bottom 3 state in literacy state

drop table if exists #topstates;
create table #topstates
( state nvarchar (255),
 topstates float

 )

 insert into #topstates
 SELECT state, round(AVG(literacy),0) AS avg_literacy_ratio
FROM  PortfolioProject.dbo.Data1
GROUP BY State
ORDER BY avg_literacy_ratio desc;

SELECT top 3 * 
FROM #topstates
order by #topstates.topstates desc;


drop table if exists #bottomstates;
create table #bottomstates
( state nvarchar (255),
 bottomstates float

 )

 insert into #bottomstates
 SELECT state, round(AVG(literacy),0) AS avg_literacy_ratio
FROM  PortfolioProject.dbo.Data1
GROUP BY State
ORDER BY avg_literacy_ratio desc;

SELECT top 3 * 
FROM #bottomstates
order by #bottomstates.bottomstates asc;


--union operator

SELECT * from (
SELECT top 3 * 
FROM #topstates
order by #topstates.topstates desc) a

UNION

SELECT * from (
SELECT top 3 * 
FROM #bottomstates
order by #bottomstates.bottomstates asc) b


--states starting with letter a 

select distinct State
from PortfolioProject.dbo.Data1
where lower(state) like 'a%' or lower(state) like 'b%'

select distinct State
from PortfolioProject.dbo.Data1
where lower(state) like 'a%' or lower(state) like '%m'


--joining both tables + subquery to find males and females


SELECT	d.state, sum(d.males) total_males, sum(d.females) total_females
FROM
(SELECT c.District, c.state, round(c.population/(c.sex_ratio+1), 0) males, round((c.population*c.sex_ratio)/(c.sex_ratio+1), 0) females 
from
(SELECT a.district, a.state, a.Sex_Ratio/1000 sex_ratio, b.Population 
FROM PortfolioProject.dbo.Data1 a
INNER JOIN PortfolioProject.dbo.Data2 b
ON a.District = b.District) c) d
GROUP BY	d.State;


--total literacy rate + subquery


SELECT c.state, sum(literate_people) total_literate_pop, sum(illiterate_people) total_illiterate_pop
FROM
(SELECT d.district, d.state, round(d.literacy_ratio*d.population, 0) literate_people, round((1-d.literacy_ratio)*d.population, 0) illiterate_people
FROM
(SELECT a.district, a.state, a.literacy/100 literacy_ratio, b.Population 
FROM PortfolioProject.dbo.Data1 a
INNER JOIN PortfolioProject.dbo.Data2 b
ON a.District = b.District) d) c
GROUP BY c.state


--population in previous census + subquery


SELECT sum(m.previous_census_population) previous_census_population, sum(current_census_population) current_census_population
FROM(
SELECT e.state, sum(e.previous_census_population) previous_census_population, sum(e.current_census_population) current_census_population
FROM
(SELECT d.district, d.state, round(d.population/(1+d.growth), 0) previous_census_population, d.population current_census_population
FROM
(SELECT a.district, a.state, a.Growth growth, b.Population 
FROM PortfolioProject.dbo.Data1 a
INNER JOIN PortfolioProject.dbo.Data2 b
ON a.District = b.District) d) e
GROUP BY e.state) m


--Olympics - Data Analytics

SELECT *
FROM PortfolioProject.dbo.athlete_events

SELECT *
FROM PortfolioProject.dbo.noc_regions

--Number of regions in the dataset

SELECT COUNT(distinct region) as TotalRegions
FROM PortfolioProject.dbo.noc_regions

--Total number of female and male by gender

SELECT Sex, count(*) as TotalNumberM_F
FROM PortfolioProject.dbo.athlete_events
GROUP BY Sex
ORDER BY 2;

-- Total number of male and female by city

SELECT City, Sex, COUNT(*) as total_number,
       SUM(CASE WHEN Sex = 'M' THEN 1 ELSE 0 END) as Male,
       SUM(CASE WHEN Sex = 'F' THEN 1 ELSE 0 END) as Female
FROM PortfolioProject.dbo.athlete_events
GROUP BY City, Sex
ORDER BY 4 desc, 5 desc

--Number of male and female who won medals

SELECT Medal, SUM(CASE WHEN Sex = 'M' THEN 1 ELSE 0 END) as MedalsMale, SUM(CASE WHEN Sex = 'F' THEN 1 ELSE 0 END) as MedalsFemale
FROM PortfolioProject.dbo.athlete_events
WHERE Medal = 'Gold'
group by Medal
ORDER by Medal

SELECT Medal, SUM(CASE WHEN Sex = 'M' THEN 1 ELSE 0 END) as MedalsMale, SUM(CASE WHEN Sex = 'F' THEN 1 ELSE 0 END) as MedalsFemale
FROM PortfolioProject.dbo.athlete_events
WHERE Medal = 'Silver'
group by Medal
ORDER by Medal

SELECT Medal, SUM(CASE WHEN Sex = 'M' THEN 1 ELSE 0 END) as MedalsMale, SUM(CASE WHEN Sex = 'F' THEN 1 ELSE 0 END) as MedalsFemale
FROM PortfolioProject.dbo.athlete_events
WHERE Medal = 'Bronze'
group by Medal
ORDER by Medal

--Number of Gold Medal from each country//Top 5 countries

SELECT TOP 5 MAX(Medal) as Medal, count(*) as NumberOfGold, region
FROM PortfolioProject.dbo.athlete_events a
INNER JOIN PortfolioProject.dbo.noc_regions n on a.NOC = n.NOC
WHERE Medal = 'Gold'
GROUP BY region
ORDER BY 2 DESC

--Age distribution of the participants

SELECT CASE WHEN Age < 20 THEN '0-20' WHEN Age BETWEEN 20 AND 30 THEN '20-30'
WHEN Age BETWEEN 30 AND 40 THEN '30-40' WHEN Age BETWEEN 40 AND 50 THEN '40-50'
WHEN Age BETWEEN 50 AND 60 THEN '50-60' WHEN Age BETWEEN 60 AND 70 THEN '60-70'
WHEN Age BETWEEN 70 AND 80 THEN '70-80' WHEN Age > 80 THEN 'Above 80' END AS age_range, Age, count(Age) as count_age
FROM PortfolioProject.dbo.athlete_events
GROUP BY Age
ORDER BY age_range, count_age desc

--List of country with the highest number of participants by season 

SELECT TOP 10 Team, Season, COUNT(*) AS Participants
FROM PortfolioProject.dbo.athlete_events
GROUP BY Team, Season
ORDER BY Participants desc, Season


--Countries that have won the highest number of medal

SELECT TOP 20 Team, count(Medal) as Total
FROM PortfolioProject.dbo.athlete_events
WHERE Medal in ('gold', 'silver', 'bronze')
GROUP BY Team
ORDER BY Total desc

--Medal attained in Rio Olympics 2016

SELECT TOP 20 Team, Year, COUNT(Medal) as NumberGoldMedals
FROM PortfolioProject.dbo.athlete_events
WHERE Medal = 'Gold' and Year = 2016
GROUP BY Team, Year
ORDER by 3 desc

--Number of athletes in summer season vs in winter season

SELECT Season, 
	SUM(CASE WHEN season = 'summer' THEN 1 ELSE 0 END) AS SummerSport, 
	SUM(CASE WHEN season = 'winter' THEN 1 ELSE 0 END) AS WinterSport
FROM PortfolioProject.dbo.athlete_events
WHERE Year >= 1986
group by Season

--List the top 10 most popular sport events for women

SELECT TOP 10 Event, COUNT(*) AS PopularSports
FROM PortfolioProject.dbo.athlete_events
WHERE Sex = 'F'
GROUP BY Event
ORDER BY 2 desc

--List the top 10 most popular sport events for men

SELECT TOP 10 Event, COUNT(*) AS PopularSports
FROM PortfolioProject.dbo.athlete_events
WHERE Sex = 'M'
GROUP BY Event
ORDER BY 2 desc
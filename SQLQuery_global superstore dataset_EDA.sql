SELECT COUNT(*)
FROM [Portfolio_Project].[dbo].Orders$

SELECT *
FROM [Portfolio_Project].[dbo].Orders$
ORDER BY 1

--check if other IDs are primary keys or not

SELECT [Order ID], count(*)
FROM [Portfolio_Project].[dbo].Orders$
group by [Order ID]
having count(*)>1

SELECT *
FROM [Portfolio_Project].[dbo].Orders$
where [Order ID]= 'AG-2013-8490'

select [Row ID], [Order ID], count(*)
from [Portfolio_Project].[dbo].Orders$
group by [Row ID], [Order ID]
having count(*)>1

--check mistakes
select *
from [Portfolio_Project].[dbo].Orders$
where [Ship Date]<[Order Date]

--check distinct ship modes

select distinct [Ship Mode]
from [Portfolio_Project].[dbo].Orders$

--whats the time range

select DATEDIFF(DAY, [Order Date], [Ship Date]) as NumofDays, *
from [Portfolio_Project].[dbo].Orders$
where [Ship Mode]='Second Class'

--min and max for the second class

select min(a.NumofDays), max(a.NumofDays)
from
(
select DATEDIFF(DAY, [Order Date], [Ship Date]) as NumofDays, *
from [Portfolio_Project].[dbo].Orders$
where [Ship Mode]='Second Class'
) a

--see if customer can order multiple items or not

select [Customer ID], [Order ID], count(*)
from [Portfolio_Project].[dbo].Orders$
group by [Customer ID], [Order ID]
order by [Customer ID]

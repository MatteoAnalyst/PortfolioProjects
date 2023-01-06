
-- SUPERMARKET SALES ANALYSIS


SELECT *
FROM PortfolioProject.dbo.supermarket_sales

--Which branch has the best results in the loyalty program? Ans. Branch C

SELECT Branch, COUNT(*) AS best_loyalty_program
FROM PortfolioProject.dbo.supermarket_sales
GROUP BY Branch
ORDER BY best_loyalty_program DESC

SELECT Branch, count([Customer type]) AS Loyalty_Program
FROM PortfolioProject.dbo.supermarket_sales
WHERE [Customer type] LIKE '%Member'
Group by Branch
order by Branch desc

SELECT Branch, count([Customer type]) AS Not_Loyalty_Program
FROM PortfolioProject.dbo.supermarket_sales
WHERE [Customer type] LIKE '%Normal'
Group by Branch
order by Branch desc

---Does the membership depend on customer rating?

--1)group the data by membership and compute the average rating for each group
SELECT [Customer type], AVG(rating) as average_rating
FROM PortfolioProject.dbo.supermarket_sales
GROUP BY [Customer type]
ORDER BY average_rating DESC;

--2)membership categories that have an average rating higher than the overall average rating for all membership categories
SELECT [Customer type], AVG(rating) as average_rating
FROM PortfolioProject.dbo.supermarket_sales
GROUP BY [Customer type]
HAVING AVG(rating) > (SELECT AVG(rating) FROM PortfolioProject.dbo.supermarket_sales);


---Does gross income depend on the proportion of customers in the loyalty program? On payment method?

SELECT Payment, SUM([gross income]) as total_gross_income
FROM PortfolioProject.dbo.supermarket_sales
GROUP BY Payment;

SELECT [Customer type], Payment, SUM([gross income]) as total_gross_income, COUNT([Invoice ID]) as num_customers
FROM PortfolioProject.dbo.supermarket_sales
GROUP BY Payment, [Customer type];

SELECT [Customer type], SUM([gross income]) as total_gross_income
FROM PortfolioProject.dbo.supermarket_sales
GROUP BY [Customer type];


---Which product category generates the highest income?

SELECT [Product line], SUM([gross income]) AS highest_income
FROM PortfolioProject.dbo.supermarket_sales
group by [Product line]
order by highest_income desc

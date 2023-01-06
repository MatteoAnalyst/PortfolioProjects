

SELECT *
FROM PortfolioProject.dbo.cereal

EXEC sp_rename 'PortfolioProject.dbo.cereal.name', 'name_of_cereal', 'COLUMN';

--What is the average content of each nutrient and element per manufacturer?
SELECT mfr, AVG(fat) as g_fat, AVG(protein) as g_protein, AVG(carbo) as g_carbs, 
AVG(fiber) as g_fiber, AVG(sugars) as g_sugar, AVG(potass) as ml_potassium, AVG(vitamins) as percentage_vitamins, 
AVG(sodium) as ml_sodium
FROM PortfolioProject.dbo.cereal
GROUP BY mfr;

--What is the number of calories per ounce for each product?
SELECT name_of_cereal, calories / weight AS calories_per_ounce
FROM PortfolioProject.dbo.cereal;

--What is the average rating per manufacturer?
SELECT mfr, AVG(rating) as average_rating
FROM PortfolioProject.dbo.cereal
GROUP BY mfr;

--Which manufacturer possesses the best shelf location?
SELECT mfr, shelf as best_shelf_location
FROM PortfolioProject.dbo.cereal
group by mfr, shelf
order by mfr, best_shelf_location desc

--What is the nutritional value of each cereal according to protein, fat, and carbohydrate data.
SELECT name_of_cereal, protein as g_protein, fat as g_fat, carbo as g_carbs
FROM PortfolioProject.dbo.cereal

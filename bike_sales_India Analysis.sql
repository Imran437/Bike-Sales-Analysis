Create Database bikedb;

USE bikedb;

SELECT * FROM bike_sales_india;

SELECT COUNT(*) AS TotalRows FROM bike_sales_india;


-- Finding null values 

SELECT * FROM bike_sales_india WHERE state IS NULL;


SELECT DISTINCT state FROM bike_sales_india;

-- Finding empty Strings 

SELECT * FROM bike_sales_india WHERE Fuel_Type = '';


-- Check for blank space 

SELECT * FROM bike_sales_india WHERE TRIM(State) = '';



SELECT DISTINCT fuel_type FROM bike_sales_india;

-- change datatype of price from int to float 

ALTER TABLE bike_sales_india  
ALTER COLUMN price_INR float;


-- view data 

SELECT TOP 10 * FROM bike_sales_india;








-- Check column statistics 

SELECT COUNT(*) AS total_records, COUNT(DISTINCT Brand) AS unique_Brand, 
COUNT(DISTINCT Model) AS unique_Model FROM bike_sales_india;





-- Decriptive statistics
-- Average and total metrics 


SELECT CAST(AVG(Avg_Daily_Distance_Km) AS decimal(10, 2)) AS Avg_Distance_Km, 
CAST(AVG(Mileage_km_l) AS decimal(10, 2)) AS Avg_Mileage, 
CAST(AVG(Price_INR) AS decimal(10, 2)) As Avg_Price FROM bike_sales_india;

-- Group by state 
--  Top selling bikes by state 

SELECT state, COUNT(*) AS total_bike, 
AVG(Price_INR) AS Avg_Price, 
AVG(Mileage_Km_l) AS Avg_Mileage 
FROM bike_sales_india
GROUP BY state
ORDER BY total_bike DESC;



-- Find the top selling model of bike in state 

SELECT state, brand, Model, 
COUNT(*) AS Total_Sales
FROM bike_sales_india 
GROUP BY State, Brand, Model 
ORDER BY State, total_Sales DESC;






-- Trends over years 
-- Price Trends by Year

SELECT Year_of_Manufacture, CAST(AVG(Price_INR) AS decimal(10, 2)) As Avg_Price, 
count(*) AS total_bike 
FROM bike_sales_india 
GROUP BY Year_of_Manufacture
ORDER BY Year_of_Manufacture;


-- Average Mileage by year 

SELECT Year_of_Manufacture, 
CAST(AVG(Mileage_Km_l) AS decimal(10, 2)) AS Avg_Mileage
From bike_sales_india
GROUP BY Year_of_Manufacture
ORDER BY Year_of_Manufacture;


-- Brands and Model Insights 

-- Top Brands by Resale Price 

SELECT Brand, AVG(Resale_Price_INR) As Avg_Resale_Price, 
COUNT(*) As total_listings 
FROM bike_sales_india 
GROUP BY Brand 
ORDER BY Avg_Resale_Price DESC;



-- Models with highest Mileages 

SELECT TOP 10 Brand, Model, CAST(MAX(Mileage_Km_l)AS decimal(10, 2)) AS Avg_Mileage 
FROM bike_sales_india 
GROUP BY Brand, Model
Order BY Avg_Mileage DESC;



-- Insurance and Registration Analysis 


-- Insurnce status by owner type 

SELECT Owner_Type, COUNT(*) AS total_insured
FROM bike_sales_india
WHERE Insurance_Status = 'Active'
GROUP BY Owner_Type
Order by total_insured DESC;


-- City and Tier analysis 

-- Distribution by city tier 

SELECT City_Tier, COUNT(*) AS Total_bike, 
CAST(AVG(Price_INR) As decimal(10, 2)) AS Avg_Price, 
CAST(AVG(Resale_Price_INR) AS decimal(10, 2)) As Avg_Resale_Price
FROM bike_sales_india 
GROUP BY City_Tier
Order By Total_bike DESC;


-- Fuel type prefernce by Tier 

Select City_Tier, Fuel_Type, COUNT(*) AS total_bike
FROM bike_sales_india 
GROUP BY City_Tier, Fuel_Type
Order By City_Tier,  total_bike DESC;


-- Identify expensive bikes 

SELECT * FROM bike_sales_india 
WHERE Price_INR > (SELECT AVG(Price_INR) FROM bike_sales_india) * 2
Order by Price_INR DESC;


-- Corelation between engine capacity and price 


SELECT Engine_Capacity_cc, CAST(AVG(Price_INR) AS decimal(10, 2)) As Avg_Price
FROM bike_sales_india 
GROUP BY Engine_Capacity_cc
ORDER BY Engine_Capacity_cc;



-- Effect of Fuel type on resale price 

SELECT Fuel_Type, CAST(AVG(Resale_Price_INR)AS decimal(10, 2)) AS Avg_Resale_Price 
FROM bike_sales_india 
GROUP BY Fuel_Type
ORDER BY Avg_Resale_Price DESC;


-- Fuel type Preferences 
-- What is preferred fuel type in different tiers 

SELECT city_tier, fuel_type, count(*) AS Total_Bike 
from bike_sales_india 
GROUP BY city_tier, fuel_type
ORDER BY city_tier, Total_Bike DESC;

-- As you can see in this result that Metro cities have most bikes that preferred 
--Petrol.
-- Tier 1 cities people preferred Hybrid bikes.
-- Tier 2 - Petrol 
-- tier 3 - Hybrid 


-- Mileage Analysis
-- Which bikes are most fuel efficient?

SELECT TOP 10 Brand, Model, CAST(MAX(Mileage_Km_l)AS decimal(10,2)) AS max_mileage 
FROM bike_sales_india
GROUP BY Brand, Model 
ORDER BY max_mileage DESC;


-- Age of Vehicle
-- How does age of vehicle affect price and resale values 

SELECT Year_of_Manufacture, CAST(AVG(Price_INR)AS decimal(10,2)) AS Avg_Price, 
CAST(AVG(Resale_Price_INR)AS decimal(10,2)) AS Avg_Resale_Price, 
CAST((AVG(Resale_Price_INR)/AVG(Price_INR)) * 100 AS decimal(10,2)) AS Depreciation_rate
FROM bike_sales_india
GROUP BY Year_of_Manufacture 
ORDER BY Year_of_Manufacture;


--Popular brands and Models 

Select Brand, COUNT(*) AS Total_Bikes, 
CAST(AVG(Price_INR)AS decimal(10,2)) AS Avg_Price 
FROM bike_sales_india 
GROUP BY Brand 
ORDER BY Total_Bikes DESC;






















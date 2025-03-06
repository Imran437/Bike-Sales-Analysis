USE bikedb;


-- View the dataset 

SELECT * FROM bike_sales_india;

-- Find the top selling bikes by each state 

SELECT state, Brand, Model, COUNT(*) AS Total_Bike
FROM bike_sales_india
GROUP BY state, Brand, Model
HAVING COUNT(*) = (
    SELECT MAX(sub_count)
    FROM (
        SELECT COUNT(*) AS sub_count
        FROM bike_sales_india AS sub
        WHERE sub.state = bike_sales_india.state
        GROUP BY sub.Brand, sub.Model
    ) AS max_count_subquery
)
ORDER BY state;


WITH RankedBikes AS (
    SELECT state, Brand, Model, COUNT(*) AS Total_Bike,
           RANK() OVER (PARTITION BY state ORDER BY COUNT(*) DESC) AS rank
    FROM bike_sales_india
    GROUP BY state, Brand, Model
)
SELECT state, Brand, Model, Total_Bike
FROM RankedBikes
WHERE rank = 1
ORDER BY state;

-- what is the reason of Hero is most selling bike in Delhi 

-- Analyse Price 

SELECT state, Brand, Model, AVG(Price_INR) As avg_price, AVG(Mileage_km_l) As avg_mileage, 
AVG(Engine_Capacity_cc) As avg_engine_capactit, AVG(Resale_Price_INR) as avg_resale_price
FROM bike_sales_india 
Group by state, Brand, Model
Order by state, avg_price, avg_mileage;

-- Regional Analysis 
-- 

Select state, AVG(Mileage_Km_l) As avg_mileage, 
AVG(Price_INR) AS avg_price, 
AVG(Engine_Capacity_Cc) As avg_engine_capacity 
FROM bike_sales_india 
GROUP BY State
ORDER BY State;



-- Top Bike by City Tier 

SELECT City_Tier, Brand,  Model, COUNT(*) AS Total_Bike 
FROM bike_sales_india 
GROUP BY City_Tier, Brand, Model
ORDER BY City_Tier, Total_Bike DESC;


-- Customer Segementation
-- Identify which ownership type offers the best resale price 

SELECT Owner_type, CAST(AVG(Resale_Price_INR)AS decimal(10,2)) AS avg_resale_price 
FROM bike_sales_india 
GROUP BY Owner_Type;

-- First ownership offers best resale value 


-- Seller type Analysis 

SELECT seller_type, COUNT(*) AS Total_Bike, 
CAST(AVG(Resale_Price_INR)As decimal(10, 2)) AS avg_resale_price 
FROM bike_sales_india 
GROUP BY Seller_Type
ORDER BY Total_Bike DESC;

-- Buyer Prefers Dealer over Individual because they get more average resale price.


-- Performance Metrics 

SELECT CAST(Mileage_Km_l AS decimal(10, 2)) AS Mileage_Km_l, 
CAST(AVG(Price_INR) AS decimal(10,2)) AS avg_Price,
CAST(AVG(Resale_Price_INR)AS decimal(10,2)) AS avg_Resale_Price,
CAST(AVG(ROUND(((Price_INR - Resale_Price_INR)/ Price_INR)*100,2))AS decimal(10,2)) 
As depreciation_percent 
FROM bike_sales_india 
GROUP BY Mileage_km_l
Order BY Mileage_km_l DESC;

-- We can see that depreciation percent is affected by Mileage and Avg Price
-- High mileage bike and the price is lower then deprecaition rate is low.
-- High Mileage bike but avg price high then depreciation rate is more.


-- Engine capacity 

SELECT Engine_Capacity_Cc, AVG(Price_INR) AS avg_price, 
AVG(Resale_Price_INR) AS avg_resale_price
FROM bike_sales_india
GROUP BY Engine_Capacity_cc
ORDER BY Engine_Capacity_cc;

-- Lower capacity engine has low price


-- Resale price over time 

SELECT Year_of_Manufacture, 
CAST(avg(Resale_Price_INR) AS decimal(10,2)) AS avg_resale_price 
FROM bike_sales_india 
GROUP BY Year_of_Manufacture
ORDER BY Year_of_Manufacture;

-- Sales trends by registration year 

SELECT Registration_Year, COUNT(*) AS Total_Bike 
FROM bike_sales_india
GROUP BY Registration_Year
ORDER BY Registration_Year;

-- sales is increasing by every year


-- Brand vs Mileage 
SELECT Brand, 
CAST(AVG(Mileage_Km_l)as decimal(10,2)) AS avg_Mileage, 
CAST(AVG(Price_INR) AS decimal(10,2)) AS avg_Price,
COUNT(*) AS Total_Bike 
FROM bike_sales_india
GROUP BY Brand
ORDER BY Total_Bike DESC;

-- Average Mileage of TVS,Hero and KTM, Yamaha is almost same we can see that 
-- they sell most bikes so mileage effect sales but kawaski and Royal Enfield 
-- have sold more bike than tvs because their price are also low.
 





















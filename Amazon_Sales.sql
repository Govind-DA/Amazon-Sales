create database amazon_sales;
use amazon_sales;
CREATE TABLE sales (
    Order_id TEXT NOT NULL,
    Order_Date DATE NOT NULL,
    Ship_Date DATE NOT NULL,
    Email_id TEXT NOT NULL,
    Geography TEXT NOT NULL,
    Category TEXT NOT NULL,
    Product_Name TEXT NOT NULL,
    Sales DOUBLE NOT NULL,
    Quantity DOUBLE NOT NULL,
    Profit DOUBLE NOT NULL
);
select * from sales;



CREATE TABLE sales_staging (
  Order_id TEXT,
  Order_Date TEXT,
  Ship_Date TEXT,
  Email_id TEXT,
  Geography TEXT,
  Category TEXT,
  Product_Name TEXT,
  Sales DOUBLE,
  Quantity DOUBLE,
  Profit DOUBLE
);
drop table sales_staging;
select count(*) from sales_staging;
CREATE TABLE sales (
  Order_id TEXT NOT NULL,
  Order_Date DATE NOT NULL,
  Ship_Date DATE NOT NULL,
  Email_id TEXT NOT NULL,
  Geography TEXT NOT NULL,
  Category TEXT NOT NULL,
  Product_Name TEXT NOT NULL,
  Sales DOUBLE NOT NULL,
  Quantity DOUBLE NOT NULL,
  Profit DOUBLE NOT NULL
);
INSERT INTO sales (
  Order_id, Order_Date, Ship_Date, Email_id, Geography, Category, Product_Name, Sales, Quantity, Profit
)
SELECT
  Order_id,
  STR_TO_DATE(Order_Date, '%m/%d/%Y'),
  STR_TO_DATE(Ship_Date, '%m/%d/%Y'),
  Email_id,
  Geography,
  Category,
  Product_Name,
  Sales,
  Quantity,
  Profit
FROM sales_staging;

DROP TABLE sales;

select * from sales;

-- -------------------------------------------------------------------------------------------------------------------


SELECT 
    SUM(Profit) AS Total_Profit
FROM
    sales;

-- Output : 108418.79 

-- ------------------------------------------------------------------------------------------------------------------
SELECT 
    ROUND(SUM(Sales * Quantity), 2) AS Total_Sales
FROM
    sales;

-- Output : 3593413.87

-- -------------------------------------------------------------------------------------------------------------------

-- 												Sales

-- ------------------------------------------------------------------------------------------------------------------

SELECT 
    Category, ROUND(SUM(Sales * Quantity), 2) AS Total_Sales
FROM
    sales
GROUP BY Category
ORDER BY Total_Sales DESC
LIMIT 3;

-- Most Revenue Category
--  Tables	500602.34
--  Phones	485721.04
--  Chairs	445983.13

SELECT 
    Category, ROUND(SUM(Sales * Quantity), 2) AS Total_Sales
FROM
    sales
GROUP BY Category
ORDER BY Total_Sales 
LIMIT 3;

-- Least  Revenue Category
--  Fasteners	4726.97
--  Envelopes	15449.32
--  Labels	34686.92

-- -------------------------------------------------------------------------------------------------------------------

ALTER TABLE sales
ADD COLUMN City TEXT,
ADD COLUMN State TEXT;

SET SQL_SAFE_UPDATES = 0;
UPDATE sales
SET 
  City = SUBSTRING_INDEX(SUBSTRING_INDEX(Geography, ',', 2), ',', -1),
  State = SUBSTRING_INDEX(Geography, ',', -1);

SET SQL_SAFE_UPDATSES=1;

SELECT 
    City, ROUND(SUM(Sales * Quantity), 2) AS Total_Sales
FROM
    sales
GROUP BY City
ORDER BY Total_Sales
LIMIT 3;

-- Top 3 Sales By City 
-- Los Angeles	871395.02
-- Seattle	597615.19
-- San Francisco  541425.66


-- Top 3 Least Sales By City 
-- Everett	3.86
-- Auburn	4.18
-- San Luis Obispo	7.24

-- -------------------------------------------------------------------------------------------------------------------
SELECT 
    State, ROUND(SUM(Sales * Quantity), 2) AS Total_Sales
FROM
    sales
GROUP BY State
ORDER BY Total_Sales
LIMIT 3;

-- Top 3 Sales By State 
-- California	2299404.05
-- Washington	692360.23
-- Arizona	170003.42

-- Top 3 Least Sales By State 
-- Wyoming	6412.56
-- Idaho	14055.59
-- New Mexico	24125.31

-- -------------------------------------------------------------------------------------------------------------------

SELECT 
    City,
    AVG(DATEDIFF(Ship_Date, Order_Date)) AS Average_Shipment_Time
FROM
    sales
GROUP BY City
ORDER BY Average_Shipment_Time Desc
Limit 3;

-- Fastest Shipment City
-- Billings	0.0000
-- Redlands	0.8750
-- Murray	1.0000

-- Slowest Shipment City 
-- Citrus Heights	7.0000
-- Yucaipa	7.0000
-- Lodi	6.5000

-- -------------------------------------------------------------------------------------------------------------------


SELECT 
    monthname(Order_Date) as Order_Month, ROUND(SUM(Sales * Quantity), 2) AS Total_Sales
FROM
    sales
GROUP BY Order_Month
ORDER BY Total_Sales 
LIMIT 3;

-- Highest Sales By Month
-- December	638088.54
-- November	449626.51
-- September 382840.88

-- Least Sales By Month
-- February	71421.5
-- January	124481.79
-- April	187066.4

-- -------------------------------------------------------------------------------------------------------------------

Select year(Order_Date) as Sale_Year,Round(SUM(Sales * Quantity), 2) AS Total_Sales
from sales
group by Sale_Year
Order by Sale_Year;

-- Total Sale per Year
-- 2011	737774.72
-- 2012	695999.52
-- 2013	888671.47
-- 2014	1270968.16
-- -------------------------------------------------------------------------------------------------------------------

-- 												Profit 

-- -------------------------------------------------------------------------------------------------------------------


SELECT 
    Category, ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    sales
GROUP BY Category
ORDER BY Total_Profit DESC
LIMIT 3;

-- Total Profit per Category
-- Copiers	19327.25
-- Accessories	16484.62
-- Binders	16096.78

SELECT 
    Category, ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    sales
GROUP BY Category
ORDER BY Total_Profit
LIMIT 3;

-- Least Profit per Category
-- Bookcases	-1646.5
-- Machines	-618.95
-- Binders	16096.78
-- -------------------------------------------------------------------------------------------------------------------
Select State,ROUND(SUM(Profit), 2) AS Total_Profit 
from sales
group by State
order by Total_Profit Desc
Limit 3;

-- Most Profitable State
-- California	76381.6
-- Washington	33402.7
-- Nevada	3316.76

Select State,ROUND(SUM(Profit), 2) AS Total_Profit 
from sales
group by State
order by Total_Profit 
Limit 3;
							
-- Least Profitable State
-- Colorado	-6527.86
-- Arizona	-3427.87
-- Oregon	-1190.48

-- -------------------------------------------------------------------------------------------------------------------
Select City,ROUND(SUM(Profit), 2) AS Total_Profit 
from sales
group by City
order by Total_Profit Desc
Limit 3;

-- Most Profitable State
-- Los Angeles	30440.94
-- Seattle	29156.13
-- San Francisco  17507.39

Select City,ROUND(SUM(Profit), 2) AS Total_Profit 
from sales
group by City
order by Total_Profit 
Limit 3;
							
-- Least Profitable State
-- Louisville	-3406.18
-- Phoenix	-2790.85
-- Colorado Springs	-956.68

-- -------------------------------------------------------------------------------------------------------------------

Select monthname(Order_Date) as Order_Month,ROUND(SUM(Profit), 2) AS Total_Profit 
from sales
group by Order_Month
order by Total_Profit DESC
Limit 3;
		
-- Most Profit per month
-- March	16094.85
-- September	14694.87
-- December 	13258.64

Select monthname(Order_Date) as Order_Month,ROUND(SUM(Profit), 2) AS Total_Profit 
from sales
group by Order_Month
order by Total_Profit 
Limit 3;
	
-- Least Profit per month
-- April	1428.93
-- February	2699.65
-- January	4565.54

-- -------------------------------------------------------------------------------------------------------------------
Select year(Order_Date) as Order_Year,ROUND(SUM(Profit), 2) AS Total_Profit 
from sales
group by Order_Year
order by Total_Profit;
	
-- Profit by Year
-- 2011	20065.74
-- 2012	20492.17
-- 2013	23959.9
-- 2014	43900.98

-- -------------------------------------------------------------------------------------------------------------------

-- 												Quantity Sales			

-- -------------------------------------------------------------------------------------------------------------------

Select year(Order_Date) as Order_Year,SUM(Quantity) AS Total_Quantity_Sold
from sales
group by Order_Year
order by Total_Quantity_Sold;

-- Quantity Sold per Year
-- 2012	2438
-- 2011	2531
-- 2013	3010
-- 2014	4285

-- -------------------------------------------------------------------------------------------------------------------
Select monthname(Order_Date) as Order_Month,SUM(Quantity) AS Total_Quantity_Sold 
from sales
group by Order_Month
order by Total_Quantity_Sold DESC
Limit 3;
		
-- Most Quantity Sold month
-- December	2068
-- November	1724
-- September 1603

Select monthname(Order_Date) as Order_Month,SUM(Quantity) AS Total_Quantity_Sold
from sales
group by Order_Month
order by Total_Quantity_Sold 
Limit 3;
	
-- Least quantity sold month
-- February	345
-- January	448
-- April	723

-- -------------------------------------------------------------------------------------------------------------------
Select City,SUM(Quantity) AS Total_Quantity_Sold 
from sales
group by City
order by Total_Quantity_Sold DESC
Limit 3;
		
-- Most Quantity Sold by City
-- Los Angeles	2877
-- San Francisco	1935
-- Seattle	1590

Select City,SUM(Quantity) AS Total_Quantity_Sold
from sales
group by City
order by Total_Quantity_Sold 
Limit 3;
	
-- Least quantity sold by City
-- Lewiston	1
-- Littleton	1
-- Auburn	1

-- -------------------------------------------------------------------------------------------------------------------
Select State,SUM(Quantity) AS Total_Quantity_Sold 
from sales
group by State
order by Total_Quantity_Sold DESC
Limit 3;
		
-- Most Quantity Sold by State
-- California	7665
-- Washington	1883
-- Arizona	862

Select State,SUM(Quantity) AS Total_Quantity_Sold
from sales
group by State
order by Total_Quantity_Sold 
Limit 3;
	
-- Least quantity sold by State
-- Wyoming	4
-- Montana	56
-- Idaho	64

-- -------------------------------------------------------------------------------------------------------------------

Select Category,SUM(Quantity) AS Total_Quantity_Sold 
from sales
group by Category
order by Total_Quantity_Sold DESC
Limit 3;
		
-- Most Quantity Sold by Category
-- Binders	1868
-- Paper	1702
-- Furnishings	1175

Select Category,SUM(Quantity) AS Total_Quantity_Sold
from sales
group by Category
order by Total_Quantity_Sold 
Limit 3;
	
-- Least quantity sold by Category
-- Copiers	88
-- Machines	147
-- Envelopes	227
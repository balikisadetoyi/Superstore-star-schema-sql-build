--SQL PRACTICE 

--Show Order_ID, Order_Date, and Sales from facts table
SELECT 
	F.Order_ID,
	O.Order_Date, 
	F.Sales 
FROM Facts_superstore  AS F 
INNER JOIN 
	dim_orders AS O ON
F.Order_ID=O.Order_ID

--Show all orders where Sales > 500 AND Profit > 50.

SELECT * from Facts_superstore
WHERE Sale_ID > 50 AND
Profit > 50;

--Show all products where Category = 'Furniture' OR Category = 'Technology'.

SELECT 
	Product_ID, 
	Product_Name ,
	Category
FROM dim_products
WHERE Category='furniture' OR
Category='Technology';
--Show orders NOT from the 'West' region.


SELECT * FROM dim_orders
WHERE Region <> 'west';

--Show orders where Sales BETWEEN 200 AND 800

SELECT 
	Order_ID ,
	Sales 
from Facts_superstore
WHERE Sales BETWEEN  200 AND 800;

--Show customers whose names start with 'A'.

SELECT 
	Customer_ID, 
	Customer_Name 
FROM dim_Customers
WHERE Customer_Name LIKE 'A%';

--Show products where Product_Name contains the word 'Desk'.

SELECT 
	Product_ID, 
	Product_Name,
	Category
FROM dim_products
WHERE PRoduct_Name LIKE '%Desk%';

--Show distinct customer segments.

SELECT DISTINCT segment
FROM dim_Customers

--Show top 10 highest sales transactions ordered by Sales descending.


SELECT TOP 10 Sales 
FROM Facts_superstore
ORDER BY Sales DESC;

--Sort orders by Order_Date descending, then by Sales ascending. 
SELECT 
	F.Order_ID,
	O.Order_Date, 
	F.Sales
FROM Facts_superstore AS F 
INNER JOIN dim_orders AS O
	ON F.Order_ID=O.Order_ID
ORDER BY Order_Date DESC, Sales ASC;


--Show total Sales by Region.
SELECT 
	O.Region, 
	SUM(F.Sales) AS total_sales
FROM Facts_superstore AS F
	INNER JOIN dim_orders AS O
ON O.Order_ID=O.Order_ID
	GROUP BY O.Region


--Show average Profit per Category.
SELECT
	P.Category,
	AVG(F.Profit ) AS avg_profit
FROM Facts_superstore AS F
INNER JOIN dim_products AS P
	ON F.Product_ID=P.Product_ID
GROUP BY P.Category

--Count number of orders per Customer.
SELECT 
	C.Customer_ID, 
	C.Customer_Name, 
	COUNT (F.Order_ID) AS totalorders
FROM dim_Customers AS C
INNER JOIN Facts_superstore AS F
ON C.Customer_ID=F.Customer_ID
GROUP BY 
	C.Customer_ID, 
	C.Customer_Name 


--Show minimum and maximum Sales per Product.

SELECT 
	Product_ID, 
	MIN(Sales) AS MIN_SALES,
	MAX(Sales) AS MAX_SALES
FROM Facts_superstore
GROUP BY Product_ID

--Show total Sales per Region but only where total Sales > 100,000 
SELECT 
	O.Region, 
	SUM(F.Sales) AS total_sales
FROM Facts_superstore AS F
	INNER JOIN dim_orders AS O
ON O.Order_ID=O.Order_ID
	GROUP BY O.Region
	HAVING SUM(F.Sales)>100000

--Find regions with more than 200 orders.
SELECT  O.Region, COUNT(F.Order_ID) AS totalorders
FROM Facts_superstore AS F
INNER JOIN dim_orders AS O
ON F.Order_ID=O.Order_ID
GROUP BY O.Region
HAVING  COUNT(F.Order_ID) > 200;



--Show profit margin per Category 

SELECT 
P.Category,
SUM( F.Profit) AS TOTALPROFIT,
SUM(F.Sales) AS TOTALSALES,
SUM(Profit)/SUM(Sales) AS profitMargin
FROM Facts_superstore AS F INNER JOIN
dim_Products AS P
ON  F.Product_ID=P.Product_ID
GROUP BY P.Category




--INNER JOIN fact and customer table to show Customer_Name and Sales.
SELECT C.Customer_Name, F.Sales
FROM dim_Customers AS C
INNER JOIN Facts_superstore AS F
ON C.Customer_ID=F.Customer_ID

--LEFT JOIN customers to facts — identify customers with no orders.
SELECT C.Customer_ID,C.Customer_Name, F.Order_ID 
FROM dim_Customers AS C
LEFT JOIN Facts_superstore AS F
ON C.Customer_ID=F.Customer_ID
WHERE F.Customer_ID IS NULL

--RIGHT JOIN products to facts — identify products never sold.

SELECT 
	P. Product_ID, 
	P.product_Name ,
	F.Order_ID
FROM Facts_superstore AS F
RIGHT JOIN dim_products AS P
	ON P.Product_ID=F.Product_ID
WHERE F.Product_ID IS NULL


--Write a LEFT ANTI JOIN to find customers with no purchases.
SELECT 
	C.Customer_ID,
	C.Customer_Name,
	F.Order_ID, 
	F.Quantity, 
	F.Sales
FROM dim_Customers AS C
LEFT JOIN Facts_superstore  AS F
ON C.Customer_ID=F.Customer_ID
WHERE F.Customer_ID IS NULL


--Write a RIGHT ANTI JOIN to find products not in fact table.
SELECT
	P.Product_ID, 
	P.Product_Name 
FROM Facts_superstore AS F
	RIGHT JOIN dim_products AS P
ON P.Product_ID=F.Product_ID
WHERE F.Product_ID IS NULL

--CROSS JOIN customers and products — how many total combinations exist?
SELECT COUNT(* ) AS total_combo
FROM dim_Customers AS C
CROSS JOIN dim_products AS P




--Combine two product lists using UNION

SELECT 
Product_ID, 
Product_Name
FROM dim_products

WHERE Category='furniture'
UNION 
SELECT 
Product_ID, 
Product_Name
FROM dim_products

WHERE Category='Technology'


--Find products in Table A but not Table B (EXCEPT).
SELECT  Product_ID
FROM dim_products

EXCEPT 
SELECT Product_ID
FROM Facts_superstore

--Find common customers between two datasets (INTERSECT).

SELECT Customer_ID
FROM dim_Customers

INTERSECT

SELECT Customer_ID
FROM Facts_superstore



--Convert all customer names to uppercase.
SELECT UPPER( Customer_Name)
FROM dim_Customers

--Extract first 5 characters of Product_Name.
--substring(expression, start, length you want )
SELECT 
SUBSTRING (Product_Name, 1,5)  AS productname_short
from dim_products

--Replace 'Desk' with 'Table' in Product_Name.
SELECT Product_Name,
REPLACE(Product_Name,'Desk', 'Table') AS new_name
FROM dim_products

--Calculate absolute value of Profit.
SELECT 
	Profit, 
	ABS( Profit) AS Abs_profit
FROM Facts_superstore

--Round Sales to nearest whole number.
SELECT Sales, ROUND(Sales, 0) AS sales_adj
FROM Facts_superstore

--Extract YEAR and MONTH from Order_Date.

SELECT 
	YEAR(Order_Date) AS yr,
	MONTH(Order_Date) AS Mnth
FROM dim_orders

--Calculate number of days between Order_Date and Ship_Date.
SELECT order_date, Ship_date,
DATEDIFF(DAY, Order_Date,Ship_Date) AS interval
FROM dim_orders

--Add 30 days to Order_Date.
SELECT Order_Date,
DATEADD( DAY, 30, Order_Date) AS postdate

FROM dim_orders

--Replace NULL profit with 0.
SELECT Profit,
COALESCE(Profit,0) AS profit_adj
FROM Facts_superstore

--Convert Order_Date to formatted string 'YYYY-MM'.
SELECT 
	Order_date,
	FORMAT ( Order_date,'yyyy-MM') AS newdate
FROM dim_orders;


--Categorize Sales as:Low (<200),Medium (200–800),High (>800)

SELECT Sales,
CASE
	WHEN Sales < 200 THEN'Low'
	WHEN  Sales BETWEEN 200 AND 800 THEN 'Medium'
	ELSE 'High'
END AS sales_cat
FROM Facts_superstore



--Flag orders as “Late” if Ship_Date > Order_Date + 5 days.
SELECT Order_date, Ship_Date,
CASE
WHEN Ship_Date > DATEADD(DAY, 5,Order_Date) THEN 'Late'
ELSE 'normal'
END AS late_delivery

FROM dim_orders



--Rank customers by total Sales.

SELECT Customer_ID, SUM(SALES) AS TOTALSALES,
RANK() OVER( ORDER BY  SUM(SALES) DESC) AS Sales_ranked
FROM Facts_superstore
GROUP BY Customer_ID


--Show running total of Sales ordered by Order_Date.
SELECT O.Order_date,
SUM(F.Sales) OVER ( ORDER BY O.Order_date DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_total
FROM Facts_superstore F
INNER JOIN dim_orders O
ON F.Order_ID=O.Order_ID










--Find customers whose total Sales is above average.
SELECT * FROM(
SELECT Customer_ID, SUM(Sales) AS totalsales 

FROM Facts_superstore
GROUP BY Customer_ID)t
WHERE totalsales > (SELECT AVG(totalsales)FROM (SELECT  Customer_ID, SUM(Sales) AS totalsales 

FROM Facts_superstore
GROUP BY Customer_ID)t)





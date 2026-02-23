
--Star schema creation 
--creating my dimension tables from big table 

--customers table
CREATE TABLE dim_Customers (
	Customer_ID VARCHAR (200)  PRIMARY KEY,
	Customer_Name VARCHAR (200) NOT NULL , 
	Segment VARCHAR (50)  NOT  NULL )
	
INSERT INTO dim_Customers( 
	Customer_ID,
	Customer_Name, 
	Segment
	)
SELECT DISTINCT 
	Customer_ID,
	Customer_Name, 
	Segment	
FROM Superstore


--orders table
CREATE TABLE dim_orders (
Order_ID VARCHAR(100) PRIMARY KEY, 
Order_Date DATE ,
Ship_Date DATE,
Ship_Mode VARCHAR (100),
Country VARCHAR (100) NOT NULL,
City VARCHAR (100) NOT NULL, 
State VARCHAR ( 100) NOT NULL,
Postal_Code VARCHAR (20) NOT NULL,
Region VARCHAR ( 100) NOT NULL)


INSERT INTO dim_orders(Order_ID , 
	Order_Date,
	Ship_Date ,
	Ship_Mode,
	Country ,
	City , 
	State ,
	Postal_Code,
Region)
SELECT
    Order_ID,
    MIN(Order_Date) AS Order_Date,
    MIN(Ship_Date) AS Ship_Date,
    MIN(Ship_Mode) AS Ship_Mode,
    MIN(Country) AS Country,
    MIN(City) AS City,
    MIN(State) AS State,
    MIN(Postal_Code) AS Postal_Code,
    MIN(Region) AS Region
FROM Superstore
GROUP BY Order_ID;


--products table

	CREATE TABLE dim_products
		( Product_ID VARCHAR( 200) PRIMARY KEY,
		PRoduct_Name VARCHAR (200) NOT NULL,
		Category VARCHAR(100) NOT NULL,
		Sub_Category VARCHAR(100) NOT NULL)

	INSERT INTO  dim_products(
		Product_ID ,
		PRoduct_Name ,
		Category ,
		Sub_Category )


SELECT
    Product_ID,
    MIN(Product_Name) AS Product_Name,
    MIN(Category) AS Category,
    MIN(Sub_Category) AS Sub_Category
FROM Superstore
GROUP BY Product_ID;



--creating facts table

CREATE TABLE Facts_superstore (
Sale_ID INT IDENTITY(1,1) PRIMARY KEY,
Order_ID VARCHAR (100) NOT NULL,
Customer_ID VARCHAR(100) NOT NULL,
Product_ID VARCHAR(100) NOT NULL,
Sales DECIMAL (20,2) NOT NULL,
QUANTITY INT NOT NULL,
Discount DECIMAL (10,2) NOT NULL,
Profit DECIMAL (20,2) )


INSERT INTO Facts_superstore(
Order_ID, 
Customer_ID,
Product_ID,
Sales,
QUANTITY,
Discount ,
Profit 
)
SELECT
Order_ID, 
Customer_ID,
Product_ID,
Sales,
QUANTITY,
Discount ,
Profit 
FROM Superstore


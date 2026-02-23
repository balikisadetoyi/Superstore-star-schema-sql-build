
## Superstore Star Schema in SQL Server
### Overview
This project transforms a flat Superstore dataset into a structured star schema to improve data organisation, support efficient querying, and practice relational modelling 
and JOIN operations.
The original dataset was provided as a single table containing customer, product, order, and sales information. I separated these entities into dimension tables
with a central fact table to improve analytical clarity.

#### Tools
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)

#### Source Data
- Superstore.csv 

#### Schema Design

#### Fact Table
- Facts_superstore
- Sale_ID (Primary Key)
- Order_ID (Foreign Key)
- Customer_ID (Foreign Key)
- Product_ID (Foreign Key)
- Sales
- Quantity
- Discount
- Profit


#### Dimension Tables

#### dim_Customers
- Customer_ID (Primary Key)
- Customer_Name
- Segment


#### dim_orders
- Order_ID (Primary Key)
- Order_Date
- Ship_Date
- Ship_Mode
- Country
- City
- State
- Postal_Code
- Region


#### dim_products
- Product_ID (Primary Key)
- Product_Name
- Category
- Sub_Category





-- RANK FUNCTIONS
-- 1. ROW_NUMBER ()
-- Rank the orders based on their sales from highest to lowest

SELECT
OrderID,
ProductID,
Sales,
ROW_NUMBER () OVER (ORDER BY Sales DESC) SalesRank_Row
FROM Sales.Orders

--2. RANK ()
-- Rank the orders based on their sales from highest to lowest

SELECT
OrderID,
ProductID,
Sales,
RANK () OVER (ORDER BY Sales DESC) SalesRank_Rank
FROM Sales.Orders

--3. DENSE_RANK ()
-- Rank the orders based on their sales from highest to lowest

SELECT
OrderID,
ProductID,
Sales,
DENSE_RANK () OVER (ORDER BY Sales DESC) SalesRank_Dense
FROM Sales.Orders

-- ROW NUMBER USE CASE
-- a. Top-N Analysis
-- Find the top highest sales for each product

SELECT*
FROM (
SELECT
OrderID,
ProductID,
Sales,
ROW_NUMBER () OVER (PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
FROM Sales.Orders
)t WHERE RankByProduct = 1

-- b. Bottom-N Analysis
-- Find the lowest 2 customers based on their total sales

SELECT *
FROM (
SELECT
	CustomerID,
	SUM(Sales) TotalSales,
	ROW_NUMBER() OVER (ORDER BY SUM(Sales)) RankCustomers
FROM Sales.Orders
GROUP BY 
CustomerID
)t WHERE RankCustomers <= 2 

-- c. Generate Unique IDs
-- Assign Unique IDS to the rows of the 'Orders Archive' table

SELECT
	ROW_NUMBER() OVER (ORDER BY OrderID, OrderDate) UniqueID,
	*
FROM Sales.OrdersArchive

-- d. Identify duplicates
-- Identify duplicate rows in the 'Orders Archive' table and return
-- a clean result without any duplicates

SELECT *
FROM (
SELECT 
ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
*
FROM Sales.OrdersArchive
)t WHERE rn>1

-- 4. NTILE ()
SELECT
OrderID,
Sales,
NTILE(4) OVER (ORDER BY Sales DESC) FourBucket,
NTILE(3) OVER (ORDER BY Sales DESC) ThreeBucket,
NTILE(2) OVER (ORDER BY Sales DESC) TwoBucket,
NTILE(1) OVER (ORDER BY Sales DESC) OneBucket
FROM Sales.Orders

-- USE CASES
-- a. Data Segmentation
-- Segment all orders ito 3 categories: high, medium, and low sales.

SELECT
*,
CASE WHEN Buckets = 1 THEN 'High'
	 WHEN Buckets = 2 THEN 'Medium'
	 WHEN Buckets = 3 THEN 'Low'
END SalesSegmentations
FROM (
SELECT
	OrderID,
	Sales,
	NTILE(3) OVER (ORDER BY sales DESC) Buckets
FROM Sales.Orders
)t

-- b. Equalizing load processing
-- Inorder to export the data, divide the orders into 2 groups

SELECT 
NTILE(4) OVER (ORDER BY OrderID) Buckets,
*
FROM Sales.Orders

--5. CUME_DIST () 
-- Find the products that fall within the highest 40% of the prices

SELECT 
*,
CONCAT (DistRank * 100, '%') DistRankPerc
FROM (
SELECT
Product,
Price,
CUME_DIST () OVER (ORDER BY Price DESC) DistRank
FROM Sales.Products
)t
WHERE DistRank <=0.4

-- 6. PERCENT_RANK ()
-- Find the products that fall within the highest 40% of the prices

SELECT 
*,
CONCAT (DistRank * 100, '%') DistRankPerc
FROM (
SELECT
Product,
Price,
PERCENT_RANK () OVER (ORDER BY Price DESC) DistRank
FROM Sales.Products
)t
WHERE DistRank <=0.4
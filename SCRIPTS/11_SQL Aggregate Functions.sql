-- WINDOW AGGREGATE FUNCTIONS
-- 1. COUNT
-- a. Overall Analysis
-- Find the total number of orders
SELECT*
FROM Sales.Orders

SELECT
COUNT (*) TotalOrders
FROM Sales.Orders

-- Find the total number of orders
-- Additionaly provide details such as Order ID, Order Date

SELECT
	OrderID,
	OrderDate,
COUNT (*) OVER () TotalOrders
FROM Sales.Orders

-- Find the total number of orders
-- Find the total number of orders for each customer
-- Additionaly provide details such as Order ID, Order Date

-- b. Category Analysis
SELECT
	OrderID,
	OrderDate,
	CustomerID,
COUNT (*) OVER () TotalOrders,
COUNT (*) OVER (PARTITION BY CustomerID) OrdersByCustomers
FROM Sales.Orders

-- Find the total number of customers
-- Additionally provide ALL customer details
SELECT
	CustomerID,
	FirstName,
	LastName,
	Country,
	Score,
COUNT (*) OVER () TotalCustomers
FROM Sales.Customers

-- c. Identify NULLS
-- Find the total number of scores for each customers
SELECT
*,
COUNT (*) OVER () TotalCustomers,
COUNT (Score) OVER () TotalScores
FROM Sales.Customers

SELECT
*,
COUNT (*) OVER () TotalCustomersStar,
COUNT (1) OVER () TotalCustomersOne,
COUNT (Score) OVER () TotalScores
FROM Sales.Customers

-- d. Identify Duplicates

SELECT
OrderID,
COUNT (*) OVER (PARTITION BY OrderID) CheckPK
FROM Sales.Orders

SELECT
OrderID,
COUNT (*) OVER (PARTITION BY OrderID) CheckPK
FROM Sales.OrdersArchive

SELECT*
FROM (SELECT
OrderID,
COUNT (*) OVER (PARTITION BY OrderID) CheckPK
FROM Sales.OrdersArchive)t
WHERE CheckPK>1

-- 2. SUM
-- Find the total sales across all orders
-- And the total sales for each product
-- Additionally provide details such as order ID, OrderDate

-- a. Overall Analysis
SELECT
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	SUM(Sales) OVER () TotalSales,
	SUM(Sales) OVER (PARTITION BY ProductID) SalesByProducts
FROM Sales.Orders

-- b. Comparison Analysis
-- Find the percentage cotriution of each product's sales to the total sales

SELECT
	OrderID,
	ProductID,
	Sales
FROM Sales.Orders

-- c. Part-To-Whole Analysis

SELECT
	OrderID,
	ProductID,
	Sales,
	SUM (Sales) OVER () TotalSales,
	ROUND (CAST (Sales AS Float) / SUM (Sales) OVER () * 100, 2) PercentageofTotal
FROM Sales.Orders

-- 3. AVG
-- Find the average sales across all orders
-- And find the average sales for each product
-- Additionally provide details such as order ID, Order Date

-- a. Group-wise analysis, to understand patterns within different categories
SELECT
	OrderID,
	OrderDate,
	Sales,
	AVG (Sales) OVER () AvgSales,
	AVG (Sales) OVER (PARTITION BY ProductID) AvgSalesByProducts
FROM Sales.Orders

-- Find the average scores of customers
-- Additionally provide details such as CustomerID and LastName
SELECT
	CustomerID,
	LastName,
	Score,
	COALESCE (Score,0) CustomerScore,
	AVG(Score) OVER () AvgScore,
	AVG(COALESCE (Score,0)) OVER () AvgScoreWithoutNull
FROM Sales.Customers
-- b. Comparison Analysis
-- Find all orders where sales are higher than the average scores across all orders

SELECT *
FROM (SELECT 
	OrderID,
	ProductID,
	Sales,
	AVG(Sales) OVER () AvgSales
FROM Sales.Orders)t
WHERE Sales>AvgSales


-- 4. MIN & MAX
-- MIN
-- Find the highest and lowest sales across all orders
-- and the highest and lowest sales for each product
-- Additionally, provide details such as order ID and OrderDate

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MIN (Sales) OVER () LowestSales,
	MAX (Sales) OVER () HighestSales,
	MIN (Sales) OVER (PARTITION BY ProductID) LowestSalesByProduct,
	MAX (Sales) OVER (PARTITION BY ProductID) HighestSalesByProduct
FROM Sales.Orders

-- Show employees with the highest ad lowest salaries
SELECT 
*
FROM (
	SELECT 
	*,
MIN (Salary) OVER () LowestSalary,
MAX (Salary) OVER () HighestSalary
FROM Sales.Employees)t
WHERE Salary IN (LowestSalary, HighestSalary)

-- b.Comparision Analysis
-- Find the deviation of each sales from the minimum and maximum sales amounts

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MIN (Sales) OVER () LowestSales,
	MAX (Sales) OVER () HighestSales,
	Sales - MIN (Sales) OVER () DeviationFromMin,
	MAX (Sales) OVER () - Sales DeviationFromMax
FROM Sales.Orders


-- RUNNING AND ROLLING TOTAL
-- Calculate moving average of sales for each product over time

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	AVG (Sales) OVER (PARTITION BY ProductID) AvgByProduct
FROM Sales.Orders


SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	AVG (Sales) OVER (PARTITION BY ProductID) AvgByProduct,
	AVG (Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) MovingAvg
FROM Sales.Orders


-- Calculate moving average of sales for each product over time
-- Calculate moving average of sales for each product over time, including only the next order
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	AVG (Sales) OVER (PARTITION BY ProductID) AvgByProduct,
	AVG (Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
	AVG (Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM Sales.Orders
-- SQL CTAS
-- A. Permanent Tables
-- Use Cases
-- 1. Optimize Performance

SELECT
	DATENAME (month, OrderDate) OrderMonth,
	COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME (month, OrderDate) 

SELECT * FROM Sales.MonthlyOrders
DROP TABLE Sales.MonthlyOrders

-- Step 2
IF OBJECT_ID('Sales.MonthlyOrders', 'U') IS NOT NULL
	DROP TABLE Sales.MonthlyOrders;
GO
SELECT
	DATENAME (month, OrderDate) OrderMonth,
	COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME (month, OrderDate) 

-- B. Temporary Tables

SELECT
*
INTO #Orders
FROM Sales.Orders

DELETE FROM #Orders
WHERE OrderStatus = 'Delivered'

SELECT
*
FROM #Orders

SELECT
*
INTO Sales.OrdersTest
FROM #Orders

-- Use cases
-- 1. Store Intermediate Results Temporarily
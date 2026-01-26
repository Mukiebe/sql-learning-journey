-- SQL VIEWS
-- USE CASES
-- 1. Central Complex Query Logic
-- Find the running total of sales for each month

WITH CTE_Monthy_Summary AS (
	SELECT
	DATETRUNC (month, OrderDate) OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC (month, OrderDate)
)
SELECT
OrderMonth,
TotalSales,
SUM(TotalSales) OVER (ORDER BY OrderMonth) AS RunningTotal
FROM CTE_Monthy_Summary

-- CREATING VIEW
/*CREATE VIEW Sales.V_Monthly_Summary AS
(
	SELECT
	DATETRUNC (month, OrderDate) OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC (month, OrderDate)
)*/


SELECT
OrderMonth,
TotalSales,
SUM(TotalSales) OVER (ORDER BY OrderMonth) AS RunningTotal
FROM V_Monthly_Summary


-- DROP VIEW dbo.V_Monthy_Summary

-- You can use T-SQL for both steps
/*IF OBJECT_ID (;dbo.V_Monthy_Summary', 'V') IS NOT NULL
	DROP VIEW dbo.V_Monthy_Summary

GO 
CREATE VIEW Sales.V_Monthly_Summary AS
(
	SELECT
	DATETRUNC (month, OrderDate) OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC (month, OrderDate)
)*/

-- 2.  Hide Complexity + Improve Abstractions
-- Provide a view that combines details from orders, products, customers, and employees


CREATE VIEW Sales.V_Order_Details AS (
	SELECT
	o.OrderDate,
	o.OrderID,
	p.Product,
	p.Category,
	COALESCE (c.FirstName,'') + ' ' + COALESCE(c.LastName, '') CustomerName,
	c.Country CustomerCountry,
	COALESCE (c.FirstName,'') + ' ' + COALESCE(c.LastName, '') SalesName,
	e.Department,
	o.Sales,
	o.Quantity
	FROM Sales.Orders o
	LEFT JOIN Sales.Products p
	ON p.ProductID = o.ProductID
	LEFT JOIN Sales.Customers c
	ON c.CustomerID = o.CustomerID
	LEFT JOIN Sales.Employees e
	ON e.EmployeeID = o.SalesPersonID
	)

-- 3. Data Security
-- Provide a view for EU Sales Team
-- that combines details from ALL tables
-- And excludes Data related to the USA

CREATE VIEW Sales.V_Order_Details_EU AS (
	SELECT
	o.OrderDate,
	o.OrderID,
	p.Product,
	p.Category,
	COALESCE (c.FirstName,'') + ' ' + COALESCE(c.LastName, '') CustomerName,
	c.Country CustomerCountry,
	COALESCE (c.FirstName,'') + ' ' + COALESCE(c.LastName, '') SalesName,
	e.Department,
	o.Sales,
	o.Quantity
	FROM Sales.Orders o
	LEFT JOIN Sales.Products p
	ON p.ProductID = o.ProductID
	LEFT JOIN Sales.Customers c
	ON c.CustomerID = o.CustomerID
	LEFT JOIN Sales.Employees e
	ON e.EmployeeID = o.SalesPersonID
	WHERE c.Country != 'USA'
)
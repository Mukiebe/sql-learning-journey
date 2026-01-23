-- SQL Non-Recursive CTE
-- a. Standalone CTE
-- Step1: Find the total sales per customer.

WITH CTE_TotalSales AS
(
SELECT
CustomerID,
SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
-- Main Query
SELECT
c.CustomerID,
c.FirstName,
c.LastName,
cts.TotalSales
FROM Sales.Customers c
LEFT JOIN CTE_TotalSales cts
ON cts.CustomerID = c.CustomerID



-- b. Multiple standalone CTEs
-- Step 2: Find the last order date per customer.

; WITH CTE_TotalSales AS
(
SELECT
CustomerID,
SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)

, CTE_Last_Order AS
(
SELECT
	CustomerID,
	MAX(OrderDate) AS Last_Order
FROM Sales.Orders
GROUP BY CustomerID
)
-- Main Query
SELECT
c.CustomerID,
c.FirstName,
c.LastName,
cts.TotalSales,
clo.Last_Order
FROM Sales.Customers c
LEFT JOIN CTE_TotalSales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
ON clo.CustomerID = c.CustomerID




-- c. Nested CTE
-- Step 3: Rank customers based on total sales per customer.

;WITH CTE_Total_Sales AS
(
SELECT
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)

, CTE_Last_Order AS
(
SELECT
	CustomerID,
	MAX(OrderDate) AS Last_Order
FROM Sales.Orders
GROUP BY CustomerID
)
, CTE_Customer_Rank AS
(
SELECT
	CustomerID,
	TotalSales,
	RANK () OVER (ORDER BY TotalSales DESC) AS CustomerRank
FROM CTE_Total_Sales
)


-- Main Query
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    cts.TotalSales,
    clo.Last_Order,
    ccr.CustomerRank
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
    ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
    ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank ccr
    ON ccr.CustomerID = c.CustomerID;



-- Step 4: Segment customers based on their total sales

;WITH CTE_Total_Sales AS
(
SELECT
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)

, CTE_Last_Order AS
(
SELECT
	CustomerID,
	MAX(OrderDate) AS Last_Order
FROM Sales.Orders
GROUP BY CustomerID
)
, CTE_Customer_Rank AS
(
SELECT
	CustomerID,
	TotalSales,
	RANK () OVER (ORDER BY TotalSales DESC) AS CustomerRank
FROM CTE_Total_Sales
)

, CTE_Customer_Segments AS
( 
SELECT
    
CustomerID,
CASE WHEN TotalSales > 100 THEN 'High'
    WHEN TotalSales > 50 THEN 'Medium'
    ELSE 'Low'
END CustomerSegments
FROM CTE_Total_Sales
)

-- Main Query
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    cts.TotalSales,
    clo.Last_Order,
    ccr.CustomerRank,
    ccs.CustomerSegments
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
    ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
    ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank ccr
    ON ccr.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segments ccs
    ON ccs.CustomerID = c.CustomerID;



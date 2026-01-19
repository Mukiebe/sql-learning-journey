-- SQL Value Window Functions

/*	1. LEAD
	2. LAG
	3. FIRST_VALUE
	4. LAST_VALUE
*/

-- MIN/MAX USE CASE
-- USE CASES: LEAD and LAG
-- Comparison Analysis
-- 1. TIME SERIES ANALYSIS
-- (MoM) Month-over-Month ANALYSIS

-- Analyze the MoM performance by finding the percentage
-- change in sales between the current and the previous month

SELECT
	OrderID,
	OrderDate,
	MONTH(OrderDate) OrderMonth
FROM Sales.Orders

SELECT
	MONTH(OrderDate) OrderMonth,
	SUM (Sales) CurrentMonthSales
FROM Sales.Orders
GROUP BY
	MONTH(OrderDate)


SELECT
	MONTH(OrderDate) OrderMonth,
	SUM (Sales) CurrentMonthSales,
	LAG(SUM (Sales)) OVER (ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY
	MONTH(OrderDate)

SELECT
*,
CurrentMonthSales - PreviousMonthSales AS MoM_Change,
ROUND (CAST ((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/PreviousMonthSales *100, 1) AS MoM_Perc
FROM(
SELECT
	MONTH(OrderDate) OrderMonth,
	SUM (Sales) CurrentMonthSales,
	LAG(SUM (Sales)) OVER (ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY
	MONTH(OrderDate)
)t


-- 2. CUSTOMER RETENTION ANALYSIS
-- Analyze customer loyalty by ranking customers based on the 
-- average number of days betwee orders

SELECT
CustomerID,
AVG(DaysUntilNextOrder) AvgDays,
RANK () OVER (ORDER BY COALESCE (AVG(DaysUntilNextOrder), 9999999)) RankAvg
FROM (
	SELECT
	OrderID,
	CustomerID,
	OrderDate CurrentOrder,
	LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
	DATEDIFF (day,  OrderDate, LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
	FROM Sales.Orders
)t
GROUP BY
	CustomerID

-- VALUE WINDOW FUNCTIONS
-- FIRST_VALUE/LAST_VALUE


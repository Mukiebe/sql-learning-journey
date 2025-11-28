-- SQL Aggregate Fuctions
SELECT
*
FROM Sales.Orders;

-- 1. Count
-- Find the total number of orders
SELECT
COUNT(*) AS Total_nr_orders
FROM Sales.Orders;

-- 2. Sum
-- Find the total number of orders
SELECT
COUNT(*) AS Total_nr_orders,
SUM(sales) AS total_sales
FROM Sales.Orders;

-- 3. Average
-- Find the average sales of all orders
SELECT
COUNT(*) AS Total_nr_orders,
SUM(sales) AS total_sales,
AVG(sales) AS average_sales
FROM Sales.Orders;

-- 4. Max
-- Find the highest sales of all orders
SELECT
COUNT(*) AS Total_nr_orders,
SUM(sales) AS total_sales,
AVG(sales) AS average_sales,
MAX(sales) AS highest_sales
FROM Sales.Orders;

-- 4. Min
-- Find the lowest sales of all orders
SELECT
COUNT(*) AS Total_nr_orders,
SUM(sales) AS total_sales,
AVG(sales) AS average_sales,
MAX(sales) AS highest_sales,
MIN(sales) AS lowest_sales
FROM Sales.Orders;

SELECT
customerID,
COUNT(*) AS Total_nr_orders,
SUM(sales) AS total_sales,
AVG(sales) AS average_sales,
MAX(sales) AS highest_sales,
MIN(sales) AS lowest_sales
FROM Sales.Orders
GROUP BY CustomerID;
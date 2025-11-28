WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, ' ' UNION
SELECT 4, '  ' 
)
SELECT*
FROM Orders;

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
)
SELECT*,
DATALENGTH (Category) CategoryLen
FROM Orders; 


WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
)
SELECT*,
TRIM (Category) Policy1
FROM Orders; 

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
)
SELECT*,
DATALENGTH(Category) CategoryLen,
DATALENGTH(TRIM(Category)) Policy1
FROM Orders; 

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
)
SELECT*,
TRIM(Category) Policy1,
NULLIF(TRIM(Category), '') Policy2
FROM Orders; 

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
)
SELECT*,
TRIM(Category) Policy1,
NULLIF(TRIM(Category), '') Policy2,
COALESCE(NULLIF(TRIM(Category), ''), 'unkwown') Policy3
FROM Orders; 

-- SQL CASE WHEN Statement 
-- 1. Categorizing data
/*Create report showing total sales for each of the following categories:
High (sales over 50), Medium (sales 21-50), and Low (sales 20 or less)
Sort the categories from the highest sales to lowest*/

SELECT
Category,
SUM (Sales) AS TotalSales
FROM (
	SELECT 
	OrderID,
	Sales,
	CASE 
		WHEN Sales > 50 THEN 'High'
		WHEN Sales >20 THEN 'Medium'
		ELSE 'Low'
	END Category
	FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC;

-- 2.Mapping Values
-- Retrieve employee details with gender displayed as full text
SELECT
EmployeeID,
FirstName,
LastName,
Gender,
CASE
	WHEN Gender = 'F' THEN 'Female'
	WHEN Gender = 'M' THEN 'Male'
	ELSE 'Not Available'
END GederFullText
FROM Sales.Employees;

-- Retrieve customer details with abbreviated country code
SELECT
CustomerID,
FirstName,
LastName,
Country
FROM Sales.Customers;

SELECT
CustomerID,
FirstName,
LastName,
Country,
CASE 
	WHEN Country = 'Germany' THEN 'DE'
	WHEN Country = 'USA' THEN 'US'
	ELSE 'N/A'
END CountryAbbr,

CASE Country
	WHEN  'Germany' THEN 'DE'
	WHEN  'USA' THEN 'US'
	ELSE 'N/A'
END CountryAbbr2

FROM Sales.Customers;

-- 3. Handling Nulls
/*Find the average scores of customers and treat Nulls as 0 
and additionally provide details such as CustomerID & LastName*/

SELECT
CustomerID,
LastName,
Score
FROM Sales.Customers;

SELECT
CustomerID,
LastName,
Score,
CASE	
	WHEN Score IS NULL THEN 0
	ELSE Score
END ScoreClean,

AVG(CASE
	WHEN Score IS NULL THEN 0
	ELSE Score
	END) OVER () AvgCustomerClean,

AVG(Score) OVER() AvgCustomer
FROM Sales.Customers;

-- 4. Conditional Aggregations
/*Count how many times each customer has made an order with sales greater than 30*/

SELECT 
	OrderID,
	CustomerID,
	Sales
FROM Sales.Orders
Order BY CustomerID;


SELECT 
	CustomerID,
	SUM(CASE
		WHEN Sales > 30 THEN 1
		ELSE 0
	END) TotalOrdersHighSales,
	COUNT(*)TotalOrders
FROM Sales.Orders
GROUP BY CustomerID; 



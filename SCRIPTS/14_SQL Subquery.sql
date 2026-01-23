/* SQL SUBQUERRY
Categories

1. RESULT TYPES*/
-- a. Scalar subquery

SELECT
AVG(Sales)
FROM Sales.Orders

-- b. Row subquery
SELECT
CustomerID
FROM Sales.Orders

-- c. Table subquerry
SELECT
OrderID,
OrderDate
FROM Sales.Orders

-- 2.LOCATION/CLAUSES
-- a. FROM
-- Find the products that have a price higher than the average price of 
--all products

-- Main Query
SELECT
*
FROM
-- subquery
	(SELECT
	ProductID,
	Price,
	AVG(Price) OVER () AvgPrice
	FROM Sales.Products)t
WHERE price> AvgPrice


-- Rank Customers based on their total amount of sales

-- Main Query
SELECT
*,
RANK () OVER (ORDER BY TotalSales DESC) CustomerRank
FROM
	-- Subquery
	(SELECT
	CustomerID,
	SUM(Sales) TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID)t

-- b. SELECT
-- Only scalar subquery is allowed
-- Show the product IDS, product names, prices, ad the total number of orders

-- Main Query
SELECT
	ProductID,
	Product,
	Price,
-- Subquerry
	(SELECT COUNT(*) FROM Sales.Orders) AS  TotalOrders
FROM Sales.Products


-- c. JOIN
-- Show all customer details and find the total orders of each customer

-- Main Query
SELECT
*
FROM Sales.Customers c
LEFT JOIN (
	SELECT 
	CustomerID,
	COUNT(*) TotalOrders
	FROM Sales.Orders
	GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID

-- d. WHERE
-- i. Comparison Operators
-- only scalar subqueries are allowed to be used
-- Find the products that have a price higher than the average price of all products


SELECT
ProductID,
Price,
(SELECT AVG(Price) FROM Sales.Products) AvgPrice
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)

-- ii. Logical Operators
-- IN Operator
-- Show the details of orders made by customers in Germany

SELECT
*
FROM Sales.Orders
WHERE CustomerID IN
				(SELECT
				CustomerID
				FROM Sales.Customers
				WHERE Country = 'Germany')

-- Show the details of orders made by customers who are not in Germany
SELECT
*
FROM Sales.Orders
WHERE CustomerID IN
				(SELECT
				CustomerID
				FROM Sales.Customers
				WHERE Country != 'Germany')

				SELECT
*
FROM Sales.Orders
WHERE CustomerID NOT IN
				(SELECT
				CustomerID
				FROM Sales.Customers
				WHERE Country = 'Germany')
-- ANY Operator
-- Both syntaxes are the same

-- Find Female employees whose salaries are greater than the salaries of any male employees

SELECT
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender = 'M');

SELECT FirstName, Salary FROM Sales.Employees WHERE Gender = 'M';

-- ALL Operator
-- Find Female employees whose salaries are greater than the salaries of all male employees


SELECT
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ALL (SELECT Salary FROM Sales.Employees WHERE Gender = 'M');

SELECT FirstName, Salary FROM Sales.Employees WHERE Gender = 'M';

-- EXIST Operator
-- Sho the details or orders made by customers in Germany

SELECT
*
FROM Sales.Orders o
WHERE EXISTS (SELECT
				*
				FROM Sales.Customers c
				WHERE Country = 'Germany'
				AND o.CustomerID = c.CustomerID)


SELECT
*
FROM Sales.Orders o
WHERE NOT EXISTS (SELECT
				*
				FROM Sales.Customers c
				WHERE Country = 'Germany'
				AND o.CustomerID = c.CustomerID)



-- 3. NON-CORRELATED/ CORRELATED SUBQUERIES
-- Correlated
-- Show all customer details and find the total orders of each customer

SELECT
*,
(SELECT COUNT (*) FROM Sales.Orders o WHERE O.CustomerID = c.CustomerID) TotalSales
FROM Sales.Customers c


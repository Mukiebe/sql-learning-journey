-- 4. NULL FUNCTIONS --

-- a. IS NULL
-- i. Data Aggregration
-- Find the avergae scores of the customers

SELECT 
CustomerID,
Score
FROM Sales.Customers;

SELECT 
CustomerID,
Score,
AVG(Score) OVER () AVGScores
FROM Sales.Customers;

SELECT 
CustomerID,
Score,
AVG(Score) OVER () AVGScores,
AVG(COALESCE(Score,0)) OVER () AVGScores2
FROM Sales.Customers;

-- ii. Mathematical Aggregation
-- Display the full name of the customers in a single field by emerging their first and last names, and add 10 bonus points to each customer's name. 

SELECT CustomerID,
FirstName,
LastName,
FirstName + ' ' + LastName AS FullName,
Score
FROM Sales.Customers;

SELECT CustomerID,
FirstName,
LastName,
COALESCE (LastName, '') LastName2,
FirstName + ' ' + LastName AS FullName,
Score
FROM Sales.Customers;


SELECT CustomerID,
FirstName,
LastName,
FirstName + ' ' + COALESCE (LastName, '') AS FullName,
Score
FROM Sales.Customers;

SELECT CustomerID,
FirstName,
LastName,
FirstName + ' ' + COALESCE (LastName, '') AS FullName,
Score,
COALESCE (Score, 0) + 10 AS ScoreWithBonus
FROM Sales.Customers;

-- iii. Sorting Data
-- Sort the customers from lowest to highest scores, with nulls appearing last

SELECT
CustomerID,
Score
FROM Sales.Customers;

SELECT
CustomerID,
Score
FROM Sales.Customers
ORDER BY Score;

SELECT
CustomerID,
Score,
CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score;

-- c. NULL IF
-- i. Preventing the error of dividing by zero. 
-- find the sales price of each order by dividing sales by quantity

SELECT*
FROM Sales.Orders;

SELECT
OrderID,
Sales,
Quantity/*,
Sales/Quantity AS Price*/
FROM Sales.Orders;

SELECT
OrderID,
Sales,
Quantity,
Sales/ NULLIF (Quantity,0) AS Price
FROM Sales.Orders;

-- d. IS (NOT) NULL
-- i. Search for missing info
-- Identify the customers who have no scores

SELECT* 
FROM Sales.Customers;

SELECT* 
FROM Sales.Customers
WHERE Score IS NULL;

-- Show a list of all customers who have scores
SELECT* 
FROM Sales.Customers
WHERE Score IS NOT NULL;

-- ii. Anti-Joins
-- List all details for customers who have not placed any orders

SELECT
c.*,
o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID= o.CustomerID;

SELECT
c.*,
o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID= o.CustomerID
WHERE o.CustomerID IS NULL;
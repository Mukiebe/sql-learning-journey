DROP DATABASE Customers;

CREATE DATABASE CustomersData;
-- Rule 1; can be used in almost all querries (ORDER BY is allowed once at the end of the querry)
-- Rule 2; no.of columns in each querry must be the same
SELECT 
FirstName,
LastName
FROM 04_customers

UNION ALL

SELECT 
FirstName,
LastName
FROM 04_employees;

-- Rule 3; Data types in each column must be compatible
-- Rule 4; Order of Columns in each querry must be the same
SELECT 
CustomerID,
LastName
FROM 04_customers

UNION ALL

SELECT 
FirstName,
EmployeeID,
FROM 04_employees;

-- Rule 5; Column aliases; column names i the result are determied by the column 
SELECT 
CustomerID,
LastName
FROM 04_customers

UNION ALL

SELECT 
EmployeeID,
LastName
FROM 04_employees;

-- you can use an alias
SELECT 
CustomerID AS ID,
LastName
FROM 04_customers

UNION ALL

SELECT 
EmployeeID,
LastName
FROM 04_employees;


SELECT 
CustomerID AS ID,
LastName AS Name
FROM 04_customers

UNION ALL

SELECT 
EmployeeID,
LastName
FROM 04_employees;

-- Rule 6; you are responsible for mapping info between querries correctly
SELECT 
FirstName,
LastName
FROM 04_customers

UNION ALL

SELECT 
LastName,
FirstName
FROM 04_employees;


-- 1. UNION
-- Combine the data from eployees and customers into one table
SELECT *
FROM 04_customers;

SELECT *
FROM 04_employees;

SELECT 
FirstName,
LastName
FROM 04_customers
UNION
SELECT 
FirstName,
LastName
FROM 04_employees;


-- 2. NION ALL
-- Combine the data from eployees and customers into one table including duplicates
SELECT 
FirstName,
LastName
FROM 04_customers
UNION ALL
SELECT 
FirstName,
LastName
FROM 04_employees;


-- 3. EXCEPT
-- Find employees who are not customers at the same time
SELECT 
FirstName,
LastName
FROM 04_customers
EXCEPT
SELECT 
FirstName,
LastName
FROM 04_employees;

SELECT 
FirstName,
LastName
FROM 04_employees
EXCEPT
SELECT 
FirstName,
LastName
FROM 04_customers;

-- INTERSECT
-- Find the employees who are also customers
SELECT 
FirstName,
LastName
FROM 04_employees
INTERSECT
SELECT 
FirstName,
LastName
FROM 04_customers;

-- UNION CASES
-- Combine data before doing any reporting
/*Task- the orders are stored in seperate tables (Orders and OrdersArchive)
combine all orders into one report without duplicates*/

SELECT 
*
FROM 04_orders;

SELECT 
*
FROM ordersarchive;

SELECT 
	OrderID,
	ProductID,
	CustomerID,
	SalesPersonID,
	OrderDate,
	ShipDate,
	OrderStatus,
	ShipAddress,
	BillAddress,
	Quantity,
	Sales,
	CreationTime
FROM 04_orders
UNION
SELECT 
OrderID,
	ProductID,
	CustomerID,
	SalesPersonID,
	OrderDate,
	ShipDate,
	OrderStatus,
	ShipAddress,
	BillAddress,
	Quantity,
	Sales,
	CreationTime
FROM ordersarchive;

-- seeing the source of the table
SELECT 
'04_orders' AS SourceTable,
	OrderID,
	ProductID,
	CustomerID,
	SalesPersonID,
	OrderDate,
	ShipDate,
	OrderStatus,
	ShipAddress,
	BillAddress,
	Quantity,
	Sales,
	CreationTime
FROM 04_orders
UNION
SELECT
'OrdersArchive' AS SourceTable, 
OrderID,
	ProductID,
	CustomerID,
	SalesPersonID,
	OrderDate,
	ShipDate,
	OrderStatus,
	ShipAddress,
	BillAddress,
	Quantity,
	Sales,
	CreationTime
FROM ordersarchive
ORDER BY OrderID;

-- EXCEPT USE CASES
-- 1. Delta Detectiction
-- 2. Data completeness check

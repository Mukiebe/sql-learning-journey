-- SQL INDEXES
-- 1. 
-- a. CLUSTERED INDEX
-- b. NON-CLUSTERED INDEX

SELECT*
INTO Sales.DBCustomers
FROM Sales.Customers

-- The table above has the heap structure.

SELECT*
FROM Sales.DBCustomers
WHERE CustomerID = 1

-- Create a clustred index

CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID)

CREATE CLUSTERED INDEX idx_DBCustomers_FirtName
ON Sales.DBCustomers (FirstName)

DROP INDEX idx_DBCustomers CustomerID ON Sales.DBCustomers

SELECT 
*
FROM Sales.Customers
WHERE LastName = 'Brown'


CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName
ON Sales.DBCustomers (LastName)

CREATE NONCLUSTERED INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers (FirstName)

-- Composite Index
SELECT 
*
FROM Sales.Customers
WHERE Country = 'USA' AND Score > 500

CREATE INDEX idx_DBCustomers_CountryScore
ON Sales.DBCustomers (Country, Score)


SELECT 
*
FROM Sales.Customers
WHERE Country = 'USA' 

SELECT 
*
FROM Sales.Customers
WHERE Score > 500

-- A,B,C,D
-- Index will be used
/*A,
A,B
A,B,C*/

-- Index won't be used
/*B
A,C
A,B,D*/

-- 2. Storage
-- a. ROWSTORE INDEX
-- b. COLUMNSTORE INDEX

CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS
ON Sales.DBCustomers

DROP INDEX [idx_DBCustomers_CustomerID] ON Sales.DBCustomers

CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS
ON Sales.DBCustomers

DROP INDEX idx_DBCustomers_CS
ON Sales.DBCustomers


--USE Adventure WorksDW2022

/* USE AdventureWorksDW2022
-- Table 1: HEAP
SELECT *
INTO FactInternetSales_HP
FROM FactInternetSales 

-- Tables 2: RowStore
SELECT *
INTO FactInternetSales_RS
FROM FactInternetSales

CREATE CLUSTERED INDEX idx_FactInternetSales_RS_PK
ON FactInternetSales_RS (SalesOrderNumber, SalesOrderLineNumber) 

-- Table 3: ColumnStore
SELECT *
INTO FactInternetSales_CS
FROM FactInternetSales

CREATE CLUSTERED COLUMNSTORE INDEX idx_FactInternetSales_CS_PK
ON FactInternetSales_CS */

-- 3. Functions
-- a. UNIQUE INDEX

SELECT *
FROM Sales.Products

CREATE UNIQUE NONCLUSTERED INDEX idx_Products_Category
ON Sales.Products (Category)

-- Duplicates in the colums will prevent creating a unique index

CREATE UNIQUE NONCLUSTERED INDEX idx_Products_Product
ON Sales.Products (Product)

INSERT INTO Sales.Products (ProductID, Product) VALUES (106, 'Caps')



-- b. FILTERED INDEX

SELECT *
FROM Sales.Customers
WHERE Country = 'USA'

CREATE NONCLUSTERED INDEX idx_Customers_Country
ON Sales.Customers (Country)
WHERE Country = 'USA'
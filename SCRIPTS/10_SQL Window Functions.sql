-- SQL Window Functions: PARTITION BY, ORDER BY, FRAME
 -- Find the total sales across all orders

 SELECT 
 SUM(Sales) TotalSales
 From Sales.Orders

  -- Find the total sales for each product
 SELECT 
	ProductID,
	SUM(Sales) TotalSales
 From Sales.Orders
 GROUP BY ProductID

 /*Find the total sales for each product, additionally
 provide details such as order id, order date*/
 SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) TotalSales
 From Sales.Orders
 GROUP BY 
	OrderID,
	OrderDate,
	ProductID

-- WINDOW FUNCTIONS
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER (PARTITION BY ProductID) TotalSalesByProducts
 From Sales.Orders
 
 /*Find the total sales across all orders
 Additionally provide details such Order Id, Order date*/
 SELECT 
	OrderID,
	OrderDate,
	SUM(Sales) OVER () TotalSales
 FROM Sales.Orders


 /*Find the total sales for each product
 Additionally provide details such Order Id, Order date*/
 SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER (PARTITION BY ProductID) TotalSales
 FROM Sales.Orders


 /*Find the total sales across all orders
 Find total sales for each product
 Additionally provide details such Order Id, Order date*/

  SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) OVER () TotalSales,
	SUM(Sales) OVER (PARTITION BY ProductID) TotalSalesByProducts
 FROM Sales.Orders


 /*Find the total sales for each combination of product ad order status*/
 SELECT 
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) OVER () TotalSales,
	SUM(Sales) OVER (PARTITION BY ProductID) TotalSalesByProducts,
	SUM(Sales) OVER (PARTITION BY ProductID, OrderStatus) TotalSalesByProductsAndStatus
 FROM Sales.Orders

 -- Rank each order based on their sales from highest to lowest
 -- Additionally provide details such as order ID, orderDate

 SELECT 
	OrderID,
	OrderDate,
	Sales,
	RANK () OVER (ORDER BY Sales DESC) RankSales
FROM Sales.Orders

SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM (SALES) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSaes
FROM Sales.Orders



SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM (SALES) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) TotalSaes
FROM Sales.Orders

-- DEFAULT FRAME
--Option 1
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM (SALES) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TotalSaes
FROM Sales.Orders

--Option 2
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM (SALES) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS UNBOUNDED PRECEDING) TotalSaes
FROM Sales.Orders

--Option 3
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM (SALES) OVER (PARTITION BY OrderStatus ORDER BY OrderDate) TotalSaes
FROM Sales.Orders

-- Rules
-- 1. Use in SELECT AND ORDER BY clause
-- 2. Nesting window functions is not allowed
-- 3. SQL execute WINDOW Fuctions after WHERE Clause
-- Find the total sales for each order status, only for two products 101 and 102
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM (SALES) OVER (PARTITION BY OrderStatus ORDER BY OrderDate) TotalSaes
FROM Sales.Orders
WHERE ProductID IN (101,102)

-- 4. Window Function can be used together with GROUP BY in the same
-- Query only if the same columns are used. 
-- Rank the customers based on their total sales
SELECT 
	CustomerID,
	SUM (Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID

SELECT 
	CustomerID,
	SUM (Sales) TotalSales,
	RANK () OVER(ORDER BY SUM (Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID
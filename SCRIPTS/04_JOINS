CREATE DATABASE Customers;

-- Retrieve all data from customers and order in two differet results
SELECT *
FROM customers;

SELECT *
FROM orders;

/* INNER JOIN
Get all customers along with their orders, but only customers who have placed an order*/
SELECT *
FROM customers
INNER JOIN orders
ON customerS.CustomerID = Orders.CustomerID;

SELECT
	C.CustomerID,
    C.FirstName,
    C.LastName
FROM customers AS C
INNER JOIN orders AS O
ON C.CustomerID = O.CustomerID;

/*LEFT JOIN
Get all the customers along with their orders, including those without orders*/
SELECT
	C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Country,
    C.Score
FROM customers AS C
LEFT JOIN orders AS O
ON C.CustomerID = O.CustomerID;

/*RIGHT JOIN
Get all customers along with their orders, including orders without matching customers*/
SELECT
	C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Country,
    C.Score
FROM customers AS C
RIGHT JOIN orders AS O
ON C.CustomerID = O.CustomerID;

-- ALTERNATIVE
SELECT
	C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Country,
    C.Score
FROM orders AS O
LEFT JOIN customers AS C
ON C.CustomerID = O.CustomerID;

/* FULL JOIN 
 all customers ad all orders, even if there's no match*/
SELECT
	C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Country,
    C.Score
FROM customers AS C
FULL JOIN orders AS O
ON C.CustomerID = O.CustomerID;
 
-- UNION
-- FULL JOIN simulation using LEFT + RIGHT JOIN with UNION
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Country,
    C.Score,
    O.OrderID,
    O.Sales
FROM customers AS C
LEFT JOIN orders AS O
    ON C.CustomerID = O.CustomerID

UNION

SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Country,
    C.Score,
    O.OrderID,
    O.Sales
FROM customers AS C
RIGHT JOIN orders AS O
    ON C.CustomerID = O.CustomerID;
    
-- ADVANCED SQL JOINS
-- LEFT ANTI JOIN
-- Get all customers who haven't placed any order
    SELECT*
    FROM customers AS C
    LEFT JOIN orders AS O
    ON C.CustomerID = O.CustomerID;

  SELECT*
    FROM customers AS C
    LEFT JOIN orders AS O
    ON C.CustomerID = O.CustomerID
    WHERE O.CustomerID IS NULL;
    
-- RIGHT ANTI JOIN
-- Get all orders without matching customers

 SELECT*
    FROM customers AS C
    RIGHT JOIN orders AS O
    ON C.CustomerID = O.CustomerID
    WHERE O.CustomerID IS NULL;

-- FULL ANTI JOIN
-- Find customers without orders and orders without customers
 SELECT*
    FROM orders AS O 
   FULL JOIN customers AS C
    ON C.CustomerID = O.CustomerID
    WHERE O.CustomerID IS NULL;
    
-- UNION
SELECT *
FROM customers AS C
LEFT JOIN orders AS O
ON C.CustomerID = O.CustomerID

UNION

SELECT *
FROM customers AS C
RIGHT JOIN orders AS O
ON C.CustomerID = O.CustomerID;

-- Challenge: Get all customers along with their orders, but only for customers who have placed an order without using INNER JOIN

SELECT *
FROM customers AS C
LEFT JOIN orders AS O
ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NOT NULL;

-- CROSS JOIN
-- Generate all possible combinations of customers ad orders

SELECT *
FROM customers AS C
CROSS JOIN orders AS O;

SELECT *
FROM customers AS C
CROSS JOIN orders AS O;

/*Joining multiple tables
Using CustomersDB, Retrieve a list of all orders, along with the related customer, product, and employee details.
For each order display;
Order ID
Customer's Name
Product Name
Sales amount
Product Price
Salesperson's name*/

-- USE CustomersDB
-- Solving

SELECT
	O.OrderID,
	O.Sales,
	C.FirstName AS CustomerFirstName,
	C.LastName AS CustomerLastName,
	P.Product AS ProductName,
	P.Price,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName
FROM Customers.Orders AS O
LEFT JOIN Customers.Customers AS C
ON O.CustomerID = C.CustomerID
LEFT JOIN Customers.Products AS P
ON O.ProductID = P.ProductID
LEFT JOIN Customers.Employees AS E
ON O.SalesPersonID = E.EmployeeID;

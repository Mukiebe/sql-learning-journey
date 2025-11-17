-- 3. DATE & TIME
SELECT 
OrderID,
OrderDate,
ShipDate,
CreationTime
FROM 04_orders;


SELECT 
OrderID,
CreationTime,
'2025-08-20' HardCoded,
GETDATE() Today
FROM 04_orders;

SELECT 
  OrderID,
  CreationTime,
  '2025-08-20' HardCoded,
  NOW() AS Today
FROM 04_orders;


-- a. Part Extraction
-- i. DAY | MONTH | YEAR

SELECT
OrderID,
CreationTime,
YEAR(CreationTime) Year,
MONTH(CreationTime) Month,
DAY (CreationTime) Day
FROM 04_orders;

-- ii. DATEPART
SELECT
OrderID,
CreationTime,
DATEPART (year, CreationTime) Year_dp,
DATEPART (month, CreationTime) Month_dp,
DATEPART (day, CreationTime) Day_dp,
DATEPART (hour, CreationTime) Hour_dp,
(CreationTime) Year,
MONTH(CreationTime) Month,
DAY (CreationTime) Day
FROM 04_orders;

SELECT
  OrderID,
  CreationTime,
  YEAR(CreationTime) AS Year_dp,
  MONTH(CreationTime) AS Month_dp,
  DAY(CreationTime) AS Day_dp,
  HOUR(CreationTime) AS Hour_dp,
  YEAR(CreationTime) AS Year,
  MONTH(CreationTime) AS Month,
  DAY(CreationTime) AS Day
FROM `04_orders`;


SELECT
  OrderID,
  CreationTime,
  YEAR(CreationTime) AS Year_dp,
  MONTH(CreationTime) AS Month_dp,
  DAY(CreationTime) AS Day_dp,
  HOUR(CreationTime) AS Hour_dp,
  QUARTER(CreationTime) AS Quarter_dp,
  WEEKDAY(CreationTime) AS Weekday_dp,
    WEEK(CreationTime) AS Week_dp
FROM `04_orders`;

-- iii. DATENAME

SELECT
  OrderID,
  OrderDate,
  MONTH(OrderDate) AS Month_dn,
  WEEKDAY(OrderDate) AS Weekday_dn, 
  DAY(OrderDate) AS Day_dn
FROM `04_orders`;

SELECT
  OrderID,
  OrderDate,
  MONTH(STR_TO_DATE(OrderDate, '%d/%m/%Y')) AS Month_dn,
  DAYNAME(STR_TO_DATE(OrderDate, '%d/%m/%Y')) AS Weekday_name,
  DAY(STR_TO_DATE(OrderDate, '%d/%m/%Y')) AS Day_dn
FROM `04_orders`;

-- iii. DATETRUNC

SELECT 
OrderID, 
CreationTime, 
DATETRUNC(Year, CreationTime) AS Year_dt, 
DATETRUNC(day, CreationTime) AS Day_dt, 
DATETRUNC(minute, CreationTime) AS Minute_dt 
FROM 04_orders;

SELECT
  OrderID,
  CreationTime,
  DATE_FORMAT(CreationTime, '%Y-01-01') AS Year_dt,
  DATE(CreationTime) AS Day_dt,
  DATE_FORMAT(CreationTime, '%Y-%m-%d %H:%i:00') AS Minute_dt
FROM `04_orders`;

SELECT
DATETRUNC (month, CreationTime) Creation,
COUNT(*) 
FROM 04_Orders
GROUP BY CreationTime;

SELECT
  DATE_FORMAT(CreationTime, '%Y-%m-01') AS Creation,
  COUNT(*) AS CountPerMonth
FROM `04_Orders`
GROUP BY DATE_FORMAT(CreationTime, '%Y-%m-01');

-- iv. EOMONTH

SELECT
OrderID,
CreationTime,
EOMONTH(CreationTime) EndOfMonth
FROM 04_Orders;

SELECT
  OrderID,
  CreationTime,
  LAST_DAY(CreationTime) AS EndOfMonth,
  DATE_FORMAT(CreationTime, '%Y-%m-01') AS StartOfMonth,
  MONTHNAME(CreationTime) AS MonthName,
  WEEK(CreationTime) AS WeekNumber
FROM `04_Orders`;

-- v. SOMONTH
SELECT
  OrderID,
  CreationTime,
  DATE_FORMAT(CreationTime, '%Y-%m-01') AS StartOfMonth,
  LAST_DAY(CreationTime) AS EndOfMonth
FROM `04_Orders`;

-- Task
-- How many orders were placed each year?

SELECT
YEAR (OrderDate),
COUNT(*) NrOfOrders
FROM 04_orders
GROUP BY YEAR(OrderDate);

-- Task
-- How many orders were placed each month?
SELECT
MONTH(OrderDate),
COUNT(*) NrOfOrders
FROM 04_orders
GROUP BY MONTH(OrderDate);

-- Show all orders that were placed during the month of January
SELECT*
FROM 04_Orders
WHERE MONTH(OrderDate) = 1;


-- CREATING A TABLE

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(50),
    ShipAddress VARCHAR(255),
    BillAddress VARCHAR(255),
    Quantity INT,
    Sales INT,
    CreationTime DATETIME
);

INSERT INTO Orders (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, 
                    OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES
(1, 101, 2, 3, '2025-01-01', '2025-01-05', 'Delivered', '9833 Mt. Dias Blv.', '1226 Shoe St.', 1, 10, '2025-01-01 00:34'),
(2, 102, 3, 3, '2025-01-05', '2025-01-10', 'Shipped', '250 Race Court', NULL, 1, 15, '2025-01-05 00:22'),
(3, 101, 1, 5, '2025-01-10', '2025-01-25', 'Delivered', '8157 W. Book', '8157 W. Book', 2, 20, '2025-01-10 00:24'),
(4, 105, 1, 3, '2025-01-20', '2025-01-25', 'Shipped', '5724 Victory Lane', NULL, 2, 60, '2025-01-20 00:50'),
(5, 104, 2, 5, '2025-02-01', '2025-02-05', 'Delivered', NULL, NULL, 1, 25, '2025-02-01 00:02'),
(6, 104, 3, 5, '2025-02-05', '2025-02-10', 'Delivered', '1792 Belmont Rd.', NULL, 2, 50, '2025-02-06 00:34'),
(7, 102, 1, 1, '2025-02-15', '2025-02-27', 'Delivered', '136 Balboa Court', NULL, 2, 30, '2025-02-16 00:22'),
(8, 101, 4, 3, '2025-02-18', '2025-02-27', 'Shipped', '2947 Vine Lane', '4311 Clay Rd', 3, 90, '2025-02-18 00:45'),
(9, 101, 2, 3, '2025-03-10', '2025-03-15', 'Shipped', '3768 Door Way', NULL, 2, 20, '2025-03-10 00:59'),
(10, 102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped', NULL, NULL, 0, 60, '2025-03-16 00:25');


-- b. Format and Casting
SELECT 
OrderID,
CreationTime,
FORMAT (CreationTime, 'dd') dd,
FORMAT (CreationTime, 'ddd') ddd
FROM orders;

SELECT 
    OrderID,
    CreationTime,
    FORMAT(CAST(CreationTime AS DATETIME), 'dd') AS dd,
    FORMAT(CAST(CreationTime AS DATETIME), 'ddd') AS ddd
FROM Orders;


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(50),
    ShipAddress VARCHAR(255) NULL,
    BillAddress VARCHAR(255) NULL,
    Quantity INT,
    Sales INT,
    CreationTime DATETIME
);

INSERT INTO Orders
(OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, 
 ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES
(1, 101, 2, 3, '2025-01-01', '2025-01-05', 'Delivered', '9833 Mt. Dias Blv.', '1226 Shoe St.', 1, 10, '1/1/25 12:34 AM'),
(2, 102, 3, 3, '2025-01-05', '2025-01-10', 'Shipped', '250 Race Court', NULL, 1, 15, '1/5/25 12:22 AM'),
(3, 101, 1, 5, '2025-01-10', '2025-01-25', 'Delivered', '8157 W. Book', '8157 W. Book', 2, 20, '1/10/25 12:24 AM'),
(4, 105, 1, 3, '2025-01-20', '2025-01-25', 'Shipped', '5724 Victory Lane', NULL, 2, 60, '1/20/25 12:50 AM'),
(5, 104, 2, 5, '2025-02-01', '2025-02-05', 'Delivered', NULL, NULL, 1, 25, '2/1/25 12:02 AM'),
(6, 104, 3, 5, '2025-02-05', '2025-02-10', 'Delivered', '1792 Belmont Rd.', NULL, 2, 50, '2/6/25 12:34 AM'),
(7, 102, 1, 1, '2025-02-15', '2025-02-27', 'Delivered', '136 Balboa Court', NULL, 2, 30, '2/16/25 12:22 AM'),
(8, 101, 4, 3, '2025-02-18', '2025-02-27', 'Shipped', '2947 Vine Lane', '4311 Clay Rd', 3, 90, '2/18/25 12:45 AM'),
(9, 101, 2, 3, '2025-03-10', '2025-03-15', 'Shipped', '3768 Door Way', NULL, 2, 20, '3/10/25 12:59 AM'),
(10, 102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped', NULL, NULL, 0, 60, '3/16/25 12:25 AM');

INSERT INTO Orders
(OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, 
 ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES
(1, 101, 2, 3, '2025-01-01', '2025-01-05', 'Delivered', '9833 Mt. Dias Blv.', '1226 Shoe St.', 1, 10, '2025-01-01 00:34:00'),
(2, 102, 3, 3, '2025-01-05', '2025-01-10', 'Shipped',   '250 Race Court', NULL,                  1, 15, '2025-01-05 00:22:00'),
(3, 101, 1, 5, '2025-01-10', '2025-01-25', 'Delivered', '8157 W. Book',    '8157 W. Book',        2, 20, '2025-01-10 00:24:00'),
(4, 105, 1, 3, '2025-01-20', '2025-01-25', 'Shipped',   '5724 Victory Lane', NULL,                  2, 60, '2025-01-20 00:50:00'),
(5, 104, 2, 5, '2025-02-01', '2025-02-05', 'Delivered', NULL,               NULL,                  1, 25, '2025-02-01 00:02:00'),
(6, 104, 3, 5, '2025-02-05', '2025-02-10', 'Delivered', '1792 Belmont Rd.', NULL,                  2, 50, '2025-02-06 00:34:00'),
(7, 102, 1, 1, '2025-02-15', '2025-02-27', 'Delivered', '136 Balboa Court',  NULL,                  2, 30, '2025-02-16 00:22:00'),
(8, 101, 4, 3, '2025-02-18', '2025-02-27', 'Shipped',   '2947 Vine Lane',   '4311 Clay Rd',        3, 90, '2025-02-18 00:45:00'),
(9, 101, 2, 3, '2025-03-10', '2025-03-15', 'Shipped',   '3768 Door Way',     NULL,                  2, 20, '2025-03-10 00:59:00'),
(10,102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped',   NULL,               NULL,                  0, 60, '2025-03-16 00:25:00');

-- b. Formatting & Casting
-- i. Format

SELECT 
OrderID,
CreationTime,
FORMAT (CreationTime, 'dd') dd,
FORMAT (CreationTime, 'dddd') dddd
FROM orders;
-- FORMAT (CreationTime, 'ddd') 

DROP TABLE Orders;
SELECT 
OrderID,
CreationTime,
FORMAT (CreationTime, 'MM-dd-yyyy') USA_Format,
FORMAT (CreationTime, 'dd') dd,
FORMAT (CreationTime, 'ddd') ddd,
FORMAT (CreationTime, 'dddd') dddd,
FORMAT (CreationTime, 'MM') MM,
FORMAT (CreationTime, 'MMM') MMM,
FORMAT (CreationTime, 'MMMM') MMMM
FROM orders;

-- Show creationTime using the follow format
-- Day Wed Jan Q12025 12:34:56 PM

SELECT
OrderID,
CreationTime,
'Day' + FORMAT(CreationTime, 'ddd MMM') + 
'Q' + DATENAME (quarter, CreationTime) + ' ' +
FORMAT (CreationTime, 'yyyy hh:mm:ss tt') AS CustomFormat
FROM Orders;

-- ii. Date Aggregations
SELECT 
FORMAT (OrderDate, 'MM yy') OrderDate,
COUNT(*)
FROM orders
GROUP BY OrderDate;

-- ii. Convert
SELECT 
    CreationTime,
    DATE_FORMAT(CreationTime, '%d') AS dd,        
    DATE_FORMAT(CreationTime, '%a') AS ddd,       
    DATE_FORMAT(CreationTime, '%W') AS dddd       
FROM Orders;

-- iii. Cast
SELECT
    CAST(123 AS SIGNED) AS `String_to_Int`,
    CAST(123 AS SIGNED) AS `String_to_Int2`,
    CAST('2025-08-20' AS DATE) AS `String_to_Date`,
    CAST('2025-08-20 12:34:00' AS DATETIME) AS `String_to_DateTime`,
    CreationTime,
     CAST(CreationTime AS DATETIME) AS `DateTime to Date`
FROM orders;

-- c. Calculations

SELECT
    CAST(123 AS SIGNED) AS `String_to_Int`,
    CAST(123 AS SIGNED) AS `String_to_Int2`,
    CAST('2025-08-20' AS DATE) AS `String_to_Date`,
    CAST('2025-08-20 12:34:00' AS DATETIME) AS `String_to_DateTime`,
    CreationTime,
     CAST(CreationTime AS DATETIME) AS `DateTime to Date`
FROM orders;

-- c. Calculations
-- i. DATEADD
SELECT
    OrderID,
    OrderDate,
    DATE_SUB(OrderDate, 10, DAY) AS TenDaysBefore,
    DATE_ADD(OrderDate, 3, MONTH) AS ThreeMonthsLater,
    DATE_ADD(OrderDate, 2, YEAR) AS TwoYearsLater
FROM orders;

SELECT
    OrderID,
    OrderDate,
    DATE_SUB(OrderDate, INTERVAL 10 DAY) AS TenDaysBefore,
    DATE_ADD(OrderDate, INTERVAL 3 MONTH) AS ThreeMonthsLater,
    DATE_ADD(OrderDate, INTERVAL 2 YEAR) AS TwoYearsLater
FROM orders;

-- II. DATEDIFF
-- Calculate the age of employees
SELECT*
FROM 04_employees;

SELECT 
	EmployeeID,
	BirthDate,
DATEDIFF(year, BirthDate, GETDATE ()) Age
FROM 04_employees;

SELECT 
    EmployeeID,
    BirthDate,
    TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) AS Age
FROM `04_employees`;

-- Find the average shipping duration in days for each month

SELECT
OrderID,
OrderDate,
ShipDate,
DATEDIFF(OrderDate, ShipDate) Day2Ship
FROM orders;

SELECT
MONTH (OrderDate) AS OrderDate,
AVG (DATEDIFF(OrderDate, ShipDate)) AVGShip
FROM orders
GROUP BY MONTH (OrderDate);

-- Time Gap Analysis
-- Find the number of days between each order and the previous orders

SELECT 
	OrderID,
    OrderDate
    FROM orders;
    
SELECT 
	OrderID,
    OrderDate CurrentOrderDate,
    LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate
    FROM orders;
    
SELECT 
	OrderID,
    OrderDate CurrentOrderDate,
    LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate,
    DATEDIFF(LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) NrOfDays
    FROM orders;
    
-- d. Calculation
-- ISDATE

SELECT 
    ISDATE('123') AS DateCheck1,
    ISDATE('2025-08-20') AS DateCheck2,
    ISDATE('20-08-2025') AS DateCheck3;

SELECT
    CASE 
        WHEN STR_TO_DATE('123', '%Y-%m-%d') IS NOT NULL THEN 'Valid'
        ELSE 'Invalid'
    END AS DateCheck1,

    CASE 
        WHEN STR_TO_DATE('2025-08-20', '%Y-%m-%d') IS NOT NULL THEN 'Valid'
        ELSE 'Invalid'
    END AS DateCheck2,

    CASE 
        WHEN STR_TO_DATE('20-08-2025', '%d-%m-%Y') IS NOT NULL THEN 'Valid'
        ELSE 'Invalid'
    END AS DateCheck3,
    
    CASE 
        WHEN STR_TO_DATE('2025', '%Y') IS NOT NULL THEN 'Valid'
        ELSE 'Invalid'
    END AS DateCheck4;

SELECT
    OrderDate,
    CASE 
        WHEN STR_TO_DATE(OrderDate, '%Y-%m-%d') IS NOT NULL 
        THEN STR_TO_DATE(OrderDate, '%Y-%m-%d')
        ELSE STR_TO_DATE('9999-01-01', '%Y-%m-%d')
    END AS NewOrderDate
FROM (
    SELECT '2025-08-20' AS OrderDate UNION
    SELECT '2025-08-21' UNION
    SELECT '2025-08-23' UNION
    SELECT '2025-08'
) t;


-- WHERE ISDATE(OrderDate) = 0
    
    





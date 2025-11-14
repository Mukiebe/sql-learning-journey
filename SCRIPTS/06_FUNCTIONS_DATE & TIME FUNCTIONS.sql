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
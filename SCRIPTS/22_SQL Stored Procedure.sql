-- Step 1: Write a Query
-- For US Customers Find the Total Number of Customers as the Average Score

SELECT 
COUNT (*) Customers, 
AVG (Score) AvgScore
FROM Sales.Customers
WHERE Country = 'USA'


-- Step 2: Turning the Query Into a Stored Procedure

CREATE PROCEDURE GetCustomerSummary AS
BEGIN
SELECT 
COUNT (*) Customers, 
AVG (Score) AvgScore
FROM Sales.Customers
WHERE Country = 'USA'
END



-- Step 3: Execute the Stored Procedure

EXEC GetCustomerSummary


-- New Task: For Germany Customers Find the Total Number of Customers and the Average Score

CREATE PROCEDURE GetCustomerSummaryGermany AS
BEGIN
SELECT 
COUNT (*) Customers, 
AVG (Score) AvgScore
FROM Sales.Customers
WHERE Country = 'Germany'
END

EXEC GetCustomerSummaryGermany 

-- to avoid repetition follow below
--  Step 1: Define the Parameter

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR (50) = 'USA'
AS
BEGIN
SELECT 
	COUNT (*) TotalCustomers, 
	AVG (Score) AvgScore
FROM Sales.Customers
WHERE Country = @Country
END

EXEC GetCustomerSummary @Country = 'Germany'

EXEC GetCustomerSummary @Country = 'USA'

DROP PROCEDURE GetCustomerSummaryGermany


-- Multiple Queries / Statements
-- Find the Total Nr. of Orders and Total Sales

SELECT 
	COUNT (OrderID) TotalOrders, 
	SUM (Sales) TotlSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE C.Country = 'USA'



ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR (50) = 'USA'
AS
BEGIN
SELECT 
	COUNT (*) TotalCustomers, 
	AVG (Score) AvgScore
FROM Sales.Customers
WHERE Country = @Country; 

SELECT 
	COUNT (OrderID) TotalOrders, 
	SUM (Sales) TotlSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE C.Country = @Country;

END


EXEC GetCustomerSummary 
EXEC GetCustomerSummary @Country = 'Germany'



-- Variables
-- Total Customers from Germany: 2
-- Average Score from Germany: 425


ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR (50) = 'USA'
AS
BEGIN

DECLARE @TotalCustomers INT, @AvgScore FLOAT;  -- Step 1: Declare Variables

SELECT 
	@TotalCustomers = COUNT (*), -- Step 2: Assign Values to Variables 
	@AvgScore = Avg(Score)
FROM Sales.Customers
WHERE Country = @Country; 

PRINT 'Total Customers from ' + @Country + ':' + CAST (@TotalCustomers AS NVARCHAR); -- Step 3: Use Variables 
PRINT 'Average Score from ' + @Country + ':' + CAST (@AvgScore AS NVARCHAR);

SELECT 
	COUNT (OrderID) TotalOrders, 
	SUM (Sales) TotlSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE C.Country = @Country;

END

EXEC GetCustomerSummary 
EXEC GetCustomerSummary @Country = 'Germany'




-- Control Flow

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR (50) = 'USA'
AS
BEGIN

DECLARE @TotalCustomers INT, @AvgScore FLOAT;  

-- Prepare and Cleanup Data

IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
BEGIN
	PRINT ('Updating NULL Scores to 0');
	UPDATE Sales.Customers
	SET Score = 0
	WHERE Score IS NULL AND Country = @Country;
END

ELSE
BEGIN
	PRINT ('No NULL Scores Found')
END;

-- Generating Reports

SELECT 
	@TotalCustomers = COUNT (*), -- Step 2: Assign Values to Variables 
	@AvgScore = Avg(Score)
FROM Sales.Customers
WHERE Country = @Country; 

PRINT 'Total Customers from ' + @Country + ':' + CAST (@TotalCustomers AS NVARCHAR); -- Step 3: Use Variables 
PRINT 'Average Score from ' + @Country + ':' + CAST (@AvgScore AS NVARCHAR);

SELECT 
	COUNT (OrderID) TotalOrders, 
	SUM (Sales) TotlSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE C.Country = @Country;

END

EXEC GetCustomerSummary 
EXEC GetCustomerSummary @Country = 'Germany'



-- TRY AND CATCH

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR (50) = 'USA'
AS
BEGIN
BEGIN TRY
DECLARE @TotalCustomers INT, @AvgScore FLOAT;  

-- Prepare and Cleanup Data
IF EXISTS ( SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
BEGIN
    PRINT 'Updating NULL Scores to 0';
    UPDATE Sales.Customers
    SET Score = 0
    WHERE Score IS NULL AND Country = @Country;
END

ELSE
BEGIN
    PRINT 'No NULL Scores Found';
END;

-- Generating Reports
SELECT 
    @TotalCustomers = COUNT(*),
    @AvgScore = AVG(Score)
FROM Sales.Customers
WHERE Country = @Country; 

PRINT 'Total Customers from ' + @Country + ': ' + CAST(@TotalCustomers AS NVARCHAR);
PRINT 'Average Score from ' + @Country + ': ' + CAST(@AvgScore AS NVARCHAR);

SELECT 
    COUNT(OrderID) TotalOrders, 
    SUM(Sales)TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c.Country = @Country;

END TRY
BEGIN CATCH
        PRINT ('An error occurred.'); 
        PRINT ('Error Message: ' + ERROR_MESSAGE()); 
        PRINT ('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR)); 
        PRINT ('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR)); 
        PRINT ('Error Procedure: ' + ERROR_PROCEDURE()); 
END CATCH
END
GO

EXEC GetCustomerSummary 
EXEC GetCustomerSummary @Country = 'Germany'






-- Styling

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR (50) = 'USA'
AS
BEGIN

DECLARE @TotalCustomers INT, @AvgScore FLOAT;  

-- Prepare and Cleanup Data

IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
BEGIN
	PRINT ('Updating NULL Scores to 0');
	UPDATE Sales.Customers
	SET Score = 0
	WHERE Score IS NULL AND Country = @Country;
END

ELSE
BEGIN
	PRINT ('No NULL Scores Found')
END;

-- Generating Reports

SELECT 
	@TotalCustomers = COUNT (*), -- Step 2: Assign Values to Variables 
	@AvgScore = Avg(Score)
FROM Sales.Customers
WHERE Country = @Country; 

PRINT 'Total Customers from ' + @Country + ':' + CAST (@TotalCustomers AS NVARCHAR); -- Step 3: Use Variables 
PRINT 'Average Score from ' + @Country + ':' + CAST (@AvgScore AS NVARCHAR);

SELECT 
	COUNT (OrderID) TotalOrders, 
	SUM (Sales) TotlSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE C.Country = @Country;

END

EXEC GetCustomerSummary 
EXEC GetCustomerSummary @Country = 'Germany'



-- TRY AND CATCH

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR (50) = 'USA'
AS
BEGIN
	BEGIN TRY
		DECLARE @TotalCustomers INT, @AvgScore FLOAT;  
		
		-- =======================================
		-- Step 1: Prepare and Cleanup Data
		-- =======================================
		IF EXISTS ( SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
		BEGIN
			PRINT 'Updating NULL Scores to 0';
			UPDATE Sales.Customers
			SET Score = 0
			WHERE Score IS NULL AND Country = @Country;
		END

		ELSE
		BEGIN
			PRINT 'No NULL Scores Found';
		END;

		-- =======================================
		-- Step 2: Generating Summary Reports
		-- =======================================
		-- Calculate Total Customers & Avg Score for Specific Country
		SELECT 
			@TotalCustomers = COUNT(*),
			@AvgScore = AVG(Score)
		FROM Sales.Customers
		WHERE Country = @Country; 

		PRINT 'Total Customers from ' + @Country + ': ' + CAST(@TotalCustomers AS NVARCHAR);
		PRINT 'Average Score from ' + @Country + ': ' + CAST(@AvgScore AS NVARCHAR);

		-- Calculate Total Nr, of Orders & Total Sales for Specific Country
		SELECT 
			COUNT(OrderID) TotalOrders, 
			SUM(Sales)TotalSales
		FROM Sales.Orders o
		JOIN Sales.Customers c
		ON c.CustomerID = o.CustomerID
		WHERE c.Country = @Country;
	END TRY
	BEGIN CATCH
			-- ==========================================
			-- Error Handling 
			-- ==========================================
			PRINT ('An error occurred.'); 
			PRINT ('Error Message: ' + ERROR_MESSAGE()); 
			PRINT ('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR)); 
			PRINT ('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR)); 
			PRINT ('Error Procedure: ' + ERROR_PROCEDURE()); 
	END CATCH
END
GO

EXEC GetCustomerSummary 
EXEC GetCustomerSummary @Country = 'Germany'
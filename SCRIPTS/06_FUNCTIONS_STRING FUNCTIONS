-- STRING FUNCTIONS
-- 1. MANIPULATION
-- a. CONCAT
-- CoNCAT first name and country into one column

SELECT
first_name,
country
FROM 04_customers;

SELECT*
FROM 04_customers;

SELECT
FirstName,
country
FROM 04_customers;

SELECT
FirstName,
country,
CONCAT (FirstName, '-', country) AS name_country
FROM 04_customers;

-- b. LOWER
-- Convert the first name to lowercase

SELECT
FirstName,
country,
CONCAT (FirstName, '-', country) AS name_country,
LOWER (FirstName) AS Low_name
FROM 04_customers;

-- c. UPPER
-- Transform the customer's first name to uppercase

SELECT
FirstName,
country,
CONCAT (FirstName, '-', country) AS name_country,
LOWER (FirstName) AS Low_name,
UPPER (FirstName) AS Up_name
FROM 04_customers;

-- d. TRIM
-- Find customers whose first name contains leading or trailing spaces

SELECT
FirstName
FROM 04_customers
WHERE FirstName != TRIM(FirstName);

-- 
SELECT
FirstName,
LEN(FirstName) AS len_name,
LEN(TRIM(FirstName)) len_trim_name
FROM 04_customers;
--
SELECT
FirstName,
LENGTH(FirstName) AS len_name,
LENGTH(TRIM(FirstName)) len_trim_name,
LENGTH(FirstName) - LENGTH(TRIM(FirstName)) flag
FROM 04_customers;

-- e. REPLACE
-- Remove dashes (-) from a phone number

SELECT 
'123-456-7890' AS phone,
REPLACE('123-456-7890', '-', '/') AS clean_phone;

-- Replace File Extence from txt to csv
SELECT
'report.txt' AS old_filename,
REPLACE('report.txt', 'txt', '.csv') AS new_filename;

-- 2. Calculation
-- a. LENGTH
-- Calculate the length of each customer's first name

SELECT
FirstName,
LENGTH(FirstName) AS Len_Name
FROM 04_customers;

-- 3. String Extractions
-- a. LEFT
-- Retrieve the first two characters of each first name.

SELECT 
FirstName,
LEFT (FirstName, 2) first_2_char
FROM 04_customers;

-- a. RIGHT
-- Retrieve the last two characters of each first name.

SELECT 
FirstName,
RIGHT (FirstName, 2) AS Right_2_Char
FROM 04_customers;

SELECT 
FirstName,
LEFT (FirstName,2) first_2_char,
RIGHT (FirstName, 2) last_2_Char
FROM 04_customers;

-- c. SUBSTRING
-- Retrieve a list of customers' first_names removing the first character

SELECT 
	FirstName,
	SUBSTRING(FirstName, 2, 4) AS sub_name
FROM 04_customers;


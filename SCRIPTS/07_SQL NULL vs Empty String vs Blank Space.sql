WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, ' ' UNION
SELECT 4, '  ' 
)
SELECT*
FROM Orders;

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
)
SELECT*,
DATALENGTH (Category) CategoryLen
FROM Orders; 


WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
)
SELECT*,
TRIM (Category) Policy1
FROM Orders; 

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
)
SELECT*,
DATALENGTH(Category) CategoryLen,
DATALENGTH(TRIM(Category)) Policy1
FROM Orders; 

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
)
SELECT*,
TRIM(Category) Policy1,
NULLIF(TRIM(Category), '') Policy2
FROM Orders; 

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
)
SELECT*,
TRIM(Category) Policy1,
NULLIF(TRIM(Category), '') Policy2,
COALESCE(NULLIF(TRIM(Category), ''), 'unkwown') Policy3
FROM Orders; 

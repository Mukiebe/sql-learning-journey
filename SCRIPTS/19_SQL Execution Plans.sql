SELECT*
FROM FactResellerSales
WHERE CarrierTrackingNumber = '4911-403c-98'

CREATE NONCLUSTERED INDEX idx_FactReseller_CTA
ON FactResellerSales (CarrierTrackingNumber)

SELECT
	p.EnglishProductName AS ProductName,
	SUM (s.SalesAmount) AS TotalSales
FROM FactResellerSales s
JOIN DimProduct p
ON p.ProductKey = s.ProductKey
GROUP BY p.EnglishProductName


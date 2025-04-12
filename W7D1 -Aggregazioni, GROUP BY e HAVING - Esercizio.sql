-- Esercizio 1
-- Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 
-- Quali considerazioni/ragionamenti è necessario che tu faccia?

SELECT ProductKey
, COUNT(*)
FROM dimproduct
GROUP BY ProductKey
HAVING count(*) = 1;
-- ProductKey è una primarykey all'interno della tabella dimproduct in quanto all'interno del campo key è indicata come PRI.
-- E' una chiave primaria con datatype INT e non accetta valori duplicati. Essendo una primary key non ammette valori duplicati, quindi è un
-- campo univoco;

-- Esercizio 2
-- Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK;

SELECT SalesOrderNumber
, SalesOrderLineNumber
, COUNT(*)
FROM factresellersales
GROUP BY SalesOrderNumber, SalesOrderLineNumber
HAVING count(*) > 1;

-- Esercizio 3
-- Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020;

SELECT *
FROM factresellersales;

SELECT OrderDate
, COUNT(SalesOrderLineNumber)
FROM factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY OrderDate
ORDER BY OrderDate;

-- Esercizio 4
-- Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) e il prezzo medio
-- di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
-- Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 
-- I campi in output devono essere parlanti;

SELECT * 
FROM factresellersale;

SELECT * 
FROM dimproduct;

SELECT B.EnglishProductName AS NomeProdotto
, SUM(A.SalesAmount) AS FatturatoTotale
, SUM(A.OrderQuantity) AS QuantitaTotaleVenduta
, AVG(A.UnitPrice) AS PrezzoMedio
FROM factresellersales AS A
INNER JOIN
dimproduct AS B
ON A.ProductKey = B.ProductKey
WHERE A.OrderDate >= '2020-01-01'
GROUP BY B.EnglishProductName;

-- Esercizio 5
-- Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) 
-- per Categoria prodotto (DimProductCategory). Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale 
-- e la quantità totale venduta. I campi in output devono essere parlanti;

SELECT *
FROM factresellersales;

SELECT *
FROM dimproductcategory;

SELECT * 
FROM dimproductsubcategory;

SELECT * 
FROM dimproduct;

SELECT D.EnglishProductCategoryName
, SUM(A.SalesAmount) AS FatturatoTotale
, SUM(A.OrderQuantity) AS QuantitaTotaleVenduta
FROM factresellersales AS A
INNER JOIN
dimproduct AS B
ON A.ProductKey = B.ProductKey 
INNER JOIN
dimproductsubcategory AS C
ON B.ProductSubcategoryKey = C.ProductSubcategoryKey
INNER JOIN
dimproductcategory AS D
ON C.ProductCategoryKey = D.ProductCategoryKey
GROUP BY D.EnglishProductCategoryName
ORDER BY FatturatoTotale;

-- Esercizio 6
-- Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre 
-- lʼelenco delle città con fatturato realizzato superiore a 60K;

SELECT * 
FROM dimgeography;

SELECT *
FROM dimreseller;

SELECT *
FROM factresellersales;

SELECT C.City AS Città
, SUM(A.SalesAmount) AS FatturatoTotale
FROM factresellersales AS A
INNER JOIN
dimreseller AS B
ON A.ResellerKey = B.ResellerKey
INNER JOIN
dimgeography AS C
ON B.GeographyKey = C.GeographyKey
WHERE OrderDate >= '2020-01-01'
GROUP BY C.City
HAVING SUM(SalesAmount) > 60000
ORDER BY FatturatoTotale;

                     
-- Esercizio 1
-- Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory);

-- Interrogo le tabelle di interesse;
SELECT * 
FROM dimproduct;

SELECT *
FROM dimproductsubcategory;

-- Espongo solo i prodotti per i quali è presente una sottocategoria;
SELECT
A.ProductKey
, A.EnglishProductName
, A.ProductSubcategoryKey
, B.ProductSubcategoryKey
, B.EnglishProductSubcategoryName
FROM dimproduct AS A 
INNER JOIN 
dimproductsubcategory AS B
ON A.ProductSubcategoryKey = B.ProductSubcategoryKey;

-- Espongo anche prodotti per i quali non è presente una sottocategoria;
SELECT
A.ProductKey
, A.EnglishProductName
, A.ProductSubcategoryKey
, B.ProductSubcategoryKey
, B.EnglishProductSubcategoryName
FROM dimproduct AS A 
LEFT OUTER JOIN 
dimproductsubcategory AS B
ON A.ProductSubcategoryKey = B.ProductSubcategoryKey;

-- Esercizio 2
-- Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory,
-- DimProductCategory);

-- Interrogo le tabelle di interesse;
SELECT *
FROM dimproductcategory;

SELECT * 
FROM dimproduct;

SELECT *
FROM dimproductsubcategory;

-- Espongo solo i prodotti per i quali è presente una sottocategoria e una categoria;
SELECT
 A.ProductKey
 , A.EnglishProductName
 , A.ProductSubcategoryKey
 , B.ProductSubcategoryKey
 , B.EnglishProductSubcategoryName
 , B.ProductCategoryKey
 , C.ProductCategoryKey
 , C.EnglishProductCategoryName
FROM dimproduct AS A 
INNER JOIN 
dimproductsubcategory AS B 
ON A.ProductSubcategoryKey = B.ProductSubcategoryKey
INNER JOIN 
dimproductcategory AS C 
ON B.ProductCategoryKey = C.ProductCategoryKey;

-- Espongo anche i prodotti per i quali non è presente una sottocategoria e una categoria;
SELECT
 A.ProductKey
 , A.EnglishProductName
 , A.ProductSubcategoryKey
 , B.ProductSubcategoryKey
 , B.EnglishProductSubcategoryName
 , B.ProductCategoryKey
 , C.ProductCategoryKey
 , C.EnglishProductCategoryName
FROM dimproduct AS A 
LEFT OUTER JOIN 
dimproductsubcategory AS B 
ON A.ProductSubcategoryKey = B.ProductSubcategoryKey
LEFT OUTER JOIN dimproductcategory AS C 
ON B.ProductCategoryKey = C.ProductCategoryKey;

-- Esercizio 3
-- Esponi lʼelenco dei soli prodotti venduti (DimProduct, FactResellerSales);

-- Interrogo le tabelle di interesse;
SELECT * 
FROM dimproduct;

SELECT * 
FROM factresellersales;

SELECT DISTINCT
A.ProductKey
, A.EnglishProductName
, B.SalesOrderNumber
, B.ProductKey
, B.ResellerKey
FROM dimproduct AS A 
INNER JOIN 
factresellersales AS B
ON A.ProductKey = B.ProductKey;

-- Esercizio 4
-- Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1);

-- Alternativa uno LEFT OUTER JOIN;
SELECT 
A.ProductKey
, A.EnglishProductName
, A.FinishedGoodsFlag
, B.ProductKey
FROM dimproduct AS A
LEFT OUTER JOIN
factresellersales AS B
ON A.ProductKey = B.ProductKey
WHERE A.FinishedGoodsFlag = 1
AND B.ProductKey IS NULL;

-- Alternativa due SUBQUERY;

SELECT ProductKey,
EnglishProductName
FROM dimproduct
WHERE FinishedGoodsFlag = 1 
AND ProductKey NOT IN (SELECT ProductKey
					   FROM factresellersales);

-- Esercizio 5
-- Esponi lʼelenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct);

-- Interrogo le tabelle di interesse;
SELECT * 
FROM dimproduct;

SELECT * 
FROM factresellersales;

SELECT 
A.*
, B.EnglishProductName
FROM factresellersales AS A INNER JOIN
dimproduct AS B
ON A.ProductKey = B.ProductKey;

-- Esercizio 6
-- Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto;

-- Interrogo le tabelle di interesse;
SELECT * 
FROM dimproduct;

SELECT * 
FROM factresellersales;

SELECT * 
FROM dimproductcategory;

SELECT * 
FROM dimproductsubcategory;

SELECT 
A.*
, B.EnglishProductName
, C.EnglishProductSubcategoryName
, D.EnglishProductCategoryName
FROM factresellersales AS A 
INNER JOIN
dimproduct AS B 
ON A.ProductKey = B.ProductKey
INNER JOIN 
dimproductsubcategory AS C
ON B.ProductSubcategoryKey = C.ProductSubcategoryKey
INNER JOIN 
dimproductcategory AS D
ON C.ProductCategoryKey = D.ProductCategoryKey;

-- Esercizio 7
-- Esplora la tabella DimReseller;

SELECT * 
FROM dimreseller;

-- Esercizio 8
-- Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica;

-- Interrogo le tabelle di interesse
SELECT * 
FROM dimreseller;

SELECT * 
FROM dimgeography;

-- Espongo solo i reseller per i quali è presente l'area geografica;
SELECT 
A.ResellerKey
, A.ResellerName
, A.GeographyKey
, B.City
, B.EnglishCountryRegionName
FROM dimreseller AS A 
INNER JOIN
dimgeography AS B
ON A.GeographyKey = B.GeographyKey;

-- Espongo anche i reseller per i quali non è presente l'area geografica;
SELECT 
A.ResellerKey
, A.ResellerName
, A.GeographyKey
, B.City
, B.EnglishCountryRegionName
FROM dimreseller AS A 
LEFT OUTER JOIN
dimgeography AS B
ON A.GeographyKey = B.GeographyKey;
-- Non ci sono reseller per i quali non è presente l'area geografica;

-- Esercizio 9
-- Esponi lʼelenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, 
-- UnitPrice, Quantity, TotalProductCost. Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, 
-- il nome del reseller e lʼarea geografica;

-- -- Interrogo le tabelle di interesse
SELECT * 
FROM factresellersales;

SELECT * 
FROM dimproduct;

SELECT * 
FROM dimproductcategory;

SELECT * 
FROM dimproductsubcategory;

SELECT * 
FROM dimreseller;

SELECT * 
FROM dimgeography;

SELECT 
A.SalesOrderNumber
, A.SalesOrderLineNumber
, A.OrderDate
, A.UnitPrice
, A.OrderQuantity
, A.TotalProductCost
, B.EnglishProductName
, C.EnglishProductSubcategoryName
, D.EnglishProductCategoryName
, E.ResellerName
, F.City
, F.EnglishCountryRegionName
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
INNER JOIN 
dimreseller AS E
ON A.ResellerKey = E.ResellerKey
INNER JOIN
dimgeography AS F
ON E.GeographyKey = F.GeographyKey;






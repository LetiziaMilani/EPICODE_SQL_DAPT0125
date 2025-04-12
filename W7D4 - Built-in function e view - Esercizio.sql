-- Esercizio 1
-- Implementa una vista denominata Product al fine di creare unʼanagrafica (dimensione) prodotto completa. La vista, se interrogata o utilizzata
-- come sorgente dati, deve esporre il nome prodotto, il nome della sottocategoria associata e il nome della categoria associata;

USE adw;

SELECT *
FROM dimproduct;

SELECT * 
FROM dimproductsubcategory;

SELECT *
FROM dimproductcategory;

CREATE VIEW LM_Product AS (
SELECT A.ProductKey AS CodiceProdotto 
, A.EnglishProductName AS NomeProdotto
, B.EnglishProductSubcategoryName AS NomeSottoCategoria
, C.EnglishProductCategoryName AS NomeCategoria
, A.StandardCost AS CostoStandard
, A.FinishedGoodsFlag AS IndicatoreProdottoFinito
, A.ListPrice AS PrezzoListino
FROM DimProduct AS A
INNER JOIN
dimproductsubcategory AS B
ON A.ProductSubcategoryKey = B.ProductSubcategoryKey
INNER JOIN
dimproductcategory AS C
ON C.ProductCategoryKey = B.ProductCategoryKey
ORDER BY ProductKey
);

SELECT *
FROM LM_Product;

-- Esercizio 2;
--  Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa. La vista, se interrogata o utilizzata
-- come sorgente dati, deve esporre il nome del reseller, il nome della città e il nome della regione;

SELECT *
FROM dimreseller;

SELECT *
FROM dimgeography;

CREATE VIEW LM_Reseller AS (
SELECT A.ResellerKey AS CodiceRivenditore
, A.ResellerName AS NomeRivenditore
, A.BusinessType AS ModelloBusiness
, A.NumberEmployees AS NumeroDipendenti
, B.City AS NomeCitta
, B.StateProvinceName AS Provincia
, B.EnglishCountryRegionName AS Regione
FROM dimreseller AS A
INNER JOIN
dimgeography AS B
ON A.GeographyKey = B.GeographyKey
);

SELECT *
FROM LM_Reseller;

-- Esercizio 3
-- Crea una vista denominata Sales che deve restituire la data dellʼordine, il codice documento, la riga di corpo del documento, 
-- la quantità venduta, lʼimporto totale e il profitto;

SELECT * 
FROM factresellersales;

-- Non facciamo la UNION con la tabella 'FACTINTERNETSALES' in quanto non presenta il campo ResellerKey, che permette di effettuare il collegamento 
-- con la view 'Reseller'. Per effettuare la UNION dovremmo aggiungere sulla tabella 'FACTINTERNETSALES' una colonna che conterrà tutti NULL 
-- per il fatto che non è presente il campo 'ResellerKey', quindi non avrebbe molto senso;

CREATE VIEW LM_Sales AS (
SELECT A.OrderDate AS DataOrdine
, A.SalesOrderNumber AS CodiceDocumento
, A.SalesOrderLineNumber AS RigaDiCorpoDelDocumento
, A.ProductKey AS CodiceProdotto
, A.ResellerKey AS CodiceRivenditore
, A.OrderQuantity AS Quantita
, A.UnitPrice AS PrezzoUnitario
, A.SalesAmount AS ImportoTotale
, IFNULL (A.TotalProductCost, B.StandardCost * A.OrderQuantity) AS CostoTotale -- Effettuo questo passaggio in quanto, per alcuni prodotti,  
FROM factresellersales AS A  					                               -- non è presente il TotalProductCost quindi lo vado a calcolare com                                                  -- come prodotto tra OrderQuantity e StandardCost (dimproduct)
INNER JOIN                                                                     -- come prodotto tra OrderQuantity e StandardCost (dimproduct)
dimproduct AS B
ON A.ProductKey = B.ProductKey
ORDER BY A.SalesOrderNumber, A.SalesOrderLineNumber
);

-- Alternativa all' IF NULL (TotalProductCost, StandardCost * OrderQuantity):  
-- CASE WHEN A.TotalProductCost IS NULL
-- THEN A.StandardCost * B.OrderQuantity
-- ELSE A.TotalProductCost END

SELECT *
FROM LM_Sales;







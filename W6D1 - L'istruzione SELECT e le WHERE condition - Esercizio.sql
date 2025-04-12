-- Esercizio 2
-- Esplora la tabelle dei prodotti (DimProduct);
-- Per esplorare la tabella bisogna andare a vedere quale campo è la primary key, quali le foreign key e i vari datatype assegnati ai campi della tabella;
SELECT * 
FROM dimproduct;
-- Esercizio 3
-- Interroga la tabella dei prodotti (DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color, 
-- StandardCost, FinishedGoodsFlag. Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno;
SELECT ProductKey
, ProductAlternateKey
, EnglishProductName
, Color
, StandardCost
, FinishedGoodsFlag
FROM dimproduct;

-- Assegno gli alias;
SELECT ProductKey AS CodiceProdotto
, ProductAlternateKey AS CodiceProdottoAlternativo
, EnglishProductName AS NomeProdotto
, Color AS Colore
, StandardCost AS Costo
, FinishedGoodsFlag AS IndicatoreProdottoFinito
FROM dimproduct;

-- Esercizio 4
-- Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo 
-- FinishedGoodsFlag è uguale a 1;
SELECT ProductKey AS CodiceProdotto
, ProductAlternateKey AS CodiceProdottoAlternativo
, EnglishProductName AS NomeProdotto
, Color AS Colore
, StandardCost AS Costo
, FinishedGoodsFlag AS IndicatoreProdottoFinito
FROM dimproduct
WHERE FinishedGoodsFlag = 1;

-- Esercizio 5
-- Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK.
-- Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost) 
-- e il prezzo di listino (ListPrice);

SELECT ProductKey AS CodiceProdotto
, ProductAlternateKey AS CodiceProdottoAlternativo
, ModelName AS Modello
, EnglishProductName AS NomeProdotto
, StandardCost AS CostoStandard
, ListPrice AS PrezzoDiListino
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';

-- Esercizio 6
-- Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dallʼazienda (ListPrice - StandardCost);
SELECT ProductKey AS CodiceProdotto
, ProductAlternateKey AS CodiceProdottoAlternativo
, ModelName AS Modello
, EnglishProductName AS NomeProdotto
, StandardCost AS CostoStandard
, ListPrice AS PrezzoDiListino
, ListPrice - StandardCost AS Markup
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';

-- Esercizio 7
-- Scrivi unʼaltra query al fine di esporre lʼelenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000;
SELECT ProductKey AS CodiceProdotto
, ProductAlternateKey AS CodiceProdottoAlternativo
, EnglishProductName AS NomeProdotto
, FinishedGoodsFlag AS IndicatoreProdottoFinito
, ListPrice AS PrezzoDiListino
FROM dimproduct
WHERE FinishedGoodsFlag = 1 AND
ListPrice BETWEEN 1000 AND 2000;

-- Esercizio 8
-- Esplora la tabella degli impiegati aziendali;
SELECT *
FROM dimemployee;

-- Esercizio 9 
-- Esponi, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti. Gli agenti sono i dipendenti per i quali 
-- il campo SalespersonFlag è uguale a 1.

SELECT EmployeeKey AS CodiceImpiegato
, FirstName AS Nome
, LastName AS Cognome
, SalesPersonFlag AS IndicatoreVenditore
FROM dimemployee
WHERE SalesPersonFlag = 1;

-- Esercizio 10
-- Interroga la tabella delle vendite (FactResellerSales). Esponi in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020
-- dei soli codici prodotto: 597, 598, 477, 214. Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost);
SELECT *
FROM factresellersales;

SELECT SalesOrderNumber AS NumeroVendita
, SalesOrderLineNumber AS NumeroLineaOrdine -- Inserisco anche questo campo perchè anch'esso è una primary key
, OrderDate AS DataOrdine
, ProductKey AS CodiceProdotto
, SalesAmount - TotalProductCost AS Profitto
FROM factresellersales
WHERE OrderDate >= '2020-01-01' AND
ProductKey IN (597, 598, 477, 214);




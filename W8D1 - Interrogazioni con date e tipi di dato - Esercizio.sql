CREATE SCHEMA Store;

USE Store;

-- TABELLA REGIONE
CREATE TABLE REGIONE (
    IDREGIONE INT PRIMARY KEY,
    NOMEREGIONE VARCHAR(50) NOT NULL
);

-- TABELLA CITTA
CREATE TABLE CITTA (
    IDCITTA INT PRIMARY KEY,
    NOMECITTA VARCHAR(50) NOT NULL,
    IDREGIONE INT NOT NULL,
    FOREIGN KEY (IDREGIONE) REFERENCES REGIONE(IDREGIONE)
);

-- TABELLA STORE
CREATE TABLE STORE (
    IDSTORE INT PRIMARY KEY,
    NOMESTORE VARCHAR(100) NOT NULL,
    DATAAPERTURA DATE NOT NULL,
    IDCITTA INT NOT NULL,
    FOREIGN KEY (IDCITTA) REFERENCES CITTA(IDCITTA)
);

INSERT INTO REGIONE (IDREGIONE, NOMEREGIONE) 
VALUES
(1, 'Abruzzo'),
(2, 'Basilicata'),
(3, 'Calabria'),
(4, 'Campania'),
(5, 'Emilia-Romagna'),
(6, 'Friuli-Venezia Giulia'),
(7, 'Lazio'),
(8, 'Liguria'),
(9, 'Lombardia'),
(10, 'Marche'),
(11, 'Molise'),
(12, 'Piemonte'),
(13, 'Puglia'),
(14, 'Sardegna'),
(15, 'Sicilia'),
(16, 'Toscana'),
(17, 'Trentino-Alto Adige'),
(18, 'Umbria'),
(19, 'Valle Aosta'),
(20, 'Veneto');

INSERT INTO CITTA (IDCITTA, NOMECITTA, IDREGIONE) 
VALUES
(1, 'Milano', 9),
(2, 'Monza', 9),
(3, 'Roma', 7),
(4, 'Latina', 7),
(5, 'Napoli', 4),
(6, 'Salerno', 4),
(7, 'Torino', 12),
(8, 'Alessandria', 12),
(9, 'Palermo', 15),
(10, 'Catania', 15),
(11, 'Bari', 13),
(12, 'Lecce', 13),
(13, 'Bologna', 5),
(14, 'Modena', 5),
(15, 'Firenze', 16),
(16, 'Pisa', 16),
(17, 'Venezia', 20),
(18, 'Verona', 20),
(19, 'Cagliari', 14),
(20, 'Sassari', 14);

INSERT INTO STORE (IDSTORE, NOMESTORE, DATAAPERTURA, IDCITTA) VALUES
(1, 'Fashion House', '2019-05-10', 1),
(2, 'Tech Planet', '2020-08-15', 1),
(3, 'Bookland', '2018-03-21', 2),
(4, 'Foodie Market', '2021-09-12', 3),
(5, 'BioStore', '2022-01-10', 3),
(6, 'Eco Shop', '2020-06-30', 4),
(7, 'Urban Style', '2019-11-25', 5),
(8, 'Casa & Design', '2017-04-14', 6),
(9, 'Green Wear', '2021-07-19', 7),
(10, 'Bimbi Felici', '2023-02-10', 8),
(11, 'Trendy Tech', '2018-10-03', 9),
(12, 'Game World', '2020-12-21', 10),
(13, 'Sole & Mare', '2016-08-08', 11),
(14, 'Apulian Goods', '2019-05-05', 12),
(15, 'Emilia Gourmet', '2021-03-17', 13),
(16, 'Moto Style', '2022-06-01', 14),
(17, 'Tuscany Art', '2018-01-29', 15),
(18, 'Vintage Dream', '2023-04-20', 16),
(19, 'Laguna Living', '2020-07-11', 17);

-- Esegui operazioni di aggiornamento, modifica ed eliminazione record;

UPDATE Store
SET NOMESTORE = 'HOME & Design'
WHERE IDSTORE = 6;

SELECT *
FROM STORE
WHERE IDSTORE = 6;

UPDATE CITTA
SET NOMECITTA = 'Messina'
WHERE IDCITTA = 9;

SELECT *
FROM CITTA
WHERE IDCITTA = 9;

DELETE FROM STORE
WHERE IDSTORE = 19;


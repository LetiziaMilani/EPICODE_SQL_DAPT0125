-- Creazione dello schema 'Killer'. Lo schema è il database, l'insieme delle tabelle
CREATE SCHEMA KILLER;
-- Vado a selezione lo schema creato 'Killer'
USE KILLER;

-- Creazione la tabella 'Killer'
CREATE TABLE KILLER (
ID_KILLER INT
, NOME VARCHAR(50)
, COGNOME VARCHAR(50)
, GENERE CHAR(1)
, NUM_VITTIME INT
, STATUS_MORTO INT
, CONSTRAINT PK_KILLER PRIMARY KEY (ID_KILLER) -- Indico quale è la chiave primaria della tabella
);

-- Creazione tabella 'Area-geografica'
CREATE TABLE AREA_GEOGRAFICA (
ID_AREA INT
, NOME_AREA VARCHAR(50)
, CONSTRAINT PK_AREA_GEOGRAFICA PRIMARY KEY (ID_AREA)
);

-- Creazione tabella 'Arma'
CREATE TABLE ARMA (
ID_ARMA INT
, NOME_ARMA VARCHAR(50)
, CONSTRAINT PK_ARMA PRIMARY KEY (ID_ARMA)
);

-- Creazione tabella 'Vittima'

CREATE TABLE VITTIMA (
ID_VITTIMA INT
, NOME VARCHAR(50)
, COGNOME VARCHAR(50)
, ANNI INT
, GENERE CHAR(1)
, CONSTRAINT PK_VITTIMA PRIMARY KEY (ID_VITTIMA)
);

-- Creazione tabella 'Delitto'

CREATE TABLE DELITTO (
ID_DELITTO INT
, ID_KILLER INT
, ID_AREA INT
, ID_ARMA INT
, ID_VITTIMA INT
, CONSTRAINT PK_DELITTO PRIMARY KEY (ID_DELITTO)
, CONSTRAINT FK_KILLER_DELITTO FOREIGN KEY (ID_KILLER) REFERENCES KILLER (ID_KILLER)
, CONSTRAINT FK_AREA_GEOGRAFICA_DELITTO FOREIGN KEY (ID_AREA) REFERENCES AREA_GEOGRAFICA (ID_AREA)
, CONSTRAINT FK_ARMA_DELITTO FOREIGN KEY (ID_ARMA) REFERENCES ARMA (ID_ARMA)
, CONSTRAINT FK_VITTIMA_DELITTO FOREIGN KEY (ID_VITTIMA) REFERENCES VITTIMA (ID_VITTIMA)
);


-- Popolamento della tabella 'Killer'
INSERT INTO KILLER
VALUES (1, "Dexter", "Morgan", "M", 2, 0)
, (2, "Beatrix", "Kiddo", "F", 1, 0)
, (3, "Walter", "White", "M", 1, 1)
, (4, "John", "Red", "M", 2, 1)
, (5, "Hannibal", "Lecter", "M", 1, 1)
, (6, "Freddy", "Kruger", "M", 1, 0)
, (7, "IT", "IT", "N", 2, 0);

-- Popolamento della tabella 'Area_Geografica"
INSERT INTO AREA_GEOGRAFICA 
VALUES (1, "America")
, (2, "Europa")
, (3, "Asia")
, (4, "Africa");

-- Popolamento della tabella 'Arma'
INSERT INTO ARMA
VALUES (1, "Coltello"),
(2, "Katana"),
(3, "Droghe"),
(4, "Coltello"),
(5, "Denti"),
(6, "Lame"),
(7, "Palloncini");

-- Popolamento della tabella 'Vittima'
INSERT INTO VITTIMA
VALUES (1, "Mario", "Luigi", 49, "M"),
(2, "Luigi", "Mario", 34, "M"),
(3, "Sara", "Rasa", 35, "F"),
(4, "Giulio", "Liogiu", 43, "M"),
(5, "Carlo", "Locarl", 26, "M"),
(6, "Federica", "Ricafede", 67, "M"),
(7, "Vittoria", "Persa", 34, "M"),
(8, "Riccardo", "Bettino", 15, "M"),
(9, "Tizio", "Caio", 53, "M");

-- Popolamento della tabella 'Delitto'
INSERT INTO DELITTO
VALUES (1, 1, 1, 1, 1),
(2, 1, 2, 2, 2),
(3, 2, 3, 3, 3),
(4, 3, 4, 4, 4),
(5, 4, 1, 7, 2),
(6, 4, 2, 6, 4),
(7, 5, 3, 7, 2),
(8, 6, 4, 5, 1),
(9, 7, 1, 3, 3);

-- Alterazione delle colonne della tabella 'Area_Geografica'
-- Aggiunta colonna 'Stato VARCHAR(50)'

ALTER TABLE AREA_GEOGRAFICA
ADD STATO VARCHAR(50);

SELECT * 
FROM AREA_GEOGRAFICA;

-- Modifica datatype della colonna 'Stato VARCHAR(50)' > 'Stato CHAR(20)'

ALTER TABLE AREA_GEOGRAFICA
MODIFY COLUMN STATO CHAR(20);

-- Modifica nome della colonna 'Stato' > 'Nazione'

ALTER TABLE AREA_GEOGRAFICA
RENAME COLUMN STATO TO NAZIONE;

-- Eliminazione colonna 'Nazione'
ALTER TABLE AREA_GEOGRAFICA
DROP COLUMN NAZIONE;

-- Aggiornamento valore di un record

UPDATE AREA_GEOGRAFICA
SET NOME_AREA = 'ASIA E OCEANIA'
WHERE ID_AREA ='3';

SELECT * 
FROM AREA_GEOGRAFICA;





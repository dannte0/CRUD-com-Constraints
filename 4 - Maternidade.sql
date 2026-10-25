CREATE DATABASE Maternidade
GO
USE Maternidade
GO

CREATE TABLE Mae
(
ID_Mae					INTEGER			IDENTITY(1001,1)				NOT NULL,
Nome					VARCHAR(60)										NOT NULL,
Logradouro_Endereco		VARCHAR(100)									NOT NULL,
Numero_Endereco			INTEGER			CHECK(Numero_Endereco >= 0)		NOT NULL,
CEP_Endereco			CHAR(8)			CHECK(LEN(CEP_Endereco) = 8)	NOT NULL,
Complemento_Endereco	VARCHAR(200)									NOT NULL,
Telefone				CHAR(10)		CHECK(LEN(Telefone) = 10)		NOT NULL,
Data_Nasc				DATE											NOT NULL

PRIMARY KEY (ID_Mae)
)
CREATE TABLE Medico
(
CRM_Numero				INTEGER														NOT NULL,
CRM_UF					CHAR(2)														NOT NULL,
Nome					VARCHAR(60)													NOT NULL,
Telefone_Celular		CHAR(11)		UNIQUE CHECK(LEN(Telefone_Celular) = 11)	NOT NULL,
Especialidade			VARCHAR(30)													NOT NULL

PRIMARY KEY (CRM_Numero, CRM_UF)
)
GO

CREATE TABLE Bebe
(
ID_Bebe					INTEGER			IDENTITY(1,1)			NOT NULL,
Nome					VARCHAR(60)								NOT NULL,
Data_Nasc				DATE			DEFAULT('2026-10-24')	NOT NULL,
Altura					DECIMAL(7,2)	CHECK(Altura >= 0)		NOT NULL,
Peso					DECIMAL(4,3)	CHECK(Peso >= 0)		NOT NULL,
MaeID_Mae				INTEGER									NOT NULL

PRIMARY KEY (ID_Bebe)
FOREIGN KEY (MaeID_Mae) REFERENCES Mae(ID_Mae)
)
GO

CREATE TABLE Bebe_Medico
(
BebeID_Bebe				INTEGER							NOT NULL,
MedicoCRM_Numero		INTEGER							NOT NULL,
MedicoCRM_UF			CHAR(2)							NOT NULL

PRIMARY KEY (BebeID_Bebe, MedicoCRM_Numero, MedicoCRM_UF)
FOREIGN KEY (BebeID_Bebe) REFERENCES Bebe(ID_Bebe),
FOREIGN KEY (MedicoCRM_Numero, MedicoCRM_UF) REFERENCES Medico(CRM_Numero, CRM_UF),
)
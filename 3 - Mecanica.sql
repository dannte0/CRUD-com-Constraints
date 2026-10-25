CREATE DATABASE Mecanica
GO
USE Mecanica
GO
CREATE TABLE Cliente
(
ID				INTEGER			IDENTITY(3401, 15)	NOT NULL,
Nome			VARCHAR(100)						NOT NULL,
Logradouro		VARCHAR(200)						NOT NULL,
Numero			INTEGER			CHECK(Numero >= 0)	NOT NULL,
CEP				CHAR(8)			CHECK(LEN(CEP) = 8)	NOT NULL,
Complemento		VARCHAR(255)						NOT NULL

PRIMARY KEY (ID)
)

CREATE TABLE Peca
(
ID				INTEGER			IDENTITY(3411, 7)		NOT NULL,
Nome			VARCHAR(30)		UNIQUE					NOT NULL,
Preco			DECIMAL(4,2)	CHECK(Preco >= 0)		NOT NULL,
Estoque			INTEGER			CHECK(Estoque >= 10)	NOT NULL

PRIMARY KEY (ID)
)

CREATE TABLE Categoria
(
ID				INTEGER			IDENTITY(1,1)			NOT NULL,
categoria		VARCHAR(10)		CHECK((LOWER(categoria) = 'estagiario')	OR 
									(LOWER(categoria) = 'nivel 1')		OR
									(LOWER(categoria) = 'nivel 2')		OR
									(LOWER(categoria) = 'nivel 3') 
									)
														NOT NULL,
Valor_Hora		DECIMAL(4,2)							NOT NULL

PRIMARY KEY (ID),
CONSTRAINT chk_valor_cat CHECK((categoria = 'estagiario' AND Valor_Hora > 15.00)
							OR (categoria = 'nivel 1' AND Valor_Hora > 25.00)
							OR (categoria = 'nivel 2' AND Valor_Hora > 35.00)
							OR (categoria = 'nivel 3' AND Valor_Hora > 50.00)
							)				
)
GO
CREATE TABLE Telefone_Cliente
(
ClienteID		INTEGER										NOT NULL,
Telefone		VARCHAR(11)		CHECK(LEN(Telefone) = 11
								OR LEN(Telefone) = 10)		NOT NULL

PRIMARY KEY (ClienteID, Telefone)
FOREIGN KEY (ClienteID) REFERENCES Cliente(ID)
)

CREATE TABLE Veiculo
(
Placa			CHAR(7)			CHECK(LEN(Placa) = 7)				 NOT NULL,
Marca			VARCHAR(30)											 NOT NULL,
Modelo			VARCHAR(30)											 NOT NULL,
Cor				VARCHAR(15)											 NOT NULL,
Ano_Fabricacao	INTEGER			CHECK(Ano_Fabricacao > 1997)		 NOT NULL,
Ano_Modelo		INTEGER												 NOT NULL,
Data_Aquisicao	DATE												 NOT NULL,
ClienteID		INTEGER												 NOT NULL

PRIMARY KEY (Placa),
CONSTRAINT chk_anofab_anomod CHECK(Ano_Modelo > 1997 
								AND (Ano_Modelo = Ano_Fabricacao
								OR Ano_Modelo = Ano_Fabricacao + 1)),
FOREIGN KEY (ClienteID) REFERENCES Cliente(ID)
)

CREATE TABLE Funcionario
(
ID						INTEGER			IDENTITY(1,1)		NOT NULL,
Nome					VARCHAR(100)						NOT NULL,
Logradouro				VARCHAR(200)						NOT NULL,
Numero					INTEGER			CHECK(Numero >= 0)	NOT NULL,
Telefone				CHAR(11)							NOT NULL,
Categoria_Habilitacao	VARCHAR(2)							NOT NULL,
CategoriaID				INTEGER								NOT NULL

PRIMARY KEY (ID),
CONSTRAINT chk_cathab CHECK((UPPER(Categoria_Habilitacao) = 'A') OR
							(UPPER(Categoria_Habilitacao) = 'B') OR 
							(UPPER(Categoria_Habilitacao) = 'C') OR
							(UPPER(Categoria_Habilitacao) = 'D') OR
							(UPPER(Categoria_Habilitacao) = 'E')),
FOREIGN KEY (CategoriaID) REFERENCES Categoria(ID)
)
GO
CREATE TABLE Reparo
(
VeiculoPlaca			CHAR(7)									NOT NULL,
FuncionarioID			INTEGER									NOT NULL,
PecaID					INTEGER									NOT NULL,
Data					DATE			DEFAULT('2026-10-23')	NOT NULL,
Custo_Total				DECIMAL(4,2)							NOT NULL,
Tempo					INTEGER									NOT NULL

PRIMARY KEY (VeiculoPlaca, FuncionarioID, PecaID, Data)
FOREIGN KEY (VeiculoPlaca) REFERENCES Veiculo(Placa),
FOREIGN KEY (FuncionarioID) REFERENCES Funcionario(ID),
FOREIGN KEY (PecaID) REFERENCES Peca(ID)
)
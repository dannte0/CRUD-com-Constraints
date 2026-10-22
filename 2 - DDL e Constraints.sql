CREATE DATABASE Livraria
GO
USE Livraria
GO
CREATE TABLE Livro
(
Codigo		INTEGER			IDENTITY(100001,100)	NOT NULL,
Nome		VARCHAR(200)						NOT NULL,
Lingua		VARCHAR(10)		DEFAULT('PT-BR')	NOT NULL,
Ano			INTEGER			CHECK(Ano >= 1990)

PRIMARY KEY (Codigo)
)

CREATE TABLE Autor
(
ID_Autor	INTEGER			IDENTITY(2351,1)	NOT NULL,
Nome		VARCHAR(100)	UNIQUE				NOT NULL,
Data_nasc	DATE								NOT NULL,
Pais_Nasc	VARCHAR(50)		CHECK(Pais_Nasc = UPPER('BRASIL') 
								OR Pais_Nasc = UPPER('ESTADOS UNIDOS')
								OR Pais_Nasc = UPPER('INGLATERRA')
								OR Pais_Nasc = UPPER('ALEMANHA')
								)				NOT NULL,
Biografia	VARCHAR(255)						NOT NULL

PRIMARY KEY (ID_Autor)
)

CREATE TABLE Editora
(
ID_Editora				INTEGER			IDENTITY(491,16)				NOT NULL,
Nome					VARCHAR(70)		UNIQUE							NOT NULL,
Telefone				VARCHAR(11)										NOT NULL,
Logradouro_Endereco		VARCHAR(200)									NOT NULL,
Numero_Endereco			INTEGER			CHECK(Numero_Endereco >= 0)		NOT NULL,
CEP_Endereco			CHAR(8)											NOT NULL,
Complemento				VARCHAR(255)									NOT NULL

PRIMARY KEY (ID_Editora)
)
CREATE TABLE Edicao
(
ISBN				CHAR(13)										NOT NULL,
Preco				DECIMAL(4,2)	CHECK(Preco >= 0)				NOT NULL,
Ano					INTEGER			CHECK(Ano >= 1993)				NOT NULL,
Numero_Paginas		INTEGER			CHECK(Numero_Paginas >= 15)		NOT NULL,
Qtd_Estoque			INTEGER											NOT NULL

PRIMARY KEY(ISBN)
)
GO

CREATE TABLE Livro_Autor
(
LivroCodigo		INTEGER		NOT NULL,
AutorID_Autor	INTEGER		NOT NULL

PRIMARY KEY (LivroCodigo, AutorID_Autor)
FOREIGN KEY (LivroCodigo) REFERENCES Livro(Codigo),
FOREIGN KEY (AutorID_Autor) REFERENCES Autor(ID_Autor)
)

CREATE TABLE Editora_Edicao_Livro
(
EditoraID_Editora	INTEGER		NOT NULL,
EdicaoISBN			CHAR(13)	NOT NULL,
LivroCodigo			INTEGER		NOT NULL

PRIMARY KEY (EditoraID_Editora, EdicaoISBN, LivroCodigo)
FOREIGN KEY (EditoraID_Editora) REFERENCES Editora(ID_Editora),
FOREIGN KEY (EdicaoISBN)		REFERENCES Edicao(ISBN),
FOREIGN KEY (LivroCodigo)		REFERENCES Livro(Codigo)
)
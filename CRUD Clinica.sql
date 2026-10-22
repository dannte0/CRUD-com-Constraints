CREATE DATABASE Clinica
GO
USE Clinica
GO
--DDL
CREATE TABLE Paciente
(
Num_Beneficiario	INTEGER			NOT NULL	IDENTITY(99901,1),
Nome				VARCHAR(100)	NOT NULL,
Logradouro			VARCHAR(200)	NOT NULL,
Numero				INTEGER			NOT NULL,
CEP					CHAR(8)			NOT NULL,
Complemento			VARCHAR(255)	NOT NULL,
Telefone			VARCHAR(11)		NOT NULL
PRIMARY KEY (Num_Beneficiario)
)
CREATE TABLE Especialidade
(
ID				INTEGER			NOT NULL	IDENTITY(1,1),
Especialidade	VARCHAR(100)	NOT NULL
PRIMARY KEY (ID)
)
GO
CREATE TABLE Medico
(
Codigo			INTEGER			NOT NULL	IDENTITY(100001,1),
Nome			VARCHAR(100)	NOT NULL,
Logradouro		VARCHAR(200)	NOT NULL,
Numero			INTEGER			NOT NULL,
CEP				CHAR(8)			NOT NULL,
Complemento		VARCHAR(255)	NOT NULL,
Contato			VARCHAR(11)		NOT NULL,
EspecialidadeID	INTEGER			NOT NULL
PRIMARY KEY (Codigo)
FOREIGN KEY (EspecialidadeID) REFERENCES Especialidade(ID)
)
GO
CREATE TABLE Consulta
(
PacienteNum_Beneficiario	INTEGER			NOT NULL,
MedicoCodigo				INTEGER			NOT NULL,
Data_hora					DATETIME		NOT NULL,
Observacao					VARCHAR(255)	NOT NULL

PRIMARY KEY(PacienteNum_Beneficiario, MedicoCodigo, Data_hora)
FOREIGN KEY(PacienteNum_Beneficiario) REFERENCES Paciente(Num_Beneficiario),
FOREIGN KEY(MedicoCodigo) REFERENCES Medico(Codigo)
)
GO

--Alterações

ALTER TABLE Medico
ADD dia_atendimento	VARCHAR(100)

EXEC sp_rename 'dbo.Medico.dia_atendimento', 'dia_semana_atendimento', 'COLUMN'

ALTER TABLE	Consulta
ALTER COLUMN Observacao VARCHAR(200)

--DML
INSERT INTO Paciente (Nome, Logradouro, Numero, CEP, Complemento, Telefone) VALUES
('Washington Silva', 'R. Anhaia', 150, '02345000', 'Casa', '922229999'),
('Luis Ricardo', 'R. Voluntários da Pátria', 2251, '03254010', 'Bloco B. Apto 25', '932450987'),
('Maria Elisa', 'Av. Águia de Haia', 1188, '06987020', 'Apto 1208', '912348765'),
('José Araujo', 'R. XV de Novembro', 18, '03678000', 'Casa', '945674312'),
('Joana Paula', 'R. 7 de Abril', 97, '01214000', 'Conjunto 3 - Apto 801', '912095674')

INSERT INTO Especialidade (Especialidade) VALUES
('Otorrinolarigologista'),
('Urologista'),
('Geriatra'),
('Pediatra')
GO
INSERT INTO Medico (Nome, Logradouro, Numero, CEP, Complemento, Contato, EspecialidadeID) VALUES
('Ana Paula', 'R. 7 de Setembro', 256, '03698000', 'Casa', '915689456', 1),
('Maria Aparecida', 'Av. Brasil', 32, '02145070', 'Casa', '923235454', 1),
('Lucas Borges', 'Av. do Estado', 3210, '05241000', 'Apto 205', '963698585', 2),
('Gabriel Oliveira', 'Av. Dom Helder Camara', 350, '03145000', 'Apto 602', '932458745', 3)
GO
INSERT INTO Consulta (PacienteNum_Beneficiario, MedicoCodigo, Data_hora, Observacao) VALUES
(99901, 100002, '2021-09-04 13:20', 'Infecção Urina'),
(99902, 100003, '2021-09-04 13:15', 'Gripe'),
(99901, 100001, '2021-09-04 12:30', 'Infecção Garganta')

UPDATE Medico
SET dia_atendimento = 'Passa a atender na 2ª feira'
WHERE Codigo = 100001

UPDATE Medico
SET dia_atendimento = 'Passa a atender na 4ª feira'
WHERE Codigo = 100002

UPDATE Medico
SET dia_atendimento = 'Passa a atender na 2ª feira'
WHERE Codigo = 100003

UPDATE Medico
SET dia_atendimento = 'Passa a atender na 5ª feira'
WHERE Codigo = 100004

DELETE Especialidade
WHERE Especialidade = 'Pediatra'

UPDATE Medico
SET Logradouro = 'Av. Bras Leme', Numero = 876, Complemento = 'Apto 504', CEP = '02122000'
WHERE Nome = 'Lucas Borges'

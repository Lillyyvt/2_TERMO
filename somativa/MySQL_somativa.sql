-- COMANDOS PARA CRIAR BANCO DE DADOS
CREATE DATABASE Somativa_liviaOF;

CREATE DATABASE Somativa_liviaOF;


-- COMANDOS PARA ATIVAR BANCO DE DADOS
USE  Somativa_liviaOF;

-- MOSTRAR TABELAS NO BANCO DE DADOS
SHOW TABLES;

-- COMANDO PARA CRIAR TABELAS
CREATE TABLE Cliente(
ID_Cliente INT auto_increment primary key,
Nome varchar(60) not null,
Telefone INT,
CPF varchar(40) not null,
Email varchar(20) not null,
Endereço datetime
);

CREATE TABLE Veiculos(
ID_Veiculos INT auto_increment primary key,
Preço_Veiculo INT,
Marca_Veiculo varchar(10) not null,
Design_Veiculo varchar(15) not null,
Placa varchar(10) not null,
Nome_carro varchar(20) not null
);

CREATE TABLE marcas(
ID_Marcas INT auto_increment primary key,
Design_Marca varchar(40) not null,
Nome_Marca varchar(60) not null,
Data_Fab datetime,
Peça INT,
Cor varchar(10) not null
);

CREATE TABLE modelos(
ID_Modelos INT auto_increment primary key,
Design_modelo  varchar(60) not null,
Nome_Modelo varchar(20) not null,
Identificação INT,
Composição varchar(40) not null,
Cor varchar(60) not null
Cor varchar(60) not null


);

CREATE TABLE Funcionarios(

);

CREATE TABLE Serviço(

);

CREATE TABLE Peças(

); 

CREATE TABLE Ordem_serviços(

);

CREATE TABLE (

);

CREATE TABLE Pagamentos(

);

CREATE TABLE Fornecedores(

);

-- COMANDO PARA ALTERAR INFORMAÇÕES
ALTER TABLE  ADD  varchar(15);

-- ALTERAR O TIPO DE DADOS E TAMANHO DO ATRIBUTO
ALTER TABLE MODIFY  varchar(15);

-- RENOMAR O NOME DO ATRIBUTO
-- ALTER TABLE Leitores CHANGE Telefone Celular(15);

-- RENOMEAR TABELAS
ALTER TABLE  RENAME TO;

-- EXCLUIR ATRIBUTO
ALTER TABLE  DROP COLUMN ;

-- LIMPAR DADOS DA TABELA
TRUNCATE TABLE ;
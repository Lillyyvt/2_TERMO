-- Active: 1794917653787@@127.0.0.1@3308@biblioteca_senai_lilly

-- FASE 1 -- 

DROP DATABASE recuperativa_RetroGame_Livia;

CREATE DATABASE IF NOT EXISTS recuperativa_RetroGame_Livia; -- SEMPRE FAZER A CRIAÇÃO E DEPOIS ATIVAR

USE recuperativa_RetroGame_Livia;

-- FASE 2 --
CREATE TABLE CLIENTE ( 
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(120) NOT NULL UNIQUE,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE plataforma (
    id_plataforma INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE categoria (
    id_categoria INT  AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE jogo (
    id_jogo INT AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    codigo VARCHAR(15) NOT NULL UNIQUE,
    ano_lancamento INT NOT NULL,
    quantidade_disponivel INT DEFAULT 0 CHECK (QUANTIDADE_DISPONIVEL >= 0),
    id_plataforma INT NOT NULL,
    id_categoria INT NOT NULL,

    CONSTRAINT pk_jogo PRIMARY KEY (id_jogo),
    CONSTRAINT fk_plataforma Foreign Key (id_plataforma) REFERENCES  plataforma (id_plataforma),
    CONSTRAINT fk_categoria Foreign Key (id_categoria) REFERENCES CATEGORIA (id_categoria)
);

CREATE TABLE locacao (
    id_locacao INT AUTO_INCREMENT,
    data_retirada DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE NULL,
    status_locacao VARCHAR(20) DEFAULT 'ABERTA'CHECK 
    (status_locacao IN ( 'ABERTO', 'DEVOLVIDO', 'ATRASADO' )),
    id_cliente INT NOT NULL,
    id_jogo INT NOT NULL,

    CONSTRAINT PK_locacao PRIMARY KEY (id_locacao),
    CONSTRAINT FK_cliente FOREIGN KEY (id_cliente) REFERENCES
    cliente (id_cliente),
    CONSTRAINT FK_jogo FOREIGN KEY (id_jogo) REFERENCES jogo
(id_jogo)
);

ALTER TABLE jogo ADD desenvolvedora VARCHAR(100);

-----------------------------------------------------

INSERT INTO CLIENTE (NOME, EMAIL, TELEFONE, ATIVO) VALUES
('Lilly', 'lirioxente@gmail.com', '123456789', TRUE),
('laura', 'lauradocamarao@gmail.com', '987654321', TRUE),
('lidia', 'lidiaofavelada@gmail.com', '987654321', TRUE),
('Mônikye', 'môniquinha@gmail.com', NULL, TRUE);

INSERT INTO plataforma (nome) VALUES
('X-box'),
('Playstation'),
('Android_IOS')

INSERT INTO categoria (descricao) VALUES
('TIRO'),
('TERROR'),
('ANIME'),
('ACAO');

INSERT INTO jogo (titulo, codigo, ano_lancamento, quantidade_disponivel, id_plataforma, id_categoria) VALUES
('Grand Theft Auto', 'GTA001', 1997, 500, 1, 1),
('red dead redemption', 'BLUS-30418', 2010, 410, 2, 4),
(' God of War', 'GOW001', 2005, 60, 2, 4),
('Aniimo', 'ANI2026', 2026, 100, 3, 3),
('Resident Evil', 'RE1996001', 1996, 60, 2, 2 ),
('Marvels Spider-Man: Miles Morales', 'CUSA20177', 2020, 890, 2, 4);

INSERT INTO locacao ( data_retirada, data_prevista, data_devolucao, status_locacao , id_cliente, id_jogo) VALUES
(NOW(), '2026-06-20', '2027-07-14', 'ABERTO', 1, 1),
(NOW(), '2026-10-01', NULL, 'ABERTO', 2, 5),
(NOW(), '2026-04-28', '2027-01-01', 'ABERTO', 4, 4);

SELECT * FROM cliente;

UPDATE cliente
SET telefone = '123456789'
WHERE id_cliente = 2 ;



UPDATE jogo
SET quantidade_disponivel = quantidade_disponivel + 2 
WHERE ano_lancamento= 2000;

SELECT * FROM jogo;

INSERT INTO CLIENTE (NOME, EMAIL, TELEFONE, ATIVO) VALUES
('Juan', 'saguhhdeuva@gmail.com', NULL, TRUE)

select * from cliente;

DELETE FROM cliente
WHERE id_cliente = 9;

------------------------------------------------------
SELECT titulo, ano_lancamento,quantidade_disponivel FROM jogo;

SELECT * FROM jogo
WHERE QUANTIDADE_DISPONIVEL > 2
ORDER BY QUANTIDADE_DISPONIVEL DESC;

SELECT titulo FROM jogo
WHERE titulo LIKE '%G%';

SELECT  ano_lancamento FROM jogo
WHERE ano_lancamento BETWEEN 1990 AND 2005;

SELECT COUNT(*) AS QUANTIDADE, SUM(QUANTIDADE_DISPONIVEL) AS SOMA, AVG(QUANTIDADE_DISPONIVEL) AS MEDIA, MAX(QUANTIDADE_DISPONIVEL) AS MAXIMO, MIN(QUANTIDADE_DISPONIVEL) AS MINIMO FROM jogo;

SELECT 
E.id_locacao,
U.nome AS nome,
L.titulo AS titulo,
E.data_devolucao,
E.status_locacao
FROM locacao E
INNER JOIN cliente U ON E.id_cliente = U.id_cliente
INNER JOIN jogo L ON E.id_jogo = L.id_jogo


SELECT 
E.id_locacao,
U.nome AS nome,
L.titulo AS titulo,
E.data_devolucao,
E.status_locacao
FROM locacao E
INNER JOIN cliente U ON E.id_cliente = U.id_cliente
INNER JOIN jogo L ON E.id_jogo = L.id_jogo
WHERE E.status_locacao = 'ABERTO';

SELECT
    U.cliente

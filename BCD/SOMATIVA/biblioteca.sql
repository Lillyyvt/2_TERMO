-- Active: 1788268411059@@127.0.0.1@3306@biblioteca_livia_som

-- Código Regra
-- RN01 Todo usuário deve possuir nome e e-mail.
-- RN02 O e-mail do usuário não pode se repetir.
-- RN03 Todo usuário inicia ativo no sistema.
-- RN04 Todo livro deve possuir título, autor, ISBN e quantidade disponível.
-- RN05 O ISBN não pode se repetir.
-- RN06 A quantidade disponível nunca pode ser negativa.
-- RN07 Um usuário pode realizar vários empréstimos ao longo do tempo.
-- RN08 Cada empréstimo pertence a exatamente um usuário.
-- RN09 Cada empréstimo desta versão refere-se a exatamente um livro.
-- RN10 Um livro pode aparecer em vários empréstimos ao longo do tempo.
-- RN11 Todo empréstimo deve possuir data de empréstimo e data prevista.
-- RN12 Status permitido: ABERTO, DEVOLVIDO ou ATRASADO.
-- RN13 Ao emprestar, a quantidade disponível do livro diminui em 1.
-- RN14 Não é permitido emprestar livro com quantidade disponível igual a zero.
-- RN15 Na devolução, o empréstimo vira DEVOLVIDO e a quantidade do livro aumenta

-- em 1.

-- RN16 Usuário com histórico de empréstimo não pode ser excluído.
-- RN17 Livro com histórico de empréstimo não pode ser excluído.

-- Importante: traduza as regras para tipos adequados, PK, FK, UNIQUE, NOT
-- NULL, DEFAULT, CHECK e ações referenciais quando aplicáveis.


-- 1. Criação do banco 
-- Crie o banco biblioteca_som2 e selecione-o.
CREATE DATABASE IF NOT EXISTS biblioteca_livia_som;
USE biblioteca_livia_som;

-- 2. Tabela USUARIO 
-- Crie a tabela respeitando RN01, RN02 e RN03.
-- 3. Tabela LIVRO 
-- Crie a tabela e utilize CHECK para impedir quantidade negativa.
-- 4. Tabela EMPRESTIMO
-- Crie PK, duas FKs, DEFAULTs e CHECK de status. As FKs devem impedir
-- exclusão de usuário ou livro com histórico.
-- 5. ALTER TABLE 
-- Adicione editora VARCHAR(100) à tabela LIVRO.
CREATE TABLE USUARIO (
    ID_USUARIO INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(100)NOT NULL,
    EMAIL VARCHAR(120)NOT NULL UNIQUE,
    TELEFONE VARCHAR(20),
    ATIVO BOOLEAN DEFAULT TRUE
)

CREATE TABLE LIVRO ( 
    ID_LIVRO INT PRIMARY KEY AUTO_INCREMENT, 
    TITULO VARCHAR(150) NOT NULL, 
    AUTOR VARCHAR(120) NOT NULL, 
    ISBN CHAR(13) NOT NULL UNIQUE, 
    ANO_PUBLICACAO INT, 
    QUANTIDADE_DISPONIVEL INT DEFAULT 0 CHECK(QUANTIDADE_DISPONIVEL >= 0) 
);


CREATE TABLE EMPRESTIMO (
    ID_EMPRESTIMO INT AUTO_INCREMENT,
    ID_USUARIO INT NOT NULL,
    ID_LIVRO INT NOT NULL,
    DATA_EMPRESTIMO DATETIME DEFAULT CURRENT_TIMESTAMP,
    DATA_PREVISTA DATE NOT NULL,
    DATA_DEVOLUCAO DATE,
    STATUS_EMPRESTIMO VARCHAR(20) DEFAULT 'Ativo',
    -- Chave Primária
    CONSTRAINT PK_EMPRESTIMO PRIMARY KEY (ID_EMPRESTIMO),
    -- Chaves Estrangeiras
    CONSTRAINT FK_EMPRESTIMO_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO) ON DELETE RESTRICT,
    CONSTRAINT FK_EMPRESTIMO_LIVRO FOREIGN KEY (ID_LIVRO) REFERENCES LIVRO(ID_LIVRO) ON DELETE RESTRICT,
    -- Restrição CHECK para o status
    CONSTRAINT CK_EMPRESTIMO_STATUS CHECK (STATUS_EMPRESTIMO IN ('Ativo', 'Devolvido', 'Atrasado', 'Renovado'))
);


CREATE TABLE AUTOR (
    ID_AUTOR INT AUTO_INCREMENT PRIMARY KEY,
    NOME_AUTOR VARCHAR(100) NOT NULL,
    NACIONALIDADE VARCHAR(50),
    DATA_NASCIMENTO DATE
)

CREATE TABLE EDITORA (
    ID_EDITORA INT AUTO_INCREMENT PRIMARY KEY,
    NOME_EDITORA VARCHAR(100) NOT NULL,
    CIDADE VARCHAR(100),
    ESTADO CHAR(100),
    PAIS VARCHAR(100)
)





-- 6. INSERT de usuários
-- Cadastre pelo menos 4 usuários; um deles deve ter telefone NULL.
INSERT INTO USUARIO (NOME, EMAIL, TELEFONE, ATIVO) VALUES
('Clara Ferreira', 'clara@email.com', '19456847305', TRUE),
('Analu', 'analua@email.com', NULL, TRUE),
('Laura Gonçalves', 'LauN@email.com', '19457389230', TRUE),
('Sophie Albuquerque', 'SophiA@email.com', '19548375680', TRUE);


-- 7. INSERT de livros
-- Cadastre pelo menos 6 livros com autores, ISBNs, anos e quantidades diferentes.
-- Inserção de dados iniciais

INSERT INTO LIVRO (TITULO, AUTOR, ISBN, ANO_PUBLICACAO, QUANTIDADE_DISPONIVEL) VALUES
('Dungeouns&Drama', 'Kristy Boyce', '6583175002', '2024', '500'),
('Shatter Me', 'Tahereh Mafi','8550303011', '2011', '76' ),
('Destroy Me', 'Tahereh Mafi', ' 0062208195', '2012', '40' ),
('Normal People', 'Sally Rooney', '9896419361', '2018', '100'),
('Looking for Alaska', 'John Green','0008120927','2005', '2'),
('The Poppy War', 'R. F. Kuang', '0062662562', '2018', '90');




-- 8. INSERT de empréstimos 
-- Cadastre pelo menos 3 empréstimos ABERTOS para usuários e livros existentes.
INSERT INTO EMPRESTIMO (ID_USUARIO, ID_LIVRO, DATA_EMPRESTIMO, DATA_PREVISTA, DATA_DEVOLUCAO, STATUS_EMPRESTIMO) 
VALUES 
(4, 1, '2026-11-01', '2026-11-15', NULL, 'Ativo'),
(2, 3, '2026-11-02', '2026-11-16', NULL, 'Ativo'),
(1, 6, '2026-11-03', '2026-11-17', NULL, 'Ativo');



-- 9. UPDATE
-- Localize um usuário com SELECT e depois altere seu telefone com UPDATE.
SELECT * FROM USUARIO;
UPDATE USUARIO
SET TELEFONE = NULL
WHERE `ID_USUARIO` = 3;

-- 10. Atualização em lote 
-- Acrescente 2 exemplares a todos os livros publicados a partir de 2020. 
UPDATE LIVRO 
SET QUANTIDADE_DISPONIVEL = QUANTIDADE_DISPONIVEL + 2 
WHERE ANO_PUBLICACAO >= 2020;


-- 11. DELETE e integridade
-- Crie e exclua um usuário sem empréstimos. Depois tente excluir um usuário que possua empréstimo e explique o resultado.
-- 1. Inserir o usuário

INSERT INTO USUARIO (nome, email, telefone, ativo) VALUES ('Juan Assumpcao', 'Juan.assumpcao@email.com','199991231456',TRUE)

SELECT * FROM USUARIO

DELETE FROM usuario
WHERE ID_USUARIO = 9;
-- 12. SELECT básico — 
-- Liste título, autor e quantidade disponível de todos os livros.
SELECT * FROM LIVRO

-- 13. WHERE + ORDER BY 
-- Liste livros com quantidade maior que 2, do maior para o menor estoque.
SELECT TITULO, QUANTIDADE_DISPONIVEL 
FROM LIVRO 
WHERE QUANTIDADE_DISPONIVEL > 2
ORDER BY QUANTIDADE_DISPONIVEL DESC;




-- 14. LIKE 
-- Pesquise livros cujo título contenha uma palavra escolhida por você.
SELECT id, titulo, autor, ano_publicacao
FROM LIVRO
WHERE titulo LIKE '%Normal People%';


-- 15. BETWEEN 
-- Liste livros publicados entre 2015 e 2025. ** Bruno vou colocar entre 2015 e 2024.
SELECT TITULO, ANO_PUBLICACAO
FROM LIVRO
WHERE ANO_PUBLICACAO = 2015 OR ANO_PUBLICACAO = 2025;


-- 16. Funções agregadas 
-- Mostre COUNT, SUM, AVG, MIN e MAX sobre a quantidade disponível.
SELECT COUNT(*) AS QUANTIDADE_DISPONIVEL
FROM LIVRO;

SELECT AVG(QUANTIDADE_DISPONIVEL) AS QUANTIDADE
FROM LIVRO;

SELECT MIN(QUANTIDADE_DISPONIVEL) AS QUANTIDADE, MAX(QUANTIDADE_DISPONIVEL) AS QUANTIDADE, AVG(QUANTIDADE_DISPONIVEL) AS QUANTIDADE
FROM LIVRO;



-- 17. INNER JOIN 
-- Liste ID do empréstimo, usuário, livro, data e status.


-- 18. JOIN + WHERE
-- Mostre apenas os empréstimos ABERTOS.


-- 19. GROUP BY 
-- Mostre cada usuário e sua quantidade de empréstimos, do maior para o menor.
SELECT , COUNT(*) AS 
FROM 
GROUP BY 
HAVING COUNT(*) >= 2;


-- 20. LEFT JOIN 
-- Liste todos os usuários, inclusive os que nunca fizeram empréstimo, com a
-- quantidade de empréstimos de cada um.
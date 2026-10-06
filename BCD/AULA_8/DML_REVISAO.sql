-- Active: 1788268411059@@127.0.0.1@3306@smartcoffe_dml_livia


-- REVISAO DE INSERT5 / O INSERT SERVE PARA INSERIR INFORMAÇÕES NO BCD
INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES
('Kauan R','kauan@email.com','1999999900','Limeira', TRUE),
('Laura C', 'laura@email.com', '1999999901', 'Limeira', TRUE),
('Laura N', 'lauran@email.com', '1999999902', 'Limeira', TRUE),
('Laura R', 'laurar@email.com', '1999999903', 'Limeira', TRUE),
('Leonardo B', 'leonardob@email.com', '1999999904', 'Limeira', TRUE),
('Leonardo BT', 'leonardobt@email.com', '1999999905', 'Americana', TRUE),
('Lídia M', 'lidia@email.com', '1999999906', 'Belem', TRUE),
('Livia V', 'livia@email.com', NULL, 'Limeira', TRUE),
('Marcos V', 'marcos@email.com', '1999999907', 'Campo Mourão', TRUE),
('Nicolas N', 'nicolasn@email.com', '1999999908', '', FALSE),
('Nicolas F', 'nicolasf@email.com', '1999999909', 'Campinas', TRUE),
('Pablo H', 'pablo@email.com', '1999999910', 'Indaiatuba', TRUE),
('Sophie A', 'sophie@email.com', '1999999911', 'Campinas', TRUE),
('Vinicius H', 'vinicius@email.com', NULL, 'Limeira', TRUE),
('Vitoria S', 'vitoria@email.com', '1999999912', 'Limeira', TRUE),
('Virginia S', 'virginia@email.com', NULL, 'Boston', TRUE);

INSERT INTO categoria (nome_categoria) VALUES
('Combos Especiais'), ('Nutella');

INSERT INTO pedido (data_pedido, status_pedido, valor_total, id_cliente) VALUES
(NOW(), 'ABERTO',0.00,1);

INSERT INTO pedido (data_pedido, status_pedido, valor_total, id_cliente) VALUES
(NOW(), 'ABERTO',0.00,14);

SET @pedido = LAST_INSERT_ID(); --Sempre que for inserir um valor novo ele vai ser inserido apartir do ultimo 

SELECT @pedido;
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, observacao) VALUES
(@pedido, 4, 2, 13.00, 'Nutella');

-----------------------------------------------------------------------
-- ATUALIZANDO DADOS NO BD
UPDATE cliente
SET telefone = '19999888801'
WHERE id_cliente = 18;

UPDATE cliente
SET telefone = '19992527920',
    cidade = 'Curitiba',
    ativo = FALSE
WHERE id_cliente = 19;

-- TOMAR MUITO CUIDADO ( E NÃO ESQUECER DE COLOCAR O WHERE) ☀️😤

UPDATE cliente
SET ativo = FALSE;
-- WHERE 

UPDATE pedido
SET valor_total = 100000.00; -- CUIDADO!!!

----------------------------------------------------------------------
-- DICAS DE NUTELLA (OURO)
-- EXECUTAR O SELECT SEMPRE ANTES DE ATUALIZAR
-- SELECT * FROM TABELA_QUE_DESEJO;
----------------------------------------------------------------------

-- CONDICIONAIS
UPDATE produto -- atualizou
SET preco = -- preco vai receber a condição abaixo
CASE 
    WHEN preco < 30 THEN  preco * 1.50 -- todos valores abaixo de 30, 1.50
    ELSE preco * 1.25 -- todos valores acima de 30, 1.25
END 
WHERE ativo = TRUE; -- apenas para produtos ativos

UPDATE cliente
SET telefone = NULL
WHERE id_cliente = 19;

-- APAGANDO DADOS DO BD
DELETE FROM cliente
WHERE id_cliente = 16;

TRUNCATE TABLE cliente; -- apaga todos os dados

-- EXCLUINDO DADOS DE FORMA LÓGICA
UPDATE cliente
SET ativo = FALSE
WHERE id_cliente = 10;

---------------------------------------------------------------------

-- CADASTRANDO UM PROCENDIMENTO DE COMPPRA

INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES
('BRUNO M', 'bruno@email.com', '1992527920', 'Piracicaba', TRUE);

SET @cliente = LAST_INSERT_ID();

-- PASSO 2: ADICIONANDO UM NOVO PEDIDO
INSERT INTO pedido (data_pedido, status_pedido, valor_total, id_cliente) VALUES
(NOW(), 'ABERTO',0.00,@cliente);

SET @pedido = LAST_INSERT_ID();


-- PASSO 3: ADICIONANDO ITENS AO PEDIDO
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, observacao) VALUES
(@pedido, 4 ,2, 13.00, 'Mel'),
(@pedido, 5, 1, 15.00, '');


-- PASSO 4: ATUALIZANDO O VALOR TOTAL DO PEDIDO
UPDATE pedido
SET valor_total = 22.00,
    status_pedido = 'Preparando'
WHERE id_pedido = @pedido;


-- PASSO 5: REGISTRO PAGAMENTO
INSERT INTO pagamento (id_pedido, id_forma_pagamento, valor, data_pagamento) VALUES
(@pedido, 2, 22.00, NOW());

-- CONSULTA DE FORMA COMPLETA
SELECT p.id_pedido,
    c.nome AS cliente,
    p.status_pedido,
    p.valor_total
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
WHERE p.id_pedido = @pedido;


---------------------------------------------------------------------

-- CONSULTAS PARA OS DADOS DE BD
SELECT * FROM cliente;
SELECT * FROM cliente
WHERE id_cliente = 5; 

-- Active: 1788268411059@@127.0.0.1@3306@smartcoffe_dml_livia

-- Parte A - INSERT 

-- 1. Cadastre dois novos clientes. 
INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES
('Tiana','tiana@email.com','1999999900','Nova orleans', TRUE),
('Naaven', 'naaven@email.com', '1995799990', 'Maldonia', TRUE);

-- 2. Cadastre uma nova categoria chamada Especiais da Casa. 
INSERT INTO categorias (nome_categoria) VALUES
('Especiarias da casa');


-- 3. Cadastre três produtos na nova categoria. 
INSERT INTO produto (nome_categoria, preco, ativo, id_categoria) VALUES
('Tostadas', 15.00, TRUE, 1),
('Gumbo', 50.00, TRUE, 2),
('Jambalaia', 25.00, TRUE, 3);

-- 4. Insira um cliente sem telefone e observe o uso de NULL. 
INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES
('Charlotte','Charlotte@email.com',NULL,'Nova orleans', TRUE);

-- 5. Crie um novo pedido para um dos clientes cadastrados.
INSERT INTO pedido (data_pedido, status_pedido, valor_total, id_cliente) VALUES
(NOW(), 'Preparando',0.00,14);

-- 6. Use LAST_INSERT_ID() para inserir pelo menos dois itens no pedido. 
SET @pedido = LAST_INSERT_ID(); --Sempre que for inserir um valor novo ele vai ser inserido apartir do ultimo 

SELECT @pedido;
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, observacao) VALUES
(@pedido, 4, 1, 13.00, 'Étouffée');

-- Parte B-UPDATE 

-- 7. Corrija o telefone de um dos clientes criados.
UPDATE cliente
SET telefone = '19999888801'
WHERE id_cliente = 4; 
-- 8. Altere cidade e telefone de outro cliente em um único comando. 
UPDATE CLIENTE
SET TELEFONE = '19999945989',
    CIDADE = 'RIO CLARO'
WHERE ID_CLIENTE = 16;

-- 9. Aumente em 8% os preços dos produtos da categoria criada. 
UPDATE PRODUTO
SET PRECO = PRECO * 1.08
WHERE ID_CATEGORIA = @CATEGORIA;

-- 10. Altere o status do novo pedido para PREPARANDO. 
UPDATE PEDIDO
SET STATUS_PEDIDO = 'PREPARANDO'
WHERE ID_PEDIDO = @PEDIDO;

-- 11. Atualize o valor_total do pedido para refletir os itens adicionados. 
UPDATE PEDIDO
SET VALOR_TOTAL = (
    SELECT SUM(QUANTIDADE * PRECO_UNITARIO)
    FROM ITEM_PEDIDO
    WHERE ID_PEDIDO = @PEDIDO
)
WHERE ID_PEDIDO = @PEDIDO;


-- 12. Desative um produto utilizando exclusão lógica. 
UPDATE NOME_PRODUTO
SET ATIVO = FALSE
WHERE NOME = 'PIZZA' AND ID_CATEGORIA = @CATEGORIA;


-- Parte C-DELETE 

-- 13. Crie um cliente de teste que não possua pedidos e depois exclua-o. 
INSERT INTO CLIENTE (NOME, EMAIL, TELEFONE, CIDADE, ATIVO) VALUES
('CLIENTE TESTE', 'TESTE@EMAIL.COM', '19900000000', 'LIMEIRA', TRUE);
SET @CLIENTE_TESTE = LAST_INSERT_ID();
-- 14. Tente excluir um cliente que possui pedidos e registre o que aconteceu. 

DELETE FROM CLIENTE 
WHERE ID_CLIENTE = @CLIENTE_TESTE;
-- 15. Explique por que a FK protegeu o banco.
-- Resposta:
-- A Foreign Key (Chave Estrangeira) garante a Integridade Referencial do banco de dados.
-- Ela impede a formação de dados "órfãos" — neste caso, registros na tabela pedidos que apontariam 
-- para um id_cliente inexistente. Para deletar o cliente, seria necessário primeiro tratar os registros 
-- filhos em pedidos ou definir regras como ON DELETE CASCADE na FK.
-- 16. Crie uma categoria de teste sem produtos e depois remova-a.
INSERT INTO categorias (nome, descricao) VALUES
('Categoria Teste', 'Categoria temporária sem produtos');
SET @categoria_teste = LAST_INSERT_ID();
-- SELECT de validação:
SELECT id_categoria, nome FROM categorias WHERE id_categoria = @categoria_teste;
DELETE FROM categorias 
WHERE id_categoria = @categoria_teste;
-- SELECT final:
SELECT id_categoria, nome FROM categorias WHERE id_categoria = @categoria_teste;
-- ============================================================
-- PARTE D - INTEGRIDADE E ERROS CONTROLADOS
-- ============================================================
-- 17. Tente inserir um produto com id_categoria = 9999.
-- INSERT INTO produtos (nome, preco, id_categoria, ativo) VALUES ('Produto Teste FK', 15.00, 9999, TRUE);
-- Qual restrição impediu a operação?
-- Restrição: FOREIGN KEY (Chave Estrangeira - fk_produtos_categorias).
-- Explicação: Não existe registro de categoria cadastrada com o id_categoria = 9999, portanto a inserção do produto falhou devido à violação da integridade referencial.
-- 18. Tente cadastrar um cliente usando 'ana@email.com'.
-- INSERT INTO clientes (nome, email, telefone, cidade) VALUES ('Ana Dup', 'ana@email.com', '(19) 90000-0000', 'Limeira');
-- Qual restrição impediu a operação?
-- Restrição: UNIQUE CONSTRAINT (Chave Única na coluna email).
-- Explicação: O e-mail 'ana@email.com' já está cadastrado no banco de dados e não aceita duplicidade.
-- 19. Tente criar um pedido com id_cliente = 9999.
-- INSERT INTO pedidos (id_cliente, data_pedido, status, valor_total) VALUES (9999, NOW(), 'PENDENTE', 10.00);
-- Qual restrição impediu a operação?
-- Restrição: FOREIGN KEY (Chave Estrangeira - fk_pedidos_clientes).
-- Explicação: Não existe registro de cliente cadastrado com o id_cliente = 9999.
-- 20. Escreva em comentários a diferença entre os três erros anteriores.
-- Resposta:
-- As questões 17 e 19 geraram erros de CHAVE ESTRANGEIRA (FOREIGN KEY), pois tentaram vincular
-- um registro filho a um registro pai inexistente (violação da Integridade Referencial entre tabelas).
-- A questão 18 gerou um erro de CHAVE ÚNICA (UNIQUE CONSTRAINT), pois tentou inserir um valor duplicado
-- em uma coluna da própria tabela que exige valores estritamente exclusivos.
-- ============================================================
-- PARTE E - DESAFIO COMPLETO COM TRANSAÇÃO
-- ============================================================
-- 21. Inicie uma transação.
START TRANSACTION;
-- 22. Dentro dela, cadastre um cliente, um pedido e dois itens relacionados.
INSERT INTO clientes (nome, email, telefone, cidade, ativo) 
VALUES ('Fernanda Lima', 'fernanda.lima@email.com', '19955554444', 'Rio Claro', TRUE);
SET @id_cli_trans = LAST_INSERT_ID();
INSERT INTO pedidos (id_cliente, data_pedido, status, valor_total) 
VALUES (@id_cli_trans, NOW(), 'PENDENTE', 35.00);
SET @id_ped_trans = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES 
    (@id_ped_trans, 1, 1, 15.00),
    (@id_ped_trans, 2, 1, 20.00);
-- 23. Faça uma consulta com JOIN comprovando que os registros existem enquanto a transação está aberta.
SELECT 
    c.nome AS cliente,
    p.id_pedido,
    p.status,
    i.id_produto,
    i.quantidade,
    i.preco_unitario
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN itens_pedido i ON p.id_pedido = i.id_pedido
WHERE c.id_cliente = @id_cli_trans;
-- 24. Execute ROLLBACK e depois use SELECT para provar que o cadastro foi desfeito.
ROLLBACK;
SELECT * FROM clientes WHERE email = 'fernanda.lima@email.com';
SELECT * FROM pedidos WHERE id_cliente = @id_cli_trans;
-- 25. Repita o processo com novos dados e finalize usando COMMIT. Depois consulte os registros persistidos.
START TRANSACTION;
INSERT INTO clientes (nome, email, telefone, cidade, ativo) 
VALUES ('Carlos Eduardo', 'carlos.eduardo@email.com', '19933332222', 'Americana', TRUE);
SET @id_cli_commit = LAST_INSERT_ID();
INSERT INTO pedidos (id_cliente, data_pedido, status, valor_total) 
VALUES (@id_cli_commit, NOW(), 'FINALIZADO', 40.00);
SET @id_ped_commit = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES 
    (@id_ped_commit, 1, 2, 20.00);
COMMIT;
SELECT 
    c.nome AS cliente,
    p.id_pedido,
    p.status,
    p.valor_total,
    i.id_produto,
    i.quantidade
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN itens_pedido i ON p.id_pedido = i.id_pedido
WHERE c.id_cliente = @id_cli_commit;
-- ============================================================
-- DESAFIO EXTRA
-- ============================================================
-- 26. Escolha uma situação realista do SmartCoffee que exija INSERT + UPDATE
--     ou UPDATE + DELETE lógico. Descreva a regra de negócio e implemente.
-- Regra de Negócio:
-- Cenário: "Descontinuação de Categoria e Auditoria de Inativação em Lote"
-- Ao descontinuar uma linha de produtos (ex: 'Sazonais de Inverno'), o sistema deve:
-- 1. Registrar um histórico da ação no log de eventos do sistema (INSERT).
-- 2. Inativar logicamente todos os produtos associados a essa categoria setando ativo = FALSE (UPDATE).
INSERT INTO log_sistema (data_evento, usuario, descricao) 
VALUES (NOW(), 'admin_smartcoffee', 'Descontinuação da categoria Sazonais de Inverno e inativação em lote.');
UPDATE produtos p
JOIN categorias c ON p.id_categoria = c.id_categoria
SET p.ativo = FALSE
WHERE c.nome = 'Sazonais de Inverno';
SELECT p.id_produto, p.nome, p.ativo, c.nome AS categoria
FROM produtos p
JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE c.nome = 'Sazonais de Inverno';




-- Active: 1788268411059@@127.0.0.1@3306@smartcoffe_dml_livia
-- ============================================================
-- AULA 09 - ATIVIDADE PRÁTICA DE DQL
-- Nome: Livia Vitória
-- Turma:2 série A Data:06/10/26
-- Base: smartcoffee_dql
-- ============================================================
USE smartcoffe_dml_livia;

-- PARTE A - AQUECIMENTO

-- 1. Liste todos os clientes cadastrados.
SELECT * FROM CLIENTE;

-- 2. Exiba apenas nome, cidade e e-mail dos clientes.
SELECT NOME, EMAIL, CIDADE FROM CLIENTE;

-- 3. Liste os nomes das cidades sem repetir valores.
select distinct cidade from cliente;


-- 4. Liste todos os produtos em ordem crescente de preço.
select * from produto order by preco asc;

-- 5. Mostre apenas os 5 produtos mais caros.
select * from produto order by preco desc limit 5;

-- PARTE B - FILTROS

-- 6. Liste os produtos com preço entre R$ 8,00 e R$ 15,00.
select * from produto where preco between 8 and 15;


-- 7. Liste os clientes das cidades Limeira ou Americana.
select * from cliente where cidade in ('LIMEIRA', 'AMERICANA');

-- 8. Localize os produtos cujo nome contém a palavra “Café”.
SELECT NOME_PRODUTO
FROM PRODUTO
WHERE NOME_PRODUTO LIKE 'NUTELLA'; 

-- 9. Liste os clientes que não informaram telefone.
select * from cliente where telefone is null;

-- 10. Mostre os pedidos FINALIZADOS com valor acima de R$ 20,00,
--     do maior para o menor valor.
select * from pedido where status_pedido = 'FINALIZADO' and valor_total > 20 order by valor_total desc;

-- PARTE C - CÁLCULOS E AGRUPAMENTOS

-- 11. Informe quantos produtos estão cadastrados.
select count(*) from produto;

-- 12. Mostre menor preço, maior preço e preço médio dos produtos.
SELECT MIN(PRECO) AS MENORES_PRECOS,
 MAX(PRECO) AS MAIORES_PRECOS,
 AVG(PRECO) AS MÉDIA_PRECOS
 FROM PRODUTO;

-- 13. Informe quantos clientes existem em cada cidade.
select cidade, count(*) as total_clientes 
from cliente 
group by cidade;

-- 14. Mostre somente as cidades que possuem dois ou mais clientes.
select cidade, count(*) as total_clientes
 from cliente
  group by cidade having count(*) >= 2;

-- 15. Calcule o faturamento total considerando apenas pedidos FINALIZADOS.
select sum(valor_total) as faturamento_total from pedido where status_pedido = 'FINALIZADO';

-- PARTE D - RELACIONAMENTOS



-- 16. Liste cada pedido exibindo id, data, nome do cliente, status e valor total.
SELECT p.id_pedido, p.data_pedido, c.nome AS nome_cliente, p.status_pedido, p.valor_total
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente;


-- 17. Liste cada produto acompanhado do nome de sua categoria.
SELECT 
    p.nome_produto, 
    cat.nome_categoria
FROM produto p
JOIN categoria cat ON p.id_categoria = cat.id_categoria;


-- 18. Gere um relatório dos itens vendidos: pedido, produto, quantidade, preço unitário e subtotal.
SELECT 
    i.id_pedido, pr.nome_produto, i.quantidade, i.preco_unitario, 
    (i.quantidade * i.preco_unitario) AS subtotal
FROM item_pedido i
JOIN produto pr ON i.id_produto = pr.id_produto;


-- 19. Mostre todos os clientes, inclusive aqueles que nunca fizeram pedidos.
SELECT 
    c.id_cliente, 
    c.nome AS nome_cliente, 
    p.id_pedido, 
    p.status_pedido
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente;


-- 20. Liste apenas os clientes que nunca fizeram pedidos.
SELECT 
    c.id_cliente, 
    c.nome AS nome_cliente, 
    c.email
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;




-- ============================================================
-- PARTE E - DESAFIO GERENCIAL
-- ============================================================


-- 21. Informe quantos pedidos FINALIZADOS cada cliente realizou e quanto cada cliente gastou. 
-- Ordene do maior gasto para o menor.
SELECT 
    c.nome AS nome_cliente,
    COUNT(p.id_pedido) AS total_pedidos_finalizados,
    SUM(p.valor_total) AS total_gasto
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.status_pedido = 'FINALIZADO'
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC;


-- 22. Mostre a quantidade de produtos e o preço médio de cada categoria.
SELECT 
    cat.nome_categoria,
    COUNT(p.id_produto) AS quantidade_produtos,
    ROUND(AVG(p.preco), 2) AS preco_medio
FROM categoria cat
LEFT JOIN produto p ON cat.id_categoria = p.id_categoria
GROUP BY cat.id_categoria, cat.nome_categoria;


-- 23. Descubra quais produtos possuem preço superior ao preço médio geral.
SELECT 
    nome_produto, 
    preco
FROM produto
WHERE preco > (SELECT AVG(preco) FROM produto)
ORDER BY preco DESC;


-- 24. Classifique os produtos como Econômico, Intermediário ou Premium. 
-- Faixas definidas: Até R$ 10,00 (Econômico) | R$ 10,01 a R$ 20,00 (Intermediário) | Acima de R$ 20,00 (Premium)
SELECT 
    nome_produto,
    preco,
    CASE 
        WHEN preco <= 10.00 THEN 'Econômico'
        WHEN preco <= 20.00 THEN 'Intermediário'
        ELSE 'Premium'
    END AS classificacao_preco
FROM produto
ORDER BY preco ASC;


-- 25. CONSULTA AUTORAL
-- Pergunta de negócio:
-- Quais são os 3 produtos mais vendidos (em quantidade total de itens) e o faturamento gerado por cada um nos pedidos finalizados?
-- Os 3 produtos mais vendidos são aqueles que tiveram a maior quantidade total de unidades vendidas em pedidos finalizados. O faturamento gerado por cada produto é calculado multiplicando a quantidade vendida pelo preço unitário do produto.
-- Por que essa informação é útil?
-- Essa informação é util para identificar os produtos mais populares entre os clientes, permitindo à empresa focar em estratégias de marketing, estoque e promoções para maximizar o faturamento e atender melhor a demanda do mercado.


SELECT 
    pr.nome_produto,
    SUM(i.quantidade) AS total_unidades_vendidas,
    ROUND(SUM(i.quantidade * i.preco_unitario), 2) AS faturamento_gerado
FROM item_pedido i
JOIN produto pr ON i.id_produto = pr.id_produto
JOIN pedido p ON i.id_pedido = p.id_pedido
WHERE p.status_pedido = 'FINALIZADO'
GROUP BY pr.id_produto, pr.nome_produto
ORDER BY total_unidades_vendidas DESC
LIMIT 3;
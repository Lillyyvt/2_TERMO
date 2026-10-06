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


-- 17. Liste cada produto acompanhado do nome de sua categoria.


-- 18. Gere um relatório dos itens vendidos: pedido, produto, quantidade,
--     preço unitário e subtotal.


-- 19. Mostre todos os clientes, inclusive aqueles que nunca fizeram pedidos.


-- 20. Liste apenas os clientes que nunca fizeram pedidos.


-- PARTE E - DESAFIO GERENCIAL

-- 21. Informe quantos pedidos FINALIZADOS cada cliente realizou e quanto
--     cada cliente gastou. Ordene do maior gasto para o menor.


-- 22. Mostre a quantidade de produtos e o preço médio de cada categoria.


-- 23. Descubra quais produtos possuem preço superior ao preço médio geral.


-- 24. Classifique os produtos como Econômico, Intermediário ou Premium.
--     Defina e informe suas faixas de preço.


-- 25. CONSULTA AUTORAL
-- Pergunta de negócio:
--
-- Por que essa informação é útil?
--
-- Consulta:
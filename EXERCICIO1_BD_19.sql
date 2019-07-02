/*//////////////////////////  PARTE 2.1 - CRIANDO E MANIPULANDO O BANCO DE DADOS //////////////////////////*/
--EXERCICIO 3
ALTER TABLE CLIENTE
MODIFY ENDERECO VARCHAR2(30);

--EXERCICIO 4
ALTER TABLE ITEM_PEDIDO
ADD PCO_UNIT NUMERIC(6,2);

--EXERCICIO 5
UPDATE CLIENTE
SET CEP = '18035-400'
WHERE CIDADE = 'SOROCABA';

--EXERCICO 6
UPDATE PEDIDO
SET PRAZO_ENTREGA = PRAZO_ENTREGA + 10
WHERE NUM_PEDIDO = 78945; 

--EXERCICIO 7
UPDATE PRODUTO
SET VALOR_UNITARIO = VALOR_UNITARIO * 1.1
WHERE UNIDADE = 'UN';

--EXERCICIO 8
DELETE FROM PRODUTO
WHERE UNIDADE = 'CX' AND VALOR_UNITARIO > 50;
/*Nota caso o produto tenha sido referenciado em item_pedido n�o poder� ser excluido (restri��o m�e-filha)*/




/*//////////////////////////  PARTE 2.2 - CRIANDO E MANIPULANDO O BANCO DE DADOS //////////////////////////*/
--EXERCICIO 1
SELECT NUM_PEDIDO, PRAZO_ENTREGA FROM PEDIDO;

--EXERCICIO 2
SELECT DESCRICAO, VALOR_UNITARIO FROM PRODUTO;

--EXERCICIO 3
SELECT NOME_CLIENTE, ENDERECO FROM CLIENTE;

--EXERCICIO 4
SELECT NOME_VENDEDOR FROM VENDEDOR;

--EXERCICIO 5
SELECT * FROM CLIENTE;

--EXERCICIO 6
SELECT * FROM PRODUTO;

--EXERCICIO 7
SELECT NOME_VENDEDOR AS NOME FROM VENDEDOR;

--EXERCICIO 8
SELECT COD_PRODUTO, VALOR_UNITARIO, SUM(VALOR_UNITARIO * 1.1) AS AUMENTO
FROM PRODUTO
GROUP BY COD_PRODUTO, VALOR_UNITARIO;

--EXERCICIO 9
SELECT SALARIO_FIXO, SUM(SALARIO_FIXO * 1.05) AS AUMENTO
FROM VENDEDOR
GROUP BY SALARIO_FIXO;

--EXERCICIO 10
SELECT NOME_CLIENTE
FROM CLIENTE
WHERE CIDADE = 'SOROCABA';

--EXERCICIO 11
SELECT * FROM VENDEDOR
WHERE SALARIO_FIXO < 1900;

--EXERCICIO 12
SELECT COD_PRODUTO, DESCRICAO
FROM PRODUTO
WHERE UNIDADE = 'UN';

--EXERCICIO 13
SELECT NUM_PEDIDO
FROM PEDIDO
WHERE PRAZO_ENTREGA
BETWEEN '01/01/2018' AND '28/03/2019';

--EXERCICIO 14
SELECT NUM_PEDIDO, PRAZO_ENTREGA
FROM PEDIDO
WHERE PRAZO_ENTREGA
BETWEEN '01/01/2019' AND '31/12/2019';

--EXERCICIO 15
SELECT * FROM PRODUTO
WHERE VALOR_UNITARIO
BETWEEN 10 AND 2000;

--EXERCICIO 16
SELECT NUM_PEDIDO, COD_PRODUTO, QUANTIDADE
FROM ITEM_PEDIDO
WHERE QUANTIDADE BETWEEN 1 AND 2;

--EXERCICIO 17
SELECT NOME_VENDEDOR
FROM VENDEDOR
WHERE NOME_VENDEDOR LIKE 'AMAIA%';

--EXERCICIO 18
SELECT NOME_VENDEDOR
FROM VENDEDOR
WHERE NOME_VENDEDOR LIKE '%MENDEZ';

--EXERCICIO 19
SELECT DESCRICAO, COD_PRODUTO
FROM PRODUTO
WHERE DESCRICAO LIKE '%IA%';

--EXERCICIO 20
SELECT * FROM CLIENTE
WHERE ENDERECO IS NULL;

--EXERCICIO 21
SELECT DISTINCT CIDADE FROM CLIENTE;

--EXERCICIO 22
SELECT * FROM CLIENTE
ORDER BY NOME_CLIENTE ASC;

--EXERCICIO 23
SELECT * FROM CLIENTE
ORDER BY NOME_CLIENTE DESC;

--EXERCICIO 24
SELECT * FROM CLIENTE
ORDER BY CIDADE, NOME_CLIENTE;

--EXERCICIO 25
SELECT COD_PRODUTO, DESCRICAO
FROM PRODUTO
WHERE UNIDADE = 'UN'
ORDER BY DESCRICAO;

/*//////////////////////////  PARTE 2.5 - CRIANDO E MANIPULANDO VIS�ES //////////////////////////*/
--EXERCICIO 1
CREATE VIEW V_PEDIDO_CLIENTE
AS SELECT NUM_PEDIDO, COD_CLIENTE, PRAZO_ENTREGA
FROM PEDIDO;

SELECT * FROM V_PEDIDO_CLIENTE

--EXERCICIO 2
CREATE VIEW V_LISTA_PRODUTO_UN
AS SELECT * FROM PRODUTO
WHERE UNIDADE = 'UN';

--EXERCICIO 3
CREATE VIEW V_LISTA_PRODUTO_MENORMEDIA
AS SELECT * FROM PRODUTO
WHERE VALOR_UNITARIO < (SELECT AVG(VALOR_UNITARIO) FROM PRODUTO);

--EXERCICIO 4
CREATE VIEW V_PEDIDO_PORVENDEDOR
AS SELECT PEDIDO.COD_VENDEDOR,
          VENDEDOR.NOME_VENDEDOR,
          COUNT(PEDIDO.COD_VENDEDOR) AS QTD_PEDIDO
FROM PEDIDO, VENDEDOR
WHERE PEDIDO.COD_VENDEDOR = VENDEDOR.COD_VENDEDOR
GROUP BY PEDIDO.COD_VENDEDOR, VENDEDOR.NOME_VENDEDOR;

--EXERCICIO 5
/*
    � ATUALIZAVEL O EXERCICIO 1
    POIS, N�O S�O ATUALIZAVEIS VISOES QUE POSSUEM JUN��ES OU COLUNAS CALCULAS.
    LOGO, N�O S�O ATUALIZAVEIS:
    *EXERCICIO 3
    *EXERCICIO 4
*/

/*//////////////////////////  PARTE 2.6 - CRIANDO E MANIPULANDO SUB-CONSULTAS //////////////////////////*/
--EXERCICIO 1
SELECT * FROM CLIENTE
WHERE ENDERECO = (SELECT ENDERECO FROM CLIENTE 
                    WHERE NOME_CLIENTE = 'LUISA MOREIRA');
                    
--EXERCICIO 2
SELECT * FROM PRODUTO
WHERE VALOR_UNITARIO < (SELECT AVG(VALOR_UNITARIO) FROM PRODUTO);

--EXERCICIO 3
SELECT DISTINCT 
       PEDIDO.COD_CLIENTE,
       CLIENTE.NOME_CLIENTE,
       PEDIDO.COD_VENDEDOR,
       VENDEDOR.NOME_VENDEDOR
FROM PEDIDO, CLIENTE, VENDEDOR
WHERE PEDIDO.COD_VENDEDOR = VENDEDOR.COD_VENDEDOR
AND   PEDIDO.COD_CLIENTE = CLIENTE.COD_CLIENTE 
AND   PEDIDO.COD_VENDEDOR = 98525 
AND   CLIENTE.COD_CLIENTE NOT IN (SELECT PEDIDO.COD_CLIENTE
                                  FROM PEDIDO
                                  WHERE PEDIDO.COD_VENDEDOR <> 98525);

/*OBS.: O DISTINCT FOI UTILIZADO POIS HOUVE CASOS DE DUAS COMPRAS DO MESMO CLIENTE COM O VENDEDOR*/

--EXERCICIO 4
SELECT PEDIDO.COD_VENDEDOR, 
       VENDEDOR.NOME_VENDEDOR,
       COUNT(PEDIDO.COD_VENDEDOR) AS QTD_PEDIDO
FROM PEDIDO, VENDEDOR
WHERE PEDIDO.COD_VENDEDOR = VENDEDOR.COD_VENDEDOR
GROUP BY PEDIDO.COD_VENDEDOR, VENDEDOR.NOME_VENDEDOR
HAVING COUNT(PEDIDO.COD_VENDEDOR) < 5;
--ERRO: NO EXEMPLO ACIMA O VENDEDOR QUE N�O FEZ NENHUM PEDIDO N�O � SELECIONADO 


SELECT DISTINCT 
       PEDIDO.COD_VENDEDOR
FROM PEDIDO 
WHERE PEDIDO.COD_VENDEDOR NOT IN (SELECT PEDIDO.COD_VENDEDOR
                          FROM PEDIDO
                          GROUP BY PEDIDO.COD_VENDEDOR
                          HAVING COUNT(*) >= 5);


--EXERCICIO 5
SELECT DISTINCT VENDEDOR.NOME_VENDEDOR
FROM PEDIDO, VENDEDOR
WHERE PEDIDO.COD_VENDEDOR = VENDEDOR.COD_VENDEDOR
AND PEDIDO.NUM_PEIDO NOT IN(SELECT PEDIDO.NUM_PEDIDO
                            FROM PEDIDO
                            WHERE PEDIDIO.PRAZO_ENTREGA BETWEEN '01/05/2019' AND '01/06/2019');



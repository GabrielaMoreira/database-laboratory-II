--EXERCICIO 1
ALTER TABLE PACIENTE
ADD PAIS VARCHAR2(15);

--EXERCICIO 2
ALTER TABLE PACIENTE
MODIFY ENDERECO VARCHAR2(28);

--EXERCICIO 3
ALTER TABLE PACIENTE
DROP COLUMN PAIS;

--EXERCICIO 4
ALTER TABLE PACIENTE
MODIFY ENDERECO NOT NULL;

--EXERCICIO 5
UPDATE PACIENTE
SET DATA_NASC = '01-09-1960'
WHERE COD_PACIENTE = 001;

--EXERCICIO 6
UPDATE PACIENTE
SET DESCONTO = 'N';

--EXERCICIO 7
UPDATE PACIENTE
SET ENDERECO = 'Rua Melo Alves, 40',
    CIDADE   = 'Itu'
WHERE COD_PACIENTE = 02;

--EXERCICIO 8
DELETE FROM CONSULTA
WHERE COD_CONSULTA = 002
AND VALOR_CONSULTA = 0;

--EXERCICIO 9
DELETE FROM PACIENTE
WHERE COD_PACIENTE = 005;

--EXERCICIO 10
DELETE FROM PACIENTE
WHERE SEXO = 'F'
AND CIDADE = 'SOROCABA';

--EXERCICIO 11
UPDATE PACIENTE
SET DESCONTO = 'S'
WHERE SEXO = 'F'
AND trunc((months_between(sysdate, DATA_NASC))/12) > 60;

/*CALCULO DE IDADE PELA DATA DE NASCIMENTO COM DADOS EM TABELA*/
SELECT DATA_NASC,
trunc((months_between(sysdate, DATA_NASC))/12) AS idade
FROM DUAL, Paciente;

/*CALCULO DE IDADE PELA DATA DE NASCIMENTO COM DATA FIXA*/
SELECT
trunc((months_between(sysdate, to_date('25/01/1987','dd/mm/yyyy')))/12) AS idade
FROM DUAL;

/*CONSULTA DATA DO SISTEMA*/
SELECT SYSDATE FROM SYS.DUAL; 

--EXERCICIO 12
ALTER TABLE PACIENTE
ADD TELEFONE VARCHAR2(15);

UPDATE PACIENTE
SET TELEFONE = '15981256987';
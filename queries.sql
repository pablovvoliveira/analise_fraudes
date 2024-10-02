-- Conhecendo o dataset
SELECT * FROM fraud_data LIMIT 10;

-- Quantas compras com fraude foram registradas(class = 0 - compra sem fraude/ 1 - compra com fraude)?
SELECT class,
	COUNT(*) AS total
FROM fraud_data
WHERE class = 1;

-- Qual é o percentual de compras fraudulentas?
SELECT class,
    COUNT(*) as total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fraud_data),2) as percentual
FROM fraud_data
GROUP BY class;
-- 9,36% das compras tiveram fraude

-- Qual o faturamento por class?
SELECT class,
	sum(purchase_value) as faturamento
FROM fraud_data
GROUP BY class;
-- O prejuízo com fraudes foi de $ 523.488,00

-- Qual o intervalo entre cadastro e compra no site?
SELECT class,
	signup_time AS hora_cadastro,
	purchase_time AS hora_compra,
    DATEDIFF(purchase_time, signup_time) AS diferenca_dias
FROM fraud_data
ORDER BY diferenca_dias;
-- Compras com fraude tendem ser feitas logo após ao cadastro

-- Análise por faixa etária
SELECT 
    CASE 
        WHEN age < 18 THEN 'Menor de 18'
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 50 THEN '31-50'
        ELSE 'Acima de 50'
    END as faixa_etaria,
    COUNT(*) as total_transacoes,
    SUM(class) as transacoes_fraudulentas,
    ROUND(SUM(class) * 100.0 / COUNT(*), 2) as percentual_fraude
FROM fraud_data
GROUP BY faixa_etaria
ORDER BY transacoes_fraudulentas DESC;

-- Análise por gênero 
SELECT sex as genero,
    COUNT(*) as total_transacoes,
    SUM(class) as transacoes_fraudulentas,
    ROUND(SUM(class) * 100.0 / COUNT(*), 2) as percentual_fraude
FROM fraud_data
GROUP BY sex
ORDER BY percentual_fraude DESC;

-- Análise por hora do dia
SELECT HOUR(purchase_time) as hora_do_dia,
    COUNT(*) as total_transacoes,
    SUM(class) as transacoes_fraudulentas,
    ROUND(SUM(class) * 100.0 / COUNT(*), 2) as percentual_fraude
FROM fraud_data
GROUP BY hora_do_dia
ORDER BY percentual_fraude DESC;

-- Análise por dispositivo
SELECT device_id,
    COUNT(*) as total_transacoes,
    SUM(class) as transacoes_fraudulentas,
    ROUND(SUM(class) * 100.0 / COUNT(*), 2) as percentual_fraude
FROM fraud_data
GROUP BY device_id
HAVING total_transacoes > 1  
ORDER BY transacoes_fraudulentas DESC;
-- Principal padrão encontrado: dispositivos sendo usados várias vezes para fraudar compras.

-- Análise por fonte
SELECT source,
    COUNT(*) as total_transacoes,
    SUM(class) as transacoes_fraudulentas,
    ROUND(SUM(class) * 100.0 / COUNT(*), 2) as percentual_fraude
FROM fraud_data
GROUP BY source
ORDER BY percentual_fraude DESC;

-- Análise por navegador
SELECT browser,
    COUNT(*) as total_transacoes,
    SUM(class) as transacoes_fraudulentas,
    ROUND(SUM(class) * 100.0 / COUNT(*), 2) as percentual_fraude
FROM fraud_data
GROUP BY browser
ORDER BY percentual_fraude DESC;



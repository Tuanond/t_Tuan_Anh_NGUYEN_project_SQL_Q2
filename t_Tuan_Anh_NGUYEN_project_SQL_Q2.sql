-- Výzkumná otázka č. 2
-- 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?


SELECT *
FROM czechia_payroll AS cp
WHERE value_type_code = 5958;


-- 114201 = mléko, 111301 = chleba
SELECT *
FROM czechia_price AS cp
LEFT JOIN czechia_price_category AS cpc 
	ON cp.category_code = cpc.code
WHERE cp.category_code IN ('114201', '111301');
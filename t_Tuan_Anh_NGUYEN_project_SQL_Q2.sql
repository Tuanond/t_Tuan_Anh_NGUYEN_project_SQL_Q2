-- Výzkumná otázka č. 2
-- 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?


SELECT *
FROM czechia_payroll AS cpay
WHERE value_type_code = 5958);


-- 114201 = mléko, 111301 = chleba


SELECT
	cpay.value AS payroll_value,
	cpay.payroll_year,
	cp.category_code,
	cpc.name,
	cp.value,
	cpc.price_value,
	cpc.price_unit 
FROM czechia_price AS cp
LEFT JOIN czechia_price_category AS cpc 
	ON cp.category_code = cpc.code
LEFT JOIN czechia_payroll AS cpay
	ON YEAR(cp.date_from) = cpay.payroll_year
WHERE cp.category_code IN ('114201', '111301') AND cpay.value_type_code = 5958
ORDER BY cp.category_code, cpay.payroll_year;






WITH prices_chleba_mleko AS (
SELECT *
FROM czechia_price AS cp
LEFT JOIN czechia_price_category AS cpc 
	ON cp.category_code = cpc.code
WHERE cp.category_code IN ('114201', '111301')
ORDER BY cp.category_code, cp.date_from)
SELECT 
FROM czechia_payroll AS cpay
LEFT JOIN prices_chleba_mleko AS pcm
	ON cpay.payroll_year = year(pcm.date_from);


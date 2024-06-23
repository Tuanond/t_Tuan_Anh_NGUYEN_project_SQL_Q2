-- Výzkumná otázka č. 2
-- 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?


SELECT *
FROM czechia_payroll AS cpay
WHERE value_type_code = 5958;


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
WHERE cp.category_code = '114201' AND cpay.value_type_code = 5958 AND payroll_year = 2006; -- mléko



-- sum of chleba 2006 and 2018
SELECT 
	cp.category_code,
	cpc.name,
	YEAR(cp.date_from),
	sum(cp.value) sum_of_avg_prices,
	sum(cpc.price_value) AS sum_of_kg,
	cpc.price_unit
FROM czechia_price AS cp
LEFT JOIN czechia_price_category AS cpc 
	ON cp.category_code = cpc.code
WHERE cp.category_code = '111301' AND YEAR(cp.date_from) IN ('2006', '2018')
GROUP BY YEAR(cp.date_from);

-- sum of mleko 2006 and 2018

SELECT 
	cp.category_code,
	cpc.name,
	YEAR(cp.date_from),
	sum(cp.value) sum_of_avg_prices,
	sum(cpc.price_value) AS sum_of_liters, 	
	cpc.price_unit
FROM czechia_price AS cp
LEFT JOIN czechia_price_category AS cpc 
	ON cp.category_code = cpc.code
WHERE cp.category_code = '114201' AND YEAR(cp.date_from) IN ('2006', '2018')
GROUP BY YEAR(cp.date_from);


-- union of mleko a chleba v roce 2006 a 2018
SELECT 
	cp.category_code,
	cpc.name,
	YEAR(cp.date_from),
	sum(cp.value) sum_of_avg_prices,
	sum(cpc.price_value) AS sum_of_kg,
	cpc.price_unit
FROM czechia_price AS cp
LEFT JOIN czechia_price_category AS cpc 
	ON cp.category_code = cpc.code
WHERE cp.category_code = '111301' AND YEAR(cp.date_from) IN ('2006', '2018')
GROUP BY YEAR(cp.date_from)
UNION
SELECT 
	cp.category_code,
	cpc.name,
	YEAR(cp.date_from),
	sum(cp.value) sum_of_avg_prices,
	sum(cpc.price_value) AS sum_of_liters, 	
	cpc.price_unit
FROM czechia_price AS cp
LEFT JOIN czechia_price_category AS cpc 
	ON cp.category_code = cpc.code
WHERE cp.category_code = '114201' AND YEAR(cp.date_from) IN ('2006', '2018')
GROUP BY YEAR(cp.date_from);

-- sum mzdy pro rok 2006

SELECT
	payroll_year,
	sum(value) AS mzda_celkem
FROM czechia_payroll AS cpay
WHERE value_type_code = 5958 AND payroll_year IN ('2006', '2018')
GROUP BY payroll_year;

 


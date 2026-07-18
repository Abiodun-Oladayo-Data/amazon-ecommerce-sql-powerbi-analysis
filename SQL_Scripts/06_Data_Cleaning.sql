/*
Project : Amazon E-Commerce Sales Analysis
File    : 06_Data_Cleaning.sql
Author  : Abiodun Oladayo
Purpose : Create a cleaned version of the staging table for business analysis and Power BI reporting.
*/

USE amazon_ecommerce_db;

-- Create cleaned sales table
DROP TABLE IF EXISTS clean_amazon_sales;

CREATE TABLE clean_amazon_sales AS
SELECT
    staging_id,
    TRIM(order_id) AS order_id,
    STR_TO_DATE(order_date, '%m-%d-%y') AS order_date,
    TRIM(order_status) AS order_status,
    TRIM(fulfilment_method) AS fulfilment_method,
    TRIM(sales_channel) AS sales_channel,
    TRIM(ship_service_level) AS ship_service_level,
    TRIM(style) AS style,
    TRIM(sku) AS sku,
    TRIM(category) AS category,
    TRIM(size) AS size,
    TRIM(asin) AS asin,
    TRIM(courier_status) AS courier_status,
    quantity,
    TRIM(currency) AS currency,
    CAST(NULLIF(amount, '') AS DECIMAL(10,2)) AS amount,
    TRIM(ship_city) AS ship_city,
    TRIM(ship_state) AS ship_state,
    TRIM(ship_postal_code) AS ship_postal_code,
    TRIM(ship_country) AS ship_country,
    TRIM(promotion_ids) AS promotion_ids,
    CASE
        WHEN LOWER(is_b2b) = 'true' THEN 1
        WHEN LOWER(is_b2b) = 'false' THEN 0
        ELSE NULL
    END AS is_b2b,
    TRIM(fulfilled_by) AS fulfilled_by
FROM staging_amazon_sales;


-- Validate Clean Table
SELECT COUNT(*) AS total_records
FROM clean_amazon_sales;

SELECT *
FROM clean_amazon_sales
LIMIT 10;

-- Find Inconsistent State Names
SELECT ship_state, COUNT(*) AS total_orders
FROM clean_amazon_sales
GROUP BY ship_state
ORDER BY ship_state;

-- Investigate Inconsistent State Values
SELECT ship_state, ship_city, COUNT(*) AS total_orders
FROM clean_amazon_sales
WHERE ship_state IN (
    'Pondicherry',
    'orissa',
    'Rajsthan',
    'rajsthan',
    'New Delhi',
    'AR',
    'APO',
    'PB',
    'RJ',
    'NL',
    'Punjab/Mohali/Zirakpur'
)
GROUP BY ship_state, ship_city
ORDER BY ship_state;

-- Standardize State Names
SET SQL_SAFE_UPDATES = 0;

UPDATE clean_amazon_sales
SET ship_state = CASE

	WHEN LOWER(ship_state) = 'orissa' THEN 'ODISHA'
    WHEN ship_state = 'Pondicherry' THEN 'PUDUCHERRY'
    WHEN ship_state IN ('Rajsthan','rajsthan', 'Rajshthan', 'RJ')  THEN 'RAJASTHAN'
    WHEN ship_state = 'PB' THEN 'PUNJAB'
    WHEN ship_state = 'Punjab/Mohali/Zirakpur' THEN 'PUNJAB'
    WHEN ship_state = 'New Delhi' THEN 'DELHI'
    WHEN ship_state = 'NL' THEN 'NAGALAND'
    WHEN ship_state = 'AR' THEN 'ARUNACHAL PRADESH'
    ELSE ship_state

END;

SET SQL_SAFE_UPDATES = 1;

-- Updated list of State values after cleaning.
SELECT ship_state, COUNT(*) AS total_orders
FROM clean_amazon_sales
GROUP BY ship_state
ORDER BY ship_state;

-- Investigate Inconsistent City Values
SELECT ship_city, COUNT(*) AS total_orders
FROM clean_amazon_sales
GROUP BY ship_city
ORDER BY total_orders DESC
LIMIT 100;

-- Standardize Ship City Names
SET SQL_SAFE_UPDATES = 0;

UPDATE clean_amazon_sales
SET ship_city = CASE

    WHEN ship_city = 'bangalore' THEN 'BENGALURU'
    WHEN ship_city = 'Gurgaon' THEN 'GURUGRAM'
    WHEN ship_city = 'pune' THEN 'PUNE'
    WHEN ship_city = 'Ahmedabad' THEN 'AHMEDABAD'
    WHEN ship_city = 'Nellore' THEN 'NELLORE'
    WHEN ship_city = 'Mohali' THEN 'MOHALI'
    WHEN ship_city = 'Jammu' THEN 'JAMMU'
    WHEN ship_city = 'Agra' THEN 'AGRA'
    WHEN ship_city = 'Salem' THEN 'SALEM'
    WHEN ship_city = 'dimapur' THEN 'DIMAPUR'
    WHEN ship_city = 'Port Blair' THEN 'PORT BLAIR'

    ELSE ship_city

END;

SET SQL_SAFE_UPDATES = 1;

-- Verification of Standardized City Values
SELECT ship_city, COUNT(*) AS total_orders
FROM clean_amazon_sales
WHERE ship_city IN (
    'bangalore',
    'Gurgaon',
    'pune',
    'Ahmedabad',
    'Nellore',
    'Mohali',
    'Jammu',
    'Agra',
    'Salem',
    'dimapur',
    'Port Blair'
)
GROUP BY ship_city;

SELECT ship_city, COUNT(*) AS total_orders
FROM clean_amazon_sales
WHERE ship_city IN (
    'BENGALURU',
    'GURUGRAM',
    'PUNE',
    'AHMEDABAD',
    'NELLORE',
    'MOHALI',
    'JAMMU',
    'AGRA',
    'SALEM',
    'DIMAPUR',
    'PORT BLAIR'
)
GROUP BY ship_city
ORDER BY total_orders DESC;

-- Checking for Missing Values Again
SELECT
    SUM(CASE WHEN order_id IS NULL OR order_id = '' THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN order_status IS NULL OR order_status = '' THEN 1 ELSE 0 END) AS missing_status,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS missing_amount,
    SUM(CASE WHEN sku IS NULL OR sku = '' THEN 1 ELSE 0 END) AS missing_sku,
    SUM(CASE WHEN category IS NULL OR category = '' THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN ship_city IS NULL OR ship_city = '' THEN 1 ELSE 0 END) AS missing_ship_city,
    SUM(CASE WHEN ship_state IS NULL OR ship_state = '' THEN 1 ELSE 0 END) AS missing_ship_state,
    SUM(CASE WHEN ship_country IS NULL OR ship_country = '' THEN 1 ELSE 0 END) AS missing_ship_country
FROM clean_amazon_sales;

-- Investigate Missing Transaction Amounts
SELECT order_status, COUNT(*) AS total,
	SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS missing_count
FROM clean_amazon_sales
GROUP BY order_status;

SELECT
    SUM(ship_city IS NULL) AS null_ship_city,
    SUM(ship_city = '') AS blank_ship_city,
    SUM(ship_state IS NULL) AS null_ship_state,
    SUM(ship_state = '') AS blank_ship_state,
    SUM(ship_country IS NULL) AS null_ship_country,
    SUM(ship_country = '') AS blank_ship_country
FROM clean_amazon_sales;

SET SQL_SAFE_UPDATES = 0;

UPDATE clean_amazon_sales
SET
    ship_city = NULLIF(TRIM(ship_city), ''),
    ship_state = NULLIF(TRIM(ship_state), ''),
    ship_country = NULLIF(TRIM(ship_country), ''),
	courier_status = NULLIF(TRIM(courier_status), '');
    
SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM clean_amazon_sales
WHERE ship_city IS NULL
   OR ship_city = ''
   OR ship_state IS NULL
   OR ship_state = ''
   OR ship_country IS NULL
   OR ship_country = '';
   
SELECT
    SUM(ship_city IS NULL) AS null_ship_city,
    SUM(ship_city = '') AS blank_ship_city,
    SUM(ship_state IS NULL) AS null_ship_state,
    SUM(ship_state = '') AS blank_ship_state,
    SUM(ship_country IS NULL) AS null_ship_country,
    SUM(ship_country = '') AS blank_ship_country
FROM clean_amazon_sales;

-- Standardize Category Names
SET SQL_SAFE_UPDATES = 0;
UPDATE clean_amazon_sales
SET category = CASE
    WHEN LOWER(category) = 'set' THEN 'SET'
    WHEN LOWER(category) = 'kurta' THEN 'KURTA'
    WHEN LOWER(category) = 'top' THEN 'TOP'
    WHEN LOWER(category) = 'western dress' THEN 'WESTERN DRESS'
    WHEN LOWER(category) = 'ethnic dress' THEN 'ETHNIC DRESS'
    WHEN LOWER(category) = 'blouse' THEN 'BLOUSE'
    WHEN LOWER(category) = 'bottom' THEN 'BOTTOM'
    WHEN LOWER(category) = 'saree' THEN 'SAREE'
    WHEN LOWER(category) = 'dupatta' THEN 'DUPATTA'

    ELSE category
END;
SET SQL_SAFE_UPDATES = 1;

SELECT category,
    COUNT(*) AS total_orders
FROM clean_amazon_sales
GROUP BY category
ORDER BY total_orders DESC;

-- Validate the Cleaned Dataset
-- ==========================================
-- Validate Record Count
SELECT COUNT(*) AS total_records
FROM clean_amazon_sales;

-- Verify Data Types
DESCRIBE clean_amazon_sales;

-- Verify State Standardization
SELECT ship_state, COUNT(*) AS total_orders
FROM clean_amazon_sales
GROUP BY ship_state
ORDER BY ship_state;

-- Verify City Standardization
SELECT ship_city, COUNT(*) AS total_orders
FROM clean_amazon_sales
WHERE ship_city IN (

'BENGALURU',
'GURUGRAM',
'PUNE',
'AHMEDABAD',
'NELLORE',
'MOHALI',
'JAMMU',
'AGRA',
'SALEM',
'DIMAPUR',
'PORT BLAIR'
)
GROUP BY ship_city
ORDER BY total_orders DESC;

-- Preview the Final Dataset
SELECT *
FROM clean_amazon_sales
LIMIT 10;

-- Validate Duplicate Order + SKU Records
SELECT order_id, sku, COUNT(*) AS duplicate_count
FROM clean_amazon_sales
GROUP BY order_id, sku
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

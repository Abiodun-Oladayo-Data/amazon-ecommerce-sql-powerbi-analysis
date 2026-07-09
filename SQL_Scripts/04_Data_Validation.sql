/*
Project : Amazon E-Commerce Sales Analysis
File    : 04_Data_Validation.sql
Author  : Abiodun Oladayo
Purpose : Validate the imported staging data.
*/

USE amazon_ecommerce_db;

-- count total number of imported records
SELECT COUNT(*) AS total_records
FROM staging_amazon_sales;

-- Preview first 10 rows
SELECT *
FROM staging_amazon_sales
LIMIT 10;

-- Total number of columns
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='amazon_ecommerce_db'
AND TABLE_NAME='staging_amazon_sales';

-- Checking for Missing Values
SELECT
    SUM(CASE WHEN order_id IS NULL OR order_id = '' THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN order_date IS NULL OR order_date = '' THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN order_status IS NULL OR order_status = '' THEN 1 ELSE 0 END) AS missing_status,
    SUM(CASE WHEN amount IS NULL OR amount = '' THEN 1 ELSE 0 END) AS missing_amount,
    SUM(CASE WHEN sku IS NULL OR sku = '' THEN 1 ELSE 0 END) AS missing_sku,
    SUM(CASE WHEN category IS NULL OR category = '' THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN ship_city IS NULL OR ship_city = '' THEN 1 ELSE 0 END) AS missing_ship_city,
    SUM(CASE WHEN ship_state IS NULL OR ship_state = '' THEN 1 ELSE 0 END) AS missing_ship_state,
    SUM(CASE WHEN ship_country IS NULL OR ship_country = '' THEN 1 ELSE 0 END) AS missing_ship_country
FROM staging_amazon_sales;

-- Check for duplicate Order IDs
SELECT order_id, sku, COUNT(*) AS duplicate_count
FROM staging_amazon_sales
GROUP BY order_id, sku
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

SELECT *
FROM staging_amazon_sales
WHERE order_id = '406-0372545-6086735'
  AND sku = 'SET197-KR-NP-L';

/* Duplicate Analysis: Inspection of duplicate order_id + sku combinations shows that some records are exact duplicates across all business columns. 
These duplicates will be handled during the data cleaning stage rather than altering the raw staging data. */  


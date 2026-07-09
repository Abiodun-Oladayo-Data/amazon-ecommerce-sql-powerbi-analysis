/*
Project : Amazon E-Commerce Sales Analysis
File    : 03_Load_Staging_Data.sql
Author  : Abiodun Oladayo
Purpose : Load Amazon sales CSV data into the staging table.
*/

USE amazon_ecommerce_db;

TRUNCATE TABLE staging_amazon_sales;

LOAD DATA LOCAL INFILE 'C:/Users/abiod/Downloads/amazon-ecommerce-sql-powerbi-analysis/dataset/Amazon Sale Report.csv'
INTO TABLE staging_amazon_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@index, order_id, order_date, order_status, fulfilment_method, sales_channel,
 ship_service_level, style, sku, category, size, asin, courier_status,
 quantity, currency, amount, ship_city, ship_state, ship_postal_code,
 ship_country, promotion_ids, is_b2b, fulfilled_by, @unnamed_22); 
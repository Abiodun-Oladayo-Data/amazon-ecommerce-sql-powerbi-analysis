/*
Project : Amazon E-Commerce Sales Analysis
File    : 05_Data_Profiling.sql
Author  : Abiodun Oladayo
Purpose : Profile the staging data before cleaning.
*/

USE amazon_ecommerce_db;

-- Dataset Overview
SELECT
COUNT(*) AS total_records
FROM staging_amazon_sales;

SELECT
COUNT(DISTINCT order_id) AS unique_orders
FROM staging_amazon_sales;

SELECT
COUNT(DISTINCT sku) AS unique_products
FROM staging_amazon_sales;

SELECT
COUNT(DISTINCT category) AS product_categories
FROM staging_amazon_sales;

-- Date Range
SELECT
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date
FROM staging_amazon_sales;

-- Order Status Distribution
SELECT order_status, COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_amazon_sales),2) AS percentage
FROM staging_amazon_sales
GROUP BY order_status
ORDER BY total_orders DESC;

-- Fulfilment Method Distribution
SELECT fulfilment_method, COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_amazon_sales),2) AS percentage
FROM staging_amazon_sales
GROUP BY fulfilment_method
ORDER BY total_orders DESC;

-- Sales Channel Distribution
SELECT sales_channel, COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_amazon_sales),2) AS percentage
FROM staging_amazon_sales
GROUP BY sales_channel
ORDER BY total_orders DESC;

-- Shipping Service Level
SELECT ship_service_level, COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_amazon_sales),2) AS percentage
FROM staging_amazon_sales
GROUP BY ship_service_level
ORDER BY total_orders DESC;

-- Product Category Distribution
SELECT category, COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_amazon_sales),2) AS percentage
FROM staging_amazon_sales
GROUP BY category
ORDER BY total_orders DESC;

-- Product Size Distribution
SELECT size, COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_amazon_sales),2) AS percentage
FROM staging_amazon_sales
GROUP BY size
ORDER BY total_orders DESC;

-- Top 20 Product Styles
SELECT style, COUNT(*) AS total_orders
FROM staging_amazon_sales
GROUP BY style
ORDER BY total_orders DESC
LIMIT 10;

-- Product Diversity
SELECT
    COUNT(DISTINCT style) AS unique_styles,
    COUNT(DISTINCT sku) AS unique_skus,
    COUNT(DISTINCT asin) AS unique_asins
FROM staging_amazon_sales;

-- Ship State Distribution
SELECT ship_state, COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_amazon_sales),2) AS percentage
FROM staging_amazon_sales
GROUP BY ship_state
ORDER BY total_orders DESC;

-- Top 10 Shipping Cities
SELECT ship_city, COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_amazon_sales),2) AS percentage
FROM staging_amazon_sales
GROUP BY ship_city
ORDER BY total_orders DESC
LIMIT 15;

-- Country Distribution
SELECT ship_country, COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_amazon_sales),2) AS percentage
FROM staging_amazon_sales
GROUP BY ship_country
ORDER BY total_orders DESC;
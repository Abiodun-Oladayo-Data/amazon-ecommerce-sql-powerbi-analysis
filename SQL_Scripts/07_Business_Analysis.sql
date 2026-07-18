/*
Project : Amazon E-Commerce Sales Analysis
File    : 07_Business_Analysis.sql
Author  : Abiodun Oladayo
Purpose : Analyze cleaned sales data to answer key business questions for Power BI reporting.
*/

USE amazon_ecommerce_db;

-- SECTION 1: OVERALL SALES PERFORMANCE
-- Total revenue from records with a valid amount
SELECT ROUND(SUM(amount), 2) AS total_revenue
FROM clean_amazon_sales;

-- Total number of unique orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM clean_amazon_sales;

-- Total units ordered
SELECT SUM(quantity) AS total_units
FROM clean_amazon_sales;

-- Average order value
SELECT
    ROUND(SUM(amount) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM clean_amazon_sales;

SELECT
    ROUND(
		SUM(amount) / 
        COUNT(DISTINCT CASE WHEN amount IS NOT NULL THEN order_id END), 2) AS average_order_value
FROM clean_amazon_sales;

-- SECTION 2: CATEGORY PERFORMANCE
-- Business Question: Which product categories generate the highest recorded revenue?
SELECT category,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        SUM(amount) * 100.0 /(
            SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL), 2) AS revenue_percentage
FROM clean_amazon_sales
WHERE amount IS NOT NULL
GROUP BY category
ORDER BY total_revenue DESC;

-- SECTION 3: SKU PERFORMANCE
--  Business Question: Which SKUs generate the highest recorded revenue?
SELECT sku, style, category, 
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
        SUM(amount) * 100.0 /(
            SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL), 2) AS revenue_percentage
FROM clean_amazon_sales
WHERE amount IS NOT NULL
GROUP BY sku, style, category
ORDER BY total_revenue DESC
LIMIT 10;

-- SECTION 4: GEOGRAPHIC SALES PERFORMANCE
-- Business Question: Which states generate the highest revenue?

SELECT ship_state,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
        SUM(amount) * 100.0 /(
            SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL), 2) AS revenue_percentage
FROM clean_amazon_sales
WHERE amount IS NOT NULL
  AND ship_state IS NOT NULL
GROUP BY ship_state
ORDER BY total_revenue DESC;

-- SECTION 5: CITY-LEVEL REVENUE ANALYSIS
-- Business Question: Which cities generate the highest recorded revenue?

SELECT ship_city, ship_state,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL), 2) AS revenue_percentage
FROM clean_amazon_sales
WHERE amount IS NOT NULL
    AND ship_city IS NOT NULL
GROUP BY ship_city, ship_state
ORDER BY total_revenue DESC
LIMIT 20;

-- SECTION 6: ORDER STATUS PERFORMANCE
-- Business Question: How does each order status contribute to revenue and order volume?

SELECT order_status,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL ),2) AS revenue_percentage
FROM clean_amazon_sales
WHERE amount IS NOT NULL
GROUP BY order_status
ORDER BY total_revenue DESC;

-- SECTION 7: FULFILLMENT METHOD PERFORMANCE
-- Business Question: How does each fulfillment method contribute to revenue and order volume?

SELECT fulfilment_method,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
		SUM(amount) * 100.0 /
			(SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL),2 ) AS revenue_percentage
FROM clean_amazon_sales
WHERE amount IS NOT NULL
GROUP BY fulfilment_method
ORDER BY total_revenue DESC;

-- SECTION 8: SALES CHANNEL PERFORMANCE
-- Business Question: Which sales channels generate the highest revenue and order volume?

SELECT
    sales_channel,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL), 2) AS revenue_percentage
FROM clean_amazon_sales
WHERE amount IS NOT NULL
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- SECTION 9: COURIER STATUS PERFORMANCE
-- Business Question: How does courier status contribute to revenue and order volume?

SELECT
    courier_status,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL), 2) AS revenue_percentage
FROM clean_amazon_sales
WHERE amount IS NOT NULL
GROUP BY courier_status
ORDER BY total_revenue DESC;

-- Further investigation on NULL values in courier_state
SELECT
    order_status,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(amount), 2) AS total_revenue
FROM clean_amazon_sales
WHERE courier_status IS NULL
	AND amount IS NOT NULL
GROUP BY order_status
ORDER BY total_orders DESC;

-- SECTION 10: B2B VS B2C CUSTOMER PERFORMANCE
-- Business Question: How do B2B and B2C customers contribute to revenue and order volume?

SELECT
    CASE
        WHEN is_b2b = 1 THEN 'B2B'
        ELSE 'B2C'
    END AS customer_segment,

    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL), 2) AS revenue_percentage

FROM clean_amazon_sales
WHERE amount IS NOT NULL
GROUP BY customer_segment
ORDER BY total_revenue DESC;

-- SECTION 11: MONTHLY SALES TREND ANALYSIS
-- Business Question: How did revenue and order volume change over time?

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_sold,
    ROUND(AVG(amount), 2) AS average_order_value

FROM clean_amazon_sales
WHERE amount IS NOT NULL
GROUP BY sales_month
ORDER BY sales_month;

-- Monthly Revenue Growth Analysis
-- Business Question: How did recorded revenue change from one month to the next?

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
        ROUND(SUM(amount), 2) AS total_revenue,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(quantity) AS total_units_sold,
        ROUND(AVG(amount), 2) AS average_order_value
    FROM clean_amazon_sales
    WHERE amount IS NOT NULL
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
),

monthly_comparison AS (
    SELECT sales_month, total_revenue, total_orders, total_units_sold, average_order_value,
        LAG(total_revenue) OVER 
        (ORDER BY sales_month) AS previous_month_revenue
    FROM monthly_sales
)

SELECT  sales_month, total_revenue, total_orders, total_units_sold, average_order_value, previous_month_revenue,
    ROUND(
        (total_revenue - previous_month_revenue)
        * 100.0 / previous_month_revenue, 2) AS revenue_growth_percentage
FROM monthly_comparison
ORDER BY sales_month;


-- SECTION 12: STYLE PERFORMANCE ANALYSIS
-- Business Question: Which product styles generate the highest revenue and order volume?

SELECT style,

    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_sold,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL), 2) AS revenue_percentage

FROM clean_amazon_sales
WHERE amount IS NOT NULL
GROUP BY style
ORDER BY total_revenue DESC
LIMIT 20;

-- SECTION 13: SIZE PERFORMANCE ANALYSIS
-- Business Question: Which clothing sizes generate the highest revenue and sales volume?

SELECT size,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_sold,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL), 2) AS revenue_percentage

FROM clean_amazon_sales
WHERE amount IS NOT NULL
    AND size IS NOT NULL
    AND TRIM(size) <> ''
GROUP BY size
ORDER BY total_revenue DESC;

-- SECTION 14: SHIPPING SERVICE LEVEL PERFORMANCE
-- Business Question: How do different shipping service levels contribute to revenue and order volume?

SELECT ship_service_level,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(amount), 2) AS average_order_value,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount)
            FROM clean_amazon_sales
            WHERE amount IS NOT NULL ), 2) AS revenue_percentage

FROM clean_amazon_sales
WHERE amount IS NOT NULL
GROUP BY ship_service_level
ORDER BY total_revenue DESC;

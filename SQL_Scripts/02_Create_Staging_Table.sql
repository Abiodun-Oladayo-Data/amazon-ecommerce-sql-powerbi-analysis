/*
Project : Amazon E-Commerce Sales Analysis
File    : 02_Create_Staging_Table.sql
Author  : Abiodun Oladayo
Purpose : Create the staging table for importing raw
          Amazon sales data.
*/

USE amazon_ecommerce_db;

CREATE TABLE staging_amazon_sales (

    staging_id INT AUTO_INCREMENT PRIMARY KEY,

    order_id VARCHAR(30),

    order_date DATE,

    order_status VARCHAR(50),

    fulfilment_method VARCHAR(30),

    sales_channel VARCHAR(30),

    ship_service_level VARCHAR(30),

    style VARCHAR(30),

    sku VARCHAR(30),

    category VARCHAR(50),

    size VARCHAR(10),

    asin VARCHAR(30),

    courier_status VARCHAR(30),

    quantity INT,

    currency VARCHAR(10),

    amount DECIMAL(10,2),

    ship_city VARCHAR(100),

    ship_state VARCHAR(100),

    ship_postal_code VARCHAR(20),

    ship_country VARCHAR(10),

    promotion_ids TEXT,

    is_b2b BOOLEAN,

    fulfilled_by VARCHAR(50)

);
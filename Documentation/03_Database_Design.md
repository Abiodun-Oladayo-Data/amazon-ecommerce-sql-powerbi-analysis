# Database Design

## Design Approach

The raw Amazon sales CSV contains order, product, shipping, fulfillment, and sales information in one flat file.

Instead of keeping everything in one large table, this project uses a relational database design to organize the data into logical tables.

This improves:

- Data organization
- Query performance
- Data consistency
- Reporting flexibility
- Power BI modeling

---

## Main Business Entities

The main entities identified from the dataset are:

| Entity | Purpose |
|---|---|
| Orders | Stores order-level information |
| Products | Stores product-level information |
| Sales Transactions | Stores sales line-level facts |
| Shipping | Stores shipping destination details |
| Fulfillment | Stores fulfillment and courier details |

---

## Proposed Tables

### 1. `orders`

Stores one record per order.

| Column | Description |
|---|---|
| order_id | Unique Amazon order identifier |
| order_date | Date the order was placed |
| order_status | Status of the order |
| sales_channel | Sales platform/channel |

---

### 2. `products`

Stores product information.

| Column | Description |
|---|---|
| sku | Product stock keeping unit |
| style | Product style code |
| category | Product category |
| size | Product size |
| asin | Amazon product identifier |

---

### 3. `sales_transactions`

Stores the main transaction facts.

| Column | Description |
|---|---|
| transaction_id | Auto-generated primary key |
| order_id | Links to orders table |
| sku | Links to products table |
| quantity | Quantity sold |
| currency | Currency code |
| amount | Sales amount |
| promotion_ids | Promotion codes applied |
| is_b2b | Indicates business-to-business order |

---

### 4. `shipping`

Stores shipping destination information.

| Column | Description |
|---|---|
| shipping_id | Auto-generated primary key |
| order_id | Links to orders table |
| ship_city | Destination city |
| ship_state | Destination state |
| ship_postal_code | Destination postal code |
| ship_country | Destination country |
| ship_service_level | Shipping service level |

---

### 5. `fulfillment`

Stores fulfillment and courier information.

| Column | Description |
|---|---|
| fulfillment_id | Auto-generated primary key |
| order_id | Links to orders table |
| fulfilment_method | Fulfillment method |
| courier_status | Courier/shipping status |
| fulfilled_by | Fulfillment provider |

---

## Relationships

| Relationship | Type | Explanation |
|---|---|---|
| orders → sales_transactions | One-to-Many | One order can contain multiple product lines |
| products → sales_transactions | One-to-Many | One product can appear in many sales transactions |
| orders → shipping | One-to-One or One-to-Many | One order usually has one shipping destination |
| orders → fulfillment | One-to-One or One-to-Many | One order usually has one fulfillment record |

---

## Primary Keys

| Table | Primary Key |
|---|---|
| orders | order_id |
| products | sku |
| sales_transactions | transaction_id |
| shipping | shipping_id |
| fulfillment | fulfillment_id |

---

## Foreign Keys

| Table | Foreign Key | References |
|---|---|---|
| sales_transactions | order_id | orders(order_id) |
| sales_transactions | sku | products(sku) |
| shipping | order_id | orders(order_id) |
| fulfillment | order_id | orders(order_id) |

---

## Important Design Note

The `Amazon Sale Report.csv` file is a raw reporting file, not a normalized database.

Because of this, the final database will be created in two stages:

### Stage 1: Raw Table

First, the CSV will be imported into a staging table called:

`staging_amazon_sales`

This table will closely match the original CSV structure.

### Stage 2: Normalized Tables

After import, SQL queries will be used to populate the cleaned relational tables:

- `orders`
- `products`
- `sales_transactions`
- `shipping`
- `fulfillment`

This is a common analytics engineering workflow.

---

## Why Use a Staging Table?

A staging table allows us to:

- Import raw data safely
- Preserve the original dataset
- Clean data before inserting into final tables
- Handle missing values
- Standardize column names
- Convert data types
- Remove unnecessary columns

---

## Database Workflow

```text
Raw CSV File
     ↓
staging_amazon_sales
     ↓
Clean and Transform with SQL
     ↓
Normalized Tables
     ↓
SQL Views
     ↓
Power BI Dashboard
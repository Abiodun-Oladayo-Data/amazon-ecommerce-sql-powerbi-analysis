# Data Dictionary

## Dataset: Amazon Sale Report.csv

This file is the main transactional dataset for the project. It contains Amazon order-level sales records, including order status, product details, quantity, amount, shipping location, fulfillment method, and promotion information.

## Initial Dataset Summary

| Item | Value |
|---|---:|
| Total Rows | 128,975 |
| Total Columns | 24 |
| Business Columns After Removing `index` and `Unnamed: 22` | 22 |

---

## Column Dictionary

| Original Column | Clean Column Name | Description | Keep? | Suggested SQL Type | Notes |
|---|---|---|---|---|---|
| index | index_id | Export-generated row index | No | INT | Remove from final analysis table |
| Order ID | order_id | Unique Amazon order identifier | Yes | VARCHAR(30) | Candidate key, but must check duplicates |
| Date | order_date | Date the order was placed | Yes | DATE | Convert from text/date format to SQL DATE |
| Status | order_status | Current order status | Yes | VARCHAR(50) | Examples: Shipped, Cancelled |
| Fulfilment | fulfilment_method | Who fulfilled the order | Yes | VARCHAR(30) | Amazon or Merchant |
| Sales Channel | sales_channel | Sales platform/channel | Yes | VARCHAR(30) | Column has trailing space in original name |
| ship-service-level | ship_service_level | Shipping service level | Yes | VARCHAR(30) | Example: Standard, Expedited |
| Style | style | Product style code | Yes | VARCHAR(30) | Product attribute |
| SKU | sku | Stock Keeping Unit | Yes | VARCHAR(50) | Important product identifier |
| Category | category | Product category | Yes | VARCHAR(50) | Example: Set, kurta, Top |
| Size | size | Product size | Yes | VARCHAR(20) | Example: S, M, L, XL |
| ASIN | asin | Amazon Standard Identification Number | Yes | VARCHAR(30) | Amazon product identifier |
| Courier Status | courier_status | Shipping/courier status | Yes | VARCHAR(30) | Examples: Shipped, Cancelled |
| Qty | quantity | Number of units ordered | Yes | INT | Used for quantity sold |
| currency | currency | Currency code | Yes | VARCHAR(10) | Mostly INR |
| Amount | amount | Sales amount for the order line | Yes | DECIMAL(10,2) | Some missing values expected |
| ship-city | ship_city | Shipping destination city | Yes | VARCHAR(100) | Standardize later if needed |
| ship-state | ship_state | Shipping destination state | Yes | VARCHAR(100) | Useful for regional analysis |
| ship-postal-code | ship_postal_code | Shipping postal code | Yes | VARCHAR(20) | Store as text, not number |
| ship-country | ship_country | Shipping destination country | Yes | VARCHAR(10) | Mostly IN |
| promotion-ids | promotion_ids | Promotion code applied to order | Yes | TEXT | Can be NULL |
| B2B | is_b2b | Whether the order is business-to-business | Yes | BOOLEAN | TRUE/FALSE |
| fulfilled-by | fulfilled_by | Fulfillment provider | Yes | VARCHAR(50) | Many missing values |
| Unnamed: 22 | unnamed_22 | Empty/unnecessary column | No | TEXT | Remove from final analysis table |

---

## Columns to Remove

| Column | Reason |
|---|---|
| index | This is an exported row number, not business data |
| Unnamed: 22 | Appears to be an empty extra column from the CSV export |

---

## Important Data Quality Notes

- The `Date` column displayed as `#####` in Excel because the column width was too small.
- The actual date values are valid and appear in a format like `4/30/2022`.
- The `index` column should not be used for analysis.
- The `Unnamed: 22` column should be removed.
- `Amount`, `currency`, `Courier Status`, `promotion-ids`, and `fulfilled-by` may contain missing values.
- `ship-postal-code` should be stored as text because postal codes are identifiers, not values for calculation.
- `Order ID` may not be fully unique because one order can contain multiple product lines.

---

## Initial Modeling Notes

The raw CSV should not be treated as the final database design.

The main business entities identified are:

- Orders
- Products
- Sales Transactions
- Shipping Locations
- Fulfillment
- Promotions

These entities will guide the database design in the next deliverable.
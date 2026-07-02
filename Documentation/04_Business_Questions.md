# Business Questions and KPIs

## Purpose

This document defines the business questions and key performance indicators that will guide the SQL analysis and Power BI dashboard development.

The goal is to ensure that every SQL query and dashboard visual answers a meaningful business question.

---

# Key Business Questions

## 1. Sales Performance

- What is the total revenue?
- What is the total number of orders?
- What is the total quantity sold?
- What is the average order value?
- How does revenue change over time?
- Which months generate the highest revenue?

---

## 2. Product Performance

- Which products generate the highest revenue?
- Which products sell the highest quantity?
- Which product categories perform best?
- Which sizes are most frequently ordered?
- Which products have low sales performance?

---

## 3. Geographic Performance

- Which states generate the highest revenue?
- Which cities generate the highest revenue?
- Which locations have the highest order volume?
- Are there regions with high cancellation rates?

---

## 4. Fulfillment and Operations

- What percentage of orders are shipped, cancelled, or pending?
- Which fulfillment method handles the most orders?
- Which courier statuses are most common?
- How does shipping service level affect order performance?
- Which fulfillment method contributes the most revenue?

---

## 5. Promotion and B2B Analysis

- How many orders used promotions?
- Do promoted orders generate more revenue than non-promoted orders?
- What percentage of orders are B2B?
- How does B2B revenue compare with non-B2B revenue?

---

# Key Performance Indicators

| KPI | Description |
|---|---|
| Total Revenue | Sum of all sales amount |
| Total Orders | Count of unique order IDs |
| Total Quantity Sold | Sum of quantity sold |
| Average Order Value | Total revenue divided by total orders |
| Cancellation Rate | Percentage of orders with cancelled status |
| Shipped Order Rate | Percentage of orders successfully shipped |
| Revenue by Category | Revenue grouped by product category |
| Revenue by State | Revenue grouped by shipping state |
| Top Products | Products ranked by revenue or quantity |
| B2B Revenue Share | Percentage of revenue from B2B orders |
| Promotion Usage Rate | Percentage of orders with promotion IDs |

---

# Dashboard Pages Planned

## Page 1: Executive Summary

Main KPIs:

- Total Revenue
- Total Orders
- Total Quantity Sold
- Average Order Value
- Cancellation Rate

Recommended visuals:

- KPI cards
- Monthly revenue trend
- Revenue by category
- Revenue by state
- Order status breakdown

---

## Page 2: Product Performance

Main KPIs:

- Top products by revenue
- Top products by quantity sold
- Revenue by category
- Sales by size

Recommended visuals:

- Bar charts
- Matrix/table
- Category filters
- Product ranking

---

## Page 3: Geographic Sales

Main KPIs:

- Revenue by state
- Revenue by city
- Order volume by location

Recommended visuals:

- Map visual
- Bar chart by state
- City ranking table

---

## Page 4: Fulfillment and Operations

Main KPIs:

- Orders by fulfillment method
- Orders by courier status
- Revenue by shipping service level
- Cancellation rate by fulfillment method

Recommended visuals:

- Donut chart
- Stacked bar chart
- KPI cards
- Trend analysis

---

## Page 5: Promotions and B2B

Main KPIs:

- Promotion usage rate
- Revenue from promoted orders
- Revenue from non-promoted orders
- B2B revenue share

Recommended visuals:

- Comparison charts
- KPI cards
- Revenue split visuals

---

# Analysis Priority

The SQL analysis will begin with core business metrics:

1. Total revenue
2. Total orders
3. Total quantity sold
4. Revenue by month
5. Revenue by category
6. Revenue by state
7. Order status breakdown
8. Top products
9. Fulfillment analysis
10. Promotion and B2B analysis
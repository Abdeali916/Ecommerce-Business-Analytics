# Business Problem — E-Commerce Sales Analytics

## 1. Business Context

An e-commerce business generates a large volume of transactional data across customers, orders, payments, products, and order items.

However, having the data alone does not tell the business whether the business is performing well.

The management team needs to understand:

- How much revenue is being generated and how it changes over time
- Which states and customer markets contribute the most revenue
- Whether customers are returning to purchase again
- Which product categories generate the most sales
- Which payment methods customers prefer
- How different order statuses affect realized revenue
- Where the business may have opportunities to improve customer retention and revenue

Without a structured analysis, these questions are difficult to answer consistently from raw transactional tables.

---

## 2. The Business Problem

### The company has transaction data, but lacks a clear view of its sales and customer performance.

The business needs to determine:

> **What is driving e-commerce revenue, where is the business performing strongly or weakly, and what customer, product, payment, and geographic patterns can be identified from historical sales data?**

The problem is not simply to calculate total sales.

The business needs to move from **raw transaction records → performance insights → actionable business decisions.**

---

## 3. Specific Business Challenges

### Challenge 1 — Revenue Performance Is Not Clearly Understood

The company needs to understand its revenue performance across different months and order statuses.

Management needs answers to questions such as:

- What is the total revenue?
- How does revenue change month by month?
- Which months generated the highest revenue?
- How much revenue comes from delivered orders?
- Are there significant differences between revenue and order volume?

Without this analysis, it is difficult to identify sales trends or periods of strong and weak performance.

---

### Challenge 2 — Customer Retention Is Unclear

The business has a large customer base, but it needs to understand whether customers are making repeat purchases.

Key questions include:

- How many unique customers does the business have?
- How many customers purchased only once?
- How many customers returned to purchase again?
- Which states have the largest customer base?
- Which states generate the highest customer revenue?
- Where is customer spending relatively high?

A high number of customers does not necessarily mean strong customer retention.

The business therefore needs to distinguish between **customer acquisition and repeat purchasing behavior.**

---

### Challenge 3 — Product Performance Is Difficult to Compare

The business sells products across many categories.

Management needs to identify:

- Which product categories generate the most revenue?
- Which categories have the highest order volume?
- What is the average product price?
- Which categories have a large product catalog but relatively lower revenue?
- Which products or categories contribute most to overall sales?

Without category-level analysis, the business may not know where to focus inventory, marketing, or promotional efforts.

---

### Challenge 4 — Geographic Concentration Creates a Visibility Gap

Customers are distributed across multiple Brazilian states and cities.

The business needs to determine:

- Which states have the largest customer base?
- Which states generate the most revenue?
- Is revenue heavily concentrated in a small number of states?
- Are there states with customers but comparatively low revenue contribution?

Understanding geographic concentration can help the business evaluate market expansion opportunities and regional performance.

---

### Challenge 5 — Payment Behavior Needs to Be Understood

Customers use different payment methods, including:

- Credit card
- Boleto
- Voucher
- Debit card

The business needs to understand:

- Which payment methods are most commonly used?
- Which payment methods generate the most revenue?
- What proportion of revenue comes from each payment method?
- How dependent is the business on a particular payment method?

This can help management understand customer payment preferences and the importance of maintaining convenient payment options.

---

### Challenge 6 — Order Status Affects Revenue Interpretation

Not every order has the same business outcome.

Orders may have statuses such as:

- Delivered
- Shipped
- Canceled
- Unavailable
- Processing
- Invoiced
- Created
- Approved

Therefore, total transaction value alone may not represent the actual business performance.

The business needs to compare revenue across order statuses to understand how much value is associated with successfully completed versus unsuccessful or incomplete orders.

---

## 4. Core Business Question

The analysis is designed around one central question:

> **How can the company use historical e-commerce transaction data to understand sales performance, customer behavior, product performance, payment preferences, and geographic concentration in order to identify opportunities for revenue growth and stronger customer retention?**

---

## 5. Business Objectives

To address the problem, the analysis will:

1. **Measure overall sales performance**
   - Total revenue
   - Total orders
   - Average order value
   - Monthly revenue trends

2. **Analyze customer behavior**
   - Unique customers
   - Repeat vs one-time customers
   - Average customer spend
   - Customer distribution by state

3. **Evaluate product performance**
   - Product and category volumes
   - Revenue by category
   - Product price distribution
   - Category-level performance

4. **Understand payment behavior**
   - Payment method usage
   - Revenue contribution by payment type
   - Installment patterns

5. **Analyze geographic performance**
   - Customers by state
   - Revenue by state
   - Regional concentration

6. **Evaluate order outcomes**
   - Order status distribution
   - Revenue by order status
   - Delivered-order performance

7. **Identify deeper business patterns**
   - Customer revenue ranking
   - Revenue growth by month
   - Month-over-month revenue changes
   - Customer value segments
   - Revenue concentration across categories

---

## 6. Data Available for the Analysis

The project uses **five selected datasets** from the Olist Brazilian E-Commerce dataset:

| Dataset | Business Purpose |
|---|---|
| `olist_customers_dataset.csv` | Customer location and customer identification |
| `olist_orders_dataset.csv` | Order dates, order status, and delivery information |
| `olist_order_items_dataset.csv` | Products purchased, prices, and freight values |
| `olist_order_payments_dataset.csv` | Payment methods, payment values, and installments |
| `olist_products_dataset.csv` | Product and category information |

These datasets are connected through customer, order, and product relationships to create a unified view of e-commerce performance.

---

## 7. Expected Business Value

The analysis is expected to help management:

- Identify major revenue-generating periods
- Understand the strongest customer markets
- Identify high-performing product categories
- Measure customer repeat-purchase behavior
- Understand payment preferences
- Evaluate delivered versus unsuccessful order value
- Identify geographic concentration
- Prioritize areas for customer retention and revenue growth

The final objective is to turn transactional data into **clear, decision-oriented business insights.**

---

---

## 8. Project Scope

The analysis covers:

- Sales analysis
- Customer analysis
- Product and category analysis
- Payment analysis
- Geographic analysis
- Order-status analysis
- Advanced SQL analysis
- Power BI dashboard visualization

### Geographic Analysis

The project evaluates geographic performance through:

- Customer distribution by state
- Revenue by state
- Customer spending by state
- Identification of regions with strong customer and revenue contribution
- Geographic concentration of the customer base

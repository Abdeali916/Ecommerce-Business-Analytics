# Data Dictionary — Olist E-Commerce Analytics

## 1. Dataset Overview

This project uses five selected datasets from the Olist Brazilian E-Commerce Public Dataset.

The datasets represent different parts of the e-commerce transaction lifecycle:

**Customer → Order → Order Item → Product / Payment**

These tables are connected through customer, order, and product identifiers and are used for sales, customer, product, payment, and geographic analysis.

---

## 2. Customers Dataset

**File:** `olist_customers_dataset.csv`

**Purpose:** Contains customer identification and geographic information.

| Column | Data Type | Description | Key / Role |
|---|---|---|---|
| `customer_id` | String | Unique identifier assigned to each customer record/order relationship | Customer identifier |
| `customer_unique_id` | String | Unique identifier representing the actual customer across orders | Customer-level identifier |
| `customer_zip_code_prefix` | Integer | First five digits of the customer's ZIP code | Geographic attribute |
| `customer_city` | String | Customer's city | Geographic attribute |
| `customer_state` | String | Customer's state | Geographic attribute |

**Business use:** Customer counts, repeat-purchase analysis, customer revenue, state-level distribution, and geographic concentration.

---

## 3. Orders Dataset

**File:** `olist_orders_dataset.csv`

**Purpose:** Contains order-level information, order status, and order lifecycle dates.

| Column | Data Type | Description | Key / Role |
|---|---|---|---|
| `order_id` | String | Unique identifier for an order | Primary key |
| `customer_id` | String | Identifier linking the order to the customer record | Foreign key |
| `order_status` | String | Current/final status of the order | Order performance attribute |
| `order_purchase_timestamp` | DateTime | Date and time when the customer placed the order | Sales time dimension |
| `order_approved_at` | DateTime | Date and time when payment was approved | Order lifecycle date |
| `order_delivered_carrier_date` | DateTime | Date and time when the order was handed to the carrier | Delivery lifecycle date |
| `order_delivered_customer_date` | DateTime | Date and time when the order was delivered | Delivery lifecycle date |
| `order_estimated_delivery_date` | DateTime | Estimated delivery date | Delivery performance attribute |

**Business use:** Sales trends, order status analysis, delivered-order analysis, order lifecycle analysis, and time-based analysis.

---

## 4. Order Items Dataset

**File:** `olist_order_items_dataset.csv`

**Purpose:** Contains individual products purchased within each order.

| Column | Data Type | Description | Key / Role |
|---|---|---|---|
| `order_id` | String | Identifier of the order containing the item | Foreign key |
| `order_item_id` | Integer | Sequential item number within an order | Item identifier |
| `product_id` | String | Identifier of the purchased product | Foreign key |
| `seller_id` | String | Identifier of the seller fulfilling the item | Seller attribute |
| `shipping_limit_date` | DateTime | Date by which the seller should ship the item | Shipping attribute |
| `price` | Decimal | Price of the purchased product item | Sales metric |
| `freight_value` | Decimal | Freight/shipping value associated with the item | Shipping metric |

**Business use:** Revenue, product sales, category revenue, product volume, average price, freight, and high-value product analysis.

**Revenue definition used in this project:**

`Revenue = SUM(order_items.price)`

`freight_value` is analyzed separately as a shipping-related metric.

---

## 5. Order Payments Dataset

**File:** `olist_order_payments_dataset.csv`

**Purpose:** Contains payment information associated with customer orders.

| Column | Data Type | Description | Key / Role |
|---|---|---|---|
| `order_id` | String | Identifier of the order associated with the payment | Foreign key |
| `payment_sequential` | Integer | Sequence number of a payment within an order | Payment record identifier |
| `payment_type` | String | Payment method used by the customer | Payment attribute |
| `payment_installments` | Integer | Number of installments selected | Payment attribute |
| `payment_value` | Decimal | Monetary value of the payment | Payment metric |

**Business use:** Payment method analysis, payment revenue, revenue share, installment analysis, and payment behavior.

**Payment types observed:**
- `credit_card`
- `boleto`
- `voucher`
- `debit_card`
- `not_defined`

---

## 6. Products Dataset

**File:** `olist_products_dataset.csv`

**Purpose:** Contains product-level attributes and product category information.

| Column | Data Type | Description | Key / Role |
|---|---|---|---|
| `product_id` | String | Unique identifier of a product | Primary key |
| `product_category_name` | String | Product category in the source dataset | Product/category attribute |
| `product_name_lenght` | Integer | Length of the product name | Product attribute |
| `product_description_lenght` | Integer | Length of the product description | Product attribute |
| `product_photos_qty` | Integer | Number of photos associated with the product | Product attribute |
| `product_weight_g` | Integer | Product weight in grams | Product attribute |
| `product_length_cm` | Integer | Product length in centimeters | Product attribute |
| `product_height_cm` | Integer | Product height in centimeters | Product attribute |
| `product_width_cm` | Integer | Product width in centimeters | Product attribute |

**Business use:** Product catalog, category revenue, product volume, product attributes, and premium-product analysis.

---

## 7. Key Relationships

```text
Customers
    │
    │ customer_id
    ▼
Orders
    │
    │ order_id
    ├──────────────────────► Order Payments
    │
    ▼
Order Items
    │
    │ product_id
    ▼
Products
```

### Main Joins

**Customers → Orders**
```sql
customers.customer_id = orders.customer_id
```

**Orders → Order Items**
```sql
orders.order_id = order_items.order_id
```

**Orders → Payments**
```sql
orders.order_id = order_payments.order_id
```

**Order Items → Products**
```sql
order_items.product_id = products.product_id
```

---

## 8. Important Analytical Fields

| Metric | Calculation / Logic |
|---|---|
| Total Revenue | `SUM(order_items.price)` |
| Total Orders | `COUNT(DISTINCT order_id)` |
| Average Order Value | `Total Revenue / Total Orders` |
| Total Customers | `COUNT(DISTINCT customer_unique_id)` |
| Customer Revenue | `SUM(order_items.price)` grouped by customer |
| Category Revenue | `SUM(order_items.price)` grouped by product category |
| Payment Revenue | `SUM(payment_value)` grouped by payment type |
| Revenue Share | Category/Payment revenue ÷ total revenue |
| Repeat Customer | Customer with more than one distinct order |
| One-Time Customer | Customer with exactly one distinct order |
| Monthly Revenue | Revenue grouped by order purchase month |
| MoM Revenue Change | Current month revenue compared with previous month using `LAG()` |
| Customer Revenue Rank | `RANK()` based on customer revenue |
| Category Revenue Rank | `DENSE_RANK()` based on category revenue |
| Customer Value Segment | High / Medium / Low based on customer revenue |
| Customer Revenue Quartile | `NTILE(4)` based on customer revenue |

---

## 9. Data Quality Notes

The project includes a dedicated SQL data-quality validation module.

### Missing Values Identified

**Orders**
- `order_approved_at`: 160 missing
- `order_delivered_carrier_date`: 1,783 missing
- `order_delivered_customer_date`: 2,965 missing

**Products**
- `product_category_name`: 610 missing
- `product_name_lenght`: 610 missing
- `product_description_lenght`: 610 missing
- `product_photos_qty`: 610 missing
- `product_weight_g`: 2 missing
- `product_length_cm`: 2 missing
- `product_height_cm`: 2 missing
- `product_width_cm`: 2 missing

### Dataset Size

| Dataset | Rows |
|---|---:|
| Customers | 99,441 |
| Orders | 99,441 |
| Order Items | 112,650 |
| Order Payments | 103,886 |
| Products | 32,951 |

### Category Count

The project contains **73 distinct non-null product categories** in the selected product dataset.

---

## 10. Analytical Role of Each Dataset

| Dataset | Main Analysis |
|---|---|
| Customers | Customer & Geographic Analysis |
| Orders | Sales & Order Performance |
| Order Items | Revenue & Product Sales |
| Order Payments | Payment Behavior |
| Products | Product & Category Performance |

Together, these datasets provide the foundation for the project's **sales, customer, product, payment, geographic, and advanced SQL analysis**.

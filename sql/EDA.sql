--IN THIS SECTION WE ARE UNDERSTANDING THE DATA 

------SECTION 1 = ORDERS TABLE---------


SELECT COUNT(order_id) as total_orders  FROM orders
-- Insight
--There were 99441 orders made by the customers


SELECT order_status,count(*) as total,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage 
from orders group by order_status
-- Insight:
-- Total Orders: 99,441
-- Delivered Orders: 96,478 (approximately 97% of all orders)
-- Only about 3% of orders are in other statuses such as shipped, canceled, processing, or unavailable



SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM orders
--Insight
--first order was made on 04-09-2016 
-- last order was made on 17-10-2018


------SECTION 2 = CUSTOMER TABLE---------


SELECT COUNT(customer_id) as total_cust FROM customers
--Insight
---we have 99441 customers so far 


SELECT customer_city,count(*) AS total_cust FROM customers GROUP BY customer_city ORDER BY total_cust DESC
--Insight
--OUR MAJORITY CUSTOMERS ARE FROM SAO PAULO (APPROX=15540)
-- FOLLOWING WE HAVE MAJORITY CUSTOMER FROM RIO DE JANERIO(RJ) AND BELO HORIZONTE(BH)


SELECT  customer_state,count(*) AS total_cust FROM customers GROUP BY customer_state ORDER BY total_cust DESC
-- INSIGHT
--OUR MAJORITY CUSTOMER ARE FROM SP (APPROX=41746)
--FOLLOWING WE HAVE RJ,MG ETC...



------SECTION 3 = PRODUCTS TABLE---------




SELECT COUNT(product_id) as total_product FROM products
--INSIGHT
--THIS BUSINESS SELLS 32951 (33,000 approx)DIFFERENT PRODUCTS



SELECT COUNT(DISTINCT product_category_name) AS TOTAL_CATEGORIES FROM PRODUCTS
--INSIGHT
---THERE ARE 74 DIFERENT CATEGORIES OF PRODUCTS



SELECT TOP 10 product_category_name,COUNT(*) AS TOTAL_PRODUCT 
FROM products
GROUP BY product_category_name ORDER BY TOTAL_PRODUCT DESC
--Insight
-- The cama_mesa_banho (Bed, Bath and Table) category has the highest
-- number of products (3,029) in the dataset



------SECTION 4 = PAYMENTS TABLE---------

SELECT payment_type,count(*) AS total FROM order_payments GROUP BY  payment_type ORDER BY total DESC
--INSIGHT
--MAJORITY OF CUSTOMER USES CREDIT CARD FOR PAYMENTS(APPROX 76795 PAYMENTS ARE MADE USING CC)
--LESS NUMBER OF CUSTOMER USES DEBIT CARD FOR PAYMENTS

SELECT payment_installments,COUNT(*) AS TOTAL FROM order_payments GROUP BY payment_installments ORDER BY TOTAL DESC
--INSIGHT
--MOST OF THE CUSTOMER USES ONE INSTALLMENTS (AROUND 52,546)
--THIS BUSINESS PROVIDES INSTALMENTS TILL 24 MONTH

SELECT
    ROUND(SUM(payment_value),2) AS total_revenue,
    ROUND(AVG(payment_value),2) AS avg_payment,
    ROUND(MIN(payment_value),2) AS min_payment,
    ROUND(MAX(payment_value),2) AS max_payment
FROM order_payments
--Insight
--  The business generated a total revenue of approximately 16.01 million
--  The average payment value per transaction is approximately 154.10
--  The highest payment recorded is 13,664.08, showing the presence of high-value customer


--IMPROVEMENTS --IQR FOR OUTLIERS
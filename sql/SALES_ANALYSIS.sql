                              -----SALES ANALYSIS-----
--The purpose of this analysis is to understand the sales
--performance of the business by analyzing revenue, order
--trends and payment patterns to identify key business insights


----REVENUE ANALYSIS----

SELECT ROUND(SUM(payment_value),1) AS TOTAL_REVENUE FROM order_payments
--Insight
--The business generated approximately 16.01 million in total revenue

SELECT 
    YEAR(o.order_purchase_timestamp) AS ORDER_YEAR,
    MONTH(o.order_purchase_timestamp) AS ORDER_MONTH,
    ROUND(SUM(p.payment_value),1) AS REVENUE
FROM orders AS o INNER JOIN order_payments AS p 
ON o.order_id=p.order_id
GROUP BY YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp) 
ORDER BY REVENUE DESC
--Insight 
-- Revenue was maximum in November 2017 (1,194,882$).
-- Revenue was lowest in December 2016 (19.6$)

SELECT 
    MONTH(order_purchase_timestamp) AS ORDER_MONTH,
    COUNT(order_id) AS TOTAL_ORDERS
FROM orders 
GROUP BY  MONTH(order_purchase_timestamp)
ORDER BY TOTAL_ORDERS DESC
--Insight
--Highest orders was placed in August 
--least orders were placed in september month


SELECT ROUND(AVG(TOTAL_REVENUE),1) AS AVERAGE_ORDER_VALUE 
FROM(
SELECT
    order_id,
    SUM(payment_value) AS TOTAL_REVENUE
FROM order_payments
GROUP BY order_id)t
--Insight
--The average amount spent per order is 161$

 SELECT 
    payment_type,
    ROUND(SUM(payment_value),1) AS TOTAL_REVENUE,
     ROUND(SUM(payment_value) * 100.0 /(SELECT SUM(payment_value) FROM order_payments),2)
     AS revenue_percentage
FROM order_payments
GROUP BY payment_type
ORDER BY TOTAL_REVENUE DESC
--Insight 
-- Credit cards are the most preferred payment method, generating
-- approximately 12.54 million in revenue.
-- Around 77.5% of the total revenue comes from credit card transactions,
-- indicating a strong customer preference for credit card payments.

SELECT 
    S.order_status,
    ROUND(SUM(P.payment_value),1) AS TOTAL_REVENUE,
    ROUND(SUM(P.payment_value)*100/(SELECT SUM(payment_value) FROM order_payments),2) 
    AS REVENUE_PERCENTAGE
FROM orders AS S
INNER JOIN order_payments AS P
ON S.order_id=P.order_id 
GROUP BY S.order_status
ORDER BY TOTAL_REVENUE DESC
--Insight
---Delivered orders account for 96.34% of total revenue
-- indicating a highly successful order fulfillment process
-- and strong operational efficiency

SELECT TOP 10
    o.order_id,
    c.customer_id,
    c.customer_state,
    o.order_purchase_timestamp,
    ROUND(SUM(p.payment_value),2) AS TOTAL_REVENUE
FROM order_payments AS p 
INNER JOIN orders AS o
ON p.order_id=o.order_id
INNER JOIN customers AS c 
ON c.customer_id=o.customer_id
GROUP BY  o.order_id,
    c.customer_id,
    c.customer_state,
    o.order_purchase_timestamp
ORDER BY TOTAL_REVENUE DESC
--Insight
-- The analysis reveals that a small number of high-value orders contribute significantly
-- to revenue. Identifying these premium transactions helps businesses understand
-- customer purchasing behavior and target high-value customers more effectively
--------------------------CUSTOMER ANALYSIS---------------------------------
---This analysis aims to understand customer behavior, purchasing
---patterns, and geographic distribution. The insights help identify
---valuable customers, customer concentration across regions, and
---opportunities to improve customer retention and business growth.

SELECT 
	COUNT(DISTINCT customer_unique_id) AS TOTAL_UNIQUE_CUST
FROM customers
--Insight
--The business has 96096 unique customers in the dataset



SELECT 
	CASE 
	WHEN TOTAL_ORDERS =1 THEN 'NEW CUSTOMER'
	ELSE 'REPEAT CUSTOMER'
	END AS CUSTOMER_TYPE,
	COUNT(*) AS TOTAL_CUSTOMER
FROM (
SELECT 
	c.customer_unique_id,
	COUNT(o.order_id) AS TOTAL_ORDERS
FROM orders AS o INNER JOIN customers AS c 
ON o.customer_id=c.customer_id
GROUP BY c.customer_unique_id)t 
GROUP BY CASE 
	  WHEN TOTAL_ORDERS =1 THEN 'NEW CUSTOMER'
	  ELSE 'REPEAT CUSTOMER'
	  END 
--Insight
-- Most customers are one-time buyers, indicating an opportunity
-- to improve customer retention through offers,discounts  and
-- personalized marketing
--Services and operations should be improved for better retention

SELECT TOP 10 c.customer_unique_id,
	ROUND(SUM(p.payment_value),1) AS TOTAL_REVENUE
FROM customers AS c INNER JOIN orders AS o
ON c.customer_id=o.customer_id
INNER JOIN order_payments AS p ON o.order_id=p.order_id
GROUP BY c.customer_unique_id
ORDER BY ROUND(SUM(p.payment_value),1) DESC

--Insight
--These customer are the top contributing customers 
--They can be high valued customers and can be targeted marketing

SELECT
    customer_state,
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC
--INSIGHT
--The majority of customer are from sp (approx 40,3302) 
--making it the company's strongest market
--The business must focus on states like RR,AP,AC and AM to expand business


SELECT ROUND(AVG(TOTAL_REVENUE),1) AS AVERAGE_CUSTOMER_SPEND
FROM(
SELECT  c.customer_unique_id,
	ROUND(SUM(p.payment_value),1) AS TOTAL_REVENUE
FROM customers AS c INNER JOIN orders AS o
ON c.customer_id=o.customer_id
INNER JOIN order_payments AS p ON o.order_id=p.order_id
GROUP BY c.customer_unique_id)t
--Insight
-- On average, each customer spends approximately 166.6$ across
-- all of their purchases


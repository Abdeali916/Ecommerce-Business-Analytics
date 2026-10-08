            ----------------- ADVANCE SQL ANALYSIS ------------------

/*
This analysis uses advanced SQL concepts such as CTEs,
window functions, ranking, and analytical functions to
extract deeper business insights from the e-commerce dataset
*/

WITH customerRevenue AS
(
SELECT C.customer_unique_id,
    ROUND(SUM(P.payment_value),2) AS TOTAL_REVENUE
FROM customers AS C INNER JOIN orders AS O
ON C.customer_id=O.customer_id
INNER JOIN order_payments AS P ON O.order_id=P.order_id
GROUP BY C.customer_unique_id
)
SELECT 
    customer_unique_id,
    TOTAL_REVENUE,
    RANK() OVER(ORDER BY TOTAL_REVENUE DESC) AS REVENUE_RANK
FROM customerRevenue;
--Insight
--Some customers spend much more than others
--Identifying these customers can help the business build stronger customer relationships



WITH categoryRevenue AS
(
SELECT 
    P.product_category_name,
    ROUND(SUM(OI.price),2) AS  REVENUE
FROM products AS P
INNER JOIN order_items AS OI 
ON OI.product_id=P.product_id
GROUP BY P.product_category_name
)
SELECT product_category_name,
    REVENUE,
    DENSE_RANK() OVER(ORDER BY REVENUE DESC) AS category_rank
FROM categoryRevenue;
--Insight
--This ranking highlights the best-performing product categories based on revenue
--It gives a clear view of which categories contribute the most to the business



WITH Monthlyrevenue AS 
(
SELECT 
    FORMAT(O.order_purchase_timestamp,'yyyy-MM') AS MONTH,
    ROUND(SUM(P.payment_value),2) AS REVENUE
FROM orders AS O
INNER JOIN order_payments AS P
ON P.order_id=O.order_id
GROUP BY FORMAT(O.order_purchase_timestamp,'yyyy-MM')
)
SELECT 
    MONTH,
    REVENUE,
    SUM(REVENUE) OVER(ORDER BY MONTH ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RUNNING_REVENUE
FROM Monthlyrevenue;
--Learning
--FORMAT() returns an NVARCHAR value. When using window functions,
--it's better to ORDER BY a DATE or numeric column, or explicitly use
--ROWS instead of the default RANGE window frame

--Insight
-- The running revenue month by month contributation, showing how the business
--generated revenue over time and highlighting its overall growth



WITH MonthlyRevenue AS 
(
SELECT 
    FORMAT(O.order_purchase_timestamp,'yyyy-MM') AS MONTH,
    ROUND(SUM(P.payment_value),2) AS REVENUE
FROM orders AS O
INNER JOIN order_payments AS P
ON P.order_id=O.order_id
GROUP BY FORMAT(O.order_purchase_timestamp,'yyyy-MM')
)
SELECT 
    Month,
    REVENUE,
    REVENUE-ISNULL(LAG(REVENUE) OVER(ORDER BY Month),0)AS REVENUE_GROWTH
FROM MonthlyRevenue;
--Insight
--Comparing each month's revenue with the previous month highlights
--periods of growth and decline, making it easier to identify monthly sales trends



WITH customer_sale AS
(
SELECT C.customer_state,
    C.customer_unique_id,
    ROUND(SUM(P.payment_value),2) AS TOTAL_REVENUE
FROM customers AS C INNER JOIN orders AS O 
ON O.customer_id=C.customer_id
INNER JOIN order_payments AS P
ON P.order_id=O.order_id
GROUP BY C.customer_state,
    C.customer_unique_id
)
SELECT * FROM (
SELECT *,
    ROW_NUMBER() OVER(PARTITION BY customer_state
ORDER BY TOTAL_REVENUE DESC) AS rn
FROM customer_sale
) AS T
WHERE rn<=5;
--Insight
--By ranking customers within each state, we can identify the highest-spending customers
--in every region and compare customer performance across different states.



WITH customerRevenue AS
(
SELECT C.customer_unique_id,
    ROUND(SUM(P.payment_value),2) AS REVENUE
FROM customers AS C INNER JOIN orders AS O
ON C.customer_id=O.customer_id
INNER JOIN order_payments AS P 
ON O.order_id=P.order_id
GROUP BY C.customer_unique_id
)
SELECT
    CASE
    WHEN Revenue>=1000 THEN 'High Value'
    WHEN Revenue>=500 THEN 'Medium Value'
    ELSE 'Low Value'
    END CustomerSegment,
    COUNT(*) Customers
FROM CustomerRevenue
GROUP BY
    CASE
    WHEN Revenue>=1000 THEN 'High Value'
    WHEN Revenue>=500 THEN 'Medium Value'
    ELSE 'Low Value'
END;
--Insight
--Most customers belong to the Low Value segment, while High Value
--customers represent only a small portion of the customer base
--This shows that a few customers contribute significantly more revenue than the majority




WITH customerRevenue AS
(
SELECT C.customer_unique_id,
    ROUND(SUM(P.payment_value),2) AS REVENUE
FROM customers AS C INNER JOIN orders AS O
ON C.customer_id=O.customer_id
INNER JOIN order_payments AS P 
ON O.order_id=P.order_id
GROUP BY C.customer_unique_id
)
SELECT
    customer_unique_id,
    REVENUE,
    NTILE(4) OVER(ORDER BY REVENUE DESC) AS REVENUE_QUARTILE
FROM customerRevenue;
--Insight:
--NTILE(4) divides customers into four equal-sized groups based
--on their total spending.
--This analysis highlights differences in customer purchasing
--behavior and supports data-driven customer segmentation.


WITH REVENUE AS(
SELECT P.product_category_name,
    ROUND(SUM(OI.price),2) AS TOTAL_REVENUE
FROM products AS P
INNER JOIN order_items AS OI 
ON P.product_id=OI.product_id
GROUP BY P.product_category_name
),
PARETO AS(
SELECT product_category_name,
    TOTAL_REVENUE,
    SUM(TOTAL_REVENUE) OVER(
    ORDER BY TOTAL_REVENUE DESC) AS CUMMULATIVE_REVENUE,
    SUM(Total_Revenue) OVER () AS Grand_Total_Revenue
FROM REVENUE
)
SELECT product_category_name,
    TOTAL_REVENUE,
    CUMMULATIVE_REVENUE,
    (TOTAL_REVENUE*100.0/Grand_Total_Revenue) AS PER_CENT,
    SUM((TOTAL_REVENUE*100.0/Grand_Total_Revenue)) OVER(ORDER BY (TOTAL_REVENUE*100.0/Grand_Total_Revenue)
    DESC) AS CUM_PERCENT
FROM PARETO

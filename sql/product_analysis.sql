--------------------  PRODUCT ANALYSIS -----------------------
/*
This analysis focuses on evaluating product performance by identifying
top-selling categories, high-revenue products,pricing trends,and shipping costs.
The insights help understand which products drive business growth and support 
inventory and marketing decisions.
*/



SELECT product_category_name,
	COUNT(*) AS TOTAL_PRODUCTS
FROM products
GROUP BY product_category_name
ORDER BY TOTAL_PRODUCTS DESC
--Insight
--'cama_mesa_banho' has the highest number of products,making it the largest
--product category in the catalog
--The product catalog is concentrated in a few major categories



SELECT 
	P.product_category_name,
	ROUND(SUM(OI.price),2) AS TOTAL_REVENUE
FROM products AS P INNER JOIN order_items AS OI
ON P.product_id=OI.product_id 
GROUP BY P.product_category_name
ORDER BY TOTAL_REVENUE DESC
-- Insight:
-- The results show that only a few product categories are responsible for most of 
--the revenue
-- Promoting these categories and keeping them well-stocked may help boost
--overall sales



SELECT oi.product_id,
	p.product_category_name,
	COUNT(*) AS NO_OF_PRODUCT_SOLD
FROM order_items AS oi INNER JOIN products AS p 
ON p.product_id=oi.product_id
GROUP BY oi.product_id,p.product_category_name
ORDER BY NO_OF_PRODUCT_SOLD DESC
-- Insight:
--The products listed above were purchased the most by customers
--Keeping these products in stock can help meet customer demand 
--and avoid stock shortages



SELECT TOP 10
	P.product_category_name,
	ROUND(AVG(OI.price),2) AS average_price
FROM products AS P
JOIN order_items AS OI
    ON p.product_id = OI.product_id
GROUP BY P.product_category_name
ORDER BY average_price DESC;
--Insight
--Some categories have a much higher average selling price,
--indicating premium product segments



SELECT TOP 10
	OI.product_id,
	P.product_category_name,
	OI.price,
	COUNT(P.product_id) AS TOTAL_ORDERED
FROM order_items AS OI INNER JOIN products AS P
ON P.product_id=OI.product_id
GROUP BY OI.product_id,P.product_category_name,OI.price
ORDER BY OI.price DESC
--Insight
--Premium-priced products are purchased less often, but each sale
--generates higher revenue
--These products still make an important contribution to overall sales



SELECT TOP 10
    P.product_category_name,
    ROUND(AVG(OI.freight_value),2) AS average_freight
FROM order_items AS OI
JOIN products AS P
    ON OI.product_id = P.product_id
GROUP BY P.product_category_name
ORDER BY average_freight DESC
-- Insight:
-- Some product categories have higher average shipping costs than others
-- This could be because the products are larger, heavier, or require
--extra care during delivery



SELECT TOP 10
    P.product_category_name,
    ROUND(SUM(OI.price),2) AS total_revenue,
    ROUND(SUM(OI.freight_value),2) AS total_freight_cost
FROM order_items AS OI
JOIN products AS P
    ON OI.product_id = P.product_id
GROUP BY P.product_category_name
ORDER BY total_revenue DESC
--Insight
--By comparing revenue and freight costs, it's easier to identify
--which product categories are more cost-effective and which have 
--higher delivery expenses


SELECT product_id,
price 
FROM order_items
WHERE price>(
	SELECT AVG(price)
	FROM order_items)
ORDER BY price DESC
--Insight
--The products listed above are priced higher than the overall average,
--indicating they belong to the premium range of the product catalog
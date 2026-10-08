
-- TO SEE HOW MANY TABLES ARE THERE IN THE DATABASE
SELECT name FROM sys.tables;

-- VIEWING TOP 10 COLUMN OF EACH TABLE 
SELECT TOP 10 * FROM customers ;

SELECT TOP 10 * FROM order_items ;

SELECT TOP 10 * FROM order_payments; 

SELECT TOP 10 * FROM orders; 

SELECT TOP 10 * FROM products; 

-- CHECK THE ROW COUNTS
SELECT COUNT(*)AS TOTAL_ROWS FROM customers;
SELECT COUNT(*) AS TOTAL_ROWS FROM order_items;
SELECT COUNT(*) AS TOTAL_ROWS FROM order_payments;
SELECT COUNT(*) AS TOTAL_ROWS  FROM orders;
SELECT COUNT(*) AS TOTAL_ROWS FROM products;

-- CHECKING MISSING VALUES
SELECT * FROM customers WHERE customer_id IS NULL;

SELECT * FROM order_items WHERE  order_id IS NULL OR order_item_id IS NULL;

SELECT * FROM order_payments WHERE order_id IS NULL OR payment_sequential IS NULL;

SELECT * FROM orders WHERE order_id IS NULL;

SELECT * FROM products WHERE product_id IS NULL;

-- FINDING DUPLICATES VALUES 
SELECT customer_id,COUNT(*) AS DUPLICATE_COUNT FROM customers GROUP BY customer_id HAVING COUNT(*)>1;

SELECT order_id,order_item_id,count(*) FROM order_items GROUP BY order_id,order_item_id HAVING COUNT(*)>1;

SELECT order_id,payment_sequential,count(*) FROM order_payments GROUP BY order_id,payment_sequential HAVING COUNT(*)>1;

SELECT order_id,count(*) FROM orders GROUP BY order_id HAVING COUNT(*)>1;

SELECT product_id,count(*) FROM products GROUP BY product_id HAVING COUNT(*)>1;


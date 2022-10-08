/* Exercises */

-- 1. Refer to the data in Table 3.1. Write a query that returns all customer purchases of product
--- IDs 4 and 9.

SELECT
	product_id,
	product_name,
	product_category_id
FROM
	product
WHERE
	product_category_id = 1;

SELECT 
	*
FROM 
	customer_purchases;

SELECT
	*
FROM
	customer_purchases
WHERE
	product_id IN (4,9);
	
-- 2. Refer to the data in Table 3.1. Write two queries, one using two conditions with an AND
--- operator, and one using the BETWEEN operator, that will return all customer purchases
--- made from vendors with vendor IDs between 8 and 10 (inclusive)

SELECT
	*
FROM
	customer_purchases
WHERE
	vendor_id >= 8 AND vendor_id <= 10;
	
SELECT
	*
FROM
	customer_purchases
WHERE
	vendor_id BETWEEN 8 AND 10;
	
-- 3. Can you think of two different ways to change the final query in the chapter so it
--- would return purchases from days when it wasn'training?


SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity*cost_to_customer_per_qty AS price
FROM
	customer_purchases
WHERE
	market_date IN 
		(SELECT
			market_date
		FROM
			market_date_info
		WHERE
			market_rain_flag != 1) -- <> Would work as well
LIMIT 5;
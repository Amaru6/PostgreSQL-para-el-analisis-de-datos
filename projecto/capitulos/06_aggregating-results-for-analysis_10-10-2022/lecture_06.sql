/* Lecture 06 */

-- GROUP BY Syntax

SELECT
	market_date,
	customer_id
FROM
	customer_purchases
GROUP BY
	market_date, customer_id
ORDER BY 
	market_date, customer_id;

-- Displaying Group Summaries

/* Example 1 */
SELECT
	market_date,
	customer_id,
	COUNT(*) AS items_purchased
FROM 
	customer_purchases
GROUP BY 
	market_date, customer_id
ORDER BY
	market_date, customer_id
LIMIT 10;

/* Example 2 */

WITH sapo AS (SELECT
	market_date,
	customer_id,
	SUM(quantity) AS items_purchased
FROM
	customer_purchases
GROUP BY
	market_date, customer_id
ORDER BY
	market_date, customer_id
LIMIT 10)
	SELECT items_purchased
	FROM sapo;

/* Example 3 */

SELECT
	market_date,
	customer_id,
	COUNT(DISTINCT(product_id)) AS different_products_purchased
FROM
	customer_purchases
GROUP BY
	market_date, customer_id
ORDER BY
	market_date, customer_id
LIMIT 10;

/* Example 4 */

SELECT
	market_date,
	customer_id,
	SUM(quantity) AS items_purchased,
	COUNT(DISTINCT(product_id)) AS different_products_purchased
FROM
	customer_purchases
GROUP BY
	market_date, customer_id
ORDER BY
	market_date, customer_id;
	

-- Perfoming Calculations Inside Aggregate Functions

/* Example 1 */
SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity * cost_to_customer_per_qty AS price
FROM
	customer_purchases
WHERE
	customer_id = 3
ORDER BY
	market_date, vendor_id;
	
/* Example 2 */

SELECT
	customer_id,
	market_date,
	SUM(quantity*cost_to_customer_per_qty) AS total_spent
FROM	
	customer_purchases
WHERE
	customer_id = 3
GROUP BY
	market_date, customer_id
ORDER BY
	market_date;

/* Example 3 */

SELECT
	customer_id,
	vendor_id,
	SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM
	customer_purchases
WHERE
	customer_id = 3
GROUP BY
	customer_id, vendor_id
ORDER BY
	customer_id, vendor_id;
	
/* Example 4 */

SELECT
	customer_id,
	SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM
	customer_purchases
GROUP BY
	customer_id
ORDER BY
	customer_id;
	
/* Example 5 (Joins with aggregation) */

SELECT
	c.customer_first_name,
	c.customer_last_name,
	cp.customer_id,
	v.vendor_id,
	cp.quantity*cp.cost_to_customer_per_qty AS price
FROM
	customer c
LEFT JOIN customer_purchases cp
	ON c.customer_id = cp.customer_id
LEFT JOIN vendor v
	ON cp.vendor_id = v.vendor_id
WHERE
	cp.customer_id = 3
ORDER BY
	cp.customer_id, cp.vendor_id;

/* Example 5.2 (Joins with aggregation) */

SELECT
	c.customer_first_name,
	c.customer_last_name,
	cp.customer_id,
	v.vendor_name,
	cp.vendor_id,
	ROUND(SUM(quantity * cost_to_customer_per_qty), 2) AS total_spent
FROM
	customer c
	LEFT JOIN customer_purchases cp
		ON c.customer_id = cp.customer_id
	LEFT JOIN vendor v
		ON cp.vendor_id = v.vendor_id
WHERE
	cp.customer_id = 3
GROUP BY
	c.customer_first_name,
	c.customer_last_name,
	cp.customer_id,
	v.vendor_name,
	cp.vendor_id
ORDER BY
	cp.customer_id, cp.vendor_id;
	
-- MIN and MAX

/* Example 6 */

SELECT
	*
FROM
	vendor_inventory
ORDER BY
	original_price DESC
LIMIT 10;

SELECT
	MIN(original_price) AS minimum_price,
	MAX(original_price) AS maximum_price
FROM
	vendor_inventory;
	
/* Example 7 */

SELECT
	pc.product_category_name,
	p.product_category_id,
	MIN(vi.original_price) AS minimum_price,
	MAX(vi.original_price) AS maximum_price
FROM
	vendor_inventory vi
	INNER JOIN product p
		ON vi.product_id = p.product_id
	INNER JOIN product_category pc
		ON p.product_category_id = pc.product_category_id
GROUP BY
	pc.product_category_name, p.product_category_id;
	
-- COUNT and COUNT DISTINCT

/* Example 8 */

SELECT
	market_date,
	COUNT(product_id) AS product_count
FROM 
	vendor_inventory
GROUP BY
	market_date
ORDER BY
	market_date;
	
/* Example 9 */

SELECT
	vendor_id,
	COUNT(DISTINCT(product_id)) AS different_products_offered
FROM
	vendor_inventory
WHERE
	market_date BETWEEN '2020-03-02' AND '2020-03-16'
GROUP BY
	vendor_id
ORDER BY
	vendor_id;
	
/* Example 10 */

SELECT
	vendor_id,
	COUNT(DISTINCT(product_id)) AS different_products_offered,
	ROUND(AVG(original_price), 2)AS average_product_price
FROM
	vendor_inventory
WHERE
	market_date BETWEEN '2020-03-02' AND '2020-03-16'
GROUP BY
	vendor_id
ORDER BY
	vendor_id;

SELECT 
	*
FROM
	vendor_inventory
ORDER BY
	vendor_id;
	
-- Filtering with HAVING

SELECT
	vendor_id,
	COUNT(DISTINCT(product_id)) AS different_products_offered,
	SUM(quantity*original_price) AS value_of_inventory,
	SUM(quantity) AS inventory_item_count,
	SUM(quantity*original_price)/SUM(quantity) AS average_item_price
FROM
	vendor_inventory
WHERE
	market_date BETWEEN '2020-03-02' AND '2020-03-16'
GROUP BY
	vendor_id
HAVING
	SUM(quantity*original_price) >= 100 -- This will be evaluated FIRST instead of 'SELECT'
ORDER BY
	vendor_id;

-
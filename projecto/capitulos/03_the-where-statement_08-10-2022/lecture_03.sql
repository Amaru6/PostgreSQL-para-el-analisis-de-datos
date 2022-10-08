/* Lesson 3 */

-- Filtering SELECT Statement Results

/* Example 1 */
SELECT 
	product_id,
	product_name,
	product_category_id
FROM
	product
WHERE 
	product_category_id = 1
LIMIT 5;

/* Example 2 */

SELECT
	market_date,
	customer_id,
	vendor_id,
	product_id,
	quantity,
	ROUND(quantity*cost_to_customer_per_qty, 2) AS price
FROM 
	customer_purchases
WHERE 
	customer_id = 4
ORDER BY market_date, vendor_id, product_id
LIMIT 5;

-- Filtering on Multiple Conditions

/* Example 1 */

SELECT
	market_date,
	customer_id,
	vendor_id,
	product_id,
	quantity,
	quantity*cost_to_customer_per_qty AS price
FROM 
	customer_purchases
WHERE 
	customer_id = 3 OR customer_id = 4
ORDER BY
	market_date, customer_id, vendor_id, product_id
LIMIT 10;

/* Example 2 */

SELECT
	market_date,
	customer_id,
	vendor_id,
	product_id,
	quantity,
	quantity*cost_to_customer_per_qty AS price
FROM
	customer_purchases
WHERE 
	customer_id > 3 AND customer_id <= 5
ORDER BY
	market_date, customer_id, vendor_id, product_id
LIMIT 10;

/* Example 3 (Nice example) */

SELECT
	product_id,
	product_name
FROM 
	product
WHERE
	product_id = 10
	OR (product_id > 3 AND product_id < 8); -- It returns product_id = 10


SELECT
	product_id,
	product_name
FROM 
	product
WHERE
	(product_id = 10
	OR product_id > 3) AND product_id < 8; -- It doesn't return product_id = 10

-- Multi-Column Conditional Filtering

/* Example 1 */

SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity*cost_to_customer_per_qty AS price
FROM 
	customer_purchases
WHERE
	customer_id = 4 AND 
	vendor_id = 7;
	
/* Example 2 */

SELECT
	customer_id,
	customer_first_name,
	customer_last_name
FROM
	customer
WHERE
	customer_first_name = 'Carlos' OR
	customer_last_name = 'Diaz';

-- More Ways To Filter

/* BETWEEN */

SELECT 
	*
FROM 
	vendor_booth_assignments
WHERE 
	vendor_id = 7 AND
	market_date BETWEEN '2019-03-02' AND  '2019-03-16'
ORDER BY 
	market_date;
	
/* IN */

SELECT 
	customer_id,
	customer_first_name,
	customer_last_name
FROM
	customer
WHERE 
	customer_last_name IN ('Diaz', 'Edwards', 'Wilson')
ORDER BY
	customer_last_name, customer_first_name;

/* LIKE */

SELECT
	customer_id,
	customer_first_name,
	customer_last_name
FROM
	customer
WHERE 
	customer_first_name LIKE 'Jer%'; -- '%' Matches one or more characters
	
SELECT
	customer_id,
	customer_first_name,
	customer_last_name
FROM
	customer
WHERE 
	customer_first_name LIKE 'Jer_'; -- '%' Matches one character

/* IS NULL */

--- First example
SELECT
	*
FROM
	product
WHERE 
	product_size IS NULL;

--- Second examples
SELECT
	*
FROM 
	product
WHERE 
	product_size IS NULL OR
	TRIM(product_size) = '';

--- Third example
SELECT
	*
FROM
	product
WHERE 
	product_size IS NOT NULL;
	
-- Filtering Using SUBQUERIES

SELECT
	market_date, market_rain_flag
FROM
	market_date_info
WHERE
	market_rain_flag = 1;
	
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
		market_rain_flag = 1)
LIMIT 5;
/* Lesson 2 */

-- Selecting Columns and Limiting the Number of Rows Returned

SELECT * FROM product;

SELECT * FROM product LIMIT 5; -- Same in PostgreSQL as in MySQL

SELECT 
	product_id, 
	product_name 
FROM
	product
LIMIT 5;

-- The ORDER BY clause: Sorting Results

/* Example 1*/
SELECT
	product_id,
	product_name
FROM
	product
ORDER BY 
	product_name DESC
LIMIT 5;



/* Example 2*/

SELECT
	market_date,
	vendor_id,
	booth_number
FROM 
	vendor_booth_assignments
ORDER BY 
	market_date,
	vendor_id
LIMIT 5;

-- Introduction to Simple Inline Calculations

/* Example 1*/

SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity,
	cost_to_customer_per_qty
FROM customer_purchases
LIMIT 10;

SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity,
	cost_to_customer_per_qty,
	quantity*cost_to_customer_per_qty AS price
FROM
	customer_purchases
LIMIT 10;

/* Example 2*/

SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity,
	cost_to_customer_per_qty,
	ROUND(quantity*cost_to_customer_per_qty, 2) AS price
FROM
	customer_purchases
LIMIT 10;

-- More Inline Calculation Examples: Concatenating Strings

/* Example 1*/

SELECT 
	customer_id,
	UPPER(CONCAT(customer_first_name, ' ', customer_last_name)) AS customer_name 
FROM
	customer
LIMIT 5;

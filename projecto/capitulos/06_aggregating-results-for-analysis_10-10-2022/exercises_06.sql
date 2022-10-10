/* Exercises 6 */

-- 1. Write a query that determines how many times each vendor has rented a booth at the
--- farmer's market. In other words, count the vendor booth assignments per vendor_id

SELECT 
	vendor_id,
	COUNT(DISTINCT(booth_number))
FROM
	vendor_booth_assignments
GROUP BY
	vendor_id;
	
SELECT
	vendor_id,
	booth_number,
	COUNT(booth_number)
FROM
	vendor_booth_assignments
GROUP BY
	vendor_id, booth_number
ORDER BY
	vendor_id, booth_number;
	
-- 2. The farmer wants to give a bumper sticker to everyone who has ever spent more than $50 at the market
--- Write a query that geneates a list of customers for them to give stickers to, sorted by last name,
-- then first name.

SELECT
	cp.customer_id,
	c.customer_first_name,
	c.customer_last_name,
	SUM(quantity*cost_to_customer_per_qty) AS total_spent
FROM
	customer c
	LEFT JOIN
		customer_purchases cp
		ON
			c.customer_id = cp.customer_id
GROUP BY
	cp.customer_id,
	c.customer_first_name,
	c.customer_last_name
HAVING
	SUM(quantity*cost_to_customer_per_qty) > 50
ORDER BY
	c.customer_last_name, c.customer_first_name;
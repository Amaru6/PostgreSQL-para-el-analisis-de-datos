/* Exercises */

-- 1. 

SELECT 
	cp.*
	customer_id,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS customer_visit,
	DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date) AS customer_visit_2
FROM
	customer_purchases cp
ORDER BY
	customer_id; 
	
-- 2

SELECT
	cp.*,
	COUNT(*) OVER (PARTITION BY customer_id, product_id)
FROM
	customer_purchases cp;
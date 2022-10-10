/* Exercises */

-- 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the
--- vendor_id field they both have in cmmon, and sorts the result by vendor_name, then market_date

SELECT
	*
FROM
	vendor vr
INNER JOIN vendor_booth_assignments vba
	ON vr.vendor_id = vba.vendor_id
ORDER BY
	vendor_name, market_date;
	
-- 2. Is it possible to write a quety that produces an output identical to the output of the
--- following query, but using a LEFT JOIN instead of a RIGHT JOIN?

SELECT 
	*
FROM
	customer c
RIGHT JOIN customer_purchases cp
	ON c.customer_id = cp.customer_id;

--- As explained in the lecture notes you will only need to change the "order" of the query so that
--- customer_purchases appears first.



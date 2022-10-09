/* Exercises */

-- 1. Products can be sold by the individual unit or by bulk mesaures like lbs or oz. 
--- Write a query that outputs the 'product_id' and 'product_name' columns from the 'product' table,
--- and add a column called 'prod_qty_type_condensed' that display the word "unit" if the
--- 'product_qty_condensed' is "unit", and otherwise displays the word "bulk".

SELECT 
	product_id,
	product_name,
	CASE
		WHEN product_qty_type = 'unit' THEN 'unit'
		ELSE 'bulk'
	END AS product_qty_type_condensed
FROM
	product;

-- 2. We want to flag all of the different types of pepper products that are sold at the market.
--- Add a column to the previous qurty called 'peper_flag' that outputs a 1 if the product_name
--- contains the word "pepper" (regardless of capitalization), and otherwise outputs 0.

SELECT
	product_id,
	product_name,
	CASE
		WHEN product_qty_type = 'unit' THEN 'unit'
		ELSE 'bulk'
	END AS product_qty_type_condensed,
	CASE
		WHEN product_name ILIKE '%pepper%' THEN 1 -- 'ILIKE is PostgreSQL implementation'
		ELSE 0
	END AS pepper_flag
FROM
	product;

-- 3. Can you think of a situation when a pepper product might not get flagged as a pepper product
--- using the code from the previous exercise?

--- Since we are using the ILIKE instead of LIKE the possibilities of being wrong and not 
--- catching the rows containing "peppers" are reduced dramatically. However, it may be the case
--- that because of a human-error when entering the data, a row may be misspelled and 
--- won't get those rows.


/* CASE Statements */

-- CASE Statement Syntax

SELECT
	vendor_id,
	vendor_name,
	vendor_type,
	CASE 
		WHEN LOWER(vendor_type) LIKE '%fresh' THEN 'Fresh Produce'
		ELSE 'Other'
	END AS vendor_type_condensed -- Esto hace que sea más fácil de leer
FROM
	vendor;

-- Creating Binary Flags Using CASE

SELECT
	market_date,
	market_day
FROM 
	market_date_info
LIMIT 5;

SELECT
	market_date,
	market_day,
	CASE
		WHEN market_day = 'Saturday' OR market_day = 'Sunday' THEN 1
		ELSE 0
	END AS weekend_flag
FROM market_date_info
LIMIT 5;

-- Grouping or Binning Continuous Values Using CASE

/* Example 1 */
SELECT
	market_date,
	customer_id,
	vendor_id,
	ROUND(quantity*cost_to_customer_per_qty,2) AS price,
	CASE
		WHEN quantity*cost_to_customer_per_qty > 50 THEN 1
		ELSE 0
	END AS price_over_50
FROM customer_purchases
ORDER BY price DESC
LIMIT 10;

/* Example 2 */

SELECT
	market_date,
	customer_id,
	vendor_id,
	ROUND(quantity * cost_to_customer_per_qty, 2) AS price,
	CASE
		WHEN quantity * cost_to_customer_per_qty < 5 THEN 'Under $5'
		WHEN quantity * cost_to_customer_per_qty BETWEEN 5 AND 10 THEN '$5-$5.99'
		WHEN quantity * cost_to_customer_per_qty BETWEEN 11 AND 20 THEN '$11-$20'
		WHEN quantity * cost_to_customer_per_qty > 20 THEN '$20 UP'
		ELSE 'Other'
	END AS price_bin
FROM
	customer_purchases
LIMIT 10;

-- Categorical Encoding Using CASE

SELECT
	booth_number,
	booth_price_level,
	CASE
		WHEN booth_price_level = 'A' THEN 1
		WHEN booth_price_level = 'B' THEN 2
		WHEN booth_price_level = 'C' THEN 3
	END AS booth_price_level_numeric
FROM 
	booth
LIMIT 5;

--- One hot encoding:

SELECT
	vendor_id,
	vendor_name,
	vendor_type,
	CASE
		WHEN vendor_type = 'Arts & Jewelry' THEN 1
		ELSE 0
	END AS vendor_type_arts_jewelry,
	CASE 
		WHEN vendor_type = 'Eggs & Meats' THEN 1
		ELSE 0
	END AS vendor_type_eggs_meats,
	CASE 
		WHEN vendor_type = 'Fresh Focuses' THEN 1
		ELSE 0
	END AS vendor_type_fresh_focused,
	CASE
		WHEN vendor_type = 'Fresh Variety: Veggies & More' THEN 1
		ELSE 0
	END AS vendor_type_fresh_variety,
	CASE
		WHEN vendor_type = 'Prepared Foods' THEN 1
		ELSE 0
	END AS vendor_type_prepared
FROM
	vendor;
	

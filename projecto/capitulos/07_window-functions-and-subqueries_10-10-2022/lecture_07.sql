/* Lecture 7 */

-- ROW NUMBER

/* Example 1 */

SELECT
	vendor_id,
	MAX(original_price) AS highest_price
FROM
	vendor_inventory
GROUP BY
	vendor_id
ORDER BY 
	vendor_id;
	
SELECT
	vendor_id,
	market_date,
	product_id,
	original_price,
	ROW_NUMBER() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_rank
FROM
	vendor_inventory
ORDER BY
	vendor_id, original_price DESC;
	
	
WITH sapo AS (SELECT
	vendor_id,
	market_date,
	product_id,
	original_price,
	ROW_NUMBER() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_rank
FROM
	vendor_inventory
ORDER BY
	vendor_id, original_price DESC)
SELECT
	*
FROM
	sapo
WHERE
	price_rank = 1;
	
-- RANK and DENSE RANK

SELECT
	vendor_id,
	market_date,
	product_id,
	original_price,
	RANK() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_rank
FROM
	vendor_inventory
ORDER BY
	vendor_id, original_price DESC;
	
-- NTILE

SELECT
	vendor_id,
	market_date,
	product_id,
	original_price,
	NTILE(10) OVER (ORDER BY original_price DESC) AS price_ntile
FROM
	vendor_inventory
ORDER BY
	original_price DESC;
	
	
-- Aggregate Window Functions

SELECT
	vendor_id,
	market_date,
	product_id,
	original_price,
	ROUND(AVG(original_price) OVER (PARTITION BY market_date ORDER BY market_date),2) AS 
	average_cost_product
FROM
	vendor_inventory;
	
--- Additionnal WITH!

WITH sapo AS (SELECT
	vendor_id,
	market_date,
	product_id,
	original_price,
	ROUND(AVG(original_price) OVER (PARTITION BY market_date ORDER BY market_date),2) AS 
	average_cost_product
FROM
	vendor_inventory)
SELECT
	vendor_id, 
	original_price,
	average_cost_product,
	(original_price - average_cost_product) AS diff_var
FROM
	sapo
WHERE
	vendor_id = 4 
ORDER BY
	vendor_id;

--- Example 2

SELECT
	vendor_id,
	market_date,
	product_id,
	original_price,
	COUNT(product_id) OVER (PARTITION BY market_date, vendor_id) AS
	vendor_product_count_per_market_date
FROM
	vendor_inventory
ORDER BY
	vendor_id, market_date, original_price DESC;
	
--- Running totals!

SELECT
	customer_id,
	market_date,
	vendor_id,
	product_id,
	quantity*cost_to_customer_per_qty AS price,
	SUM(quantity*cost_to_customer_per_qty) OVER (ORDER BY market_date, transaction_time,
											customer_id, product_id) AS running_total_purchases
FROM
	customer_purchases;
	

-- LAG and LEAD

--- Example 1 
WITH sapo AS (SELECT
	market_date,
	vendor_id,
	booth_number,
	LAG(booth_number, 1) OVER (PARTITION BY vendor_id ORDER BY market_date, vendor_id) AS 
	previous_booth_number
FROM
	vendor_booth_assignments
ORDER BY
	vendor_id)
SELECT
	*
FROM
	sapo
WHERE
	booth_number - previous_booth_number != 0 OR
	previous_booth_number IS NULL
ORDER BY
	vendor_id;

--- Example 2
SELECT
	market_date,
	SUM(quantity*cost_to_customer_per_qty) AS market_date_total_sales,
	LAG(SUM(quantity*cost_to_customer_per_qty), 1) OVER (ORDER BY market_date) AS
	previous_market_date_total_sales
FROM
	customer_purchases
GROUP BY
	market_date;
	
-- More about WINDOW Functions

CREATE TABLE widget_companies(
	id bigserial,
	company varchar(30) NOT NULL,
	widget_output integer NOT NULL
);

INSERT INTO widget_companies (company, widget_output)
VALUES
	('Morse Widgets', 125000),
	('Springfield Widget Masters', 143000),
	('Best Widgets', 196000),
	('Acme Inc.', 133000),
	('District Widget Inc.', 201000),
	('Clarke Amalgamted', 244000),
	('Stavesacre Industries', 244000),
	('Bowers Widget Emporium', 201000);
	
SELECT
	wc.*,
	RANK() OVER (ORDER BY widget_output) AS ranking_sapal,
	DENSE_RANK() OVER (ORDER BY widget_output) AS ranking_sapal_2
FROM	
	widget_companies wc;
	
--- Ranking Within Subgroups with PARTITION BY

CREATE TABLE store_sales (
	store varchar(30),
	category varchar(30) NOT NULL,
	unit_sales bigint NOT NULL,
	CONSTRAINT store_category_key PRIMARY KEY (store, category)
);

INSERT INTO store_sales (store, category, unit_sales)
VALUES
	('Broders', 'Cereal', 1104),
	('Wallace', 'Ice Cream', 1863),
	('Broders', 'Ice Cream', 2517),
	('Cramers', 'Ice Cream', 2112),
	('Broders', 'Beer', 641),
	('Cramers', 'Cereal', 1003),
	('Cramers', 'Beer', 640),
	('Wallace', 'Cereal', 980),
	('Wallace', 'Beer', 988);
	
SELECT
	ss.*,
	RANK() OVER (PARTITION BY store ORDER BY unit_sales) AS ranking_sapal,
	ROUND(AVG(unit_sales) OVER (PARTITION BY store),2) AS media
FROM
	store_sales ss;
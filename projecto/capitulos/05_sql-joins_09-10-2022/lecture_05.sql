/* SQL JOINs */
-- 
-- JOIN Basics
--- You can think of joining tables in two steps:
--- 1. Display all combinations of rows in tables. (CROSS JOIN)
--- 2. Filter on the rows that have matching values.

-- TIP:
--- The LEFT JOIN is much more common than the RIGHT JOIN. If a RIGHT JOIN is needed, swap
--- the two tables within the FORM clause and do a LEFT JOIN instead.

/*---------------------------------*/
SELECT * FROM product;

SELECT 
	DISTINCT(product_id) 
FROM 
	product;

SELECT
	*
FROM
	product_category;
	
-- Database Relationships and SQL JOINs

/* Example 1 */
SELECT
	*
FROM
	product pt
LEFT JOIN	product_category pc
	ON pt.product_category_id = pc.product_category_id;
	
/* Example 2 */

SELECT
	pt.product_id,
	pt.product_name,
	pt.product_category_id AS product_prod_cat_id,
	pc.product_category_id AS category_prod_cat_id,
	pc.product_category_name
FROM
	product pt
LEFT JOIN product_category pc
	ON pt.product_category_id = pc.product_category_id;
	
/* Example 3 */

SELECT
	*
FROM
	customer c
LEFT JOIN customer_purchases cp
	ON c.customer_id = cp.customer_id;
	

/* Example 4 */

SELECT 
	c.*
FROM 
	customer c
LEFT JOIN customer_purchases cp
	ON c.customer_id = cp.customer_id
WHERE cp.customer_id IS NULL;

/* Example 5 */

SELECT
	*
FROM
	customer c
RIGHT JOIN customer_purchases cp
	ON c.customer_id = cp.customer_id;
	
/* Example 6 */

SELECT 
	customer_id
FROM
	customer_purchases
WHERE
	customer_id IS NOT NULL;
	
-- A Common Pitfall when Filtering Joined Data

SELECT 
	*
FROM 
	customer c
LEFT JOIN customer_purchases cp
	ON c.customer_id = cp.customer_id
WHERE cp.market_date <> '2019-03-02';

SELECT 
	*
FROM 
	customer c
LEFT JOIN customer_purchases cp
	ON c.customer_id = cp.customer_id
WHERE cp.market_date <> '2019-03-02' OR cp.market_date IS NULL;

SELECT
	DISTINCT(c.*)
FROM
	customer c
LEFT JOIN customer_purchases cp	
	ON c.customer_id = cp.customer_id
WHERE cp.market_date <> '2019-03-02' OR cp.market_date IS NULL;


/* Understanding */
create table product_catalog (title varchar(100), isbn varchar(100));
create table order_item (id_order_item int, isbn varchar(100), price decimal (10,2));

insert into product_catalog values ('The Wayfinders', '978-0887847660');
insert into product_catalog values ('One River', '978-0684834962');
insert into product_catalog values ('Shadows in the Sun', '978-1597263924');

insert into order_item values (1, '978-0887847660', 12.99);
insert into order_item values (2, '978-0684834962', 9.99);

SELECT * 
FROM	product_catalog;

SELECT 
*
FROM 
	product_catalog pc
LEFT JOIN order_item oi
	ON pc.isbn = oi.isbn;
	
SELECT
*
FROM
	product_catalog pc
LEFT JOIN order_item oi
	ON pc.isbn = oi.isbn AND oi.price > 10;

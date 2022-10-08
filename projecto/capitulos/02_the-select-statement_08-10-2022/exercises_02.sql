/* Exercises */

-- 1. Write a query that returns everything in the customer table

SELECT * FROM customer;

-- 2. Write a query that display all of the columns and 10 rows from the customer table, 
--- sorted by customer_last_name, then customer_first_name

SELECT * FROM customer ORDER BY customer_last_name, customer_first_name LIMIT 10;

-- 3. Write a query that lists all customer IDs and first names in the customer table,
--- sorted by first_name

SELECT customer_id, customer_first_name FROM customer ORDER BY customer_first_name;
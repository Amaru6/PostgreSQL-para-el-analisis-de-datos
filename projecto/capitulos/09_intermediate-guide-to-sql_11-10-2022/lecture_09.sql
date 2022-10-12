/* Intermediate guide to SQL */

-- Different types of JOINs
CREATE TABLE favourite_colours
(friend varchar(50),
 colour varchar(50)
	);
	
INSERT INTO favourite_colours (friend, colour)
	VALUES ('Rachel DeSantos', 'blue'),
			('Sujin Lee', 'green'),
			('Najil Okoro', 'red'),
			('John Anderson', 'orange');
			
SELECT
	*
FROM
	favourite_colours;

CREATE TABLE favourite_movies
(friend varchar(50),
 movie varchar(50)
	);

INSERT INTO favourite_movies(friend, movie)
	VALUES ('Rachel DeSantos', 'Avengers'),
		   ('Sujin Lee', 'Despicable Me'),
		   ('Najil Okoro', 'Frozen');

SELECT
	*
FROM
	favourite_movies;
	
--- 

SELECT
	fc.*,
	fm.*
FROM
	favourite_colours fc
	INNER JOIN favourite_movies fm 
		ON fc.friend = fm.friend;
		
---

SELECT
	fc.*,
	fm.*
FROM
	favourite_colours fc
	LEFT JOIN favourite_movies fm
		ON fc.friend = fm.friend;

-- Aggregators like SUM() and COUNT()

CREATE TABLE purchase_table(
name varchar(25),
tickets int
);

INSERT INTO purchase_table
	VALUES ('Rachel DeSantos', 3),
		   ('Sujin Lee', 2),
		   ('Najil Okoro', 2);
	
SELECT
	* 
FROM
	purchase_table;
	
SELECT
	SUM(tickets) AS total_tickets,
	COUNT(tickets) AS number_of_purchases,
	SUM(DISTINCT(tickets)) AS total_distinct_tickets, -- Not very useful, btw!
	COUNT(DISTINCT(tickets)) AS  number_of_distinct_purchases
FROM
	purchase_table;
	
-- Using GROUP BY with aggregators

CREATE TABLE purchase_table_2(
occasion varchar(20),
name varchar(25),
tickets int
);

INSERT INTO purchase_table_2(occasion, name, tickets) 
	VALUES ('fun', 'Rachel DeSantos', 5),
		   ('date', 'Sujin Lee', 2),
		   ('date', 'Najil Okoro', 2),
		   ('fun', 'John Anderson', 3);
		   
SELECT
	occasion,
	SUM(tickets) AS total_tickets,
	COUNT(tickets) AS number_of_purchases
FROM
	purchase_table_2
GROUP BY
	occasion;
	
--- Which is the same AS:

SELECT
	occasion,
	SUM(tickets) AS total_tickets,
	COUNT(tickets) AS number_of_purchases
FROM
	purchase_table_2
GROUP BY
	1;

-- When to use HAVING
SELECT
	*
FROM 
	purchase_table_2;
	

SELECT
	occasion,
	SUM(tickets) AS total_tickets,
	COUNT(tickets) AS number_of_purchases
FROM
	purchase_table_2
GROUP BY
	1
HAVING
	SUM(tickets) > 5;

--- Subqueries to the rescue

SELECT
	*
FROM
	purchase_table_2
INNER JOIN
	(SELECT 
	 	occasion
	 FROM
	 	purchase_table_2
	 GROUP BY 
	 	occasion
	 HAVING SUM(tickets) > 5
		) AS subquery_1
	ON purchase_table_2.occasion = subquery_1.occasion;


-- Using ORDER BY to organize your results

SELECT
	*
FROM
	purchase_table
ORDER BY
	tickets ASC;
	
-- CASE statements

CREATE TABLE movie_theater(
genre varchar(25),
movie_title varchar(25)
);

INSERT INTO movie_theater(genre, movie_title)
	VALUES ('horror', 'Silence of the Lambs'),
		   ('comedy', 'Jumanji'),
		   ('family', 'Frozen 2'),
		   ('documentary', '13th');
		   
WITH sapo AS (SELECT
	CASE
		WHEN genre = 'horror' THEN 'will not watch'
		ELSE 'will watch'
		END AS watch_category	
FROM
	movie_theater)
SELECT
	watch_category,
	COUNT(*)
FROM
	sapo 
GROUP BY
	1;
	
-- TEMPORARY tables

CREATE TEMP TABLE example_table
AS
SELECT
	colour
FROM
	favourite_colours;

CREATE TEMP TABLE tickets_by_occasion
AS
SELECT
	occasion,
	SUM(tickets) AS total_tickets,
	COUNT(tickets) AS number_of_purchases
FROM
	purchase_table_2
GROUP BY
	occasion;
	
SELECT
	occasion,
	total_tickets,
	number_of_purchases
FROM
	tickets_by_occasion
WHERE
	total_tickets > 5;

--- This makes more sense sense when working with individual rows
--- since WHERE is evaluated BEFORE SELECT and GROUP BY. 

/* Exercises 08 */

-- 1. PRACTICAL SQL Chapter 11 question 1.

WITH sapo_3 AS (WITH sapo_2 AS (WITH sapo AS (SELECT
	trip_id,
	(tpep_dropoff_datetime - tpep_pickup_datetime) AS length_trip
FROM
	nyc_yellow_taxi_trips_2016_06_01
ORDER BY
	length_trip DESC)
SELECT
	trip_id,
	EXTRACT(hour FROM length_trip),
	length_trip
FROM
	sapo)
SELECT
	CASE
		WHEN extract > 10 THEN 1
		WHEN extract < 10 THEN 0
	END AS new_variable
FROM
	sapo_2)
SELECT
	new_variable,
	COUNT(*)
FROM
	sapo_3 
GROUP BY
	new_variable;



/* Lecture */

/* GETTING THE DATA */
CREATE TABLE us_counties_2010 (
    geo_name varchar(90),                    -- Name of the geography
    state_us_abbreviation varchar(2),        -- State/U.S. abbreviation
    summary_level varchar(3),                -- Summary Level
    region smallint,                         -- Region
    division smallint,                       -- Division
    state_fips varchar(2),                   -- State FIPS code
    county_fips varchar(3),                  -- County code
    area_land bigint,                        -- Area (Land) in square meters
    area_water bigint,                        -- Area (Water) in square meters
    population_count_100_percent integer,    -- Population count (100%)
    housing_unit_count_100_percent integer,  -- Housing Unit count (100%)
    internal_point_lat numeric(10,7),        -- Internal point (latitude)
    internal_point_lon numeric(10,7),        -- Internal point (longitude)

    -- This section is referred to as P1. Race:
    p0010001 integer,   -- Total population
    p0010002 integer,   -- Population of one race:
    p0010003 integer,       -- White Alone
    p0010004 integer,       -- Black or African American alone
    p0010005 integer,       -- American Indian and Alaska Native alone
    p0010006 integer,       -- Asian alone
    p0010007 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0010008 integer,       -- Some Other Race alone
    p0010009 integer,   -- Population of two or more races
    p0010010 integer,   -- Population of two races:
    p0010011 integer,       -- White; Black or African American
    p0010012 integer,       -- White; American Indian and Alaska Native
    p0010013 integer,       -- White; Asian
    p0010014 integer,       -- White; Native Hawaiian and Other Pacific Islander
    p0010015 integer,       -- White; Some Other Race
    p0010016 integer,       -- Black or African American; American Indian and Alaska Native
    p0010017 integer,       -- Black or African American; Asian
    p0010018 integer,       -- Black or African American; Native Hawaiian and Other Pacific Islander
    p0010019 integer,       -- Black or African American; Some Other Race
    p0010020 integer,       -- American Indian and Alaska Native; Asian
    p0010021 integer,       -- American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
    p0010022 integer,       -- American Indian and Alaska Native; Some Other Race
    p0010023 integer,       -- Asian; Native Hawaiian and Other Pacific Islander
    p0010024 integer,       -- Asian; Some Other Race
    p0010025 integer,       -- Native Hawaiian and Other Pacific Islander; Some Other Race
    p0010026 integer,   -- Population of three races
    p0010047 integer,   -- Population of four races
    p0010063 integer,   -- Population of five races
    p0010070 integer,   -- Population of six races

    -- This section is referred to as P2. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    p0020001 integer,   -- Total
    p0020002 integer,   -- Hispanic or Latino
    p0020003 integer,   -- Not Hispanic or Latino:
    p0020004 integer,   -- Population of one race:
    p0020005 integer,       -- White Alone
    p0020006 integer,       -- Black or African American alone
    p0020007 integer,       -- American Indian and Alaska Native alone
    p0020008 integer,       -- Asian alone
    p0020009 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0020010 integer,       -- Some Other Race alone
    p0020011 integer,   -- Two or More Races
    p0020012 integer,   -- Population of two races
    p0020028 integer,   -- Population of three races
    p0020049 integer,   -- Population of four races
    p0020065 integer,   -- Population of five races
    p0020072 integer,   -- Population of six races

    -- This section is referred to as P3. RACE FOR THE POPULATION 18 YEARS AND OVER
    p0030001 integer,   -- Total
    p0030002 integer,   -- Population of one race:
    p0030003 integer,       -- White alone
    p0030004 integer,       -- Black or African American alone
    p0030005 integer,       -- American Indian and Alaska Native alone
    p0030006 integer,       -- Asian alone
    p0030007 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0030008 integer,       -- Some Other Race alone
    p0030009 integer,   -- Two or More Races
    p0030010 integer,   -- Population of two races
    p0030026 integer,   -- Population of three races
    p0030047 integer,   -- Population of four races
    p0030063 integer,   -- Population of five races
    p0030070 integer,   -- Population of six races

    -- This section is referred to as P4. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    -- FOR THE POPULATION 18 YEARS AND OVER
    p0040001 integer,   -- Total
    p0040002 integer,   -- Hispanic or Latino
    p0040003 integer,   -- Not Hispanic or Latino:
    p0040004 integer,   -- Population of one race:
    p0040005 integer,   -- White alone
    p0040006 integer,   -- Black or African American alone
    p0040007 integer,   -- American Indian and Alaska Native alone
    p0040008 integer,   -- Asian alone
    p0040009 integer,   -- Native Hawaiian and Other Pacific Islander alone
    p0040010 integer,   -- Some Other Race alone
    p0040011 integer,   -- Two or More Races
    p0040012 integer,   -- Population of two races
    p0040028 integer,   -- Population of three races
    p0040049 integer,   -- Population of four races
    p0040065 integer,   -- Population of five races
    p0040072 integer,   -- Population of six races

    -- This section is referred to as H1. OCCUPANCY STATUS
    h0010001 integer,   -- Total housing units
    h0010002 integer,   -- Occupied
    h0010003 integer    -- Vacant
);

COPY us_counties_2010
FROM 'D:\learning\02_sql-for-data-scientist\projecto\datos\us_counties_2010.csv'
WITH (FORMAT CSV, header);

SELECT * FROM us_counties_2010;

---
-- Basic SUBQUERY
SELECT
	geo_name,
	state_us_abbreviation,
	p0010001
FROM
	us_counties_2010
WHERE
	p0010001 >= (
	SELECT percentile_cont(.9) WITHIN GROUP (ORDER BY p0010001)
	FROM us_counties_2010 
	)
ORDER BY 
	p0010001 DESC;
	
	
WITH tabla_sapo AS (
SELECT
	geo_name,
	state_us_abbreviation,
	p0010001
FROM
	us_counties_2010
WHERE
	p0010001 >= (
	SELECT percentile_cont(.9) WITHIN GROUP (ORDER BY p0010001)
	FROM us_counties_2010 
	)
ORDER BY 
	p0010001 DESC
)
SELECT 
	COUNT(*)
FROM
	tabla_sapo;

-- Common table expresions are more readable than subqueries if you ask me.
/* Example 1 */
WITH tabla_sapal AS (
SELECT
	avg(p0010001) AS average,
	CAST(percentile_cont(.5) WITHIN GROUP (ORDER BY p0010001) AS numeric)AS median
FROM
	us_counties_2010)
SELECT
	ROUND(average, 0) AS average,
	median,
	ROUND(average - median, 0) AS median_average_diff
FROM
	tabla_sapal;

/* Example 2 */

-- First needed to create the table itself!

CREATE TABLE meat_poultry_egg_inspect(
est_number varchar(50) CONSTRAINT est_number_key PRIMARY KEY,
company varchar(100),
street varchar(100),
city varchar(30),
st varchar(2),
zip varchar(5),
phone varchar(14),
grant_date date,
activities text,
dbas text
);

COPY meat_poultry_egg_inspect
FROM
	'D:\learning\02_sql-for-data-scientist\projecto\datos\MPI_Directory_by_Establishment_Name.csv'
WITH
	(FORMAT CSV, HEADER, DELIMITER ',');
	
--- As I said before, CTEs are more readable and they can manage more than one table!
-- So, we can use it when we perform two aggregations before joining. 

WITH 
	sapo_1 AS (
		SELECT
			state_us_abbreviation AS st,
			SUM(population_count_100_percent) AS population
		FROM
			us_counties_2010
		GROUP BY state_us_abbreviation
	),
	sapo_2 AS (
		SELECT
			st,
			COUNT(*) AS plants
		FROM
			meat_poultry_egg_inspect
		GROUP BY
			st
	)
SELECT
	sapo_1.st,
	population,
	plants,
	ROUND(CAST(plants/population AS NUMERIC(10,1))*1000000, 1) AS per_million
FROM
	sapo_1 
	INNER JOIN sapo_2
		ON sapo_1.st = sapo_2.st
ORDER BY
	per_million DESC;
	
	
/* Using CASE in a Common Table Expresion (CTE) */
-- Tabla 1 
CREATE TABLE ice_cream_survey(
response_id integer PRIMARY KEY,
office varchar(20),
flavor varchar(20)
);

COPY ice_cream_survey(response_id, office, flavor)
FROM 'D:\learning\02_sql-for-data-scientist\projecto\datos\ice_cream_survey.csv'
WITH (FORMAT CSV, HEADER);

-- Tabla 2
CREATE TABLE temperature_readings(
reading_id bigserial,
station_name varchar(50),
observation_date date,
max_temp integer,
min_temp integer
);

COPY temperature_readings (station_name, observation_date, max_temp, min_temp)
FROM
	'D:\learning\02_sql-for-data-scientist\projecto\datos\temperature_readings.csv'
WITH (FORMAT CSV, HEADER);

-- Queries

WITH sapo_1 (station_name, max_temperature_group) AS ( SELECT
	station_name,
	CASE 
		WHEN max_temp >= 90 THEN 'Hot'
		WHEN max_temp BETWEEN 70 AND 89 THEN 'Warm'
		WHEN max_temp BETWEEN 50 AND 69 THEN 'Pleasant'
		WHEN max_temp BETWEEN 33 AND 49 THEN 'Cold'
		WHEN max_temp BETWEEN 20 AND 32 THEN 'Freezing'
		ELSE 'Inhumane'
	END
FROM
	temperature_readings)
SELECT
	station_name, max_temperature_group, COUNT(*)
FROM
	sapo_1
GROUP BY
	station_name, max_temperature_group
ORDER BY
	station_name, COUNT(*) DESC;



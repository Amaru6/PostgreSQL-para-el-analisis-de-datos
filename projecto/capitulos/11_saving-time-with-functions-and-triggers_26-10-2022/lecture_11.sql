/* Saving time with views, functions and triggers */
-- VIEWS

SELECT	
	table_name
FROM
	information_schema.views
WHERE
	table_schema NOT IN
		('information_schema', 'pg_catalog');
		
--- It seems like VIEWs are useful when we don't want to write the code over and over again
--- to use the result of a query(Let's say it's a query with various expressions and predicates!)

CREATE VIEW nevada_counties_pop_2010 AS
SELECT
	geo_name,
	state_fips,
	county_fips,
	p0010001 AS pop_2010
FROM
	us_counties_2010
WHERE
	state_us_abbreviation = 'NV'
ORDER BY county_fips;

-- Now we can use the VIEW as any other table!
SELECT
	*
FROM
	nevada_counties_pop_2010
LIMIT 5;


-- 
--- Create a table called 'employees' and a table called 'departments'

CREATE TABLE departments(
dept_id bigserial,
dept varchar(100),
city varchar(100),
CONSTRAINT dept_key PRIMARY KEY (dept_id),
CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees(
emp_id bigserial,
first_name varchar(100),
last_name varchar(100),
salary integer,
dept_id integer REFERENCES departments (dept_id),
CONSTRAINT emp_key PRIMARY KEY(emp_id),
CONSTRAINT emp_dept_unique UNIQUE(emp_id, dept_id)
);

INSERT INTO departments (dept, city)
VALUES
	('Tax', 'Atlanta'),
	('IT', 'Boston');
	
INSERT INTO employees (first_name, last_name, salary, dept_id)
VALUES
	('Nancy', 'Jones', 62500, 1),
	('Lee', 'Smith', 59300, 1),
	('Soo', 'Nguyen', 83000, 2),
	('Janet', 'King', 95000, 2);
	
----
CREATE  VIEW employees_tax_dept AS
SELECT
	emp_id,
	first_name,
	last_name,
	dept_id
FROM
	employees
WHERE
	dept_id = 1
ORDER BY emp_id
WITH LOCAL CHECK OPTION;

---- Insert rows using the employees_tax_dept View

INSERT INTO employees_tax_dept (first_name, last_name, dept_id)
VALUES ('Suzanne', 'Legere', 1);

SELECT
	*
FROM
	employees_tax_dept;

SELECT
	*
FROM
	employees; -- Updating the view also updated the underlying table :0
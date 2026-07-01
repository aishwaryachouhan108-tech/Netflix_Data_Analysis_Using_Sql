CREATE TABLE netflix (
    show_id VARCHAR(10),
    type VARCHAR(20),
    title TEXT,
    director TEXT,
    casts TEXT,
    country TEXT,
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(20),
    listed_in TEXT,
    description TEXT
);
SELECT*FROM netflix

SELECT director
FROM netflix
LIMIT 5;

Q3.View only the director column.
SELECT director
FROM netflix
LIMIT 5;

Q4.Check the date_added formate
SELECT date_added
FROM Netflix
LIMIT 10;

Q5.Check the duration format
SELECT DISTINCT duration
FROM Netflix
LIMIT 10;

Q6.Count Movies vs TV Shows.
SELECT
  type,
COUNT(*)AS total_titles
FROM Netflix
GROUP BY type;


SELECT
   date_added
FROM netflix
LIMIT 10;

SELECT
   EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY'))
   AS year_added,
       COUNT(*) AS total_year
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;

SELECT DISTINCT duration
FROM netflix
LIMIT 10;

SELECT 
   title,
   duration
FROM netflix
WHERE type = 'Movie'
AND CAST(REPLACE(duration,'min', '') AS INTEGER) > 120
ORDER BY CAST(REPLACE(duration,'min', '') AS INTEGER) DESC;

SELECT
    release_year,
    COUNT(*) AS total_movies
FROM netflix
WHERE type = 'Movie'
GROUP BY release_year
ORDER BY total_movies DESC;

SELECT
    show_id,
	COUNT(*) AS duplicate_count
FROM netflix
GROUP BY shoW_id
HAVING COUNT(*) >1;

SELECT
    COUNT(*) AS blank_director
FROM netflix
WHERE TRIM(director) = '';

SELECT
    title,
	release_year,
	CASE
	    WHEN release_year >= 2020 THEN 
		 'Recent content'
		 WHEN release_year >= 2000 THEN 'Modern'
		 
		 ELSE 'Classic'
	END AS content_category
FROM netflix
LIMIT 10;

SELECT 
    MIN(CAST(REPLACE(duration, 'min','')AS INTEGER)) AS shortest_movie,
	MAX(CAST(REPLACE(duration, 'min', '') AS INTEGER)) AS longest_movie,
	AVG(CAST(REPLACE(duration, 'min', '') AS INTEGER)) AS Average_movie
FROM netflix
WHERE type = 'Movie';

SELECT 
    title,
	duration
FROM netflix
WHERE type = 'Movie'
AND CAST(REPLACE(duration, 'min', '') AS INTEGER)>
(
SELECT 
   AVG(CAST(REPLACE(duration, 'min','')AS INTEGER))
   FROM netflix
   WHERE type = 'Movie'
   );

WITH long_movies AS
(
 SELECT
     title,
	 duration
 FROM netflix
 WHERE type = 'Movie'
 AND CAST(REPLACE(duration, 'min', '')AS INTEGER) > 150
 )
 SELECT * FROM long_movies;

 SELECT
    title,
	release_year,
	ROW_NUMBER() OVER (ORDER BY release_year DESC) AS row_num
	FROM netflix
	WHERE type = 'Movie'
	LIMIT 10;
--data cleaning

--Q1.Check Missing Values in director.
SELECT COUNT(*) AS missing_director
FROM netflix
WHERE director IS NULL;

--Q2.Check Missing Values in country.
SELECT COUNT(*) AS missing_country
FROM netflix
WHERE country IS NULL;

--Q3.Check Missing Values in date_added.
SELECT COUNT(*) AS missing_date_added
FROM netflix
WHERE date_added IS NULL;

Q4.Check Duplicate Records.
SELECT
    show_id,
    COUNT(*) AS duplicate_count
FROM netflix
GROUP BY show_id
HAVING COUNT(*) > 1;

Q5.Check Blank Values in director.
SELECT COUNT(*) AS blank_director
FROM netflix
WHERE TRIM(director) = '';

Q6.Convert date_added into a Date (Transformation Example).
SELECT
    date_added,
    TO_DATE(date_added, 'Month DD, YYYY') AS converted_date
FROM netflix
WHERE date_added IS NOT NULL
LIMIT 10;

Q7.Remove " min" from Duration (Transformation Example).
SELECT
    duration,
    REPLACE(duration, ' min', '') AS duration_without_text
FROM netflix
WHERE type = 'Movie'
LIMIT 10;

Q8.Convert Duration to Integer.
SELECT
    duration,
    CAST(REPLACE(duration, ' min', '') AS INTEGER) AS duration_minutes
FROM netflix
WHERE type = 'Movie'
LIMIT 10;

Q1.Categorize Netflix content into Old and Recent Content.
SELECT
    title,
    release_year,
    CASE
        WHEN release_year >= 2020 THEN 'Recent Content'
        ELSE 'Old Content'
    END AS content_category
FROM netflix
LIMIT 10;


Q2.Categorize content into Classic, Modern and Recent.
SELECT
    title,
    release_year,
    CASE
        WHEN release_year < 2000 THEN 'Classic'
        WHEN release_year BETWEEN 2000 AND 2019 THEN 'Modern'
        ELSE 'Recent'
    END AS content_category
FROM netflix;


Q3.Find the shortest and longest movie on Netflix.
SELECT
    MIN(CAST(REPLACE(duration, ' min', '') AS INTEGER)) AS shortest_movie,
    MAX(CAST(REPLACE(duration, ' min', '') AS INTEGER)) AS longest_movie
FROM netflix
WHERE type = 'Movie';


Q4.Find the average movie duration.
SELECT
    AVG(CAST(REPLACE(duration, ' min', '') AS INTEGER)) AS average_duration
FROM netflix
WHERE type = 'Movie';


Q5.Find movies longer than the average movie duration.
SELECT
    title,
    duration
FROM netflix
WHERE type = 'Movie'
AND CAST(REPLACE(duration, ' min', '') AS INTEGER) >
(
    SELECT
        AVG(CAST(REPLACE(duration, ' min', '') AS INTEGER))
    FROM netflix
    WHERE type = 'Movie'
);


Q6.Find movies longer than 150 minutes using a CTE.
WITH long_movies AS
(
    SELECT
        title,
        duration
    FROM netflix
    WHERE type = 'Movie'
    AND CAST(REPLACE(duration, ' min', '') AS INTEGER) > 150
)

SELECT *
FROM long_movies;


Q7.Assign a row number to each movie based on release year.
SELECT
    title,
    release_year,
    ROW_NUMBER() OVER (ORDER BY release_year DESC) AS row_num
FROM netflix
WHERE type = 'Movie'
LIMIT 10;

Q1.Categorize Netflix content into Old and Recent Content.
SELECT
    title,
    release_year,
    CASE
        WHEN release_year >= 2020 THEN 'Recent Content'
        ELSE 'Old Content'
    END AS content_category
FROM netflix
LIMIT 10;


Q2.Categorize content into Classic, Modern and Recent.
SELECT
    title,
    release_year,
    CASE
        WHEN release_year < 2000 THEN 'Classic'
        WHEN release_year BETWEEN 2000 AND 2019 THEN 'Modern'
        ELSE 'Recent'
    END AS content_category
FROM netflix;


Q3.Find the shortest and longest movie on Netflix.
SELECT
    MIN(CAST(REPLACE(duration, ' min', '') AS INTEGER)) AS shortest_movie,
    MAX(CAST(REPLACE(duration, ' min', '') AS INTEGER)) AS longest_movie
FROM netflix
WHERE type = 'Movie';


Q4.Find the average movie duration.
SELECT
    AVG(CAST(REPLACE(duration, ' min', '') AS INTEGER)) AS average_duration
FROM netflix
WHERE type = 'Movie';


Q5.Find movies longer than the average movie duration.
SELECT
    title,
    duration
FROM netflix
WHERE type = 'Movie'
AND CAST(REPLACE(duration, ' min', '') AS INTEGER) >
(
    SELECT
        AVG(CAST(REPLACE(duration, ' min', '') AS INTEGER))
    FROM netflix
    WHERE type = 'Movie'
);


Q6.Find movies longer than 150 minutes using a CTE.
WITH long_movies AS
(
    SELECT
        title,
        duration
    FROM netflix
    WHERE type = 'Movie'
    AND CAST(REPLACE(duration, ' min', '') AS INTEGER) > 150
)

SELECT *
FROM long_movies;


Q7.Assign a row number to each movie based on release year.
SELECT
    title,
    release_year,
    ROW_NUMBER() OVER (ORDER BY release_year DESC) AS row_num
FROM netflix
WHERE type = 'Movie'
LIMIT 10;
















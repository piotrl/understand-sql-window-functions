/**
 * What is window in `window functions`
 */

-- region step 1) Employee progress

SELECT
  fullname,
  fiscalyear
FROM sales.vsalespersonsalesbyfiscalyearsdata person_sales;

-- Note: ORDER BY is independent from the OVER

SELECT
  fullname,
  salestotal,
  fiscalyear,
  salestotal - lag(salestotal) OVER (PARTITION BY fullname) AS diff
FROM sales.vsalespersonsalesbyfiscalyearsdata person_sales;

-- endregion











-- region Time series chart

-- region    Q: How to write it without lag / lead?
-- endregion A: you have to hardcode subtraction

SELECT
  lag(date) OVER () AS previous,
  date    AS current
FROM generate_series(:from, :to, '1 week') date;

-- endregion










-- region step 2) Employee progress - variance from norm

SELECT
  fullname,
  salestotal,
  fiscalyear,
  salestotal - lag(salestotal) OVER (PARTITION BY fullname ORDER BY fiscalyear) AS diff_prev_year,
  salestotal - avg(salestotal) OVER (PARTITION BY fiscalyear) AS diff_from_avg
FROM sales.vsalespersonsalesbyfiscalyearsdata
ORDER BY fullname, fiscalyear;

SELECT
  fiscalyear,
  avg(salestotal)
FROM sales.vsalespersonsalesbyfiscalyearsdata
GROUP BY fiscalyear;

-- endregion














-- region Random order + keep original row

-- region Q: Use cases?
--        A: ads, random data verification, assigning tasks to people, test data generator
-- endregion

SELECT DISTINCT ON (fullname)
  fullname,
  fiscalyear,
  salestotal,
  ROW_NUMBER() OVER(PARTITION BY fullname ORDER BY salestotal) AS original_order
FROM sales.vsalespersonsalesbyfiscalyearsdata person_sales
ORDER BY fullname, RANDOM();

-- endregion












-- region LAG: Removing duplicates

SELECT
  letter,
  lag(letter) OVER (PARTITION BY letter)
  IS NOT NULL AS to_remove
FROM regexp_split_to_table('a a a b c c d e', E'\\s+') letter

-- endregion
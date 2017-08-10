-- region Terminology - framing
/*

col|
---|
 0 | -     <--   UNBOUNDED PRECEDING (first row)
 1 |
 2 | ...
 3 | -     <-- 2 PRECEDING
 4 | -     <-- 1 PRECEDING
 5 | -     <--   CURRENT ROW
 6 | -     <-- 1 FOLLOWING
 7 | -     <-- 2 FOLLOWING
 8 | ...
 9 | -     <--   UNBOUNDED FOLLOWING (last row)
 --|
10 | -     <--   UNBOUNDED PRECEDING (first row)
11 |
12 | ...
13 | -     <-- 2 PRECEDING
14 | -     <-- 1 PRECEDING
15 | -     <--   CURRENT ROW
16 | -     <-- 1 FOLLOWING
17 | -     <-- 2 FOLLOWING
18 | ...
19 | -     <--   UNBOUNDED FOLLOWING (last row)


*/
-- endregion




-- region Query ~~> advanced framing

  -- region Normal query

SELECT
  sale.fullname,
  sale.fiscalyear,
  sale.salestotal
FROM sales.vsalespersonsalesbyfiscalyearsdata sale;

-- endregion

  -- region Frame manipulation

  SELECT
    sale.fullname,
    sale.jobtitle,
    sale.salestotal,

    SUM(sale.salestotal) OVER (
      PARTITION BY sale.jobtitle
      ORDER BY sale.salestotal
      RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
      ) AS sum_suffix

  FROM sales.vsalespersonsalesbyfiscalyearsdata sale;


  -- endregion

-- endregion




-- TODO: BONUS Examples




-- region LAG ~~> Removing duplicates

-- region step 1

-- endregion

SELECT
  letter,
  lag(letter) OVER (PARTITION BY letter)
  IS NOT NULL AS to_remove
FROM regexp_split_to_table('a a a b c c d e', E'\\s+') letter;

-- endregion




-- region Time series chart

SELECT
  lag(date) OVER () AS previous,
  date    AS current
FROM generate_series(:from, :to, '1 week') date;

-- endregion




-- region Randomize order but keep original row number

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
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

-- region Query <~ advanced framing


-- region Normal query

SELECT
  sale.fullname,
  sale.fiscalyear,
  sale.salestotal
FROM sales.vsalespersonsalesbyfiscalyearsdata sale;

-- endregion

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

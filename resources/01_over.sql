

-- region Intern task completed

SELECT DISTINCT
  department,
  count(*) OVER (PARTITION BY department) AS count_dep,
  jobtitle,
  count(*) OVER (PARTITION BY jobtitle) AS count_title
FROM humanresources.vemployeedepartment
ORDER BY department;

-- endregion






















-- region FRAMING explained

SELECT
  n,
  lag(n) OVER (ORDER BY n),
  ROW_NUMBER() OVER (),
  SUM(n) OVER (ORDER BY n)
FROM
  (VALUES (1), (2), (3), (3), (4), (5)) x(n)
ORDER BY n;

-- endregion
























-- region Real example) Employee progress

SELECT
  fullname,
  fiscalyear,
  salestotal
FROM sales.vsalespersonsalesbyfiscalyearsdata person_sales;

--

SELECT
  fullname,
  fiscalyear,
  salestotal,
  salestotal - lag(salestotal) OVER (PARTITION BY fullname ORDER BY fiscalyear) AS diff
FROM sales.vsalespersonsalesbyfiscalyearsdata person_sales
ORDER BY fullname, fiscalyear;

-- endregion
























-- region Real example) Employee progress - deviation from norm

SELECT
  fullname,
  salestotal,
  fiscalyear,
  salestotal - avg(salestotal) OVER (PARTITION BY fiscalyear) AS diff_from_avg
FROM sales.vsalespersonsalesbyfiscalyearsdata
ORDER BY fullname, fiscalyear;

-- endregion
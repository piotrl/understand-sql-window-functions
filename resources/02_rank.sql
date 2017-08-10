

-- region Real example) Employee progress - ranking

WITH employee_perf AS (
    SELECT
      fullname,
      fiscalyear,
      salestotal - lag(salestotal) OVER (PARTITION BY fullname ORDER BY fiscalyear) AS year_progress,
      salestotal - avg(salestotal) OVER (PARTITION BY fiscalyear) AS diff_from_avg
    FROM sales.vsalespersonsalesbyfiscalyearsdata
    ORDER BY fullname, fiscalyear
)
SELECT
  perf.*,
  rank() OVER (PARTITION BY fiscalyear ORDER BY diff_from_avg DESC) AS year_avg_rank,
  percent_rank() OVER (PARTITION BY fiscalyear ORDER BY diff_from_avg DESC)
FROM employee_perf perf
ORDER BY year_avg_rank, perf.fiscalyear;

-- endregion























-- region Rank functions - compare

SELECT
  letter,
  RANK()        OVER (ORDER BY letter),
  DENSE_RANK()  OVER (ORDER BY letter),
  NTILE(3)      OVER (ORDER BY letter)
FROM regexp_split_to_table('a a a b c c d e', E'\\s+') letter;

-- region refactor

SELECT
  letter,
  RANK()        OVER (w),
  DENSE_RANK()  OVER (w),
  NTILE(3)      OVER (w)
FROM regexp_split_to_table('a a a b c c d e', E'\\s+') letter
WINDOW w AS (ORDER BY letter);

-- endregion

-- endregion
























-- region NTILE ~~> Different call-center scripts for different customers

WITH Sales AS (
    SELECT
      soh.customerid,
      COUNT(*),
      SUM(soh.totaldue) AS total_sales
    FROM sales.salesorderheader AS soh
      JOIN sales.salesorderdetail sod ON soh.salesorderid = sod.salesorderid
    GROUP BY customerid
)
SELECT
  o.*,
  NTILE(4)  OVER (ORDER BY o.total_sales ) AS bucket
FROM Sales o
ORDER BY o.total_sales DESC;

-- endregion
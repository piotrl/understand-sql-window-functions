-- region First three orders per each product

WITH Orders AS (
    SELECT
      sod.productid,
      soh.salesorderid,
      soh.orderdate,
      ROW_NUMBER() OVER (PARTITION BY sod.productid ORDER BY soh.orderdate DESC ) AS row_num
    FROM sales.salesorderheader AS soh
      JOIN sales.salesorderdetail sod ON soh.salesorderid = sod.salesorderid
)
SELECT *
FROM Orders o
WHERE o.row_num <= 3;

-- endregion

















-- region NTILE Gold Star problem ~~> Different call-center scripts for different customers

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
  NTILE(4)  OVER (ORDER BY o.total_sales) AS bucket
FROM Sales o
ORDER BY o.total_sales DESC;

-- endregion

/**
- Zastosowania:
-- Przy tworzeniu grupy, różnica od największego (np. kategorie biegowe M25)

 */


-- region Rank functions - compare

SELECT
  letter,
  RANK()        OVER (ORDER BY letter),
  DENSE_RANK()  OVER (ORDER BY letter),
  NTILE(3)      OVER (ORDER BY letter)
FROM regexp_split_to_table('a a a b c c d e', E'\\s+') letter;

-- endregion












-- region Rank functions - compare + refactor

SELECT
  letter,
  RANK()        OVER (w),
  DENSE_RANK()  OVER (w),
  NTILE(3)      OVER (w)
FROM regexp_split_to_table('a a a b c c d e', E'\\s+') letter
  WINDOW w AS (ORDER BY letter);

-- endregion













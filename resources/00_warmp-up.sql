
-- region DB showcase

SELECT
  lastname,
  jobtitle,
  department
FROM humanresources.vemployeedepartment;

-- endregion


























-- region Intern task

SELECT
  department,
  count(*)
FROM humanresources.vemployeedepartment
GROUP BY department;

-- endregion



























-- region Warm-up: ROLLUP

SELECT
  department,
  jobtitle,
  COUNT(*)
FROM humanresources.vemployeedepartment
GROUP BY ROLLUP (department, jobtitle);

-- endregion
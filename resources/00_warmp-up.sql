
-- region DB showcase

SELECT
  lastname,
  jobtitle,
  department
FROM humanresources.vemployeedepartment;

-- endregion


























-- region Intern 1st task

SELECT
  department,
  jobtitle,
  count(*)
FROM humanresources.vemployeedepartment
GROUP BY department, jobtitle;

-- endregion



























-- region Warm-up: ROLLUP

SELECT
  department,
  jobtitle,
  COUNT(*)
FROM humanresources.vemployeedepartment
GROUP BY ROLLUP (department, jobtitle);

-- endregion
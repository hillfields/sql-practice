WITH ranked AS (
    SELECT
        id,
        RANK() OVER (PARTITION BY departmentid ORDER BY salary DESC) as dept_salary_rank
    FROM employee
)

SELECT
    department.name AS department,
    employee.name AS employee,
    salary
FROM employee
INNER JOIN ranked
    ON employee.id = ranked.id
INNER JOIN department
    ON employee.departmentid = department.id
WHERE dept_salary_rank = 1;
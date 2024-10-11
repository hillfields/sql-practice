-- method 1: inner join in subquery
WITH combined_ids AS (
    SELECT employee_id
    FROM employees
    UNION ALL
    SELECT employee_id
    FROM salaries
)

SELECT employee_id
FROM combined_ids
WHERE employee_id NOT IN (
    SELECT employees.employee_id
    FROM employees
    INNER JOIN salaries
        ON employees.employee_id = salaries.employee_id
)
ORDER BY employee_id;

-- method 2: aggregation
WITH combined_ids AS (
    SELECT employee_id
    FROM employees
    UNION ALL
    SELECT employee_id
    FROM salaries
)

SELECT employee_id
FROM combined_ids
GROUP BY employee_id
HAVING COUNT(employee_id) = 1
ORDER BY employee_id;
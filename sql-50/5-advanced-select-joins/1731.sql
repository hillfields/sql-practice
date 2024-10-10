WITH avg_ages AS (
    SELECT
        reports_to,
        COUNT(name) AS reports_count,
        ROUND(AVG(age)) AS average_age
    FROM employees
    GROUP BY reports_to
)

SELECT
    employee_id,
    name,
    reports_count,
    average_age
FROM employees
INNER JOIN avg_ages
    ON employees.employee_id = avg_ages.reports_to
ORDER BY employee_id;
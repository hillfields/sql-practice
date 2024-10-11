-- for people with multiple rows, keep row with Y
SELECT
    employee_id,
    department_id
FROM employee
WHERE primary_flag = 'Y'

UNION

-- for people with one row, keep that row
SELECT
    employee_id,
    department_id
FROM employee
GROUP BY employee_id
HAVING COUNT(*) = 1;
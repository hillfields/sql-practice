WITH ranked_salaries AS (
    SELECT
        id,
        name,
        salary,
        departmentid,
        DENSE_RANK() OVER (PARTITION BY departmentid ORDER BY salary DESC) AS dense_rank_num
    FROM employee
)

SELECT
    department.name AS department,
    ranked_salaries.name AS employee,
    ranked_salaries.salary
FROM ranked_salaries
LEFT JOIN department
    ON ranked_salaries.departmentid = department.id
WHERE dense_rank_num <= 3;
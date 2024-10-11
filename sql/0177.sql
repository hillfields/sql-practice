CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
RETURN (
    WITH ranked_salaries AS (
        SELECT
            salary,
            DENSE_RANK() OVER (ORDER BY salary DESC) AS ranking
        FROM employee
    )

    SELECT DISTINCT salary
    FROM ranked_salaries
    WHERE ranking = N
    LIMIT 1
);
END
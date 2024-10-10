SELECT MAX(salary) AS SecondHighestSalary
FROM employee
WHERE salary NOT IN (
    SELECT MAX(salary)
    FROM employee AS e
)
ORDER BY salary DESC;
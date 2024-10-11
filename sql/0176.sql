SELECT MAX(salary) AS secondhighestsalary
FROM employee
WHERE salary NOT IN (
    SELECT MAX(salary)
    FROM employee AS e
)
ORDER BY salary DESC;
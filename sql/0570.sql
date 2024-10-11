SELECT name
FROM employee
WHERE id IN (
    SELECT managerid
    FROM employee
    WHERE managerid IS NOT NULL
    GROUP BY managerid
    HAVING COUNT(*) >= 5
);
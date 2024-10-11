WITH cte AS (
    SELECT
        num,
        LEAD(num, 1) OVER(ORDER BY id) AS num1,
        LEAD(num, 2) OVER(ORDER BY id) AS num2
    FROM logs
)

SELECT DISTINCT num AS ConsecutiveNums
FROM cte
WHERE num = num1 AND num1 = num2;

-- num  num1  num3
-- 1    NULL  NULL
-- 1    1     NULL
-- 1    1     1    --> only this one 
-- 2    1     1
-- 1    2     1
-- 2    1     2
-- 2    2     1
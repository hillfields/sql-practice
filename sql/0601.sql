-- method 1: self-join (https://leetcode.com/problems/human-traffic-of-stadium/editorial/#approach-1-using-self-join)
SELECT DISTINCT a.*
FROM stadium AS a
CROSS JOIN stadium AS b
CROSS JOIN stadium AS c
WHERE
    a.people >= 100
    AND b.people >= 100
    AND c.people >= 100
    AND (
        (a.id - b.id = 1 AND b.id - c.id = 1)    -- a.id > b.id > c.id
        OR (c.id - b.id = 1 AND b.id - a.id = 1) -- c.id > b.id > a.id
        OR (b.id - a.id = 1 AND a.id - c.id = 1) -- b.id > a.id > c.id
    )
ORDER BY visit_date;

-- method 2: islands / consecutive values (https://leetcode.com/problems/human-traffic-of-stadium/editorial/#approach-3-finding-the-islands)
WITH stadium_with_rnk AS (
    SELECT
        id,
        visit_date,
        people,
        rnk,
        (id - rnk) AS island
    FROM (
        SELECT
            id,
            visit_date,
            people,
            RANK() OVER (ORDER BY id) AS rnk
        FROM stadium
        WHERE people >= 100
    ) AS temp
)

SELECT
    id,
    visit_date,
    people
FROM stadium_with_rnk
WHERE island IN (
    SELECT island
    FROM stadium_with_rnk
    GROUP BY island
    HAVING COUNT(*) >= 3
)
ORDER BY visit_date;
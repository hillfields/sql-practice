-- root -> p_id is null
-- inner -> has at least 1 child (i.e. where COUNT(id) >= 1)
-- leaf -> neither root nor inner

-- with CTE
WITH children_count AS (
    SELECT
        p_id AS id,
        COUNT(id) AS children
    FROM tree
    WHERE p_id IS NOT NULL
    GROUP BY p_id
)

SELECT
    tree.id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN children >= 1 THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM tree
LEFT JOIN children_count
    ON tree.id = children_count.id

-- w/ subquery
SELECT
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT p_id FROM tree) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM tree
WITH cumulative_weights AS (
    SELECT
        turn,
        person_name,
        SUM(weight) OVER(ORDER BY turn) AS total_weight
    FROM queue
    ORDER BY turn
)

SELECT person_name
FROM cumulative_weights
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1;
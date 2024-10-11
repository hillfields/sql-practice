WITH total_distance AS (
    SELECT
        user_id,
        SUM(distance) AS travelled_distance
    FROM rides
    GROUP BY user_id
)

SELECT
    name,
    IFNULL(travelled_distance, 0) AS travelled_distance
FROM users
LEFT JOIN total_distance
    ON users.id = total_distance.user_id
ORDER BY
    travelled_distance DESC,
    name
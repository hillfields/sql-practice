WITH first_login AS (
    SELECT
        player_id,
        MIN(event_date) AS event_date
    FROM activity
    GROUP BY player_id
)

SELECT
    ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM activity), 2) AS fraction
FROM activity
WHERE (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) IN (
    SELECT *
    FROM first_login
);
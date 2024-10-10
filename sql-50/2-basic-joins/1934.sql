WITH confirmation_rate_table AS (
    SELECT
        user_id,
        ROUND(SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) / COUNT(*), 2) AS confirmation_rate
    FROM confirmations
    GROUP BY user_id
)

SELECT
    signups.user_id, 
    IFNULL(confirmation_rate, 0) AS confirmation_rate
FROM signups
LEFT JOIN confirmation_rate_table
    ON signups.user_id = confirmation_rate_table.user_id;
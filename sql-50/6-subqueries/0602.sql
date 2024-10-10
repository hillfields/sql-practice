WITH requested_friends AS (
    SELECT requester_id AS id, COUNT(accepter_id) AS num_friends
    FROM requestaccepted
    GROUP BY requester_id
), accepted_friends AS (
    SELECT accepter_id AS id, COUNT(requester_id) AS num_friends
    FROM requestaccepted
    GROUP BY accepter_id
)

-- https://stackoverflow.com/questions/71618783/how-to-sum-two-tables-with-same-columns
SELECT
    id,
    SUM(num_friends) AS num
FROM (
    SELECT *
    FROM requested_friends
    UNION ALL
    SELECT *
    FROM accepted_friends
) AS combined_friends
GROUP BY id
ORDER BY num DESC
LIMIT 1;
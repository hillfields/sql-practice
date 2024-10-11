-- we want 2 tables
-- 1st table: number of cancelled (by client or driver) requests with unbanned users for each date
-- 2nd table: total number of requests with unbanned users for each date
-- then divide (number of canceled requests) by (total number of requests)
WITH cancellations AS (
    SELECT
        request_at AS day,
        COUNT(*) AS num_cancellations
    FROM trips
    LEFT JOIN users AS clients
        ON trips.client_id = clients.users_id
    LEFT JOIN users AS drivers
        ON trips.driver_id = drivers.users_id
    WHERE
        (clients.banned = 'No' AND drivers.banned = 'No')
        AND status LIKE 'cancelled_by_%'
        AND (request_at >= '2013-10-01' AND request_at <= '2013-10-03')
    GROUP BY request_at
), requests AS (
    SELECT
        request_at AS day,
        COUNT(*) AS num_requests
    FROM trips
    LEFT JOIN users AS clients
        ON trips.client_id = clients.users_id
    LEFT JOIN users AS drivers
        ON trips.driver_id = drivers.users_id
    WHERE
        (clients.banned = 'No' AND drivers.banned = 'No')
        AND (request_at >= '2013-10-01' AND request_at <= '2013-10-03')
    GROUP BY request_at
)

SELECT
    requests.day AS Day,
    ROUND(IFNULL(num_cancellations, 0) / num_requests, 2) AS `Cancellation Rate`
FROM requests
LEFT JOIN cancellations
    ON requests.day = cancellations.day;

-- less redundant
SELECT
    request_at AS Day,
    ROUND(SUM(status <> 'completed') / COUNT(*), 2) AS 'Cancellation Rate'
FROM trips
LEFT JOIN users AS clients
    ON trips.client_id = clients.users_id
LEFT JOIN users AS drivers
    ON trips.driver_id = drivers.users_id
WHERE
    clients.banned = 'No'
    AND drivers.banned = 'No'
    AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY day;
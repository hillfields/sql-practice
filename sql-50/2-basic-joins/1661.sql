-- method 1: aggregate in separate tables, then do necessary calculations after joining them
WITH combined_start AS (
    SELECT machine_id, SUM(timestamp) AS time
    FROM activity
    WHERE activity_type = 'start'
    GROUP BY machine_id
), combined_end AS (
    SELECT machine_id, SUM(timestamp) AS time
    FROM activity
    WHERE activity_type = 'end'
    GROUP BY machine_id
), combined_processes AS (
    SELECT
        machine_id,
        COUNT(DISTINCT process_id) AS num
    FROM activity
    GROUP BY machine_id
)

SELECT
    combined_start.machine_id,
    ROUND((combined_end.time - combined_start.time) / combined_processes.num, 3) AS processing_time
FROM combined_start
LEFT JOIN combined_end
    ON combined_start.machine_id = combined_end.machine_id
LEFT JOIN combined_processes
    ON combined_start.machine_id = combined_processes.machine_id;

-- method 2: use self inner join
SELECT
    a1.machine_id,
    ROUND(AVG(a2.timestamp - a1.timestamp), 3) AS processing_time
FROM activity a1
INNER JOIN activity a2
WHERE
    a1.machine_id = a2.machine_id
    AND a1.process_id = a2.process_id
    AND a1.activity_type = 'start' AND a2.activity_type = 'end'
GROUP BY machine_id;
SELECT
    event_day as day,
    emp_id, SUM(out_time - in_time) AS total_time
FROM employees
GROUP BY day, emp_id;
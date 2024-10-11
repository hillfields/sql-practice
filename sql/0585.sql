SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM insurance
WHERE
    tiv_2015 IN (
        -- same tiv_2015 value as one or more other policyholders
        SELECT tiv_2015
        FROM insurance
        GROUP BY tiv_2015
        HAVING COUNT(*) > 1
    )
    AND pid IN (
        -- unique city
        SELECT pid
        FROM insurance
        GROUP BY lat, lon
        HAVING COUNT(*) = 1
    );
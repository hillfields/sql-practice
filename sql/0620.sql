SELECT *
FROM cinema
WHERE
    description <> 'boring'
    AND id % 2 = 1
ORDER BY rating DESC;
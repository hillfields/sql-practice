(SELECT name AS results
FROM movierating
LEFT JOIN users
    ON movierating.user_id = users.user_id
GROUP BY movierating.user_id
ORDER BY
    COUNT(*) DESC,
    name
LIMIT 1)

UNION ALL

(SELECT title AS results
FROM movierating
LEFT JOIN movies
    ON movierating.movie_id = movies.movie_id
WHERE
    MONTH(created_at) = 2
    AND YEAR(created_at) = 2020
GROUP BY movierating.movie_id
ORDER BY
    AVG(rating) DESC,
    title ASC
LIMIT 1);
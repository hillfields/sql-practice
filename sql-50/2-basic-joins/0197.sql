SELECT w2.id
FROM weather w1
CROSS JOIN weather w2
WHERE w2.temperature > w1.temperature
AND DATEDIFF(w2.recorddate, w1.recorddate) = 1;
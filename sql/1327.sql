SELECT
    product_name,
    SUM(unit) AS unit
FROM orders
LEFT JOIN products
    ON orders.product_id = products.product_id
WHERE
    MONTH(order_date) = 2
    AND YEAR(order_date) = 2020
GROUP BY orders.product_id
HAVING SUM(unit) >= 100;
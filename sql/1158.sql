WITH filtered_orders AS (
    SELECT
        buyer_id,
        COUNT(order_id) AS orders_in_2019
    FROM orders
    WHERE YEAR(order_date) = 2019
    GROUP BY buyer_id
)

SELECT
    user_id AS buyer_id,
    join_date,
    IFNULL(orders_in_2019, 0) AS orders_in_2019
FROM users
LEFT JOIN filtered_orders
    ON users.user_id = filtered_orders.buyer_id;
WITH first_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order
    FROM delivery
    GROUP BY customer_id
)

SELECT
    ROUND(SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(delivery.customer_id) * 100, 2) AS immediate_percentage
FROM delivery
INNER JOIN first_orders
    ON delivery.customer_id = first_orders.customer_id
    AND delivery.order_date = first_orders.first_order;
SELECT
    prices.product_id,
    IFNULL(ROUND(SUM(units * price) / SUM(units), 2), 0) AS average_price
FROM prices
LEFT JOIN unitssold
    ON unitssold.purchase_date BETWEEN prices.start_date AND prices.end_date
    AND prices.product_id = unitssold.product_id
GROUP BY prices.product_id;
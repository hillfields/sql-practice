-- case 1: product has price before or on 2019-08-16
-- return price on date closest to 2019-08-16
WITH before_0816 AS (
    SELECT product_id, MAX(change_date) AS change_date
    FROM products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
)

SELECT
    products.product_id,
    new_price AS price
FROM products
INNER JOIN before_0816
    ON products.product_id = before_0816.product_id
    AND products.change_date = before_0816.change_date

UNION

-- case 2: product only has price after 2019-08-16
-- return 10
SELECT product_id, 10 AS price
FROM products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16';
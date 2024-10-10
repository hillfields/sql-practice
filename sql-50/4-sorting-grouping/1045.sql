SELECT customer_id
FROM customer
-- inner join isn't necessary since product_key is a foreign key to product table
-- INNER JOIN product
--     ON customer.product_key = product.product_key
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) IN (
    SELECT COUNT(product_key)
    FROM product
);
SELECT
    product_id, 
    product_name
FROM product
WHERE product_id IN (
    SELECT product_id
    FROM sales
    GROUP BY product_id
    HAVING
        MIN(sale_date) >= '2019-01-01'
        AND MAX(sale_date) <= '2019-03-31'
)
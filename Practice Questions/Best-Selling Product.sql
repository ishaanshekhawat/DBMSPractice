-- https://datalemur.com/questions/best-selling-products

with t1 as (
SELECT *, ROW_NUMBER() OVER (PARTITION BY category_name ORDER BY sales_quantity DESC, rating DESC) as rnk
FROM products p1
JOIN product_sales p2 ON p1.product_id = p2.product_id
)

SELECT category_name, product_name
FROM t1
WHERE rnk = 1;

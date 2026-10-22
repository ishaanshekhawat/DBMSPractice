-- https://datalemur.com/questions/supercloud-customer

select customer_id
from (
  SELECT customer_id, count(distinct product_category) as ct
  FROM customer_contracts c join products p on c.product_id = p.product_id
  group by customer_id
) a
where ct = 3;

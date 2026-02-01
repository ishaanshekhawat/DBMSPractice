# https://leetcode.com/problems/find-golden-hour-customers/

with table1 as 
(select order_id, customer_id, 
CASE
WHEN HOUR(order_timestamp) between 11 and 13 OR HOUR(order_timestamp) between 18 and 20 THEN 1
ELSE 0
END AS is_peak
from restaurant_orders),
table2 as 
(select customer_id, round(avg(order_rating),2) as average_rating, count(order_rating) as nn_ratings
from restaurant_orders
where order_rating is not null
group by customer_id),
table3 as 
(select customer_id, count(*) as total_orders, count(order_id) as all_ratings
from restaurant_orders
group by customer_id)

select table1.customer_id, total_orders, round((sum(is_peak)*100/count(is_peak)),0) as peak_hour_percentage, average_rating
from table1 left join table2 on table1.customer_id = table2.customer_id
left join table3 on table1.customer_id = table3.customer_id
where total_orders >= 3 
and average_rating >= 4
and nn_ratings/all_ratings >= 0.5
group by table1.customer_id
having sum(is_peak)*100/count(is_peak) >= 60
order by average_rating desc, customer_id desc

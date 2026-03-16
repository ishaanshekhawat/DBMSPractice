-- https://platform.stratascratch.com/coding/9913-order-details

select first_name, order_date, order_details, total_order_cost
from customers c join orders o on c.id = o.cust_id
where first_name = 'Jill' or first_name = 'Eva';

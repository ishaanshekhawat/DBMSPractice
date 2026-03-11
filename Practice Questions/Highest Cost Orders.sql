-- https://platform.stratascratch.com/coding/9915-highest-cost-orders

select first_name, total, order_date
from (
    select *, rank() over (partition by order_date order by total desc) as ranking
    from (
        select first_name, sum(total_order_cost) as total, order_date
        from customers c join orders o on c.id = o.cust_id
        where order_date between '2019-02-01' and '2019-05-01'
        group by first_name, order_date
        ) as t1) as t2
where ranking = 1;

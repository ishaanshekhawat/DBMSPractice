-- https://leetcode.com/problems/market-analysis-i/

select user_id as buyer_id, 
    join_date, 
    sum(case when order_date between '2019-01-01' and '2019-12-31' then 1 else 0 end) as orders_in_2019
from Orders o right join Users u on o.buyer_id = u.user_id
group by user_id;

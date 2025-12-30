-- https://leetcode.com/problems/find-loyal-customers/description/

with tab1 as 
(select customer_id, 
    count(transaction_id) as num, 
    datediff(max(transaction_date),min(transaction_date)) as diff
from customer_transactions
group by customer_id), 

tab2 as 
(select ct.customer_id, ifnull(numr,0)/count(transaction_id) as rate
from customer_transactions as ct left join (
    select customer_id, count(transaction_id) as numr
    from customer_transactions
    where transaction_type = 'refund'
    group by customer_id) as tab3 
    on ct.customer_id = tab3.customer_id
    group by ct.customer_id)

select tab1.customer_id
from tab1 left join tab2 on tab1.customer_id = tab2.customer_id
where tab1.num >= 3 AND diff >= 30 AND tab2.rate < 0.2
order by tab1.customer_id

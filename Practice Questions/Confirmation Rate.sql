-- https://leetcode.com/problems/confirmation-rate/

with table1 as
    (select user_id, count(action) as num1
    from Confirmations
    where action = 'timeout'
    group by user_id),
table2 as 
    (select user_id, count(action) as num2
    from Confirmations
    where action = 'confirmed'
    group by user_id)

select s.user_id, round(ifnull(num2/(ifnull(num1, 0)+num2), 0), 2) as confirmation_rate
from Signups s left join table1 on s.user_id = table1.user_id 
    left join table2 on s.user_id = table2.user_id

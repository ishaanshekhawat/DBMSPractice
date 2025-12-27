-- https://leetcode.com/problems/investments-in-2016/description/

with table1 as 
(select pid, tiv_2016
from (
    select pid, tiv_2016, count(tiv_2015) over (partition by tiv_2015) as num1
    from Insurance) as tab1
where num1 > 1), 
table2 as 
(select pid, tiv_2016
from (
    select pid, tiv_2016, count(*) over (partition by lat, lon) as num2
    from Insurance) as tab2
where num2 = 1)

select round(sum(table1.tiv_2016), 2) as tiv_2016
from table1 inner join table2 on table1.pid = table2.pid

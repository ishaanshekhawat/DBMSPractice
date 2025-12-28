-- https://leetcode.com/problems/restaurant-growth/description/

WITH table1 as 
(select *, sum(amount) as sum_amount, ROW_NUMBER() OVER (ORDER BY visited_on) as num
FROM Customer
GROUP BY visited_on)

select visited_on, amount, round(average_amount, 2) as average_amount
FROM (select visited_on, 
    sum(sum_amount) over (ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as amount, 
    avg(sum_amount) over (ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as average_amount, num
FROM table1) as table2
WHERE num > 6

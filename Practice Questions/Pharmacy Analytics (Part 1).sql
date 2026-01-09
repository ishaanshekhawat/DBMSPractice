-- https://datalemur.com/questions/top-profitable-drugs

select drug, sum(total_sales - cogs) as total_profit
from pharmacy_sales
group by drug
order by total_profit desc
limit 3;

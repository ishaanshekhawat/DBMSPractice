-- https://datalemur.com/questions/total-drugs-sales

select manufacturer, concat('$',round(sum(total_sales)/1000000, 0),' million') as sale
from pharmacy_sales
group by manufacturer
order by sum(total_sales) desc, manufacturer

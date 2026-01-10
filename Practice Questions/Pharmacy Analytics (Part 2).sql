-- https://datalemur.com/questions/non-profitable-drugs

select manufacturer, count(drug) as drug_count, sum(cogs - total_sales) as total_loss
from pharmacy_sales
where cogs - total_sales > 0
group by manufacturer
order by total_loss desc;

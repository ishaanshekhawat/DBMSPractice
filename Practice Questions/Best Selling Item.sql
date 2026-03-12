-- https://platform.stratascratch.com/coding/10172-best-selling-item

select mon, description, total_paid
from (
    select month(invoicedate) as mon, 
        stockcode, 
        description, 
        sum(quantity*unitprice) as total_paid,
        row_number() over (partition by month(invoicedate) order by sum(quantity*unitprice) desc) as ranking
    from online_retail
    where invoiceno not like 'C%'
    group by month(invoicedate), stockcode) as t1
where ranking = 1;

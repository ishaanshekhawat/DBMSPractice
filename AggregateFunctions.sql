-- Find sum of price for all products

Select SUM(price) totalprice 
from product;

-- Find min and max price for every category

select type,MIN(Price), MAX(price)
from product
group by type;

-- Find sum of total amt, for every type of product (amt=qty*price)

select type, sum(qty*price) amt
from product
group by type;

-- Find how many products and what is sum of prices of all products for every category

select type, count(pid) total_products, sum(price) total_amt
from product
group by type;

-- Display pid, pname, cid, sum of prices for every category

select pid, pname, cid, sum(price) over (partition by type) as Total_Category_price
from product;

-- Display sum of prices for every category, if it is perishable product

select type, sum(price) total
from product
where type = 'perishable'
group by type;

-- Display sum of amt(qty*price) for every category if the qty > 45 and < 100,

select type, sum(qty*price) amt
from product
where qty between 46 and 99
group by type;

-- Display number of products, sum of amt(price*qty) products, which are manufactured in year 2024, for every category, only if the number of products in the category are <3 arrange  it in sorted order of sum of amt(price*qty)

select count(pid) total_products, sum(price*qty) total_amt
from product
where year(mfgdate) = 2024
group by type
having count(pid) < 3
order by total_amt; 

-- Find sum and count of all products manufactured in every year (to find year-→year(mfgdate)

select year(mfgdate) Year, sum(price) total_amt, count(pid) total_products
from product
group by Year;

-- Display pid, pname, type, count for every type
Sol:

select pid, pname, type, count(type) over (partition by type) as counter_for_category
from product;

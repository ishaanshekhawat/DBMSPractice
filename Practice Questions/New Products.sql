-- https://platform.stratascratch.com/coding/10318-new-products

with t1 as 
    (select company_name, count(product_name) as num1
    from car_launches
    where year = 2020
    group by company_name),
t2 as 
    (select company_name, count(product_name) as num2
    from car_launches
    where year = 2019
    group by company_name)

select t1.company_name, num1 - num2
from t1 join t2 on t1.company_name = t2.company_name;

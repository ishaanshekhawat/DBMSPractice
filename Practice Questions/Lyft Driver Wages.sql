-- https://platform.stratascratch.com/coding/10003-lyft-driver-wages

select * 
from lyft_drivers
where yearly_salary <= 30000 or yearly_salary >= 70000;

-- https://datalemur.com/questions/duplicate-job-listings

select count(*) as duplicate_companies
from (
  select count(*) as cnt
  from job_listings
  group by company_id, title, description) as temp
where cnt > 1;

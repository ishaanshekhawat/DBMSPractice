-- https://platform.stratascratch.com/coding/10304-risky-projects

select title, budget, prorated
from (
    select lp.id, 
        title, 
        budget, 
        ceil(sum(salary*(timestampdiff(DAY, start_date, end_date)/365))) as prorated
    from linkedin_projects lp join linkedin_emp_projects lep on lp.id = lep.project_id
        join linkedin_employees le on lep.emp_id = le.id
    group by lp.id) as t1
where prorated > budget;

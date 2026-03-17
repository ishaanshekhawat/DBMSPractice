-- https://platform.stratascratch.com/coding/9881-make-a-report-showing-the-number-of-survivors-and-non-survivors-by-passenger-class

select survived,
    sum(case when pclass = 1 then 1 else 0 end) as first_class,
    sum(case when pclass = 2 then 1 else 0 end) as second_class,
    sum(case when pclass = 3 then 1 else 0 end) as third_class
from titanic
group by survived;

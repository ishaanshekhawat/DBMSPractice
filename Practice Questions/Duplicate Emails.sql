-- Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

-- Return the result table in any order.

Select email as Email
from (
    Select email, count(email) as number
    from Person
    group by email
    ) as main
where number > 1

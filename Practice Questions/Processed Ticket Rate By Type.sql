-- https://platform.stratascratch.com/coding/9781-find-the-rate-of-processed-tickets-for-each-type

select type, sum(processed)/count(processed) as output
from facebook_complaints
group by type;

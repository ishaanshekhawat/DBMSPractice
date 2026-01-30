-- https://leetcode.com/problems/find-emotionally-consistent-users/

with table1 as (
    select user_id, reaction, count(*) as reaction_count
    from reactions
    group by user_id, reaction
    order by reaction_count desc
    )

select user_id, reaction as dominant_reaction, round((max(reaction_count)/sum(reaction_count)), 2) as reaction_ratio
from table1
group by user_id
having sum(reaction_count) >= 5 and (max(reaction_count)/sum(reaction_count)) >= 0.6
order by reaction_ratio desc, user_id;

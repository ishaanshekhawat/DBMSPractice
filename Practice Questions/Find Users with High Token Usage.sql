-- https://leetcode.com/problems/find-users-with-high-token-usage/

select user_id, count(prompt) as prompt_count, round(avg(tokens),2) as avg_tokens
from prompts
group by user_id
having count(prompt) >= 3 and max(tokens) > avg(tokens)
order by avg_tokens desc, user_id asc

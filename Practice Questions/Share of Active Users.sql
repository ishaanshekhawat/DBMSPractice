-- https://platform.stratascratch.com/coding/2005-share-of-active-users

select 
    round(((select count(*) from fb_active_users where country = 'USA' and status = 'open')/count(*))*100,2) as percent
from fb_active_users

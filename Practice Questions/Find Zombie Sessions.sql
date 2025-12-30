-- https://leetcode.com/problems/find-zombie-sessions/description/

with tab3 as
(select ae1.session_id, ae1.user_id, scrolls, ifnull(clicks, 0)/ifnull(scrolls, 1) as ratio
from app_events as ae1 
    left join 
        (select session_id, user_id, count(event_type) as scrolls
        from app_events
        where event_type = 'scroll'
        group by session_id) 
    as tab1 on ae1.session_id = tab1.session_id
    left join 
        (select session_id, user_id, count(event_type) as clicks
        from app_events
        where event_type = 'click'
        group by session_id) 
    as tab2 on ae1.session_id = tab2.session_id
group by session_id)

select app_events.session_id, app_events.user_id, timestampdiff(minute, min(event_timestamp),max(event_timestamp)) as session_duration_minutes, tab3.scrolls as scroll_count
from app_events
    left join tab3 on app_events.session_id = tab3.session_id
where tab3.scrolls >= 5 
    AND tab3.ratio < 0.20 
    AND app_events.session_id NOT IN (
        select session_id
        from app_events
        where event_type = 'purchase')
group by app_events.session_id
having timestampdiff(minute, min(event_timestamp), max(event_timestamp)) > 30
order by scroll_count desc, app_events.session_id

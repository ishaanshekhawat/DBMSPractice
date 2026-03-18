-- https://platform.stratascratch.com/coding/2029-the-most-popular-client_id-among-users-using-video-and-voice-calls

select client_id
from (
    select client_id, count(user_id) as ct
    from (
        select client_id, user_id, 
            sum(case when event_type = 'video call received' or event_type = 'video call sent' or event_type = 'voice call received' or event_type = 'voice call sent' then 1 else 0 end)/count(event_type) * 100 as percent
        from fact_events
        group by client_id, user_id
    ) as t1
    where percent >= 50
    group by client_id) as t2
where ct = (
    select max(ct)
    from (
        select client_id, count(user_id) as ct
        from (
            select client_id, user_id, 
                sum(case when event_type = 'video call received' or event_type = 'video call sent' or event_type = 'voice call received' or event_type = 'voice call sent' then 1 else 0 end)/count(event_type) * 100 as percent
            from fact_events
            group by client_id, user_id
        ) as t1
        where percent >= 50
        group by client_id) as t2)

-- https://platform.stratascratch.com/coding/9992-find-artists-that-have-been-on-spotify-the-most-number-of-times

select artist, count(id) as ct
from spotify_worldwide_daily_song_ranking
group by artist
order by ct desc;

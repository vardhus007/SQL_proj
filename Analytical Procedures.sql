--- 1. What is the overall social media trend for NBA teams?
create view overall_social_trend_teams as
select nba_2017_team_player.team_id, sum(twitter_favorite_count) as team_twitter, sum(wiki_views) as team_wiki
from nba_2017_team_player left join nba_2017_twitter  using(player_id) 
                          left join (select player_id, sum(pageviews) as wiki_views
                                    from nba_2017_wikipedia
                                    group by player_id) as foo 
					            using(player_id) 				
group by team_id
order by team_twitter desc, team_wiki desc;

select * from overall_social_trend_teams;


--- 2. What is the overall social media trend for NBA players?
create view overall_social_trend_players as
select nba_2017_players.player_id, twitter_favorite_count, wiki_views
from nba_2017_players left join nba_2017_twitter  using(player_id) 
                      left join (select player_id, sum(pageviews) as wiki_views
                                    from nba_2017_wikipedia
                                    group by player_id) as foo  using(player_id) 
order by twitter_favorite_count desc, wiki_views desc;								

select * from overall_social_trend_players;
 

--- 3. What is the overall salary & endorsement trend for NBA teams? 
create view overall_salary_endorsement_teams as
select nba_2017_team_player.team_id, sum (salary_millions) as team_salary, sum (endorsement) as team_endorsement
from nba_2017_team_player left join nba_2017_salary using(player_id) 
                      left join nba_2017_endorsements using(player_id)
group by nba_2017_team_player.team_id
order by team_salary desc, team_endorsement desc;

select * from overall_salary_endorsement_teams;	


--- 4. What is the overall salary & endorsement trend for NBA players? 
create view overall_salary_endorsement_players as
select nba_2017_players.player_id, salary_millions, endorsement
from nba_2017_players left join nba_2017_salary using(player_id) 
                      left join nba_2017_endorsements using(player_id)
order by salary_millions desc, endorsement desc;		

select * from overall_salary_endorsement_players;					  


--- 5.Is there a similar trend between the effects of Twitter and the effects of Wikipedia?
select * from overall_social_trend_teams;
select * from overall_social_trend_players;


-- 6. What are the effects of Twitter on teams’/players’ endorsements?  
SELECT E.player_id, E.endorsement, T.twitter_favorite_count, T.twitter_retweet_count
FROM nba_2017_endorsements E
LEFT JOIN nba_2017_twitter T
ON E.player_id = T.player_id
Group BY E.player_id
ORDER BY E.endorsement;

SELECT E.team_id, E.endorsement, T.twitter_favorite_count, T.twitter_retweet_count
FROM nba_2017_endorsements E
LEFT JOIN nba_2017_twitter T
ON E.team_id = T.team_id
Group BY E.team_id
ORDER BY E.endorsement;


--7. What are the effects of Wikipedia on team/players’ endorsements? 
SELECT E.player_id, E.endorsement, W.pageviews, W.timestamps
FROM nba_2017_wikipedia W
LEFT JOIN nba_2017_twitter T
ON E.player_id = W.player_id
Group BY E.player_id
ORDER BY E.endorsement;

SELECT E.team_id, E.endorsement, SUM(W.pageviews) team_pageviews
FROM nba_2017_wikipedia W
LEFT JOIN nba_2017_twitter T
ON E.player_id = W.player_id
Group BY E.team_id, E.endorsement
ORDER BY E.endorsement;


--8. What are the effects of Twitter on team/players’ salaries? 
SELECT S.player_id, S.salary_millions, T.twitter_favorite_count, T.twitter_retweet_count
FROM nba_2017_salary S
LEFT JOIN nba_2017_twitter T
ON E.player_id = T.player_id
GROUP BY S.player_id
ORDER BY S.salary_millions;

SELECT P.team_id, SUM(S.salary_millions) team_salary, SUM(T.twitter_favorite_count) team_twitter_favorite_count, (SUMT.twitter_retweet_count) team_twitter_retweet_count
FROM nba_2017_team_player P
LEFT JOIN nba_2017_salary S
ON P.player_id = S.player_id
LEFT JOIN nba_2017_twitter T
ON P.player_id = T.player_id
GROUP BY P.team_id
ORDER BY team_salary;


--- 9. What are the effects of Twitter on teams’ salaries?
SELECT t.player_id, p.player_name, t.twitter_favorite_count, t.twitter_retweet_count, s.salary_millions, 
	RANK() OVER (ORDER BY twitter_favorite_count DESC, twitter_retweet_count DESC) AS twitter_interaction_rank
FROM nba_2017_twitter t
INNER JOIN nba_2017_salary s ON t.player_id = s.player_id
INNER JOIN nba_2017_players p ON t.player_id = p.player_id;


--- 10. What are the effects of Twitter on players’ salaries?
SELECT tp.team_id, t.team_name, t.team_abbreviation, SUM(tw.twitter_favorite_count) AS team_twitter_favorite_count, 
	SUM(tw.twitter_retweet_count) AS team_twitter_retweet_count, SUM(ps.salary) AS team_salary
FROM nba_2017_team_player tp
INNER JOIN nba_2017_player_stats_5 ps ON tp.player_id = ps.player_id
INNER JOIN nba_2017_teams t ON tp.team_id = t.team_id
INNER JOIN nba_2017_twitter tw ON tp.player_id = tw.player_id
GROUP BY tp.team_id, t.team_name, t.team_abbreviation
ORDER BY team_twitter_favorite_count DESC, team_twitter_retweet_count DESC;


--- 11. What are the effects of Twitter on teams’ valuations?
SELECT t.team_id, t.team_name, t.team_abbreviation, SUM(tw.twitter_favorite_count) AS team_twitter_favorite_count, 
	SUM(tw.twitter_retweet_count) AS team_twitter_retweet_count, t.value_millions
FROM nba_2017_twitter tw
INNER JOIN nba_2017_team_player tp ON tw.player_id = tp.player_id
INNER JOIN nba_2017_teams t ON tp.team_id = t.team_id
GROUP BY t.team_id, t.team_name, t.team_abbreviation
ORDER BY team_twitter_favorite_count DESC, team_twitter_retweet_count DESC;


---12. What are the effects of Wikipedia on teams’ valuations?
SELECT t.team_id, t.team_name, t.team_abbreviation, SUM(w.pageviews) AS team_wikipedia_pageviews, t.value_millions
FROM nba_2017_wikipedia w
INNER JOIN nba_2017_team_player tp ON w.player_id = tp.player_id
INNER JOIN nba_2017_teams t ON tp.team_id = t.team_id
GROUP BY t.team_id, t.team_name, t.team_abbreviation
ORDER BY team_wikipedia_pageviews DESC;
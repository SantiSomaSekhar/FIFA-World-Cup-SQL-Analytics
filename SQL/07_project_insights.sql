/*
=========================================================
FIFA WORLD CUP SQL ANALYTICS PROJECT

File: 07_project_insights.sql

Description:
Summarizes the key insights obtained from
the FIFA World Cup SQL analysis.

These insights can be used by coaches,
analysts, recruiters, and management for
better decision-making.

=========================================================
*/
/*
=========================================================
Insight 1 : Top Goal Scorer
=========================================================

Insight:
Identify the player who scored the most goals during
the tournament.

Business Value:
Highlights the tournament's most effective finisher.
=========================================================
*/

SELECT
    p.player_name,
    SUM(pms.goals) AS total_goals
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY total_goals DESC
LIMIT 1;

/*
=========================================================
Insight 2 : Highest Rated Player
=========================================================

Insight:
Find the player with the highest average rating.

Business Value:
Identifies the most consistently outstanding player.
=========================================================
*/

SELECT
    p.player_name,
    ROUND(AVG(pms.player_rating),2) AS average_rating
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY average_rating DESC
LIMIT 1;

/*
=========================================================
Insight 3 : Highest Scoring Team
=========================================================

Insight:
Determine which team scored the most goals.

Business Value:
Measures attacking strength across the tournament.
=========================================================
*/

SELECT
    p.team,
    SUM(pms.goals) AS total_goals
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY p.team
ORDER BY total_goals DESC
LIMIT 1;

/*
=========================================================
Insight 4 : Best Defensive Team
=========================================================

Insight:
Identify the team that conceded the fewest goals.

Business Value:
Shows which team had the strongest defensive performance.
=========================================================
*/

SELECT
    p.team,
    SUM(pms.goals_conceded) AS goals_conceded
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY p.team
ORDER BY goals_conceded ASC
LIMIT 1;

/*
=========================================================
Insight 5 : Most Creative Player
=========================================================

Insight:
Find the player with the highest number of assists.

Business Value:
Identifies players who created the most scoring opportunities.
=========================================================
*/

SELECT
    p.player_name,
    SUM(pms.assists) AS total_assists
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY total_assists DESC
LIMIT 1;

/*
=========================================================
Insight 6 : Most Valuable Team
=========================================================

Insight:
Calculate the total market value of each team.

Business Value:
Shows which squad has the highest estimated player value.
=========================================================
*/

SELECT
    team,
    SUM(market_value_eur) AS squad_value
FROM players
GROUP BY team
ORDER BY squad_value DESC
LIMIT 1;

/*
=========================================================
Insight 7 : Team with Highest Average Player Rating
=========================================================

Insight:
Find the team with the highest average player rating.

Business Value:
Highlights the most consistently high-performing team.
=========================================================
*/

SELECT
    p.team,
    ROUND(AVG(pms.player_rating), 2) AS avg_rating
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY p.team
ORDER BY avg_rating DESC
LIMIT 1;

/*
=========================================================
Insight 8 : Stadium with Most Goals
=========================================================

Insight:
Identify the stadium where the highest number of goals were scored.

Business Value:
Reveals the most entertaining venue during the tournament.
=========================================================
*/

SELECT
    stadium,
    SUM(goals_team + goals_opponent) AS total_goals
FROM matches
GROUP BY stadium
ORDER BY total_goals DESC
LIMIT 1;

/*
=========================================================
Insight 9 : Player with Most Minutes Played
=========================================================

Insight:
Find the player who played the most minutes.

Business Value:
Highlights the tournament's most relied-upon player.
=========================================================
*/

SELECT
    p.player_name,
    SUM(pms.minutes_played) AS total_minutes
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY total_minutes DESC
LIMIT 1;

/*
=========================================================
Insight 10 : Tournament Summary
=========================================================

Insight:
Display the overall tournament statistics.

Business Value:
Provides a quick executive overview of the tournament.
=========================================================
*/

SELECT
    (SELECT COUNT(*) FROM players) AS total_players,
    (SELECT COUNT(*) FROM matches) AS total_matches,
    (SELECT SUM(goals) FROM player_match_stats) AS total_goals,
    (SELECT ROUND(AVG(player_rating),2) FROM player_match_stats) AS average_player_rating;

/*
=========================================================
END OF FILE

Project Insights Generated:

• Top Goal Scorers
• Best Rated Players
• Most Assists
• Highest Pass Accuracy
• Best Defensive Players
• Goal Contribution Leaders
• Strongest Teams
• Most Disciplined Teams
• Most Minutes Played
• Tournament Summary

Project:
FIFA World Cup SQL Analytics

=========================================================
*/





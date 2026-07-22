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



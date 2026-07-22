/*
=========================================================
FIFA WORLD CUP SQL ANALYTICS PROJECT

File : 06_advanced_sql.sql

Description:
Demonstrates advanced SQL techniques using the
normalized FIFA World Cup database.

Topics Covered:
• Common Table Expressions (CTEs)
• Subqueries
• Correlated Subqueries
• Window Functions
• Analytical SQL

=========================================================
*/
/*
#########################################################
        COMMON TABLE EXPRESSIONS (CTEs) & SUBQUERIES
#########################################################
*/

/*
=========================================================
Question 1 : Top 10 Goal Scorers Using CTE
=========================================================

Purpose:
Find the top 10 players who scored the most goals.

SQL Concepts:
• CTE
• GROUP BY
=========================================================
*/

WITH player_goals AS (
    SELECT
        p.player_id,
        p.player_name,
        p.team,
        SUM(pms.goals) AS total_goals
    FROM players p
    JOIN player_match_stats pms USING(player_id)
    GROUP BY
        p.player_id,
        p.player_name,
        p.team
)
SELECT
    player_name,
    team,
    total_goals
FROM player_goals
ORDER BY total_goals DESC
LIMIT 10;

/*
=========================================================
Question 2 : Players Above Tournament Average Rating
=========================================================

Purpose:
Find players whose average rating is above the tournament average.

SQL Concepts:
• Subquery
• HAVING
=========================================================
*/

SELECT
    p.player_name,
    p.team,
    ROUND(AVG(pms.player_rating), 2) AS avg_rating
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name,
    p.team
HAVING AVG(pms.player_rating) >
(
    SELECT AVG(player_rating)
    FROM player_match_stats
)
ORDER BY avg_rating DESC;

/*
=========================================================
Question 3 : Best Player From Every Team
=========================================================

Purpose:
Find the highest-rated player from each team.

SQL Concepts:
• CTE
• RANK()
=========================================================
*/

WITH player_rating AS (
    SELECT
        p.team,
        p.player_name,
        ROUND(AVG(pms.player_rating),2) AS avg_rating,
        RANK() OVER(
            PARTITION BY p.team
            ORDER BY AVG(pms.player_rating) DESC
        ) AS team_rank
    FROM players p
    JOIN player_match_stats pms USING(player_id)
    GROUP BY
        p.player_id,
        p.player_name,
        p.team
)
SELECT
    team,
    player_name,
    avg_rating
FROM player_rating
WHERE team_rank = 1
ORDER BY avg_rating DESC;

/*
=========================================================
Question 4 : Players Scoring Above Their Team Average
=========================================================

Purpose:
Find players who scored more goals than their team's average.

SQL Concepts:
• CTE
• Subquery
=========================================================
*/

WITH player_goals AS (
    SELECT
        p.player_id,
        p.player_name,
        p.team,
        SUM(pms.goals) AS total_goals
    FROM players p
    JOIN player_match_stats pms USING(player_id)
    GROUP BY
        p.player_id,
        p.player_name,
        p.team
)
SELECT
    player_name,
    team,
    total_goals
FROM player_goals pg
WHERE total_goals >
(
    SELECT AVG(total_goals)
    FROM player_goals
    WHERE team = pg.team
)
ORDER BY total_goals DESC;

/*
=========================================================
Question 5 : Teams Scoring Above Tournament Average
=========================================================

Purpose:
Find teams whose total goals are above the tournament average.

SQL Concepts:
• CTE
• Subquery
=========================================================
*/

WITH team_goals AS (
    SELECT
        p.team,
        SUM(pms.goals) AS total_goals
    FROM players p
    JOIN player_match_stats pms USING(player_id)
    GROUP BY p.team
)
SELECT
    team,
    total_goals
FROM team_goals
WHERE total_goals >
(
    SELECT AVG(total_goals)
    FROM team_goals
)
ORDER BY total_goals DESC;

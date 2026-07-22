/*
=========================================================
FIFA WORLD CUP SQL ANALYTICS PROJECT

File: 06_advanced_sql.sql

Description:
Demonstrates advanced SQL concepts using the
normalized FIFA World Cup database.

Topics Covered:
• Subqueries
• Correlated Subqueries
• Common Table Expressions (CTEs)
• Window Functions
• Views
=========================================================
*/
/*
=========================================================
Question 1 : Top Goal Scorer using CTE
=========================================================

Purpose:
Find the top goal scorers using a Common Table Expression.

Business Value:
Demonstrates modular query writing using CTEs for readability
and maintainability.

=========================================================
*/

WITH player_goals AS (
    SELECT
        p.player_id,
        p.player_name,
        SUM(pms.goals) AS total_goals
    FROM players p
    JOIN player_match_stats pms USING(player_id)
    GROUP BY
        p.player_id,
        p.player_name
)
SELECT *
FROM player_goals
ORDER BY total_goals DESC
LIMIT 10;

/*
=========================================================
Question 2 : Players Above Average Rating
=========================================================

Purpose:
Find players whose average rating is higher than the
overall average player rating.

Business Value:
Identifies players performing above the tournament average
using a subquery.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    ROUND(AVG(pms.player_rating), 2) AS avg_rating
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
HAVING AVG(pms.player_rating) > (
    SELECT AVG(player_rating)
    FROM player_match_stats
)
ORDER BY avg_rating DESC;

/*
=========================================================
Question 3 : Best Rated Player in Each Team
=========================================================

Purpose:
Find the highest-rated player from every team.

Business Value:
Helps identify each team's best-performing player.

=========================================================
*/

SELECT
    p.team,
    p.player_name,
    ROUND(AVG(pms.player_rating),2) AS avg_rating
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name,
    p.team
HAVING AVG(pms.player_rating) >= ALL (
    SELECT AVG(pms2.player_rating)
    FROM players p2
    JOIN player_match_stats pms2 USING(player_id)
    WHERE p2.team = p.team
    GROUP BY p2.player_id
)
ORDER BY avg_rating DESC;

/*
=========================================================
Question 4 : Players Above Team Average Goals
=========================================================

Purpose:
Find players who scored more goals than the average
goal count of their own team.

Business Value:
Identifies standout goal scorers within each team.

=========================================================
*/

SELECT
    p.player_name,
    p.team,
    SUM(pms.goals) AS total_goals
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name,
    p.team
HAVING SUM(pms.goals) > (
    SELECT AVG(team_goals)
    FROM (
        SELECT SUM(pms2.goals) AS team_goals
        FROM players p2
        JOIN player_match_stats pms2 USING(player_id)
        WHERE p2.team = p.team
        GROUP BY p2.player_id
    ) t
)
ORDER BY total_goals DESC;

/*
=========================================================
Question 5 : Teams Having More Than Average Goals
=========================================================

Purpose:
Find teams whose total goals are above the tournament
average.

Business Value:
Highlights the strongest attacking teams.

=========================================================
*/

SELECT
    team,
    SUM(goals) AS total_goals
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY team
HAVING SUM(goals) > (
    SELECT AVG(team_goals)
    FROM (
        SELECT
            team,
            SUM(goals) AS team_goals
        FROM players p2
        JOIN player_match_stats pms2 USING(player_id)
        GROUP BY team
    ) avg_team
)
ORDER BY total_goals DESC;



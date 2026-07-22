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

/*
#########################################################
        WINDOW FUNCTIONS
#########################################################
*/

/*
=========================================================
Question 6 : Top 3 Highest Rated Players From Each Team
=========================================================

Purpose:
Find the top 3 highest-rated players from every team.

SQL Concepts:
• ROW_NUMBER()
• Window Functions

=========================================================
*/

WITH player_ratings AS (
    SELECT
        p.team,
        p.player_name,
        ROUND(AVG(pms.player_rating),2) AS avg_rating,
        ROW_NUMBER() OVER(
            PARTITION BY p.team
            ORDER BY AVG(pms.player_rating) DESC
        ) AS ranking
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
FROM player_ratings
WHERE ranking <= 3
ORDER BY team, avg_rating DESC;

/*
=========================================================
Question 7 : Rank Players By Total Goals
=========================================================

Purpose:
Assign rankings based on total goals scored.

SQL Concepts:
• RANK()
• Window Functions

=========================================================
*/

WITH goal_stats AS (
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
)
SELECT
    player_name,
    team,
    total_goals,
    RANK() OVER(
        ORDER BY total_goals DESC
    ) AS player_rank
FROM goal_stats;

/*
=========================================================
Question 8 : Dense Ranking Based On Average Rating
=========================================================

Purpose:
Assign dense ranks to players based on average rating.

SQL Concepts:
• DENSE_RANK()

=========================================================
*/

WITH ratings AS (
    SELECT
        p.player_name,
        p.team,
        ROUND(AVG(pms.player_rating),2) AS avg_rating
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
    avg_rating,
    DENSE_RANK() OVER(
        ORDER BY avg_rating DESC
    ) AS rating_rank
FROM ratings;

/*
=========================================================
Question 9 : Compare Current Match Rating With Previous Match
=========================================================

Purpose:
Compare each player's rating with their previous match.

SQL Concepts:
• LAG()

=========================================================
*/

SELECT
    player_id,
    match_id,
    player_rating,
    LAG(player_rating) OVER(
        PARTITION BY player_id
        ORDER BY match_id
    ) AS previous_rating
FROM player_match_stats;

/*
=========================================================
Question 10 : Compare Current Match Rating With Next Match
=========================================================

Purpose:
Compare each player's current rating with the next match.

SQL Concepts:
• LEAD()

=========================================================
*/

SELECT
    player_id,
    match_id,
    player_rating,
    LEAD(player_rating) OVER(
        PARTITION BY player_id
        ORDER BY match_id
    ) AS next_rating
FROM player_match_stats;

/*
#########################################################
        ADVANCED ANALYTICAL SQL
#########################################################
*/
/*
=========================================================
Question 11 : Divide Players Into Performance Quartiles
=========================================================

Purpose:
Divide players into four performance groups based on
their average rating.

SQL Concepts:
• NTILE()

=========================================================
*/

WITH player_ratings AS (
    SELECT
        p.player_name,
        p.team,
        ROUND(AVG(pms.player_rating),2) AS avg_rating
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
    avg_rating,
    NTILE(4) OVER(
        ORDER BY avg_rating DESC
    ) AS performance_group
FROM player_ratings;

/*
=========================================================
Question 12 : Running Total Of Goals
=========================================================

Purpose:
Calculate cumulative goals scored by players.

SQL Concepts:
• SUM() OVER()

=========================================================
*/

WITH goal_stats AS (
    SELECT
        p.player_name,
        SUM(pms.goals) AS total_goals
    FROM players p
    JOIN player_match_stats pms USING(player_id)
    GROUP BY
        p.player_id,
        p.player_name
)
SELECT
    player_name,
    total_goals,
    SUM(total_goals) OVER(
        ORDER BY total_goals DESC
    ) AS running_total
FROM goal_stats;

/*
=========================================================
Question 13 : Running Average Player Rating
=========================================================

Purpose:
Calculate the cumulative average rating of players.

SQL Concepts:
• AVG() OVER()

=========================================================
*/

WITH ratings AS (
    SELECT
        p.player_name,
        ROUND(AVG(pms.player_rating),2) AS avg_rating
    FROM players p
    JOIN player_match_stats pms USING(player_id)

    GROUP BY
        p.player_id,
        p.player_name
)
SELECT
    player_name,
    avg_rating,
    ROUND(
        AVG(avg_rating) OVER(
            ORDER BY avg_rating DESC
        ),
        2
    ) AS running_average
FROM ratings;

/*
=========================================================
Question 14 : Percentage Rank Of Players
=========================================================

Purpose:
Calculate each player's percentile rank based on
average rating.

SQL Concepts:
• PERCENT_RANK()

=========================================================
*/

WITH ratings AS (
    SELECT
        p.player_name,
        p.team,
        ROUND(AVG(pms.player_rating),2) AS avg_rating
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
    avg_rating,
    ROUND(
        PERCENT_RANK() OVER(
            ORDER BY avg_rating
        ),
        2
    ) AS percentile_rank
FROM ratings;

/*
=========================================================
Question 15 : Cumulative Distribution Of Player Ratings
=========================================================

Purpose:
Calculate cumulative distribution of players based on
average rating.

SQL Concepts:
• CUME_DIST()

=========================================================
*/

WITH ratings AS (
    SELECT
        p.player_name,
        p.team,
        ROUND(AVG(pms.player_rating),2) AS avg_rating
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
    avg_rating,
    ROUND(
        CUME_DIST() OVER(
            ORDER BY avg_rating
        ),
        2
    ) AS cumulative_distribution
FROM ratings;

/*
#########################################################
        ADVANCED REPORTING
#########################################################
*/
/*
=========================================================
Question 16 : Top 5 Goal Contributors
=========================================================

Purpose:
Find players with the highest combined goals and assists.

SQL Concepts:
• CTE
• Aggregate Functions

=========================================================
*/

WITH contributions AS (
    SELECT
        p.player_name,
        p.team,
        SUM(pms.goals) AS total_goals,
        SUM(pms.assists) AS total_assists,
        SUM(pms.goals + pms.assists) AS goal_contributions
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
    total_goals,
    total_assists,
    goal_contributions
FROM contributions
ORDER BY goal_contributions DESC
LIMIT 5;

/*
=========================================================
Question 17 : Most Consistent Players
=========================================================

Purpose:
Find players with the lowest variation in match ratings.

SQL Concepts:
• STDDEV()

=========================================================
*/

SELECT
    p.player_name,
    p.team,
    ROUND(AVG(pms.player_rating),2) AS avg_rating,
    ROUND(STDDEV(pms.player_rating),2) AS rating_variation
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name,
    p.team
HAVING COUNT(*) >= 5
ORDER BY rating_variation ASC;

/*
=========================================================
Question 18 : Best Passing Teams
=========================================================

Purpose:
Find teams with the highest average pass accuracy.

SQL Concepts:
• Aggregate Functions

=========================================================
*/

SELECT
    p.team,
    ROUND(AVG(pms.pass_accuracy),2) AS avg_pass_accuracy
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY p.team
ORDER BY avg_pass_accuracy DESC;

/*
=========================================================
Question 19 : Highest Rated Tournament Stages
=========================================================

Purpose:
Compare average player ratings across tournament stages.

SQL Concepts:
• JOIN
• GROUP BY

=========================================================
*/

SELECT
    m.tournament_stage,
    ROUND(AVG(pms.player_rating),2) AS avg_rating
FROM matches m
JOIN player_match_stats pms USING(match_id)
GROUP BY
    m.tournament_stage
ORDER BY avg_rating DESC;

/*
=========================================================
Question 20 : Best Defensive Teams
=========================================================

Purpose:
Find teams with the highest average defensive contribution.

SQL Concepts:
• Aggregate Functions

=========================================================
*/

SELECT
    p.team,
    ROUND(AVG(pms.defensive_contribution),2) AS avg_defense
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.team
ORDER BY avg_defense DESC;

/*
=========================================================
END OF FILE

Advanced SQL concepts covered:

• Common Table Expressions (CTEs)
• Subqueries
• Correlated Subqueries
• Window Functions
• Analytical SQL
• Advanced Reporting

Project:
FIFA World Cup SQL Analytics

=========================================================
*/


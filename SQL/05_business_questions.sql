/*
=========================================================
FIFA WORLD CUP SQL ANALYTICS PROJECT

File: 05_business_questions.sql

Description:
This file contains business-oriented SQL questions
and solutions used to analyze FIFA World Cup data.

The queries demonstrate SQL concepts such as:

• Joins
• Aggregate Functions
• GROUP BY
• HAVING
• ORDER BY
• LIMIT

=========================================================
*/
/*
=========================================================
Question 1 : Top 10 Goal Scorers
=========================================================

Purpose:
Identify the players who scored the highest number
of goals across all matches.

Business Value:
Helps identify the tournament's most effective
goal scorers.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    SUM(pms.goals) AS total_goals
FROM players p
JOIN player_match_stats pms
USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY total_goals DESC
LIMIT 10;

/*
=========================================================
Question 2 : Top Rated Players
=========================================================

Purpose:
Find the players with the highest average rating,
considering only those who have played at least
5 matches.

Business Value:
Identifies the tournament's most consistent
high-performing players.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    ROUND(AVG(pms.player_rating), 2) AS avg_rating,
    COUNT(pms.match_id) AS matches_played
FROM players p
JOIN player_match_stats pms
USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
HAVING COUNT(pms.match_id) >= 5
ORDER BY
    avg_rating DESC
LIMIT 5;

/*
=========================================================
Question 3 : Players with Most Assists
=========================================================

Purpose:
Find the players who have provided the highest
number of assists across all matches.

Business Value:
Highlights the tournament's best playmakers and
chance creators.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    SUM(pms.assists) AS total_assists
FROM players p
JOIN player_match_stats pms
USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY
    total_assists DESC
LIMIT 10;

/*
=========================================================
Question 4 : Players with Highest Pass Accuracy
=========================================================

Purpose:
Identify the players with the highest average pass
accuracy across all matches.

Business Value:
Helps evaluate players who maintain excellent
passing efficiency and ball distribution.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    ROUND(AVG(pms.pass_accuracy), 2) AS avg_pass_accuracy
FROM players p
JOIN player_match_stats pms
USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY
    avg_pass_accuracy DESC
LIMIT 10;

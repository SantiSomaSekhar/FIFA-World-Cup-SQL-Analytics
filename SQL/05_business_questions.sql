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

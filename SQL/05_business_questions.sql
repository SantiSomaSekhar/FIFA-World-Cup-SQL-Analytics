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
#########################################################
                PLAYER PERFORMANCE
#########################################################
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

/*
=========================================================
Question 5 : Players Who Played the Most Minutes
=========================================================

Purpose:
Find the players who have played the highest total
number of minutes in the tournament.

Business Value:
Identifies the most trusted and frequently used
players.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    SUM(pms.minutes_played) AS total_minutes
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY
    total_minutes DESC
LIMIT 10;

/*
=========================================================
Question 6 : Players with Highest Goal Contributions
=========================================================

Purpose:
Find players who contributed the most goals and
assists combined.

Business Value:
Highlights players with the greatest attacking
impact.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    SUM(pms.goals + pms.assists) AS goal_contributions
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY
    goal_contributions DESC
LIMIT 10;

/*
=========================================================
Question 7 : Players with Most Yellow Cards
=========================================================

Purpose:
Identify the players who received the highest
number of yellow cards.

Business Value:
Helps analyze player discipline.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    SUM(pms.yellow_cards) AS total_yellow_cards
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY
    total_yellow_cards DESC
LIMIT 10;

/*
=========================================================
Question 8 : Players with Most Red Cards
=========================================================

Purpose:
Identify the players who received the highest
number of red cards.

Business Value:
Measures disciplinary issues and player behavior.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    SUM(pms.red_cards) AS total_red_cards
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY
    total_red_cards DESC
LIMIT 10;

/*
=========================================================
Question 9 : Best Defensive Players
=========================================================

Purpose:
Find players with the highest total defensive
actions.

Business Value:
Highlights players with strong defensive
contributions.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    SUM(
        pms.tackles +
        pms.interceptions +
        pms.clearances +
        pms.blocks
    ) AS defensive_actions
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
ORDER BY
    defensive_actions DESC
LIMIT 10;

/*
=========================================================
Question 10 : Most Consistent Players
=========================================================

Purpose:
Identify players with the highest average performance
score who have played at least 5 matches.

Business Value:
Highlights players who consistently perform at a
high level throughout the tournament.

=========================================================
*/

SELECT
    p.player_id,
    p.player_name,
    ROUND(AVG(pms.performance_score), 2) AS avg_performance,
    COUNT(pms.match_id) AS matches_played
FROM players p
JOIN player_match_stats pms
USING(player_id)
GROUP BY
    p.player_id,
    p.player_name
HAVING COUNT(pms.match_id) >= 5
ORDER BY
    avg_performance DESC
LIMIT 10;

/*
#########################################################
                 TEAM PERFORMANCE
#########################################################
*/

/*
=========================================================
Question 11 : Teams with Highest Average Player Rating
=========================================================

Purpose:
Calculate the average player rating for each team.

Business Value:
Helps compare the overall quality of team
performances.

=========================================================
*/

SELECT
    p.team,
    ROUND(AVG(pms.player_rating), 2) AS avg_rating
FROM players p
JOIN player_match_stats pms
USING(player_id)
GROUP BY
    p.team
ORDER BY
    avg_rating DESC;

/*
=========================================================
Question 12 : Teams Scoring the Most Goals
=========================================================

Purpose:
Find the teams whose players scored the highest
number of goals.

Business Value:
Measures overall attacking strength.

=========================================================
*/

SELECT
    p.team,
    SUM(pms.goals) AS total_goals
FROM players p
JOIN player_match_stats pms
USING(player_id)
GROUP BY
    p.team
ORDER BY
    total_goals DESC;

/*
=========================================================
Question 13 : Teams with Highest Average Pass Accuracy
=========================================================

Purpose:
Compare the passing efficiency of all teams.

Business Value:
Evaluates ball retention and passing quality.

=========================================================
*/

SELECT
    p.team,
    ROUND(AVG(pms.pass_accuracy), 2) AS avg_pass_accuracy
FROM players p
JOIN player_match_stats pms
USING(player_id)
GROUP BY
    p.team
ORDER BY
    avg_pass_accuracy DESC;

/*
=========================================================
Question 14 : Teams with Most Assists
=========================================================

Purpose:
Identify teams that created the highest number
of goals through assists.

Business Value:
Measures teamwork and chance creation.

=========================================================
*/

SELECT
    p.team,
    SUM(pms.assists) AS total_assists
FROM players p
JOIN player_match_stats pms
USING(player_id)
GROUP BY
    p.team
ORDER BY
    total_assists DESC;

/*
=========================================================
Question 15 : Teams with Most Yellow Cards
=========================================================

Purpose:
Identify teams with the highest number of
yellow cards.

Business Value:
Measures overall team discipline.

=========================================================
*/

SELECT
    p.team,
    SUM(pms.yellow_cards) AS total_yellow_cards
FROM players p
JOIN player_match_stats pms
USING(player_id)
GROUP BY
    p.team
ORDER BY
    total_yellow_cards DESC;

/*
#########################################################
                  MATCH ANALYSIS
#########################################################
*/

/*
=========================================================
Question 16 : Stadiums Hosting the Most Matches
=========================================================

Purpose:
Find the stadiums that hosted the highest number
of matches.

Business Value:
Helps identify the busiest tournament venues.

=========================================================
*/

SELECT
    stadium,
    COUNT(match_id) AS total_matches
FROM matches
GROUP BY stadium
ORDER BY total_matches DESC;

/*
=========================================================
Question 17 : Stadium with Highest Average Goals per Match
=========================================================

Purpose:
Calculate the average number of goals scored per
match at each stadium.

Business Value:
Identifies the most entertaining stadiums based
on goal-scoring.

=========================================================
*/

SELECT
    stadium,
    ROUND(AVG(goals_team + goals_opponent), 2) AS avg_goals
FROM matches
GROUP BY stadium
ORDER BY avg_goals DESC;

/*
=========================================================
Question 18 : Tournament Stages with Most Matches
=========================================================

Purpose:
Count the number of matches played in each
tournament stage.

Business Value:
Provides an overview of tournament structure.

=========================================================
*/

SELECT
    tournament_stage,
    COUNT(match_id) AS total_matches
FROM matches
GROUP BY tournament_stage
ORDER BY total_matches DESC;

/*
=========================================================
Question 19 : Tournament Stages with Highest Average Goals
=========================================================

Purpose:
Calculate the average goals scored in each
tournament stage.

Business Value:
Identifies which stages were the most exciting.

=========================================================
*/

SELECT
    tournament_stage,
    ROUND(AVG(goals_team + goals_opponent), 2) AS avg_goals
FROM matches
GROUP BY tournament_stage
ORDER BY avg_goals DESC;

/*
=========================================================
Question 20 : Cities Hosting the Most Matches
=========================================================

Purpose:
Find the cities that hosted the highest number
of matches.

Business Value:
Measures venue utilization across host cities.

=========================================================
*/

SELECT
    city,
    COUNT(match_id) AS total_matches
FROM matches
GROUP BY city
ORDER BY total_matches DESC;







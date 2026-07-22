/*
=========================================================
FIFA WORLD CUP SQL ANALYTICS PROJECT

File: 08_views.sql

Description:
Create reusable SQL Views for reporting,
analytics and dashboard development.

=========================================================
*/
/*
=========================================================
View 1 : Player Performance
=========================================================

Purpose:
Provides overall player statistics across all matches.
=========================================================
*/

CREATE VIEW vw_player_performance AS

SELECT
    p.player_id,
    p.player_name,
    p.team,
    SUM(pms.goals) AS total_goals,
    SUM(pms.assists) AS total_assists,
    ROUND(AVG(pms.player_rating),2) AS average_rating
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name,
    p.team;

/*
=========================================================
View 2 : Match Summary
=========================================================

Purpose:
Displays important match information.
=========================================================
*/

CREATE VIEW vw_match_summary AS

SELECT
    match_id,
    match_date,
    stadium,
    city,
    opponent_team,
    tournament_stage,
    match_result,
    goals_team,
    goals_opponent
FROM matches;

/*
=========================================================
View 3 : Team Performance
=========================================================

Purpose:
Shows team-wise goals and average player ratings.
=========================================================
*/

CREATE VIEW vw_team_performance AS

SELECT
    p.team,
    SUM(pms.goals) AS total_goals,
    ROUND(AVG(pms.player_rating),2) AS average_rating
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY p.team;

/*
=========================================================
View 4 : Tournament Leaders
=========================================================

Purpose:
Displays tournament totals for every player.
=========================================================
*/

CREATE VIEW vw_tournament_leaders AS

SELECT
    p.player_name,
    p.team,
    ts.total_goals_tournament,
    ts.total_assists_tournament,
    ts.tournament_rating
FROM tournament_summary ts
JOIN players p USING(player_id);

/*
=========================================================
View 5 : Defensive Performance
=========================================================

Purpose:
Displays defensive statistics for every player.
=========================================================
*/

CREATE VIEW vw_defensive_performance AS

SELECT
    p.player_name,
    p.team,
    SUM(pms.tackles) AS tackles,
    SUM(pms.interceptions) AS interceptions,
    SUM(pms.clearances) AS clearances,
    SUM(pms.blocks) AS blocks
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name,
    p.team;

/*
=========================================================
View 6 : Passing Statistics
=========================================================

Purpose:
Shows passing accuracy for each player.
=========================================================
*/

CREATE VIEW vw_passing_statistics AS

SELECT
    p.player_name,
    p.team,
    ROUND(AVG(pms.pass_accuracy),2) AS average_pass_accuracy,
    SUM(pms.successful_passes) AS successful_passes,
    SUM(pms.total_passes) AS total_passes
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name,
    p.team;

/*
=========================================================
View 7 : Goal Contributions
=========================================================

Purpose:
Displays total goal contributions by player.
=========================================================
*/

CREATE VIEW vw_goal_contributions AS

SELECT
    p.player_name,
    p.team,
    SUM(pms.goals + pms.assists) AS goal_contributions
FROM players p
JOIN player_match_stats pms USING(player_id)
GROUP BY
    p.player_id,
    p.player_name,
    p.team;

/*
=========================================================
View 8 : Match Ratings
=========================================================

Purpose:
Displays every player's rating in every match.
=========================================================
*/

CREATE VIEW vw_match_ratings AS

SELECT
    p.player_name,
    m.match_date,
    m.opponent_team,
    pms.player_rating
FROM player_match_stats pms
JOIN players p USING(player_id)
JOIN matches m USING(match_id);


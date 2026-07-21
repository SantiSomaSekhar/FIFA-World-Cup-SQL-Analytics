/*
=========================================================
FIFA WORLD CUP SQL ANALYTICS PROJECT

File: 03_data_normalization.sql

Description:
Populate the normalized tables from the staging table.
=========================================================
*/
/*
=========================================================
1. Populate Players Table
=========================================================
*/

INSERT INTO players (
    player_id, player_name, age, nationality,
    team, jersey_number, position,
    height_cm, weight_kg, preferred_foot,
    club_name, market_value_eur
)
SELECT DISTINCT
    player_id, player_name, age, nationality,
    team, jersey_number, position,
    height_cm, weight_kg, preferred_foot,
    club_name, market_value_eur
FROM staging_fifa_data;

/*
=========================================================
2. Populate Matches Table
=========================================================
*/

INSERT INTO matches (
    match_id, match_date,
    stadium, city,
    opponent_team,
    tournament_stage,
    match_result,
    goals_team,
    goals_opponent
)
SELECT
    match_id,
    MIN(match_date),
    MIN(stadium),
    MIN(city),
    MIN(opponent_team),
    MIN(tournament_stage),
    MIN(match_result),
    MIN(goals_team),
    MIN(goals_opponent)
FROM staging_fifa_data
GROUP BY match_id;

/*
=========================================================
3. Populate Player Match Statistics Table
=========================================================
*/

INSERT INTO player_match_stats (
    player_id, match_id,
    minutes_played, goals, assists,
    shots, shots_on_target, expected_goals_xg, expected_assists_xa,
    key_passes, successful_passes, total_passes, pass_accuracy,
    dribbles_attempted, successful_dribbles,
    crosses, successful_crosses,
    tackles, interceptions, clearances, blocks,
    aerial_duels_won, aerial_duels_lost,
    recoveries, defensive_actions,
    fouls_committed, fouls_suffered,
    yellow_cards, red_cards, offsides,
    saves, save_percentage, punches, clean_sheet,
    goals_conceded, penalty_saves,
    distance_covered_km, sprint_distance_km, top_speed_kmh,
    accelerations, decelerations,
    stamina_score, player_rating, performance_score,
    offensive_contribution, defensive_contribution,
    possession_impact, pressure_resistance,
    creativity_score, consistency_score, clutch_performance_score
)
SELECT
    player_id, match_id,
    minutes_played, goals, assists,
    shots, shots_on_target, expected_goals_xg, expected_assists_xa,
    key_passes, successful_passes, total_passes, pass_accuracy,
    dribbles_attempted, successful_dribbles,
    crosses, successful_crosses,
    tackles, interceptions, clearances, blocks,
    aerial_duels_won, aerial_duels_lost,
    recoveries, defensive_actions,
    fouls_committed, fouls_suffered,
    yellow_cards, red_cards, offsides,
    saves, save_percentage, punches, clean_sheet,
    goals_conceded, penalty_saves,
    distance_covered_km, sprint_distance_km, top_speed_kmh,
    accelerations, decelerations,
    stamina_score, player_rating, performance_score,
    offensive_contribution, defensive_contribution,
    possession_impact, pressure_resistance,
    creativity_score, consistency_score, clutch_performance_score
FROM staging_fifa_data;

/*
=========================================================
4. Populate Tournament Summary Table
=========================================================
*/

INSERT INTO tournament_summary 
  (
    player_id,
    total_goals_tournament,
    total_assists_tournament,
    total_minutes_tournament,
    player_of_match_awards,
    tournament_rating
)
SELECT
    player_id,
    MAX(total_goals_tournament),
    MAX(total_assists_tournament),
    MAX(total_minutes_tournament),
    MAX(player_of_match_awards),
    MAX(tournament_rating)
FROM staging_fifa_data

GROUP BY player_id;

/*
=========================================================
Normalization Summary
=========================================================

Source Table
------------
staging_fifa_data : 54,600 rows

Normalized Tables
-----------------
players             : 1,248 rows
matches             : 1,050 rows
player_match_stats  : 54,600 rows
tournament_summary  : 1,248 rows

=========================================================
*/






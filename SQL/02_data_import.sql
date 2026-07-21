/*
=========================================================
FIFA WORLD CUP SQL ANALYTICS PROJECT

File: 02_data_import.sql

Description:
Import the raw FIFA World Cup dataset into the
staging table.
=========================================================
*/

-- Enable local file import

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';

/*
=========================================================
Create Staging Table
=========================================================

Purpose:
Creates a temporary staging table to store the raw
FIFA World Cup dataset before normalization.

=========================================================
*/

CREATE TABLE staging_fifa_data (

    player_id VARCHAR(20),
    player_name VARCHAR(100),
    age TINYINT UNSIGNED,
    nationality VARCHAR(50),
    team VARCHAR(50),
    jersey_number TINYINT UNSIGNED,
    position VARCHAR(30),
    height_cm SMALLINT UNSIGNED,
    weight_kg SMALLINT UNSIGNED,
    preferred_foot VARCHAR(10),
    club_name VARCHAR(100),
    market_value_eur BIGINT UNSIGNED,

    match_id VARCHAR(20),
    match_date DATE,
    stadium VARCHAR(100),
    city VARCHAR(50),
    opponent_team VARCHAR(50),
    tournament_stage VARCHAR(30),
    match_result VARCHAR(20),
    goals_team TINYINT UNSIGNED,
    goals_opponent TINYINT UNSIGNED,

    minutes_played TINYINT UNSIGNED,

    goals TINYINT UNSIGNED,
    assists TINYINT UNSIGNED,
    shots TINYINT UNSIGNED,
    shots_on_target TINYINT UNSIGNED,

    expected_goals_xg DECIMAL(5,2),
    expected_assists_xa DECIMAL(5,2),

    key_passes TINYINT UNSIGNED,
    successful_passes SMALLINT UNSIGNED,
    total_passes SMALLINT UNSIGNED,
    pass_accuracy DECIMAL(5,2),

    dribbles_attempted TINYINT UNSIGNED,
    successful_dribbles TINYINT UNSIGNED,

    crosses TINYINT UNSIGNED,
    successful_crosses TINYINT UNSIGNED,

    tackles TINYINT UNSIGNED,
    interceptions TINYINT UNSIGNED,
    clearances TINYINT UNSIGNED,
    blocks TINYINT UNSIGNED,

    aerial_duels_won TINYINT UNSIGNED,
    aerial_duels_lost TINYINT UNSIGNED,

    recoveries TINYINT UNSIGNED,
    defensive_actions TINYINT UNSIGNED,

    fouls_committed TINYINT UNSIGNED,
    fouls_suffered TINYINT UNSIGNED,

    yellow_cards TINYINT UNSIGNED,
    red_cards TINYINT UNSIGNED,
    offsides TINYINT UNSIGNED,

    saves TINYINT UNSIGNED,
    save_percentage DECIMAL(5,2),
    punches TINYINT UNSIGNED,
    clean_sheet BOOLEAN,
    goals_conceded TINYINT UNSIGNED,
    penalty_saves TINYINT UNSIGNED,

    distance_covered_km DECIMAL(5,2),
    sprint_distance_km DECIMAL(5,2),
    top_speed_kmh DECIMAL(5,2),

    accelerations SMALLINT UNSIGNED,
    decelerations SMALLINT UNSIGNED,

    stamina_score DECIMAL(5,2),

    player_rating DECIMAL(5,2),
    performance_score DECIMAL(5,2),

    offensive_contribution DECIMAL(5,2),
    defensive_contribution DECIMAL(5,2),

    possession_impact DECIMAL(5,2),
    pressure_resistance DECIMAL(5,2),

    creativity_score DECIMAL(5,2),
    consistency_score DECIMAL(5,2),
    clutch_performance_score DECIMAL(5,2),

    total_goals_tournament SMALLINT UNSIGNED,
    total_assists_tournament SMALLINT UNSIGNED,
    total_minutes_tournament SMALLINT UNSIGNED,
    player_of_match_awards TINYINT UNSIGNED,
    tournament_rating DECIMAL(5,2)

);

-- Load CSV into staging table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/fifa_world_cup_2026_player_performance.csv'
INTO TABLE staging_fifa_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

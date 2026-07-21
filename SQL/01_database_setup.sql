-- ==========================================
-- FIFA World Cup SQL Analytics Project
-- File: 01_database_setup.sql
-- Description:
-- Creates the database and all normalized tables.
-- ==========================================

-- Create Database

CREATE DATABASE fifa_world_cup;

USE fifa_world_cup;

/*
=========================================================
1. Players Table
=========================================================
*/

CREATE TABLE players (
    player_id VARCHAR(20) PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    age TINYINT UNSIGNED NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    team VARCHAR(50) NOT NULL,
    jersey_number TINYINT UNSIGNED,
    position VARCHAR(30) NOT NULL,
    height_cm SMALLINT UNSIGNED,
    weight_kg SMALLINT UNSIGNED,
    preferred_foot VARCHAR(10),
    club_name VARCHAR(100),
    market_value_eur BIGINT UNSIGNED
);

/*
=========================================================
2. Matches Table
=========================================================
*/

CREATE TABLE matches (
    match_id VARCHAR(20) PRIMARY KEY,
    match_date DATE NOT NULL,
    stadium VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    opponent_team VARCHAR(50) NOT NULL,
    tournament_stage VARCHAR(30) NOT NULL,
    match_result VARCHAR(20) NOT NULL,
    goals_team TINYINT UNSIGNED,
    goals_opponent TINYINT UNSIGNED
);

/*
=========================================================
3. Player Match Statistics Table
=========================================================
*/

CREATE TABLE player_match_stats (
    stat_id INT AUTO_INCREMENT PRIMARY KEY,
    player_id VARCHAR(20) NOT NULL,
    match_id VARCHAR(20) NOT NULL,
    minutes_played INT,
    goals INT,
    assists INT,
    shots INT,
    shots_on_target INT,
    expected_goals_xg DECIMAL(6,2),
    expected_assists_xa DECIMAL(6,2),
    key_passes INT,
    successful_passes INT,
    total_passes INT,
    pass_accuracy DECIMAL(5,2),
    dribbles_attempted INT,
    successful_dribbles INT,
    crosses INT,
    successful_crosses INT,
    tackles INT,
    interceptions INT,
    clearances INT,
    blocks INT,
    aerial_duels_won INT,
    aerial_duels_lost INT,
    recoveries INT,
    defensive_actions INT,
    fouls_committed INT,
    fouls_suffered INT,
    yellow_cards INT,
    red_cards INT,
    offsides INT,
    saves INT,
    save_percentage DECIMAL(5,2),
    punches INT,
    clean_sheet INT,
    goals_conceded INT,
    penalty_saves INT,
    distance_covered_km DECIMAL(6,2),
    sprint_distance_km DECIMAL(6,2),
    top_speed_kmh DECIMAL(5,2),
    accelerations INT,
    decelerations INT,
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
    CONSTRAINT fk_player
        FOREIGN KEY (player_id)
        REFERENCES players(player_id),
    CONSTRAINT fk_match
        FOREIGN KEY (match_id)
        REFERENCES matches(match_id),
    CONSTRAINT uq_player_match
        UNIQUE (player_id, match_id)
) ENGINE=InnoDB;

/*
=========================================================
4. Tournament Summary Table
=========================================================
*/

CREATE TABLE tournament_summary (
    player_id VARCHAR(20) PRIMARY KEY,
    total_goals_tournament INT,
    total_assists_tournament INT,
    total_minutes_tournament INT,
    player_of_match_awards INT,
    tournament_rating DECIMAL(5,2),
    CONSTRAINT fk_summary_player
        FOREIGN KEY (player_id)
        REFERENCES players(player_id)
);


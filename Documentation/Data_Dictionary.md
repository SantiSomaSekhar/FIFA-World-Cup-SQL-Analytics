# Data Dictionary

## Project

**FIFA World Cup SQL Analytics**

This document describes the database schema used in the FIFA World Cup SQL Analytics project.

---

# Table: players

| Column           | Data Type         | Description                            |
| ---------------- | ----------------- | -------------------------------------- |
| player_id        | VARCHAR(20)       | Unique player identifier (Primary Key) |
| player_name      | VARCHAR(100)      | Full name of the player                |
| age              | TINYINT UNSIGNED  | Player age                             |
| nationality      | VARCHAR(50)       | Player nationality                     |
| team             | VARCHAR(50)       | National team                          |
| jersey_number    | TINYINT UNSIGNED  | Jersey number                          |
| position         | VARCHAR(30)       | Playing position                       |
| height_cm        | SMALLINT UNSIGNED | Height (cm)                            |
| weight_kg        | SMALLINT UNSIGNED | Weight (kg)                            |
| preferred_foot   | VARCHAR(10)       | Preferred foot                         |
| club_name        | VARCHAR(100)      | Current club                           |
| market_value_eur | BIGINT UNSIGNED   | Estimated market value (EUR)           |

---

# Table: matches

| Column           | Data Type        | Description                           |
| ---------------- | ---------------- | ------------------------------------- |
| match_id         | VARCHAR(20)      | Unique match identifier (Primary Key) |
| match_date       | DATE             | Match date                            |
| stadium          | VARCHAR(100)     | Stadium name                          |
| city             | VARCHAR(50)      | Host city                             |
| opponent_team    | VARCHAR(50)      | Opponent team                         |
| tournament_stage | VARCHAR(30)      | Tournament stage                      |
| match_result     | VARCHAR(20)      | Match result                          |
| goals_team       | TINYINT UNSIGNED | Goals scored by the player's team     |
| goals_opponent   | TINYINT UNSIGNED | Goals scored by the opponent          |

---

# Table: player_match_stats

| Column                   | Data Type    | Description                                |
| ------------------------ | ------------ | ------------------------------------------ |
| stat_id                  | INT          | Statistics record identifier (Primary Key) |
| player_id                | VARCHAR(20)  | References players.player_id (Foreign Key) |
| match_id                 | VARCHAR(20)  | References matches.match_id (Foreign Key)  |
| minutes_played           | INT          | Minutes played                             |
| goals                    | INT          | Goals scored                               |
| assists                  | INT          | Assists                                    |
| shots                    | INT          | Total shots                                |
| shots_on_target          | INT          | Shots on target                            |
| expected_goals_xg        | DECIMAL(6,2) | Expected goals (xG)                        |
| expected_assists_xa      | DECIMAL(6,2) | Expected assists (xA)                      |
| key_passes               | INT          | Key passes                                 |
| successful_passes        | INT          | Successful passes                          |
| total_passes             | INT          | Total passes                               |
| pass_accuracy            | DECIMAL(5,2) | Pass accuracy (%)                          |
| dribbles_attempted       | INT          | Dribbles attempted                         |
| successful_dribbles      | INT          | Successful dribbles                        |
| crosses                  | INT          | Crosses attempted                          |
| successful_crosses       | INT          | Successful crosses                         |
| tackles                  | INT          | Tackles                                    |
| interceptions            | INT          | Interceptions                              |
| clearances               | INT          | Clearances                                 |
| blocks                   | INT          | Blocks                                     |
| aerial_duels_won         | INT          | Aerial duels won                           |
| aerial_duels_lost        | INT          | Aerial duels lost                          |
| recoveries               | INT          | Ball recoveries                            |
| defensive_actions        | INT          | Total defensive actions                    |
| fouls_committed          | INT          | Fouls committed                            |
| fouls_suffered           | INT          | Fouls suffered                             |
| yellow_cards             | INT          | Yellow cards                               |
| red_cards                | INT          | Red cards                                  |
| offsides                 | INT          | Offsides                                   |
| saves                    | INT          | Goalkeeper saves                           |
| save_percentage          | DECIMAL(5,2) | Save percentage                            |
| punches                  | INT          | Goalkeeper punches                         |
| clean_sheet              | INT          | Clean sheet indicator                      |
| goals_conceded           | INT          | Goals conceded                             |
| penalty_saves            | INT          | Penalty saves                              |
| distance_covered_km      | DECIMAL(6,2) | Distance covered (km)                      |
| sprint_distance_km       | DECIMAL(6,2) | Sprint distance (km)                       |
| top_speed_kmh            | DECIMAL(5,2) | Top speed (km/h)                           |
| accelerations            | INT          | Accelerations                              |
| decelerations            | INT          | Decelerations                              |
| stamina_score            | DECIMAL(5,2) | Stamina score                              |
| player_rating            | DECIMAL(5,2) | Overall player rating                      |
| performance_score        | DECIMAL(5,2) | Performance score                          |
| offensive_contribution   | DECIMAL(5,2) | Offensive contribution score               |
| defensive_contribution   | DECIMAL(5,2) | Defensive contribution score               |
| possession_impact        | DECIMAL(5,2) | Possession impact score                    |
| pressure_resistance      | DECIMAL(5,2) | Pressure resistance score                  |
| creativity_score         | DECIMAL(5,2) | Creativity score                           |
| consistency_score        | DECIMAL(5,2) | Consistency score                          |
| clutch_performance_score | DECIMAL(5,2) | Clutch performance score                   |

---

# Table: tournament_summary

| Column                   | Data Type    | Description                                   |
| ------------------------ | ------------ | --------------------------------------------- |
| player_id                | VARCHAR(20)  | Player identifier (Primary Key & Foreign Key) |
| total_goals_tournament   | INT          | Total tournament goals                        |
| total_assists_tournament | INT          | Total tournament assists                      |
| total_minutes_tournament | INT          | Total tournament minutes played               |
| player_of_match_awards   | INT          | Player of the Match awards                    |
| tournament_rating        | DECIMAL(5,2) | Overall tournament rating                     |

---

# Relationships

- **players (1) → player_match_stats (Many)** using `player_id`
- **matches (1) → player_match_stats (Many)** using `match_id`
- **players (1) → tournament_summary (1)** using `player_id`

---

# Constraints

### Primary Keys

- players.player_id
- matches.match_id
- player_match_stats.stat_id
- tournament_summary.player_id

### Foreign Keys

- player_match_stats.player_id → players.player_id
- player_match_stats.match_id → matches.match_id
- tournament_summary.player_id → players.player_id

### Unique Constraint

- `(player_id, match_id)` in **player_match_stats** ensures one statistics record per player per match.

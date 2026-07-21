/*
=========================================================
FIFA WORLD CUP SQL ANALYTICS PROJECT

File: 04_exploratory_analysis.sql

Description:
Explore the normalized database and understand
the structure and distribution of the data.

=========================================================
*/
/*
=========================================================
1. Total Players

Purpose:
Returns the total number of players available in the
Players table after database normalization.

=========================================================
*/

SELECT COUNT(*) AS total_players
FROM players;

/*
=========================================================
2. Total Matches

Purpose:
Returns the total number of unique matches played
during the tournament.

=========================================================
*/

SELECT COUNT(*) AS total_matches
FROM matches;

/*
=========================================================
3. Total Player Match Records

Purpose:
Returns the total number of player appearances
recorded across all matches.
Each row represents one player's statistics
for one match.

=========================================================
*/

SELECT COUNT(*) AS total_player_match_records
FROM player_match_stats;

/*
=========================================================
4. Total Tournament Summary Records

Purpose:
Returns the total number of tournament summary
records.
Each row represents one player's overall tournament
performance.

=========================================================
*/
SELECT COUNT(*) AS tournament_summary_records
FROM tournament_summary;

/*
=========================================================
5. Total Teams

Purpose:
Returns the total number of unique teams that
participated in the tournament.

=========================================================
*/

SELECT COUNT(DISTINCT team) AS total_teams
FROM players;

/*
=========================================================
6. List All Teams

Purpose:
Displays the names of all teams participating
in the tournament in alphabetical order.

=========================================================
*/

SELECT DISTINCT team
FROM players
ORDER BY team;

/*
=========================================================
7. Tournament Stages

Purpose:
Displays every tournament stage available
in the dataset.

=========================================================
*/

SELECT DISTINCT tournament_stage
FROM matches
ORDER BY tournament_stage;

/*
=========================================================
8. Stadiums Used

Purpose:
Displays all stadiums where tournament matches
were played.

=========================================================
*/

SELECT DISTINCT stadium
FROM matches
ORDER BY stadium;

/*
=========================================================
9. Cities Hosting Matches

Purpose:
Displays all cities that hosted FIFA World Cup
matches.

=========================================================
*/

SELECT DISTINCT city
FROM matches
ORDER BY city;

/*
=========================================================
10. Player Positions

Purpose:
Displays all playing positions available in
the dataset.

=========================================================
*/

SELECT DISTINCT position
FROM players
ORDER BY position;

/*
=========================================================
Exploratory Analysis Summary

Purpose:
This file performs an initial exploration of the
normalized FIFA World Cup database.

The objective is to understand the overall structure
of the dataset before performing business analysis.

Exploration includes:

✔ Total Players
✔ Total Matches
✔ Total Player Match Records
✔ Tournament Summary Records
✔ Teams
✔ Stadiums
✔ Cities
✔ Tournament Stages
✔ Player Positions

=========================================================
*/

-- ==========================================
-- FIFA World Cup SQL Analytics Project
-- File: 02_data_import.sql
-- Description:
-- Import the raw FIFA World Cup dataset into
-- the staging table.
-- ==========================================

-- Enable local file import
SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';

-- Create staging table
-- (Paste your CREATE TABLE staging_fifa_data here)

-- Load CSV into staging table
-- (Paste your LOAD DATA LOCAL INFILE query here)

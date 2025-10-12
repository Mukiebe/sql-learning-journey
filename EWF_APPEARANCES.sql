CREATE DATABASE ewf_appearances;

-- Creating a table
CREATE TABLE matches (
	season VARCHAR(50),
    division VARCHAR(50),
    match_name VARCHAR(100),
    attendance INT,
    goals_for INT,
    goals_against INT,
    result VARCHAR(10),
    points INT
);
    
    -- Show table
    SHOW TABLES;
    

    -- Show table contents
    SELECT* FROM matches;
    
    -- Add columnns
    CREATE TABLE matches (
	season VARCHAR(50),
    division VARCHAR(50),
    match_name VARCHAR(100),
    attendance INT,
    goals_for INT,
    goals_against INT,
    result VARCHAR(10),
    points INT
);
INSERT INTO matches (
    season,
    division,
    match_name,
    attendance,
    goals_for,
    goals_against,
    result,
    points
    ) VALUES 
('2011-2011', 'FA Women''s Super League (WSL)', 'Chelsea Ladies vs Arsenal Ladies',
2510, 0, 1, 0, 0),
('2011-2011', 'FA Women''s Super League (WSL)', 'Lincoln Ladies vs Doncaster Rovers Belles',
742, 0, 1, 0, 0),
('2011-2011', 'FA Women''s Super League (WSL)', 'Birmingham City Ladies vs Bristol Academy',
602, 4, 0, 3, 3);

-- Show table
SELECT * FROM matches;

-- Change SQL updates
SET SQL_SAFE_UPDATES = 0;

-- Remove a row
DELETE FROM matches
WHERE attendance < 700;

-- adding a column
ALTER TABLE matches
ADD COLUMN comments VARCHAR(50);

-- Show table
SELECT * FROM matches;

-- Removing a column
ALTER TABLE matches
DROP COLUMN comments;

-- Show table
SELECT * FROM matches;


-- Adding comments
ALTER TABLE matches
ADD COLUMN comments ENUM('Bad','Good') NOT NULL DEFAULT 'Good' COMMENT 'Rate match as Good or Bad';

-- modify a column
ALTER TABLE matches
MODIFY COLUMN comments VARCHAR(100) DEFAULT '' COMMENT 'Optional match notes';

-- Show table
SELECT * FROM matches;

-- renaming a table
RENAME TABLE matches to WOMENS_FOOTBALL;

-- show table
SHOW TABLES;

-- Create a table for colleges with the following columns:
-- college_id: a unique identifier for each college (primary key)   
-- name: the name of the college (text, not null, unique)
-- address: the address of the college (text)

CREATE TABLE colleges (
    college_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    address TEXT
);

-- Create a table for tournaments with the following columns:
-- tournament_id: a unique identifier for each tournament (primary key) 
-- name: the name of the tournament (text, not null)
-- host_college_id: a foreign key referencing the college_id in the colleges table
-- start_date: the start date of the tournament (date)
-- end_date: the end date of the tournament (date)
-- Added a check constraint to ensure that the start_date is less than or equal to the end_date

CREATE TABLE tournament (
    tournament_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    host_college_id INT REFERENCES colleges(college_id),
    start_date DATE,
    end_date DATE,
    CHECK (start_date <= end_date)
);


-- Create a table for sports with the following columns:
-- sport_id: a unique identifier for each sport (primary key)   
-- name: the name of the sport (text, not null)
-- max_players: the maximum number of players allowed in the sport (integer, must be greater than 0)
-- registration_fee: the fee for registering in the sport (integer, must be non-negative)
-- type: the type of sport (text, must be either 'indoor' or 'outdoor')
-- scoring_type: the type of scoring used in the sport (text, must be either 'points' or 'time')


CREATE TABLE sport (
    sport_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    max_players INT CHECK (max_players > 0),
    registration_fee INT CHECK (registration_fee >= 0),
    type TEXT CHECK (type IN ('indoor', 'outdoor')),
    scoring_type TEXT CHECK (scoring_type IN ('points', 'time')),
    eligibility_criteria INT CHECK (eligibility_criteria >= 18 AND eligibility_criteria <= 25)
);


-- Create a table for registration with the following columns:
-- registration_id: a unique identifier for each registration (primary key)
-- tournament_id: a foreign key referencing the tournament_id in the tournament table
-- sport_id: a foreign key referencing the sport_id in the sport table
-- college_id: a foreign key referencing the college_id in the colleges table
-- team_name: the name of the team registering for the sport (text, not null)
-- registration_date: the date and time when the registration was made (timestamp, default to current timestamp)
-- status: the status of the registration (text, default to 'pending')
-- Added a unique constraint to ensure that a college cannot register the same team for the same sport in the same tournament more than once


CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    tournament_id INT REFERENCES tournament(tournament_id) ON DELETE CASCADE,
    sport_id INT REFERENCES sport(sport_id),
    college_id INT REFERENCES colleges(college_id),
    team_name TEXT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status TEXT DEFAULT 'pending',
    UNIQUE (tournament_id, sport_id, college_id, team_name)
);


-- Create a table for players with the following columns:
-- player_id: a unique identifier for each player (primary key) 
-- registration_id: a foreign key referencing the registration_id in the registration table
-- name: the name of the player (text, not null)
-- dob: the date of birth of the player (date)
-- govt_id: the government ID of the player (text, unique)
-- prn: the PRN of the player (text, unique)
-- photo_url: the URL of the player's photo (text)
-- is_captain: a boolean indicating whether the player is the captain of the team (default to false)


CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    registration_id INT REFERENCES registration(registration_id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    dob DATE,
    govt_id TEXT UNIQUE,
    prn TEXT UNIQUE,
    photo_url TEXT,
    is_captain BOOLEAN DEFAULT FALSE
);
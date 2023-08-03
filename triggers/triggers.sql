-- creating a player table

CREATE TABLE player_table(
    player_id serial PRIMARY KEY,
    name varchar(100)
)

CREATE TABLE players_audits(
    players_audits_id serial PRIMARY KEY,
    player_id Int NOT NULL,
    name varchar(100) NOT NULL,
    edit_date timestamp NOT NULL
)
--view the player table

SELECT * FROM player_table;

--create a functions

CREATE OR REPLACE FUNCTION function_player_changes_log()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
BEGIN 
 IF NEW.name <> OLD.name THEN
 	INSERT INTO players_audits(
		player_id,
		name,
		edit_date
	)
 	VALUES (
		OLD.player_id,
		OLD.name,
		NOW()
	);
 END IF;
 RETURN NEW;
END;
$$

-- create a trigger functions 

CREATE TRIGGER tri_name_changes
	BEFORE UPDATE 
	ON player_table
	FOR EACH ROW 
	EXECUTE PROCEDURE function_player_changes_log()
	
-- insert some data in player table
INSERT INTO player_table (name) VALUES('siva'),('nagi');

-- update the data in player table
UPDATE player_table 
SET name ='Reddy'
WHERE player_id = 2

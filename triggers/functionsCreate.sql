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

--create a trigger functions

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


	
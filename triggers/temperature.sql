
-- creating a temperture table

CREATE TABLE t_temperture_log(
	id_temperture serial Primary key,
	add_date timestamp,
	temperture numeric
)
-- creating a functions

CREATE OR REPLACE FUNCTION fn_tri_temp_changes()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
	BEGIN 
    	IF New.temperture < -30 THEN
			 NEW.temperture = 0;
		END IF;
		
		RETURN NEW;
	END;
$$

CREATE TRIGGER tri_change_temperature
BEFORE INSERT 
ON t_temperture_log
FOR EACH ROW 
EXECUTE PROCEDURE fn_tri_temp_changes();

INSERT INTO t_temperture_log (add_date,temperture) values('03-11-2000',-40)

SELECT * FROM t_temperture_log
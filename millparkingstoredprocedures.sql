USE millparking;

-- -----------------------------------------------------
-- STORED PROCEDURES
-- -----------------------------------------------------
-- get_vacant_spaces()
-- ------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE get_vacant_spaces()
BEGIN
	SELECT * 
	FROM parking_space
	WHERE availability = "vacant";
END$$

DELIMITER ;
CALL get_vacant_spaces();

-- ----------------------------------------------------------------
-- space_ratings()
-- ---------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE space_ratings()
BEGIN
	SELECT parking_space_id
	FROM review
	WHERE rating > 4;
END$$

DELIMITER ;

CALL space_ratings();


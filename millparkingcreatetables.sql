-- -----------------------------------------------------
-- creating database - millparking
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS millparking; 
USE millparking ;


-- -----------------------------------------------------
-- Table millparking.space_owner
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.space_owner (
  space_owner_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  username VARCHAR(45) NOT NULL,
  password VARCHAR(25) NOT NULL,
  phone_no INT UNSIGNED NOT NULL,
  PRIMARY KEY (space_owner_id),
  UNIQUE INDEX space_owner_id_UNIQUE (space_owner_id ASC) VISIBLE,
  UNIQUE INDEX email_UNIQUE (email ASC) VISIBLE,
  UNIQUE INDEX username_UNIQUE (username ASC) VISIBLE)
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Creating Table millparking.staff
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.staff (
  staff_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  phone_no INT UNSIGNED NOT NULL,
  email VARCHAR(50) NOT NULL,
  username VARCHAR(45) NOT NULL,
  password VARCHAR(25) NOT NULL,
  PRIMARY KEY (staff_id),
  UNIQUE INDEX staff_id_UNIQUE (staff_id ASC) VISIBLE,
  UNIQUE INDEX email_UNIQUE (email ASC) VISIBLE,
  UNIQUE INDEX username_UNIQUE (username ASC) VISIBLE)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Creating Table millparking.driver
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.driver (
  driver_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  username VARCHAR(45) NOT NULL,
  password VARCHAR(25) NOT NULL,
  phone_no INT UNSIGNED NOT NULL,
  PRIMARY KEY (driver_id),
  UNIQUE INDEX driver_id_UNIQUE (driver_id ASC) VISIBLE,
  UNIQUE INDEX email_UNIQUE (email ASC) VISIBLE,
  UNIQUE INDEX username_UNIQUE (username ASC) VISIBLE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Creating Table millparking.car_park
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.car_park (
  car_park_id INT NOT NULL AUTO_INCREMENT,
  no_of_spaces INT NOT NULL,
  is_approved VARCHAR(25) NOT NULL,
  street_name VARCHAR(100) NOT NULL,
  city VARCHAR(45) NOT NULL,
  postcode VARCHAR(9) NOT NULL,
  staff_id INT NOT NULL,
  space_owner_id INT NOT NULL,
  PRIMARY KEY (car_park_id),
  UNIQUE INDEX car_park_id_UNIQUE (car_park_id ASC) VISIBLE,
  INDEX fk_staff_idx (staff_id ASC) VISIBLE,
  INDEX fk_space_owner_idx (space_owner_id ASC) VISIBLE,
  CONSTRAINT fk_staff
    FOREIGN KEY (staff_id)
    REFERENCES millparking.staff (staff_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT fk_space_owner
    FOREIGN KEY (space_owner_id)
    REFERENCES millparking.space_owner (space_owner_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Creating Table millparking.parking_space_type
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.parking_space_type (
  parking_space_type_id INT NOT NULL AUTO_INCREMENT,
  parking_space_type_name VARCHAR(45) NOT NULL,
  access_instruction VARCHAR (300), 
  PRIMARY KEY (parking_space_type_id),
  UNIQUE INDEX parking_space_type_UNIQUE (parking_space_type_id ASC) VISIBLE)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Creating Table millparking.parking_space
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.parking_space (
  parking_space_id INT NOT NULL AUTO_INCREMENT,
  car_park_id INT NOT NULL,
  parking_space_type_id INT,
  size VARCHAR(35) NULL DEFAULT null,
  geolocation_latitiude DECIMAL(12,8) NOT NULL,
  geolocation_longitiude DECIMAL(12,8) NOT NULL,
  availability VARCHAR(45) NOT NULL,
  has_EV_charging VARCHAR(3) NULL DEFAULT NULL,
  rate_per_hour DECIMAL(5,2) NOT NULL,
  image BLOB NULL DEFAULT NULL,
  PRIMARY KEY (parking_space_id, car_park_id),
  UNIQUE INDEX parking_space_id_UNIQUE (parking_space_id ASC) VISIBLE,
  INDEX fk_parking_space_car_park_idx (car_park_id ASC) VISIBLE,
  INDEX fk_parking_space_parking_space_type_idx (parking_space_type_id ASC) VISIBLE,
  CONSTRAINT fk_parking_space_car_park
    FOREIGN KEY (car_park_id)
    REFERENCES millparking.car_park (car_park_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT fk_parking_space_parking_space_type
    FOREIGN KEY (parking_space_type_id)
    REFERENCES millparking.parking_space_type (parking_space_type_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Creating Table millparking.vehicle_type
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.vehicle_type (
  vehicle_type_id INT NOT NULL AUTO_INCREMENT,
  vehicle_type_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (vehicle_type_id),
  UNIQUE INDEX idvehicle_type_id_UNIQUE (vehicle_type_id ASC) VISIBLE)
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Creating Table millparking.vehicle
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.vehicle (
  vehicle_id INT NOT NULL AUTO_INCREMENT,
  vehicle_registration_no VARCHAR(10) NOT NULL,
  mot_valid VARCHAR(45) NULL,
  driver_id INT NOT NULL,
  vehicle_type_id INT NOT NULL,
  PRIMARY KEY (vehicle_id),
  UNIQUE INDEX vehicle_id_UNIQUE (vehicle_id ASC) VISIBLE,
  INDEX fk_vehicle_driver_idx (driver_id ASC) VISIBLE,
  INDEX fk_vehicle_vehicle_type_idx (vehicle_type_id ASC) VISIBLE,
  CONSTRAINT fk_vehicle_driver
    FOREIGN KEY (driver_id)
    REFERENCES millparking.driver (driver_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT fk_vehicle_vehicle_type
    FOREIGN KEY (vehicle_type_id)
    REFERENCES millparking.vehicle_type (vehicle_type_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;






-- -----------------------------------------------------
-- Creating Table millparking.booking_type
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.booking_type (
  booking_type_id INT NOT NULL AUTO_INCREMENT,
  booking_start_time TIME NOT NULL,
  booking_end_time TIME NOT NULL,
  booking_type_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (booking_type_id),
  UNIQUE INDEX booking_type_UNIQUE (booking_type_id ASC) VISIBLE)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Creating Table millparking.booking
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.booking (
  booking_id INT NOT NULL AUTO_INCREMENT,
  booking_type_id INT NOT NULL,
  booking_date DATE NOT NULL,
  start_location VARCHAR(30) NOT NULL,
  end_location VARCHAR(30) NOT NULL,
  start_time DATETIME NOT NULL,
  duration_in_hours INT NOT NULL,
  booking_status VARCHAR(25) NOT NULL,
  parking_space_id INT NOT NULL,
  vehicle_id INT NOT NULL,
  PRIMARY KEY (booking_id),
  UNIQUE INDEX booking_id_UNIQUE (booking_id ASC) VISIBLE,
  INDEX fk_booking_parking_space_idx (parking_space_id ASC) VISIBLE,
  INDEX fk_booking_booking_type_idx (booking_type_id ASC) VISIBLE,
  INDEX fk_vehicle_idx (vehicle_id ASC) VISIBLE,
  CONSTRAINT fk_booking_parking_space
    FOREIGN KEY (parking_space_id)
    REFERENCES millparking.parking_space (parking_space_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT fk_vehicle
    FOREIGN KEY (vehicle_id)
    REFERENCES millparking.vehicle (vehicle_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT fk_booking_booking_type
    FOREIGN KEY (booking_type_id)
    REFERENCES millparking.booking_type (booking_type_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Creating Table millparking.payment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.payment (
  payment_id INT NOT NULL AUTO_INCREMENT,
  amount DECIMAL(5,2) NOT NULL,
  payment_date DATETIME NOT NULL,
  payment_method VARCHAR(45) NOT NULL,
  payment_status VARCHAR(45) NOT NULL,
  booking_id INT NOT NULL,
  booking_type_id INT NOT NULL, 
  PRIMARY KEY (payment_id),
  UNIQUE INDEX payment_id_UNIQUE (payment_id ASC) VISIBLE,
  INDEX fk_payment_booking_idx (booking_id ASC) VISIBLE,
  INDEX fk_payment_booking_type_id_idx (booking_type_id ASC) VISIBLE,
  CONSTRAINT fk_payment_booking
    FOREIGN KEY (booking_id)
    REFERENCES millparking.booking (booking_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT fk_payment_booking_type
    FOREIGN KEY (booking_type_id)
    REFERENCES millparking.booking_type (booking_type_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)  
ENGINE = InnoDB;







-- -----------------------------------------------------
-- Creating Table millparking.review
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS millparking.review (
  review_id INT NOT NULL AUTO_INCREMENT,
  parking_space_id INT NOT NULL,
  rating ENUM("1", "2", "3", "4", "5") NULL,
  comment_title VARCHAR(40) NULL,
  comment_message VARCHAR(200) NULL,
  driver_id INT NOT NULL,
  PRIMARY KEY (review_id, parking_space_id),
  UNIQUE INDEX review_id_UNIQUE (review_id ASC) VISIBLE,
  INDEX fk_review_driver_idx (driver_id ASC) VISIBLE,
  INDEX fk_review_parking_space_idx (parking_space_id ASC) VISIBLE,
  CONSTRAINT fk_review_driver
    FOREIGN KEY (driver_id)
    REFERENCES millparking.driver (driver_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT fk_review_parking_space
    FOREIGN KEY (parking_space_id)
    REFERENCES millparking.parking_space (parking_space_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;



CREATE INDEX bookings on millparking.booking(booking_id);
CREATE INDEX payments on millparking.payment(payment_id);
CREATE INDEX parking on millparking.parking_space(parking_space_id);
CREATE INDEX drivers on millparking.driver(driver_id);





/**


SELECT b.duration_in_hours, p.rate_per_hour, (b.duration_in_hours * p.rate_per_hour) AS amount
FROM booking AS b
JOIN
 parking_space AS p
ON
b.parking_space_id = p.parking_space_id;


show events;





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




-- -----------------------------------------------------
-- TRIGGER
-- -----------------------------------------------------

DELIMITER $$

CREATE TRIGGER booking_after_insert
	AFTER INSERT ON booking
    FOR EACH ROW
BEGIN
	UPDATE duration_in_hours
    SET booking_status = "past"
    WHERE booking_status = "completed";
END $$

DELIMITER ;    


-- -----------------------------------------------------
-- CREATING VIEWS
-- -----------------------------------------------------
CREATE VIEW available AS 
SELECT availability, rate_per_hour, image, booking_status, has_EV_charging
FROM booking
JOIN parking_space AS p
	ON booking.parking_space_id = p.parking_space_id;


CREATE VIEW driver_booking_payment AS    
SELECT payment_method, payment_status, booking_date, first_name, last_name, vehicle_registration_no
FROM payment 
JOIN booking AS b
	ON payment.booking_id = b.booking_id
JOIN vehicle
	ON b.vehicle_id = vehicle.vehicle_id
JOIN driver
	ON vehicle.driver_id = driver.driver_id;


drop database millparking;
-- -------------------------------------------------------------------------------
 #      QUERIES
-- --------------------------------------------------------------------------------
# SELECT CLAUSE - To retrieve all the drivers in the millparking database
-- ---------------------------------------------------------------------------------
SELECT *
FROM driver;

-- --------------------------------------------------------------------------------
# SELECT DISTINCT - To retrieve the distinctive cities
-- ---------------------------------------------------------------------------------
SELECT DISTINCT(city)
FROM car_park;

SELECT DISTINCT COUNT(*)
FROM booking
WHERE booking_date > '2022-11-30';

-- --------------------------------------------------------------------------------
# WHERE CLAUSE- To filter on a condition --- getting all the information for
# the space owner with id of 1008
--   ---------------------------------------------------------------------------
SELECT *
FROM space_owner
WHERE space_owner_id = 1008;

# To get a list of car parks in City called Durham
SELECT *
FROM car_park
WHERE city LIKE "Durham";

-- --------------------------------------------------------------------------------
# COMPARISM OPERATOR - To compare on a condition or multiple conditions --- the car parks 
# that have been approved and have more than two parking spaces 
-- -------------------------------------------------------------------------------------
SELECT *
FROM car_park
WHERE is_approved = "approved" AND no_of_spaces > 2;

-- --------------------------------------------------------------------------------
# ORDER BY CLAUSE - To sort in ascending or descending order (default is ascending) --- the
# list of available parking spaces from the least expensive to the most expensive 
-- _---------------------------------------------------------------------------------
SELECT * 
FROM parking_space
WHERE availability = "vacant"
ORDER BY rate_per_hour;

-- ------------------------------------------------------------------------------
# USING CLAUSE - used when two tables are connected -- gives the combination of the 
# booking and payment tables
-- -----------------------------------------------------------------------------------
SELECT *
FROM payment 
JOIN booking 
	USING (booking_id);

-- ------------------------------------------------------------------------------
# GROUP BY AND AGGREGATE FUNCTION (AVERAGE) - gets the average value of rows within a group -- 
# gives the reviews with an average score greater than 3
-- --------------------------------------------------------------------------------
SELECT review_id, AVG(rating)
FROM review
GROUP BY review_id
HAVING AVG(rating) > 3;

-- ------------------------------------------------------------------------------
# UNION - combines the result of two result sets and removes duplicates 
-- ---------------------------------------------------------------------------------
SELECT first_name
FROM space_owner
WHERE last_name = "Steward"
UNION
SELECT first_name
FROM driver
WHERE last_name = "Steward";


SELECT 
	booking_id, 
    booking_date,
    "confirmed" AS status
FROM booking
WHERE booking_date >= '2022-06-26'
UNION
SELECT 
	booking_id, 
    booking_date,
    'in-progress' AS status
FROM booking
WHERE booking_date < '2021-06-26';

-- ------------------------------------------------------------------------------
# JOINS - Returns rows that have matching values
-- ------------------------------------------------------------------------------
# USING JOINS AND ALIAS
-- --------------------------------------------------------------------------------
SELECT b.duration_in_hours, p.rate_per_hour, (b.duration_in_hours * p.rate_per_hour) AS amount
FROM booking AS b
JOIN
 parking_space AS p
ON
b.parking_space_id = p.parking_space_id;

-- -------------------------------------------------------------------------------
# INNER JOIN - 
-- -----------------------------------------------------------------------------
SELECT *
FROM car_park 
INNER JOIN space_owner
	ON car_park.Space_owner_id = space_owner.space_owner_id;

-- ---------------------------------------------------------------------------------
**/


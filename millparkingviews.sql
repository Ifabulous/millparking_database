USE millparking;

-- ------------------------------------------------------
# VIEWS
-- ---------------------------------------------------------

CREATE VIEW driver_booking_payment AS    
SELECT payment_method, payment_status, booking_date, first_name, last_name, vehicle_registration_no
FROM payment 
JOIN booking AS b
	ON payment.booking_id = b.booking_id
JOIN vehicle
	ON b.vehicle_id = vehicle.vehicle_id
JOIN driver
	ON vehicle.driver_id = driver.driver_id;
    
    
    
    CREATE VIEW available AS 
SELECT availability, rate_per_hour, image, booking_status, has_EV_charging
FROM booking
JOIN parking_space AS p
	ON booking.parking_space_id = p.parking_space_id;


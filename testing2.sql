SELECT * FROM service_request;
SELECT * FROM booking;
SELECT * FROM job;
SELECT * FROM job_part;
SELECT * FROM invoice;
SELECT * FROM payment;
SELECT * FROM review;

SELECT
    c.name AS customer,
    sc.name AS service,
    t.name AS technician,
    sr.status AS request_status,
    b.scheduled_date,
    j.status AS job_status
FROM service_request sr

JOIN customer c
    ON sr.customer_id = c.customer_id

JOIN service_category sc
    ON sr.category_id = sc.category_id

LEFT JOIN booking b
    ON sr.request_id = b.request_id

LEFT JOIN technician t
    ON b.technician_id = t.technician_id

LEFT JOIN job j
    ON b.booking_id = j.booking_id;
-------------------------------------------- 
-- ----------Aggregate functions-------------------------------
SELECT *FROM technician WHERE status = 'ACTIVE';
SELECT name, email, phone FROM customer WHERE city = 'Bangalore';
SELECT * FROM job WHERE status = 'COMPLETED';
SELECT name, experience_years FROM technician ORDER BY experience_years DESC;
SELECT part_name, unit_price FROM service_part ORDER BY unit_price ASC;
SELECT COUNT(*) AS total_customers FROM customer;
SELECT COUNT(*) AS total_technicians FROM technician;
SELECT MAX(unit_price) AS highest_part_price FROM service_part;
SELECT SUM(unit_price * stock_quantity) AS total_inventory_value FROM service_part;
SELECT
    sc.name AS service,
    COUNT(sr.request_id) AS total_requests
FROM service_category sc
LEFT JOIN service_request sr
    ON sc.category_id = sr.category_id
GROUP BY sc.category_id, sc.name;
SELECT
    sc.name AS service,
    COUNT(sr.request_id) AS total_requests
FROM service_category sc
JOIN service_request sr
    ON sc.category_id = sr.category_id
GROUP BY sc.category_id, sc.name
HAVING COUNT(sr.request_id) > 1;

SELECT
    t.name AS technician,
    sc.name AS service,
    ts.experience_level
FROM technician t
JOIN technician_skill ts
    ON t.technician_id = ts.technician_id
JOIN service_category sc
    ON ts.category_id = sc.category_id
ORDER BY t.name;

SELECT SUM(amount) AS total_revenue FROM payment;

SELECT
    payment_method,
    COUNT(*) AS number_of_payments,
    SUM(amount) AS total_amount
FROM payment
GROUP BY payment_method;

SELECT
    j.job_id,
    i.invoice_id,
    i.total_amount,
    i.tax,
    i.total_amount + i.tax AS final_amount
FROM job j
JOIN invoice i
    ON j.job_id = i.job_id;
    
    SELECT
    name,
    experience_years
FROM technician
WHERE experience_years >
      (SELECT AVG(experience_years)
       FROM technician);
       
SELECT
    job_id,
    rating,
    comment
FROM review
WHERE rating >
      (SELECT AVG(rating)
       FROM review);
UPDATE technician SET experience_years = experience_years + 1 WHERE technician_id = 3;
SELECT * FROM technician WHERE technician_id = 3;
SELECT * FROM service_category WHERE name = 'Temporary Service';
DELETE FROM service_category WHERE name = 'Temporary Service';
CREATE VIEW service_history AS
SELECT
    sr.request_id,
    c.name AS customer,
    sc.name AS service,
    t.name AS technician,
    sr.status AS request_status,
    b.scheduled_date,
    b.scheduled_time,
    j.status AS job_status
FROM service_request sr

JOIN customer c
    ON sr.customer_id = c.customer_id

JOIN service_category sc
    ON sr.category_id = sc.category_id

LEFT JOIN booking b
    ON sr.request_id = b.request_id

LEFT JOIN technician t
    ON b.technician_id = t.technician_id

LEFT JOIN job j
    ON b.booking_id = j.booking_id;
SELECT *FROM service_history;
SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';
show tables;
use fix_flow_db;
INSERT INTO customer
(name, email, phone, password_hash, address, city)
VALUES
('Rahul Kumar', 'rahul@gmail.com', '9876543210',
 'hash001', 'MG Road', 'Bangalore'),

('Ananya Sharma', 'ananya@gmail.com', '9876543211',
 'hash002', 'Gandhi Nagar', 'Hyderabad'),

('Arjun Reddy', 'arjun@gmail.com', '9876543212',
 'hash003', 'Main Road', 'Tirupati');
 
 INSERT INTO service_category
(name, description)
VALUES
('AC Repair', 'Air conditioner repair and maintenance'),
('Plumbing', 'Plumbing installation and repair'),
('Electrical', 'Electrical repair and maintenance'),
('Appliance Repair', 'Repair of household appliances'),
('Carpentry', 'Furniture and woodwork services');

INSERT INTO technician
(name, email, phone, experience_years, status)
VALUES
('Ravi Kumar', 'ravi@fixflow.com', '9000000001', 5, 'ACTIVE'),

('Suresh Babu', 'suresh@fixflow.com', '9000000002', 7, 'ACTIVE'),

('Imran Khan', 'imran@fixflow.com', '9000000003', 3, 'ACTIVE'),

('Vikram Singh', 'vikram@fixflow.com', '9000000004', 6, 'ACTIVE');

INSERT INTO technician_skill
(technician_id, category_id, experience_level)
VALUES
(1, 1, 'Expert'),
(1, 3, 'Intermediate'),
(2, 2, 'Expert'),
(3, 4, 'Intermediate'),
(4, 5, 'Expert');

INSERT INTO service_part
(part_name, unit_price, stock_quantity)
VALUES
('AC Filter', 500.00, 20),
('Copper Pipe', 1200.00, 15),
('Water Tap', 350.00, 30),
('Electrical Switch', 150.00, 50),
('Door Handle', 450.00, 25);

SELECT * FROM customer;

-- SELECT * FROM technician;
-- SELECT * FROM service_category;
-- SELECT * FROM technician_skill;
-- SELECT * FROM service_part;
USE fixflow_db;
SELECT
    t.name AS technician,
    sc.name AS service,
    ts.experience_level
FROM technician_skill ts
JOIN technician t
    ON ts.technician_id = t.technician_id
JOIN service_category sc
    ON ts.category_id = sc.category_id;
    USE fixflow_db;

-- ==========================================
-- SERVICE REQUESTS
-- ==========================================

INSERT INTO service_request
(customer_id, category_id, description, preferred_date,
 preferred_time, service_address, status)
VALUES
(1, 1, 'AC is not cooling properly',
 '2026-09-26', '10:00:00',
 'MG Road, Bangalore', 'ASSIGNED'),

(2, 2, 'Kitchen tap is leaking',
 '2026-09-26', '11:30:00',
 'Gandhi Nagar, Hyderabad', 'CONFIRMED'),

(3, 3, 'Power switch is not working',
 '2026-09-27', '14:00:00',
 'Main Road, Tirupati', 'REQUESTED'),

(1, 4, 'Washing machine making unusual noise',
 '2026-09-28', '10:30:00',
 'MG Road, Bangalore', 'ASSIGNED'),

(2, 5, 'Bedroom door handle is broken',
 '2026-09-29', '15:00:00',
 'Gandhi Nagar, Hyderabad', 'CONFIRMED');


-- ==========================================
-- BOOKINGS
-- ==========================================

INSERT INTO booking
(request_id, technician_id, scheduled_date,
 scheduled_time, status)
VALUES
(1, 1, '2026-09-26', '10:00:00', 'CONFIRMED'),

(2, 2, '2026-09-26', '11:30:00', 'CONFIRMED'),

(4, 3, '2026-09-28', '10:30:00', 'CONFIRMED'),

(5, 4, '2026-09-29', '15:00:00', 'CONFIRMED');


-- ==========================================
-- JOBS
-- ==========================================

INSERT INTO job
(booking_id, start_time, end_time, status,
 notes, completed_at)
VALUES
(1,
 '2026-09-26 10:05:00',
 '2026-09-26 11:20:00',
 'COMPLETED',
 'AC filter cleaned and cooling issue fixed',
 '2026-09-26 11:20:00'),

(2,
 '2026-09-26 11:35:00',
 '2026-09-26 12:10:00',
 'COMPLETED',
 'Leaking tap replaced',
 '2026-09-26 12:10:00'),

(3,
 '2026-09-28 10:35:00',
 '2026-09-28 11:40:00',
 'COMPLETED',
 'Washing machine motor inspected and repaired',
 '2026-09-28 11:40:00'),

(4,
 '2026-09-29 15:05:00',
 NULL,
 'IN_PROGRESS',
 'Door handle replacement in progress',
 NULL);


-- ==========================================
-- JOB PARTS
-- ==========================================

INSERT INTO job_part
(job_id, part_id, quantity_used, unit_price_at_time)
VALUES
(1, 1, 1, 500.00),
(1, 2, 1, 1200.00),

(2, 3, 1, 350.00),

(3, 4, 2, 150.00),

(4, 5, 1, 450.00);


-- ==========================================
-- INVOICES
-- ==========================================

INSERT INTO invoice
(job_id, total_amount, tax, status)
VALUES
(1, 1800.00, 180.00, 'PAID'),

(2, 350.00, 35.00, 'PAID'),

(3, 300.00, 30.00, 'PAID'),

(4, 450.00, 45.00, 'UNPAID');


-- ==========================================
-- PAYMENTS
-- ==========================================

INSERT INTO payment
(invoice_id, amount, payment_method, transaction_id)
VALUES
(1, 1980.00, 'UPI', 'TXN10001'),

(2, 385.00, 'CARD', 'TXN10002'),

(3, 330.00, 'CASH', 'TXN10003');


-- ==========================================
-- REVIEWS
-- ==========================================

INSERT INTO review
(job_id, rating, comment)
VALUES
(1, 5, 'Technician was professional and fixed the AC quickly.'),

(2, 4, 'Good service and quick response.'),

(3, 5, 'Very helpful technician and excellent work.');



-- CREATE DATABASE fixflow_db;

USE fixflow_db;
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE service_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);
CREATE TABLE technician (
    technician_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    experience_years INT DEFAULT 0,
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') DEFAULT 'ACTIVE'
);
CREATE TABLE technician_skill (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    technician_id INT NOT NULL,
    category_id INT NOT NULL,
    experience_level VARCHAR(50),

    FOREIGN KEY (technician_id)
        REFERENCES technician(technician_id)
        ON DELETE CASCADE,

    FOREIGN KEY (category_id)
        REFERENCES service_category(category_id)
        ON DELETE CASCADE,

    UNIQUE (technician_id, category_id)
);
CREATE TABLE technician_availability (
    availability_id INT AUTO_INCREMENT PRIMARY KEY,
    technician_id INT NOT NULL,
    available_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (technician_id)
        REFERENCES technician(technician_id)
        ON DELETE CASCADE
);
CREATE TABLE service_request (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    category_id INT NOT NULL,
    description TEXT,
    preferred_date DATE,
    preferred_time TIME,
    service_address VARCHAR(255),
    status ENUM(
        'REQUESTED',
        'ASSIGNED',
        'CONFIRMED',
        'TECHNICIAN_ON_WAY',
        'IN_PROGRESS',
        'COMPLETED',
        'CANCELLED'
    ) DEFAULT 'REQUESTED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    FOREIGN KEY (category_id)
        REFERENCES service_category(category_id)
);
CREATE TABLE booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT NOT NULL UNIQUE,
    technician_id INT NOT NULL,
    scheduled_date DATE NOT NULL,
    scheduled_time TIME NOT NULL,
    status ENUM(
        'CONFIRMED',
        'RESCHEDULED',
        'CANCELLED',
        'COMPLETED'
    ) DEFAULT 'CONFIRMED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (request_id)
        REFERENCES service_request(request_id),

    FOREIGN KEY (technician_id)
        REFERENCES technician(technician_id)
);
CREATE TABLE job (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL UNIQUE,
    start_time DATETIME,
    end_time DATETIME,
    status ENUM(
        'NOT_STARTED',
        'IN_PROGRESS',
        'COMPLETED',
        'CANCELLED'
    ) DEFAULT 'NOT_STARTED',
    notes TEXT,
    completed_at DATETIME,

    FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id)
);
CREATE TABLE service_part (
    part_id INT AUTO_INCREMENT PRIMARY KEY,
    part_name VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);
CREATE TABLE job_part (
    job_part_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    part_id INT NOT NULL,
    quantity_used INT NOT NULL,
    unit_price_at_time DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (job_id)
        REFERENCES job(job_id)
        ON DELETE CASCADE,

    FOREIGN KEY (part_id)
        REFERENCES service_part(part_id)
);
CREATE TABLE invoice (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL UNIQUE,
    total_amount DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM(
        'UNPAID',
        'PARTIALLY_PAID',
        'PAID',
        'CANCELLED'
    ) DEFAULT 'UNPAID',

    FOREIGN KEY (job_id)
        REFERENCES job(job_id)
);
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM(
        'CASH',
        'CARD',
        'UPI',
        'ONLINE'
    ) NOT NULL,
    transaction_id VARCHAR(100) UNIQUE,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (invoice_id)
        REFERENCES invoice(invoice_id)
);
CREATE TABLE review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL UNIQUE,
    rating INT NOT NULL,
    comment VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (job_id)
        REFERENCES job(job_id),

    CHECK (rating BETWEEN 1 AND 5)
);


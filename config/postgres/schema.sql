CREATE SCHEMA baghive;

-- Table to store clients
CREATE TABLE baghive.clients (
    id SERIAL PRIMARY KEY,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table to store locker statuses
CREATE TABLE baghive.locker_statuses (
    id SERIAL PRIMARY KEY,
    status VARCHAR(20) NOT NULL UNIQUE
);

-- Insert the allowed status values
INSERT INTO baghive.locker_statuses (status)
VALUES ('available'), ('occupied'), ('maintenance');

-- Table to store lockers
CREATE TABLE baghive.lockers (
    id SERIAL PRIMARY KEY,
    locker_number INTEGER NOT NULL UNIQUE,
    status_id INTEGER NOT NULL REFERENCES baghive.locker_statuses(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table to store rental types
CREATE TABLE baghive.rental_types (
    id SERIAL PRIMARY KEY,
    rental_duration INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table to store rentals
CREATE TABLE baghive.rentals (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES baghive.clients(id),
    locker_id INTEGER NOT NULL REFERENCES baghive.lockers(id),
    rental_type_id INTEGER NOT NULL REFERENCES baghive.rental_types(id),
    start_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table to store SMS authorization codes
CREATE TABLE baghive.sms_authorization_codes (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES baghive.clients(id),
    code VARCHAR(6) NOT NULL,
    expiration_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table to store barcodes
CREATE TABLE baghive.barcodes (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES baghive.clients(id),
    barcode VARCHAR(20) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table to store photos (URL leads to NoSQL storage)
CREATE TABLE baghive.client_photos (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES baghive.clients(id),
    photo_url VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

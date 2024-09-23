-- Table to store clients
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table to store locker statuses
CREATE TABLE locker_statuses (
    id SERIAL PRIMARY KEY,
    status VARCHAR(20) NOT NULL UNIQUE
);

-- Insert the allowed status values
INSERT INTO locker_statuses (status)
VALUES ('available'), ('occupied'), ('maintenance');

-- Table to store lockers
CREATE TABLE lockers (
    id SERIAL PRIMARY KEY,
    locker_number INTEGER NOT NULL UNIQUE,
    status_id INTEGER NOT NULL REFERENCES locker_statuses(id)
);

-- Table to store rental types
CREATE TABLE rental_types (
    id SERIAL PRIMARY KEY,
    rental_duration INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Table to store rentals
CREATE TABLE rentals (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients(id),
    locker_id INTEGER NOT NULL REFERENCES lockers(id),
    rental_type_id INTEGER NOT NULL REFERENCES rental_types(id),
    start_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP
);

-- Table to store SMS authorization codes
CREATE TABLE sms_authorization_codes (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients(id),
    code VARCHAR(6) NOT NULL,
    expiration_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table to store barcodes
CREATE TABLE barcodes (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients(id),
    barcode VARCHAR(20) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table to store photos
CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients(id),
    photo BYTEA NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

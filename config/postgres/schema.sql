-- Create the schema for booking
CREATE SCHEMA booking;
-- Table to store locker statuses
CREATE TABLE booking.locker_statuses (
    id SERIAL PRIMARY KEY,
    status VARCHAR(20) NOT NULL UNIQUE,
    description TEXT
);
-- Insert the allowed status values
INSERT INTO booking.locker_statuses (status, description)
VALUES ('available', 'Locker is available for rental'),
    ('occupied', 'Locker is currently rented out'),
    ('maintenance', 'Locker is under maintenance');
-- Table to store lockers
CREATE TABLE booking.lockers (
    id SERIAL PRIMARY KEY,
    locker_number INTEGER NOT NULL UNIQUE,
    status_id INTEGER NOT NULL REFERENCES booking.locker_statuses(id),
    location VARCHAR(50) -- Removed the comma here as it's the last column
);
-- Table to store rentals
CREATE TABLE booking.rentals (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL,
    -- Reference to external client service
    locker_id INTEGER NOT NULL REFERENCES booking.lockers(id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    -- Nullable for ongoing rentals
    status VARCHAR(20) NOT NULL DEFAULT 'occupied' -- Rental status tracking
);
DROP DATABASE IF EXISTS airlineDB;
CREATE DATABASE airlineDB;
USE airlineDB;

CREATE TABLE employee (
    emp_id INT auto_increment PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) DEFAULT 100.00
);

CREATE TABLE flights (
    flight_no INT auto_increment PRIMARY KEY,
    from_city VARCHAR(100) NOT NULL,
    to_city VARCHAR(100) NOT NULL,
    distance FLOAT DEFAULT 0.0,
    depart_time DATETIME DEFAULT NOW(),
    arrival_time DATETIME DEFAULT NOW()
);

CREATE TABLE aircraft (
    aircraft_id INT PRIMARY KEY auto_increment,
    manufacturer VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    range_km FLOAT DEFAULT 0.0,
);

CREATE TABLE certified (
    emp_id INT,
    aircraft_id INT,
    PRIMARY KEY (emp_id, aircraft_id),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id) ON DELETE CASCADE ON UPDATE CASCADE
);


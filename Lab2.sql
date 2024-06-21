DROP database if exists Lab2;
CREATE database Lab2;
use Lab2;

DROP table if exists PRODUCTS;
CREATE TABLE PRODUCTS (
    pid INT PRIMARY KEY auto_increment,
    pname VARCHAR(255),
    category VARCHAR(255),
    price DECIMAL(10 , 2 )
);

DROP table if exists LOCATIONS;
CREATE TABLE LOCATIONS (
    locid INT PRIMARY KEY auto_increment,
    city VARCHAR(255),
    region VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255)
);

DROP TABLE if exists TIMES;
CREATE TABLE TIMES (
    timeid INT PRIMARY KEY auto_increment,
    date DATE,
    week INT,
    month INT,
    quarter INT,
    year INT
);

DROP table if exists SALES;
CREATE TABLE SALES (
    pid INT,
    timeid INT,
    locid INT,
    sales DECIMAL(10 , 2 ),
    PRIMARY KEY (pid , timeid , locid),
    FOREIGN KEY (pid)
        REFERENCES PRODUCTS (pid),
    FOREIGN KEY (timeid)
        REFERENCES TIMES (timeid),
    FOREIGN KEY (locid)
        REFERENCES LOCATIONS (locid)
);

INSERT INTO PRODUCTS (pname, category, price) VALUES
('Apple iPhone 12', 'Smartphones', 699.00),
('Samsung Galaxy S21', 'Smartphones', 799.00),
('Dell XPS 13', 'Laptops', 999.00),
('Apple MacBook Pro', 'Laptops', 1299.00),
('Sony WH-1000XM4', 'Headphones', 348.00),
('Bose QuietComfort 35 II', 'Headphones', 299.00),
('Canon EOS 5D Mark IV', 'Cameras', 2499.00),
('Nikon D850', 'Cameras', 2796.95),
('Apple iPad Pro', 'Tablets', 799.00),
('Samsung Galaxy Tab S7', 'Tablets', 649.99),
('Apple iPhone 11', 'Smartphones', 599.00),
('Samsung Galaxy S20', 'Smartphones', 699.00),
('HP Spectre x360', 'Laptops', 1199.00),
('Apple MacBook Air', 'Laptops', 999.00),
('Bose SoundLink II', 'Headphones', 229.00),
('Sony WH-1000XM3', 'Headphones', 348.00),
('Nikon D780', 'Cameras', 2296.95),
('Canon EOS 6D Mark II', 'Cameras', 1399.00),
('Samsung Galaxy Tab S6', 'Tablets', 649.99),
('Apple iPad Air', 'Tablets', 599.00);

INSERT INTO TIMES (date, week, month, quarter, year) VALUES
('2012-01-15', 2, 1, 1, 2012),
('2012-02-20', 8, 2, 1, 2012),
('2012-03-25', 13, 3, 1, 2012),
('2012-04-30', 18, 4, 2, 2012),
('2012-05-20', 21, 5, 2, 2012),
('2012-06-15', 24, 6, 2, 2012),
('2012-07-10', 28, 7, 3, 2012),
('2012-08-05', 32, 8, 3, 2012),
('2012-09-15', 37, 9, 3, 2012),
('2012-10-20', 42, 10, 4, 2012),
('2012-11-15', 46, 11, 4, 2012),
('2012-12-20', 51, 12, 4, 2012);

INSERT INTO LOCATIONS (city, region, state, country) VALUES
('CityA', 'Eastern', 'StateA', 'USA'),
('CityB', 'Western', 'StateB', 'USA'),
('CityC', 'Eastern', 'StateC', 'USA'),
('CityD', 'Western', 'StateD', 'USA'),
('CityE', 'Eastern', 'StateE', 'USA'),
('CityF', 'Western', 'StateF', 'USA'),
('CityG', 'Eastern', 'StateG', 'USA'),
('CityH', 'Western', 'StateH', 'USA'),
('CityI', 'Eastern', 'StateI', 'USA'),
('CityJ', 'Western', 'StateJ', 'USA');

INSERT INTO SALES (pid, timeid, locid, sales) VALUES
(1, 1, 1, 69900.00),
(2, 2, 2, 159800.00),
(3, 3, 3, 299700.00),
(4, 4, 4, 519600.00),
(5, 5, 5, 174000.00),
(6, 6, 6, 179400.00),
(7, 7, 7, 1249500.00),
(8, 8, 8, 2237560.00),
(9, 9, 9, 159600.00),
(10, 10, 10, 1299990.00),
(11, 11, 1, 59900.00),
(12, 12, 2, 139800.00),
(13, 1, 3, 119900.00),
(14, 2, 4, 399600.00),
(15, 3, 5, 114500.00),
(16, 4, 6, 139200.00),
(17, 5, 7, 1149800.00),
(18, 6, 8, 1399000.00),
(19, 7, 9, 129990.00),
(20, 8, 10, 119800.00);

-- Query 1: Create a view TotalSalesbyRegion (break up total sales by some smaller time
-- intervals like by month) in MySQL where it gives the Total Sales for each product by
-- Regions in USA.
drop view if exists TotalSalesbyRegion; 
CREATE VIEW TotalSalesbyRegion AS
    SELECT 
        p.pid AS productID,
        l.region AS REGION,
        t.year AS YEAR,
        t.month AS MONTH,
        SUM(s.sales) AS MONTHLYSALES
    FROM
        SALES s
            JOIN
        PRODUCTS p ON s.pid = p.pid
            JOIN
        LOCATIONS l ON s.locid = l.locid
            JOIN
        TIMES t ON s.timeid = t.timeid
    GROUP BY p.pid , l.region , t.year , t.month;

SELECT * from TotalSalesbyRegion;

-- Query 2
SELECT 
    p.pid AS productID, SUM(s.sales) AS SALES
FROM
    SALES s
        JOIN
    PRODUCTS p ON s.pid = p.pid
        JOIN
    LOCATIONS l ON s.locid = l.locid
        JOIN
    TIMES t ON s.timeid = t.timeid
WHERE
    t.year = 2012 AND l.region = 'Eastern'
GROUP BY p.pid;


-- Query provided in question. Used for comparing output of previous query and expected output.
SELECT 
    productID, SUM(MONTHLYSALES) AS SALES
FROM
    TotalSalesbyRegion
WHERE
    year = 2012 AND region = 'Eastern'
GROUP BY productID;
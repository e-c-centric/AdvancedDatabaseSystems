DROP DATABASE IF EXISTS companyDB;

CREATE DATABASE companyDB;

USE companyDB;

DROP TABLE IF EXISTS Works;
DROP TABLE IF EXISTS Dept;
DROP TABLE IF EXISTS Emp;

CREATE TABLE Emp (
    eid INTEGER PRIMARY KEY AUTO_INCREMENT,
    ename VARCHAR(100) NOT NULL,
    age INTEGER NOT NULL CHECK (age > 0),
    salary REAL NOT NULL CHECK (salary >= 0)
);

CREATE TABLE Dept (
    did INTEGER PRIMARY KEY AUTO_INCREMENT,
    dname VARCHAR(100) NOT NULL,
    budget REAL NOT NULL CHECK (budget > 0),
    managerid INTEGER,
    FOREIGN KEY (managerid)
        REFERENCES Emp (eid)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Works (
    eid INTEGER,
    did INTEGER,
    pct_time INTEGER NOT NULL CHECK (pct_time > 0 AND pct_time <= 100),
    PRIMARY KEY (eid , did),
    FOREIGN KEY (eid)
        REFERENCES Emp (eid)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (did)
        REFERENCES Dept (did)
        ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO Emp (ename, age, salary) VALUES
('Kwame Mensah', 45, 75000),
('Ama Owusu', 30, 85000),
('Kojo Asante', 40, 90000),
('Yaa Asantewaa', 35, 67000),
('Kofi Amponsah', 50, 100000),
('Akosua Dapaah', 28, 72000),
('Yaw Mensah', 33, 68000),
('Afia Anane', 29, 77000),
('Adwoa Agyemang', 44, 82000),
('Kwasi Osei', 41, 69000),
('Abena Kyei', 32, 88000),
('Kwabena Adjei', 38, 94000000),
('Efua Sarpong', 39, 86000),
('Nana Kofi', 31, 69000),
('Akua Donkor', 36, 73000000),
('Kwasi Kumi Osei', 41, 69000),
('Abena Adwedaa Kyei', 32, 88000),
('Kwabena Felix Adjei', 38, 94000000),
('Efua Kumi Sarpong', 39, 86000),
('Nana Kofi Sekyere', 31, 69000),
('Akua Donkor Danso', 36, 73000000);

INSERT INTO Dept (dname, budget, managerid) VALUES
('Hardware', 3000000, 1),
('Software', 4000000, 2),
('HR', 2500000, 3),
('Finance', 5000000, 4),
('Marketing', 3500000, 5),
('Sales', 2800000, 6),
('IT', 4500000, 7),
('Support', 3000000, 8),
('Logistics', 2700000, 9),
('Operations', 3300000, 10),
('R&D', 6000000, 11),
('Admin', 2100000, 12),
('Legal', 2600000, 13),
('Procurement', 2200000, 14),
('Maintenance', 2400000, 15);

INSERT INTO Works (eid, did, pct_time) VALUES
(1, 1, 100), (2, 1, 100), (3, 1, 100), (4, 1, 100), (5, 1, 100), 
(6, 1, 100), (7, 1, 100), (8, 1, 100), (9, 1, 100), (10, 1, 100), 
(11, 1, 100), (12, 1, 100), (13, 1, 100), (14, 1, 100), (15, 1, 100),
(16, 1, 100), (17, 1, 100), (18, 1, 100), (19, 1, 100), (20, 1, 100), (21, 1, 100),  
(1, 2, 100), (2, 2, 100), (3, 2, 100), (4, 2, 100), (5, 2, 100), 
(6, 2, 100), (7, 2, 100), (8, 2, 100), (9, 2, 100), (10, 2, 100), 
(11, 2, 100), (12, 2, 100), (13, 2, 100), (14, 2, 100), (15, 2, 100), 
(1, 3, 100), (2, 3, 100), (3, 3, 100), (4, 3, 100), (5, 3, 100), 
(6, 3, 100), (7, 3, 100), (8, 3, 100), (9, 3, 100), (10, 3, 100), 
(11, 3, 100), (12, 3, 100), (13, 3, 100), (14, 3, 100), (15, 3, 100), 
(1, 4, 100), (2, 4, 100), (3, 4, 100), (4, 4, 100), (5, 4, 100), 
(6, 4, 100), (7, 4, 100), (8, 4, 100), (9, 4, 100), (10, 4, 100), 
(11, 4, 100), (12, 4, 100), (13, 4, 100), (14, 4, 100), (15, 4, 100), 
(1, 5, 100), (2, 5, 100), (3, 5, 100), (4, 5, 100), (5, 5, 100), 
(6, 5, 100), (7, 5, 100), (8, 5, 100), (9, 5, 100), (10, 5, 100), 
(11, 5, 100), (12, 5, 100), (13, 5, 100), (14, 5, 100), (15, 5, 100);


-- Query 1
SELECT 
    e.ename, e.age
FROM
    Emp e
        JOIN
    Works w1 ON e.eid = w1.eid
        JOIN
    Works w2 ON e.eid = w2.eid
        JOIN
    Dept d1 ON w1.did = d1.did
        AND d1.dname = 'Hardware'
        JOIN
    Dept d2 ON w2.did = d2.did
        AND d2.dname = 'Software';


-- Query 2
SELECT 
    w.did, COUNT(w.eid) AS num_employees
FROM
    Works w
GROUP BY w.did
HAVING SUM(w.pct_time) > 20 * 100;-- assumption is that a full time employee works 100% percent with a department


SELECT 
    e.ename
FROM
    Emp e
WHERE
    e.salary > ALL (SELECT 
            d.budget
        FROM
            Works w
                JOIN
            Dept d ON w.did = d.did
        WHERE
            w.eid = e.eid);


-- Query 4
SELECT DISTINCT
    d.managerid
FROM
    Dept d
WHERE
    d.managerid IS NOT NULL
GROUP BY d.managerid
HAVING MIN(d.budget) > 1000000;


-- Query 5
SELECT 
    e.ename
FROM
    Emp e
        JOIN
    Dept d ON e.eid = d.managerid
WHERE
    d.budget = (SELECT 
            MAX(budget)
        FROM
            Dept);


-- Query 6
SELECT 
    d.managerid
FROM
    Dept d
WHERE
    d.managerid IS NOT NULL
GROUP BY d.managerid
HAVING SUM(d.budget) > 5000000;


-- Query 7
SELECT 
    d.managerid
FROM
    Dept d
WHERE
    d.managerid IS NOT NULL
GROUP BY d.managerid
ORDER BY SUM(d.budget) DESC
LIMIT 1;


-- Query 8
SELECT 
    e.ename
FROM
    Emp e
        JOIN
    Dept d ON e.eid = d.managerid
WHERE
    d.managerid IS NOT NULL
GROUP BY e.ename
HAVING MIN(d.budget) > 1000000
    AND MAX(d.budget) < 5000000;

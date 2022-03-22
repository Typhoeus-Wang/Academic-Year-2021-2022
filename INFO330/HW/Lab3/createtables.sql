CREATE TABLE CARRIERS (
    cid VARCHAR(7) PRIMARY KEY,
    name VARCHAR(83)
);

CREATE TABLE MONTHS(
    mid INT PRIMARY KEY,
    month VARCHAR(9)
);

CREATE TABLE WEEKDAYS(
    did INT PRIMARY KEY,
    day_of_week VARCHAR(9)
);

CREATE TABLE FLIGHTS(
    fid INT PRIMARY KEY,
    month_id INT REFERENCES MONTHS(mid),
    day_of_month INT,
    day_of_week_id INT REFERENCES WEEKDAYS(did),
    carrier_id VARCHAR(7) REFERENCES CARRIERS(cid),
    flight_num INT,
    origin_city VARCHAR(34),
    origin_state VARCHAR(47),
    dest_city VARCHAR(34),
    dest_state VARCHAR(46),
    departure_delay INT,
    taxi_out INT,
    arrival_delay INT,
    canceled BIT,
    actual_time INT,
    distance INT,
    capacity INT,
    price INT
);


-- sp_help;

INSERT INTO CARRIERS 
SELECT * 
FROM flights.dbo.carriers;

INSERT INTO MONTHS
select *
FROM flights.dbo.months;

INSERT INTO WEEKDAYS
SELECT *
FROM flights.dbo.weekdays;

INSERT INTO flights
SELECT * 
FROM flights.dbo.flights;

SELECT * FROM MONTHS;
SELECT * FROM WEEKDAYS;
-- hw2-q1
SELECT DISTINCT flight_num AS flight_num
FROM FLIGHTS AS F, CARRIERS AS C, MONTHS AS M, WEEKDAYS AS W
WHERE F.carrier_id = C.cid 
AND F.day_of_week_id = W.did
AND F.day_of_month = M.mid
AND W.day_of_week = 'Monday'
AND C.name = 'Alaska Airlines Inc.'
AND F.origin_city = 'Seattle WA'
AND F.dest_city = 'Boston MA';
-- the number of rows in the query result: 3


-- hw2-q2
SELECT C.name AS name, F1.flight_num AS f1_flight_num, 
F1.origin_city AS f1_origin_city, F1.dest_city AS f1_dest_city, 
F1.actual_time AS f1_actual_time, F2.flight_num AS f2_flight_num, 
F2.origin_city AS f2_origin_city, F2.dest_city AS f2_dest_city, 
F2.actual_time AS f2_actual_time, F1.actual_time+F2.actual_time AS actual_time
FROM FLIGHTS AS F1, FLIGHTS AS F2, CARRIERS AS C, MONTHS AS M
WHERE F1.carrier_id = F2.carrier_id
AND F1.origin_city = 'Seattle WA'
AND F2.dest_city = 'Boston MA'
AND F1.dest_city = F2.origin_city
AND F1.carrier_id = C.cid 
AND F1.month_id = M.mid
AND F2.month_id = M.mid
AND F1.day_of_month = 15
AND F1.day_of_month = F2.day_of_month
AND M.month = 'July'
AND F1.actual_time + F2.actual_time < 420;
-- number of rows in the query result: 1472

-- hw2-q3
SELECT TOP 1 W.day_of_week as day_of_week, avg(F.arrival_delay) as delay
FROM FLIGHTS AS F, WEEKDAYS AS W
WHERE F.day_of_week_id = W.did
GROUP BY W.day_of_week
ORDER BY AVG(F.arrival_delay) DESC;
-- number of rows in the query result: 1


-- hw2-q4
SELECT DISTINCT C.name as name
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid
GROUP BY C.cid, C.name, F.month_id, F.day_of_month
HAVING COUNT(F.fid) > 1000;
-- number of rows in the query result: 12


-- hw2-q5
SELECT C.name as name, (SUM(CAST(F.canceled AS float))*100/COUNT(*)) as 'percent'
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid 
AND F.origin_city = 'Seattle WA'
GROUP BY C.name
HAVING (SUM(CAST(F.canceled AS float))*100/COUNT(*)) > 0.5
ORDER BY (SUM(CAST(F.canceled AS float))*100/COUNT(*)) ASC;
-- number of rows in the query result: 6


-- hw2-q6
SELECT C.name AS carrier, MAX(F.price) AS max_price
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid
AND F.origin_city in ('Seattle WA', 'New York NY')
AND F.dest_city in ('New York NY', 'Seattle WA')
GROUP BY C.cid, C.name;
-- number of rows in the query result: 3


-- hw2-q7
SELECT SUM(F.capacity) AS capacity
FROM FLIGHTS F, MONTHS M
WHERE F.month_id = M.mid
AND F.origin_city in ('Seattle WA', 'San Francisco CA')
AND F.dest_city in ('San Francisco CA', 'Seattle WA')
AND F.day_of_month = 10
AND M.month = 'July';
-- number of columns in the query result: 1


-- hw2-q8
SELECT C.name AS name, SUM(F.departure_delay) AS delay
FROM FLIGHTS F, CARRIERS C
WHERE F.carrier_id = C.cid
GROUP BY C.cid, C.name;
-- number of columns in the query result: 22
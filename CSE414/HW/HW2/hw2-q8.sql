SELECT C.name AS name, SUM(F.departure_delay) AS delay
FROM FLIGHTS F, CARRIERS C
WHERE F.carrier_id = C.cid
GROUP BY C.cid, C.name;





-- number of rows in the query result: 22
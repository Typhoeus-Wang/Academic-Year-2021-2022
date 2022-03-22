SELECT C.name AS name, (SUM(F.canceled)*100.0/COUNT(*)) AS percentage
FROM FLIGHTS F, CARRIERS C
WHERE F.carrier_id = C.cid AND F.origin_city = 'Seattle WA'
GROUP BY C.name
HAVING (SUM(F.canceled)*100.0/COUNT(*)) > 0.5
ORDER BY (SUM(F.canceled)*100.0/COUNT(*)) ASC;

-- number of rows in the query result: 6
SELECT C.name AS carrier, MAX(MAX(F1.price), MAX(F2.price)) AS max_price
FROM FLIGHTS AS F1, FLIGHTS AS F2, CARRIERS AS C
WHERE F1.origin_city = 'Seattle WA'
AND F1.dest_city = 'New York NY'
AND F2.origin_city = 'New York NY'
AND F2.dest_city = 'Seattle WA'
AND F1.carrier_id = F2.carrier_id
AND F1.carrier_id = C.cid
GROUP BY C.cid, C.name
ORDER BY F1.price;
-- number of rows in the query result: 3
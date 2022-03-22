SELECT DISTINCT C.name AS carrier
FROM FLIGHTS F, CARRIERS C
WHERE F.carrier_id = C.cid
AND F.origin_city = 'Seattle WA'
AND F.dest_city = 'San Francisco CA'
ORDER BY carrier;


-- the number of rows the query returns: 4

-- the time the query takes: 54s

/* the first 20 rows of the result:
Alaska Airlines Inc.
SkyWest Airlines Inc.
United Air Lines Inc.
Virgin America
*/
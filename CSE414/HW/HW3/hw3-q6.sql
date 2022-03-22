SELECT DISTINCT C.name AS carrier
FROM CARRIERS C
WHERE C.cid IN (SELECT F.carrier_id
                FROM FLIGHTS F
                WHERE F.origin_city = 'Seattle WA'
                AND F.dest_city = 'San Francisco CA')
ORDER BY carrier;


-- the number of rows the query returns: 4

-- the time the query takes: 21s

/* the first 20 rows of the result:
Alaska Airlines Inc.
SkyWest Airlines Inc.
United Air Lines Inc.
Virgin America
*/
SELECT DISTINCT flight_num AS flight_num
FROM FLIGHTS AS F, CARRIERS AS C, MONTHS AS M, WEEKDAYS AS W
WHERE F.carrier_id = C.cid 
AND F.day_of_week_id = W.did
AND F.day_of_month = M.mid
AND W.day_of_week = 'Monday'
AND C.name = 'Alaska Airlines Inc.'
AND F.origin_city = 'Seattle WA'
AND F.dest_city = 'Boston MA';

-- number of rows in the query result: 3
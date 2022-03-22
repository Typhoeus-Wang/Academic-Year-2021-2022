SELECT DISTINCT C.name as name
FROM FLIGHTS F, CARRIERS C
WHERE F.carrier_id = C.cid
GROUP BY C.cid, C.name, F.month_id, F.day_of_month
HAVING COUNT(F.fid) > 1000;

-- number of rows in the query result: 12
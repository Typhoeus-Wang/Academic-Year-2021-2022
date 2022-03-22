SELECT SUM(F.capacity) AS capacity
FROM FLIGHTS F, MONTHS M
WHERE F.month_id = M.mid
AND F.origin_city in ('Seattle WA', 'San Francisco CA')
AND F.dest_city in ('San Francisco CA', 'Seattle WA')
AND F.day_of_month = 10
AND M.month = 'July';

-- number of rows in the query result: 1
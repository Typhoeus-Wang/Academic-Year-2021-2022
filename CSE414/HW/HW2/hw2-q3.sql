SELECT W.day_of_week as day_of_week, avg(F.arrival_delay) as delay
FROM FLIGHTS F, WEEKDAYS W
WHERE F.day_of_week_id = W.did
GROUP BY W.day_of_week
ORDER BY AVG(F.arrival_delay) DESC
LIMIT 1;

-- number of rows in the query result: 1
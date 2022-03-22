SELECT DISTINCT F4.dest_city AS city
FROM FLIGHTS F4
WHERE F4.dest_city != 'Seattle WA'
AND F4.dest_city NOT IN (
    SELECT DISTINCT F2.dest_city
    FROM FLIGHTS F1, FLIGHTS F2
    WHERE F1.origin_city = 'Seattle WA'
    AND F1.dest_city = F2.origin_city
    AND F2.dest_city != 'Seattle WA')
AND F4.dest_city NOT IN (
    SELECT DISTINCT F3.dest_city
    FROM FLIGHTS F3
    WHERE F3.origin_city = 'Seattle WA'
)
ORDER BY city;


-- the number of rows the query returns: 3

-- the time the query takes: 25s

/* the first 20 rows of the result:
Devils Lake ND
Hattiesburg/Laurel MS
St. Augustine FL
*/
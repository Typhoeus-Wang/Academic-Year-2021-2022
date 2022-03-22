SELECT DISTINCT F2.dest_city AS city
FROM FLIGHTS F1, FLIGHTS F2
WHERE F1.origin_city = 'Seattle WA'
AND F1.dest_city = F2.origin_city
AND F2.dest_city != 'Seattle WA'
AND F2.dest_city NOT IN (SELECT DISTINCT dest_city
                         FROM FLIGHTS
                         WHERE origin_city = 'Seattle WA')
ORDER BY city;


-- the number of rows the query returns: 256
-- the time the query takes: 10s
/* the first 20 rows of the result:
Aberdeen SD
Abilene TX
Adak Island AK
Aguadilla PR
Akron OH
Albany GA
Albany NY
Alexandria LA
Allentown/Bethlehem/Easton PA
Alpena MI
Amarillo TX
Appleton WI
Arcata/Eureka CA
Asheville NC
Ashland WV
Aspen CO
Atlantic City NJ
Augusta GA
Bakersfield CA
Bangor ME
*/





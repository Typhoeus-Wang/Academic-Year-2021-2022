SELECT DISTINCT F1.origin_city AS origin_city, F1.dest_city AS dest_city, X.max_time AS time
FROM FLIGHTS F1, 
    (SELECT F2.origin_city AS origin_city, MAX(F2.actual_time) as max_time
    FROM FLIGHTS AS F2
    GROUP BY F2.origin_city) AS X
WHERE F1.origin_city = X.origin_city
AND F1.actual_time = X.max_time
ORDER BY origin_city, dest_city;

-- the number of rows the query returns: 334
-- the time the query takes: 6s
/* the first 20 rows of the result:
Aberdeen SD   Minneapolis MN   106
Abilene TX   Dallas/Fort Worth TX   111
Adak Island AK   Anchorage AK   471
Aguadilla PR   New York NY   368
Akron OH   Atlanta GA   408
Albany GA   Atlanta GA   243
Albany NY   Atlanta GA   390
Albuquerque NM   Houston TX   492
Alexandria LA   Atlanta GA   391
Allentown/Bethlehem/Easton PA   Atlanta GA   456
Alpena MI   Detroit MI   80
Amarillo TX   Houston TX   390
Anchorage AK   Barrow AK   490
Appleton WI   Atlanta GA   405
Arcata/Eureka CA   San Francisco CA   476
Asheville NC   Chicago IL   279
Ashland WV   Cincinnati OH   84
Aspen CO   Los Angeles CA   304
Atlanta GA   Honolulu HI   649
Atlantic City NJ   Fort Lauderdale FL   212
*/






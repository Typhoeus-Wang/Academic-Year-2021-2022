SELECT DISTINCT origin_city AS city
FROM FLIGHTS
WHERE canceled = 0
GROUP BY origin_city
HAVING MAX(actual_time) < 180
ORDER BY city;

-- the number of rows the query returns: 109
-- the time the query takes: 9s
/* the first 20 rows of the result:
Aberdeen SD
Abilene TX
Alpena MI
Ashland WV
Augusta GA
Barrow AK
Beaumont/Port Arthur TX
Bemidji MN
Bethel AK
Binghamton NY
Brainerd MN
Bristol/Johnson City/Kingsport TN
Butte MT
Carlsbad CA
Casper WY
Cedar City UT
Chico CA
College Station/Bryan TX
Columbia MO
Columbus GA
*/
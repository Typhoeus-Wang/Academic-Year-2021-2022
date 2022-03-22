-- Lab4-q1
SELECT DISTINCT F1.origin_city AS origin_city, F1.dest_city AS dest_city, X.max_time AS time
FROM FLIGHTS F1, 
    (SELECT F2.origin_city AS origin_city, MAX(F2.actual_time) as max_time
    FROM FLIGHTS AS F2
    GROUP BY F2.origin_city) AS X
WHERE F1.origin_city = X.origin_city
AND F1.actual_time = X.max_time
ORDER BY origin_city, dest_city;

-- the number of rows the query returns: 334

-- the time the query takes: 00:00:00.394

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


-- Lab4-q2
SELECT DISTINCT origin_city AS city
FROM FLIGHTS
WHERE canceled = 0
GROUP BY origin_city
HAVING MAX(actual_time) < 180
ORDER BY city;

-- the number of rows the query returns: 109
-- the time the query takes: 00:00:00.172
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


-- Lab4-q3
SELECT F.origin_city as origin_city, (SELECT COUNT(F2.fid) as count
                                      FROM FLIGHTS F2
                                      WHERE F2.actual_time < 180
                                      AND F2.canceled = 0
                                      AND F2.origin_city = F.origin_city
                                      GROUP BY F2.origin_city
                                    ) * 100.0/ COUNT(*) AS percentage
FROM FLIGHTS F
GROUP BY F.origin_city
ORDER BY percentage;


-- the number of rows the query returns: 327

-- the time the query takes: 00:00:00.535

/* the first 20 rows of the result:
Guam TT	NULL
Pago Pago TT	NULL
Aguadilla PR	29.433962264150
Anchorage AK	32.146037399821
San Juan PR	33.890360709190
Charlotte Amalie VI	40.000000000000
Ponce PR	41.935483870967
Fairbanks AK	50.691244239631
Kahului HI	53.664998528113
Honolulu HI	54.908808692277
San Francisco CA	56.307656826568
Los Angeles CA	56.604107648725
Seattle WA	57.755416553349
Long Beach CA	62.454116413214
Kona HI	63.282107574094
New York NY	63.481519772551
Las Vegas NV	65.163009288383
Christiansted VI	65.333333333333
Newark NJ	67.137355584082
Worcester MA	67.741935483870
*/


-- Lab4-q4
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
-- the time the query takes: 00:00:00.766
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


-- Lab4-q5
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

-- the time the query takes: 00:00:01.175

/* the first 20 rows of the result:
Devils Lake ND
Hattiesburg/Laurel MS
St. Augustine FL
*/


-- Lab4-q6
SELECT DISTINCT C.name AS carrier
FROM CARRIERS C
WHERE C.cid IN (SELECT F.carrier_id
                FROM FLIGHTS F
                WHERE F.origin_city = 'Seattle WA'
                AND F.dest_city = 'San Francisco CA')
ORDER BY carrier;


-- the number of rows the query returns: 4

-- the time the query takes: 00:00:00.092

/* the first 20 rows of the result:
Alaska Airlines Inc.
SkyWest Airlines Inc.
United Air Lines Inc.
Virgin America
*/


-- Lab4-q7
SELECT DISTINCT C.name AS carrier
FROM FLIGHTS F, CARRIERS C
WHERE F.carrier_id = C.cid
AND F.origin_city = 'Seattle WA'
AND F.dest_city = 'San Francisco CA'
ORDER BY carrier;


-- the number of rows the query returns: 4

-- the time the query takes: 00:00:00.071

/* the first 20 rows of the result:
Alaska Airlines Inc.
SkyWest Airlines Inc.
United Air Lines Inc.
Virgin America
*/
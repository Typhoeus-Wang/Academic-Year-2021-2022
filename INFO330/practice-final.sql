-- 1
-- a
SELECT t1.riderid
FROM Trip t1, Trip t2
WHERE t1.riderid = t2.riderid
AND t1.endtime > t2.starttime

-- b
SELECT b.bid
FROM Bike b LEFT OUTER JOIN Trip t
WHERE b.bid = t.bikeid
GROUP BY B.bid
HAVING COUNT(t.tripid) = 0

SELECT b.bid
FROM Bike b
WHERE b.bid NOT IN (
    SELECT t.bikeid
    FROM Trip t
)

-- c
SELECT b.electric, AVG(t.endtime - t.starttime)
FROM Trip t, Bike b
WHERE t.bikeid = b.bid
GROUP BY b.electric

-- d
SELECT t.bikeid, t.tripid, next.tripid
FROM Trip t, Trip next
WHERE t.bikeid = next.bikeid
AND next.starttime = (
    SELECT min(X.starttime)
    FROM trip x
    WHERE x.starttime > t.endtime
    AND x.bikeid = t.bikeid
)

-- e
SELECT
FROM 
WHERE 


-- 2
-- a
CREATE TABLE Programmer (
    pid INT PRIMARY KEY,
    name text
)

CREATE TABLE DBAdmin (
    DBAid INT PRIMARY KEY REFERENCES Programmer(pid),
    rdbms text,
    reportsTo INT REFERENCES Programmer
)

-- b
R1(A, B),  R2(A, C, D, E)

R2 -> R3(C, D, E), R4(A, C, D)

final: R1(A, B), R2(C, D, E), R3(A, C, D)

-- c
-- c.1
-- False. Because there are not many insertions and there are many reads

-- c.2
True


-- 3
-- a


-- b
Plan B. Because we want to avoid the expensive join between Rider and Trip

-- c
4, 3, 1, 2, 5 (In hash join: build-small, probe-large; In Nested loops join: outer-large, inner-small)

-- d
-- d.1 correct

-- d.2 incorrect

-- d.3 correct

-- d.4 correct

-- d.5 correct because the x.zid is the primary key so avg is the depth itself.KEY


-- e

-- e.1
-- Table scan because the index is on Trip.endloc so index is not involved

-- e.2
-- Table scan because this query returns most of the records, so there's no point in using the index

-- e.3
-- index selection because only a few records are returned, it will use the index selection


-- 4

-- a
{
    "Bike":[
        {
            "bid": 1,
            "electric": true,
            "Trip": [
                {
                    "tripid": 10,
                    "starttime": "11:00",
                    "endtime": "11:40",
                    "startloc": "downtown",
                    "endloc": "ballard",
                    "Rider": {
                        "rid": 3,
                        "member": true
                    }
                },
                {
                    "tripid": 20,
                    "starttime": "11:50",
                    "endtime": "12:10",
                    "startloc": "ballard",
                    "endloc": "fremont",
                    "Rider": {
                        "rid": 4,
                        "member": false
                    }
                }
            ]
        },
        {
            "bid": 2,
            "electric": false,
            "Trip": [
                {
                    "tripid": 30,
                    "starttime": "10:00",
                    "endtime": "11:15",
                    "startloc": "capital hill",
                    "endloc": "udistrict",
                    "Rider": {
                        "rid": 3,
                        "member": true
                    }
                },
                {
                    "tripid": 40,
                    "starttime": "11:30",
                    "endtime": "11:55",
                    "startloc": "udistrict",
                    "endloc": "fremont",
                    "Rider": {
                        "rid": 4,
                        "member": false
                    }
                }
            ]
        }
    ]
}

-- b

{
    "Trip": [
        {
            "tripid": 10,
            "starttime": "11:00",
            "endtime": "11:40",
            "startloc": "downtown",
            "endloc": "ballard",
            "Bike": {
                "bid": 1,
                "electric": true
            },
            "Rider": {
                "rid": 3,
                "member": true
            }
        },
        {
            "tripid": 20,
            "starttime": "11:50",
            "endtime": "12:10",
            "startloc": "ballard",
            "endloc": "fremont",
            "Bike": {
                "bid": 1,
                "electric": true
            },
            "Rider": {
                "rid": 4,
                "member": false
            }
        },
        {
            "tripid": 30,
            "starttime": "10:00",
            "endtime": "11:15",
            "startloc": "capital hill",
            "endloc": "udistrict",
            "Bike": {
                "bid": 2,
                "electric": false
            },
            "Rider": {
                "rid": 3,
                "member": true
            }
        },
        {
            "tripid": 10,
            "starttime": "11:30",
            "endtime": "11:55",
            "startloc": "udistrict",
            "endloc": "fremont",
            "Bike": {
                "bid": 2,
                "electric": false
            },
            "Rider": {
                "rid": 4,
                "member": false
            }
        }
    ]
}

-- 5
-- a
false -- true

-- b
true

-- c
false (there are many T entities "pointing" to the same S entity)

-- d
true (would be false if it was a many-to-many relationship)

-- e
true (all attributes is always a key, if the relation is a set)

-- f
false (a record is uniquely identified by a combination of A and B)

-- g
true (though we designate only one as Primary in some contexts)

-- h
false -- true

-- i
true

-- j
false -- true
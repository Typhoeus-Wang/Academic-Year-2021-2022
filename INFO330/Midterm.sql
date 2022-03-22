/*
I attest that I did not communicate with anyone other than the instructors about
the questions on this midterm, and that all of the work is my own. <Qirui Wang>
*/


-- Question 1

-- (a)
CREATE TABLE User (
    uid VARCHAR(20) PRIMARY KEY,
    ip VARCHAR(20),
    demo VARCHAR(20) CHECK (demo IN ('child'，'18-25'， '25-40'， '40+')）
);

CREATE TABLE Page (
    url VARCHAR(800) PRIMARY KEY,
    title VARCHAR(100),
    content VARCHAR(max)
);

CREATE TABLE Visit ( 
    url VARCHAR(800) REFERENCES Page(url),
    dt DATE,
    uid VARCHAR(20) REFERENCES User(uid),
    src VARCHAR(800) REFERENCES Page(url),
    rev INT NOT NULL CHECK (rev >= 0),
    PRIMARY KEY(url, dt, uid)
);


-- (b)
SELECT U.demo AS demo, COUNT(*) AS totalusers
FROM User U
GROUP BY U.demo
ORDER BY totalusers DESC;


-- (c)
SELECT U.ip AS ip, COUNT(V.rev) AS numvisits, AVG(V.rev) AS averagerev
FROM User U LEFT OUTER JOIN Visit V
ON (U.uid = V.uid AND V.rev > 10)
GROUP BY U.uid, U.ip
ORDER BY AVG(V.rev) DESC;


-- (d)
SELECT P.url, P.title
FROM Page P, Visit V
WHERE P.url = V.url
GROUP BY P.url
HAVING MAX(V.rev) < 5;


-- (e)
WITH X AS(
    SELECT V.url AS url, MAX(V.dt) AS most_recent_visit
    FROM Visit V
    GROUP BY V.url
)
SELECT V.url AS url, V.src AS latestsrc
FROM Visit V, X
WHERE V.url = X.url
AND V.dt = X.most_recent_visit


-- (g)
SELECT DISTINCT U.ip
FROM User U, Visit V1, Visit V2
WHERE U.uid = V1.uid
AND U.uid = V2.uid
AND V1.rev < 5
AND V2.rev > 10
AND V2.dt > v1


-- (h)
WITH X AS (
    SELECT V1.url AS url
    FROM Visit V1, User U1
    WHERE V1.uid = U1.uid
    AND U1.demo = 'child'
    GROUP BY V1.url
    HAVING COUNT(*) > 1
),
Y AS (
    SELECT V2.url AS url
    FROM Visit V2, User U2
    WHERE V2.uid = V2.uid
    AND U2.demo = '18-25'
    GROUP BY V2.url
    HAVING COUNT(*) > 1
)
SELECT DISTINCT X.url
FROM X, Y
AND X.url = Y.url;


-- (i)
SELECT DISTINCT V.url, V.uid, V.dt
FROM Visit V
WHERE V.src NOT IN (
    SELECT DISTINCT V1.url
    FROM Visit V1
)




-- (j)
SELECT DISTINCT V1.url
FROM User U, Visit V1, Visit V2
WHERE U.uid = V1.uid
AND U.uid = V2.uid
AND V1.url = V2.src
AND V2.url = V1.src
AND V1.dt < V2.dt


-- 2
SELECT DISTINCT x.demo
FROM User x, Visit y
WHERE x.uid = y.uid
AND y.rev >= 20;


-- 2a 
-- Y
-- 2b 
-- N
-- 2c 
-- N
-- 2d 
-- Y
-- 2e 
-- N
-- 2f 
-- 
-- 2g 
-- Y
-- 2h 
-- Y


-- 3a
-- 4 tables

-- 3b
-- instance 1, instance 2, and instance 3 are allowed but instance 4 is not allowed


-- 4a
-- (pid, cname)

-- 4b
-- (cid, pid, cname)

-- 4c
-- 3 tables

-- 4d
-- Yes, but you need to configure the definition of the Foreign Key in the Component table properly


-- 5a
insert into match values ('Sofia', 'Renata', 'Championship', '2020-10-10');
insert into match values ('Renata', 'Sofia', 'Semi-final', '2020-11-11');

-- 5b
insert into match values ('Sofia', 'Renata', 'Championship', '2021-10-10');
insert into match values ('Renata', 'Sofia', 'Championship', NULL);
insert into match values ('Sofia', 'Sofia', 'Semi-final', '2021-09-09');
insert into match values ('Sofia', 'Mike', 'Championship', '2009-01-01');


-- 6a
-- True

-- 6b
-- False

-- 6c
-- False

-- 6d
-- False

-- 6e
-- True

-- 6f
-- True

-- 6g
-- False

-- 6h
-- True

-- 6i
-- False

-- 6j
-- True
-- (a) ok
CREATE TABLE User (
    uid VARCHAR(20) PRIMARY KEY, 
    name VARCHAR(20),
    company VARCHAR(20)
)

CREATE TABLE Follows (
    uid VARCHAR(20) REFERENCES User(uid),
    followsid VARCHAR(20) REFERENCES User(uid),
    weight VARCHAR(20),
    PRIMARY KEY(uid, followsid)
)
-- shall uid, followsid both refers to User(uid)?

-- (b) ok
SELECT U.company AS company, COUNT(*) AS totalusers
FROM User AS U
GROUP BY U.company
ORDER BY totalusers DESC;


-- (c) ok

SELECT U.name, COUNT(F.uid) AS count

--FROM Follows AS F LEFT OUTER JOIN User AS U
--ON F.followsid = U.uid
FROM User AS U LEFT OUTER JOIN Follows AS F
ON (F.followsid = U.uid AND F.weight > 10)

-- (1, 2, 9)
-- (3, NULL, NULL)  XXXXXXX

WHERE F.weight > 10
-- NULL > 10?
GROUP BY U.name 
ORDER BY COUNT(F.uid) DESC;


SELECT U.name, COUNT(F.uid) AS count
FROM User AS U LEFT OUTER JOIN Follows AS F
ON (F.followsid = U.uid AND F.weight > 10)
GROUP BY U.name 
ORDER BY COUNT(F.uid) DESC;


-- (d) ok
SELECT U.name as name
FROM User AS U, Follows AS F
WHERE U.uid = F.followsid
GROUP BY U.uid
HAVING MAX(F.weight) < 10;

SELECT DISTINCT U.name
FROM User AS U
WHERE NOT EXISTS (
    SELECT *
    FROM Follows F
    WHERE F.followsid = U.uid
    AND F.weight >= 10
)


-- (e) 

SELECT F.uid, F.followsid
FROM Follows AS F, User AS U, (
    SELECT F1.uid as uid, MAX(F1.weight) as max_weight
    FROM Follows AS F1
    GROUP BY uid
) AS X
WHERE F.followsid = U.uid
AND F.weight = X.max_weight
GROUP BY F.uid;

SELECT F.uid, F.followsid
FROM Follows AS F, (
    SELECT F1.uid AS uid, Max(F1.weight) AS max_weight
    FROM Follows AS F1
    GROUP BY F1.uid
) AS X
WHERE X.uid = F.uid
AND X.max_weight = F.weight


-- (f)
SELECT F1.uid, F1.followsid
FROM Follows AS F1, Follows AS F2
WHERE F1.uid = F2.followsid
AND F1.followsid = F2.uid

-- (g)
SELECT DISTINCT Ux.name AS name
FROM User AS U, Follows AS F, User AS Ux
WHERE F.followsid = U.uid
AND F.uid = Ux.uid
AND (U.company = 'Microsoft' or U.company = 'Amazon');


WITH X AS(
    SELECT F.uid AS uid, 
    FROM User AS U, Follows AS F
    WHERE U.uid = F.followsid
)
SELECT 
FROM User AS U, X AS X1, X AS X2
WHERE U.uid = X1.uid
AND U.uid = X2.uid
AND X1.company = 'Microsoft'
AND X2.company = 'Amazon';


-- (h)
SELECT DISTINCT F1.name
FROM Follows AS F1, Follows AS F2, User AS U1, User AS U2
WHERE F1.followsid = F2.uid
AND F2.followsid = U1.uid
AND U1.company = 'Microsoft'
AND F1.uid = U2.uid



-- (i)
SELECT F1.uid, F2.uid, F3.uid
FROM Follows AS F1, Follows AS F2, Follows AS F3
WHERE F1.followsid = F2.uid
AND F2.followsid = F3.uid
AND F3.followsid = F1.uid
AND F1.uid < F2.uid
AND F2.uid < F3.uid;


-- 2
-- (a) Y
-- (b) N
-- (c) Y
-- (d) N
-- (e) Y
-- (f) Y
-- (g) Y


-- 3
-- (a) Yes.
-- (b) pid, date


-- 4
-- (a) Yes
-- (b) no, 'Sue' is not an existing patient
-- (c) No, treatedon is part of the primary key and it can not be null
-- (d) No, Lin is not an doctor
-- (e) No, the treatedon date does not satisfy the check constraint
-- (f) No (Lin, 2010-10-20) is a duplicate entry with row 1, which violates the primary key constraint.


-- 5
-- (a) False: Relational databases were originally invented to make applications faster
--     They were intended to reduce application complexity and were originally pretty slow.
-- (b) True: Every relation has at least one key. (assume set semantics -- no duplicate records)
--     All attributes together are considered a key (but, implementations allow duplicates)
-- (c) False: 
--     The combination of A and B uniquely identifies each record for primary key(A, B)
-- (d) True: A relation can have multiple keys, but only one primary key
-- (e) False: A relationship in an ER diagram (diamond) must always involve exactly two entities
-- (f) False: Non-relational databases are obsolete
-- (g) False: Given a relation R(A, B) with n records and a relation S(B, C) with m records, the join of
-- R and S will have at most n or m records, whichever is greater.
--     It could have as many as n*m records. Not every join represents a one-to-many relationship.


SELECT U.name AS name, COUNT(*) AS topfollowers -- COUNT(F.uid)
FROM User AS U LEFT OUTER JOIN Follows AS F
ON U.uid = F.followsid
AND F.weight > 10
GROUP BY U.uid, U.name
ORDER BY COUNT(*);
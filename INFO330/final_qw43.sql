-- 1 SQL
-- a
CREATE TABLE Slot (
    sid INT PRIMARY KEY,
    wall VARCHAR(255),
    x INT,
    y INT
)

CREATE TABLE Hold (
    hid INT PRIMARY KEY,
    color VARCHAR(255),
    desc VARCHAR(255)
)

CREATE TABLE Route (
    rid INT PRIMARY KEY,
    name ntext,
    circuit VARCHAR(255)
)

CREATE TABLE Placement (
    rid INT REFERENCES Route(rid)，
    hid INT REFERENCES Hold(hid),
    sid INT REFERENCES Slot(sid),
    PRIMARY KEY(rid, hid, sid)
)


-- b
SELECT DISTINCT p.rid
FROM Placement p, Hold h
WHERE p.hid = h.hid
GROUP BY p.rid
HAVING COUNT(DISTINCT h.color) > 1

-- c
SELECT DISTINCT rid
FROM Placement 
WHERE circuit = 'Beginner'
AND rid NOT IN (
    SELECT DISTINCT p1.rid
    FROM Placement p1, Placement p2
    WHERE p1.rid = p2.rid
    AND p1.sid = p2.sid
    AND p1.hid != p2.hid
)

-- d
SELECT DISTINCT h.color
FROM Placement p, Hold h
WHERE p.hid = h.hid
AND p.rid NOT IN (
    SELECT DISTINCT p1.rid
    FROM Placement p1, Hold h1
    WHERE p1.hid = h1.hid
    GROUP BY p1.rid
    HAVING COUNT(DISTINCT h1.color) > 1
)

-- e
SELECT rc.color, COUNT(DISTINCT p.rid) as count
FROM Placement p, Hold h, RouteColor rc
WHERE p.hid = h.hid
AND h.color = rc.color
GROUP BY rc.color

-- f
SELECT DISTINCT h.hid
FROM Placement p, Slot s, Hold h, Route r, (
    SELECT p.rid as rid, MAX(s.y) as y
    FROM Placement p, Slot s, Hold h, Route r
    WHERE p.hid = h.hid
    AND p.rid = r.rid
    AND p.sid = s.sid
    GROUP BY p.rid) as X
WHERE p.sid = s.sid
AND p.rid = r.rid
AND p.hid = h.hid
AND p.rid = x.rid
AND s.y = x.y


-- 2 Logical Database Design

CREATE TABLE Placement (
    hid INT REFERENCES Hold(hid),
    rid INT REFERENCES Route(rid),
    sid INT REFERENCES Slot(sid),
    is_critical boolean,
    PRIMARY KEY(hid, rid, sid)
)

-- b
R(name, status, gym, address, equipment, type, trainer, date)

R => R1(name, status)   R2(name, gym, address, equipment, type, trainer, date)

R2 => R3(gym, address)    R4(name, gym, equipment, type, trainer, date)

R4 => R5(gym, type, trainer)    R6(name, gym, type, equipment, date)

R6 => R7(equipment, type)    R8(name, gym, equipment, date)

result: R(name, gym, equipment, date), R(equipment, type), R(gym, type, trainer), 
    R(gym, address), R(name, status)


-- 3 Relational Algebra
-- a


-- b

-- bi 
-- Yes

-- bii
-- Yes

-- biii  
-- No

-- biv
-- Yes

-- bv
-- Yes

-- bvi
-- Yes

-- c
SELECT r.rid, MAX(s.x)
FROM Hold h, placement p, Route r, Slot s
WHERE h.hid = p.hid
AND r.rid = p.rid
AND s.sid = p.sid
AND h.color = 'red'
AND r.circuit = 'Beginner'
GROUP BY r.rid

-- d
SELECT DISTINCT p.rid, s.wall
FROM Placement p, Slot s
WHERE p.sid = s.sid

-- e
SELECT DISTINCT p.hid
FROM Placement p, Route r
WHERE p.rid = r.rid
AND r.circuit = 'Medium'

-- f
SELECT DISTINCT p.pid, h.hid
FROM Placement p, Hold h
WHERE p.hid h.hid
AND h.color = 'red'

-- g
SELECT p.rid, s.x, x.y
FROM Placement p, Slot s, Route r
WHERE p.sid = s.sid
AND p.rid = r.rid

-- h
SELECT p.rid, AVG(s.x), AVG(s.y)
FROM Placement p, Slot s
WHERE p.sid = s.sid
GROUP BY p.rid



-- 4 Query Optimization
-- a
V(A,a) = 1000
V(B,b) = 100
V(A,b) <= 100
# of tuples along X = 1000
# of tuples along Y = 100
# of tuples along Z = 100000

-- b IMPORTANT
A=10000
B=1600
C=5000
D=1000
E=200
F=1000
G=4000
H=4000
I=4000

-- c
-- ci
-- Join Algorithm 3 is called “Hash Join”
-- Join Algorithm 2 is called “Merge Join”
-- Join Algorithm 1 is called “Nested Loops Join”

-- cii
-- The cost of Join Algorithm 3 could be estimated as |A| + |B|
-- The cost of Join Algorithm 1 could be estimated as |A| * |B|
-- The cost of Join Algorithm 2 could be estimated as log(|A|) + log(|B|) + max(|A|, |B|)

-- ciii IMPORTANT
-- Join Algorithm 1 is typically used when both A and B are small
-- Join Algorithm 3 is typically used when A or B is large, but not both; it is very common in practice
-- Join Algorithm 2 is typically used when both A and B are large, or when tables can be accessed in sorted order


-- 5 Physical Database Design (Index Selection) IMPORTANT
-- a
-- ship_warehouse, ship_allbydate

-- b
-- ship_date_product, ship_product_date, ship_allbydate

-- c
-- ship_allbydate


-- 6 Concepts
-- a
-- True

-- b
-- False

-- c
-- True

-- d
-- False

-- e
-- True

-- f
-- True

-- g
-- False

-- h
-- False

-- i
-- True

-- j
-- True




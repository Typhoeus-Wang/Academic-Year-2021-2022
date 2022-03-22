-- 1
CREATE TABLE FrumbleData (
    name VARCHAR(255),
    discount VARCHAR(255),
    month VARCHAR(255),
    price INT
);

.mode tab
.import data.txt FrumbleData;
DELETE FROM FrumbleData WHERE month = 'month';


-- 2
-- check name -> discount. 
-- Result has more than 0 lines, so this isn't a functional dependency
SELECT * 
FROM FrumbleData X, FrumbleData Y
WHERE X.name = Y.name 
AND X.discount != Y.discount;

-- Check name -> month. 
-- Result has more than 0 lines, so this isn't a functional dependency
SELECT *
FROM FrumbleData X, FrumbleData Y
WHERE X.name = Y.name
AND X.month != Y.month;

-- Check discount -> month. 
-- Result has more than 0 lines, so this isn't a functional dependency
SELECT *
FROM FrumbleData X, FrumbleData Y
WHERE X.discount = Y.discount
AND X.month != Y.month;

-- Check name -> price. yes 
-- Result returns nothing, this is a functional dependency
SELECT * 
FROM frumbleData X, frumbleData Y
WHERE X.name = Y.name 
and X.price != Y.price;

-- Check price -> discount. 
-- Result has more than 0 lines, so this isn't a functional dependency
SELECT *
FROM FrumbleData X, FrumbleData Y
WHERE X.price = Y.price
AND X.discount != Y.discount;

-- Check month -> discount. yes
-- Result returns nothing, this is a functional dependency
SELECT * 
FROM FrumbleData X, FrumbleData Y
WHERE X.month = Y.month
AND X.discount != Y.discount;

-- name, month -> discount, price

-- Check name, discount -> month, price. 
-- Result returns nothing, this is a functional dependency
SELECT * 
FROM FrumbleData X, FrumbleData Y
WHERE X.name = Y.name
AND X.discount = Y.discount
AND X.month != Y.month
AND X.price != Y.price;

-- Check month, price -> name, discount. 
-- Result returns nothing, this is a functional dependency
SELECT * 
FROM FrumbleData X, FrumbleData Y
WHERE X.name != Y.name
AND X.discount != Y.discount
AND X.month = Y.month
AND X.price = Y.price;


-- 3
CREATE TABLE discountInMonth (
    month VARCHAR(255) PRIMARY KEY,
    discount VARCHAR(255)
);

CREATE TABLE productPrice (
    name VARCHAR(255) PRIMARY KEY,
    price INT
);

CREATE TABLE productAndMonth (
    name VARCHAR(255) REFERENCES productPrice(name),
    month VARCHAR(255) REFERENCES discountInMonth(month)
);


-- 4

INSERT INTO discountInMonth 
SELECT DISTINCT month, discount
FROM FrumbleData;

-- the number of rows the query returns: 12
SELECT COUNT(*) FROM discountInMonth;

INSERT INTO productPrice 
SELECT DISTINCT name, price
FROM FrumbleData;

-- the number of rows the query returns; 36
SELECT COUNT(*) FROM productPrice;

INSERT INTO productAndMonth 
SELECT DISTINCT name, month
FROM FrumbleData;

-- the number of rows the query returns: 426
SELECT COUNT(*) FROM FrumbleData;



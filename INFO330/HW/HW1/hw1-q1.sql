CREATE TABLE Edges (
    Source     INT,
    Destination INT
);

INSERT INTO Edges 
VALUES (10, 5),
       (6, 25),
       (1, 3),
       (4, 4);

SELECT * 
FROM Edges;

SELECT Source 
FROM Edges;

SELECT * 
FROM Edges
WHERE Source > Destination;

INSERT INTO Edges
Values ('-1', '2000');
-- I do not get an error here because SQL database engines that use rigid typing  
-- will usually try to automatically convert values to the appropriate datatype. 
-- Here it converts strings '-1' and '2000' into integer because they are 
-- well formed integer literal.

INSERT INTO Edges
Values ('-1', 'two');
-- I get an error here because the declared type contains the string "INT",
-- it is assigned INTEGER affinity and here 'two' cannot to be converted to
-- an integer.


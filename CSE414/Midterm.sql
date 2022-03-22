-- Q1.1
CREATE TABLE Lending (
isbn INT REFERENCES Books(isbn),
id INT REFERENCES Members(id),
checkout DATETIME,
returned DATETIME,
PRIMARY KEY (isbn, id, checkout)
);

-- Q1.2
SELECT M.name, B.title
FROM Lending L, Members M, Books B
WHERE L.id = M.id
AND L.isbn = B.isbn
AND L.returned IS NULL
ORDER BY M.name, B.title;

-- Q1.3
SELECT B.title, M.name, COUNT(*)
FROM Lending L, Members M, Books B
WHERE L.isbn = B.isbn
AND L.id = M.id
GROUP BY B.isbn, B.title, M.id, M.name
HAVING COUNT(*) > 1;

-- Q1.4
SELECT B.genre, COUNT(L.id)
FROM Book B LEFT OUTER JOIN Lending L
ON B.isbn = L.isbn
GROUP BY B.genre
ORDER BY COUNT(L.id) DESC;
/*
In my first submission I used inner join which will eliminate genres that has some books
in the library but none have ever been checked out. I should use left outer join 
and count the id of each lending to keep all book genres to have their counts to be 0. 
*/

-- Q1.5
SELECT DISTINCT M.id, M.name
FROM Members M, Lending L1, Books B1, Lending L2, Books B2 
WHERE M.id = L1.id AND L1.isbn = B1.isbn
AND M.id = L2.id AND L2.isbn = B2.isbn
AND B1.title = 'Leaves of Grass'
AND B2.title = 'Harmonium';


-- Q2
-- correct


-- Q3.1
-- Fasle

-- Q3.2
-- True

-- Q3.3
-- False

-- Q3.4
-- False

-- Q3.5
-- True






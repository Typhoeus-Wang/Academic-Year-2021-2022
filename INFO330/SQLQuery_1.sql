CREATE TABLE Users (
    uid VARCHAR(20) PRIMARY KEY,
    ip VARCHAR(20),
    demo VARCHAR(20) CHECK (demo IN ('child', '18-25', '25-40', '40+'))
)

CREATE TABLE Page (
    url VARCHAR(800) PRIMARY KEY,
    title VARCHAR(100),
    content VARCHAR(max)
)

CREATE TABLE Visit ( 
    url VARCHAR(800) REFERENCES Page(url),
    dt DATE,
    uid VARCHAR(20) REFERENCES Users(uid),
    src VARCHAR(800) REFERENCES Page(url),
    rev INT NOT NULL CHECK (rev >= 0),
    PRIMARY KEY(url, dt, uid)
)

INSERT INTO Users VALUES
(1, '120.0.0.1', 'child'), (2, '120.0.0.2', '18-25'), (3, '120.0.0.3', '25-40'),
(4, '120.0.0.4', '40+'), (5, '120.0.0.5', 'child'), (6, '120.0.0.6', '18-25'),
(7, '120.0.0.7', 'child'), (8, '120.0.0.8', '18-25'), (9, '120.0.0.9', '25-40');

INSERT INTO Page VALUES
('url1', 'physics web', 'physics knowledge'), ('url2', 'chemistry web', 'chemistry knowledge'),
('url3', 'CS web', 'CS knowledge'), ('url4', 'CE web', 'CE knowledge'),
('url5', 'art web', 'art knowledge'), ('url6', 'math web', 'math knowledge');

INSERT INTO Visit VALUES
('url3', '2020-03-23', 8, 'url5', 23),
('url6', '2020-03-23', 9, 'url4', 99),
('url2', '2020-03-23', 4, 'url4', 34),
('url4', '2020-01-25', 7, 'url6', 3), ('url5', '2021-06-07', 5, 'url1', 7),
('url3', '2020-01-25', 3, 'url6', 4), ('url2', '2021-06-07', 2, 'url1', 11),
('url1', '2020-01-25', 2, 'url2', 12), ('url5', '2021-06-07', 8, 'url2', 2);

SELECT * FROM Users;
SELECT * FROM Page;
SELECT * FROM Visit;


-- Question 5
create table player (
    name VARCHAR(50) PRIMARY KEY,
    birthdate date
);

create table tournament (
    name varchar(50) PRIMARY KEY,
    prize int
);

create table match (
    winner VARCHAR(50) REFERENCES player(name),
    loser VARCHAR(50) REFERENCES player(name),
    tournament VARCHAR(50) REFERENCES tournament(name),
    playedon date NOT NULL,
    UNIQUE (winner, loser, tournament),
    CHECK(loser != winner)
);

insert into player values ('Sofia', '12/13/1987');
insert into player values ('Renata', '3/2/1992');
insert into tournament values ('Championship', 1000);
insert into tournament values ('Semi-final', 200);

insert into match values ('Sofia', 'Renata', 'Championship', '2020-10-10');
insert into match values ('Renata', 'Sofia', 'Semi-final', '2020-11-11');

insert into match values ('Sofia', 'Renata', 'Championship', '2021-10-10');
insert into match values ('Renata', 'Sofia', 'Championship', NULL);
insert into match values ('Sofia', 'Sofia', 'Semi-final', '2021-09-09');
insert into match values ('Sofia', 'Mike', 'Championship', '2009-01-01');


   select distinct x.demo
   from Users x, visit y, visit z
   where x.uid = y.uid
     and y.src = z.url
     and y.rev >= 20

select distinct x.demo
from users x, visit y
where x.uid = y.uid
and y.rev >= 20


SELECT DISTINCT U.ip
FROM Users U, Visit V1, Visit V2
WHERE U.uid = V1.uid
AND U.uid = V2.uid
AND V1.rev < 5
AND V2.rev > 10
AND V2.dt > v1.dt
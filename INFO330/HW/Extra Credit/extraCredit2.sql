-- 1. Load new data
SELECT * FROM Public_Art_Data

-- 2: Figure out the key
SELECT *
FROM Public_Art_Data
GROUP BY sac_id

SELECT * 
FROM Public_Art_Data
GROUP BY title;

-- 3: Fix empty descriptions
UPDATE Public_Art_Data
SET [description] = NULL
WHERE [description] = ''''''

-- 4: Create clean public art table
CREATE TABLE seattle_public_art (
    sac_id NVARCHAR(200),
    project NVARCHAR(200),
    title NVARCHAR(200),
    [description] ntext,
    media ntext,
    [date] NVARCHAR(200),
    [location] NVARCHAR(200),
    PRIMARY KEY(sac_id, title)
)

-- 4a
INSERT INTO seattle_public_art
SELECT DISTINCT sac_id, project, title, [description], media, [date], [location]
FROM Public_Art_Data
WHERE sac_id IS NOT NULL;

-- 5: Create an artist table
CREATE TABLE seattle_public_art_artist (
    first_name varchar(100),
    last_name varchar(100),
    suffix varchar(10),
    PRIMARY KEY(first_name, last_name)
)

SELECT * FROM seattle_public_art_artist

DROP TABLE seattle_public_art_artist

-- 6: Populate your artist table with all the artist data
INSERT seattle_public_art_artist(first_name, last_name)
SELECT DISTINCT artist_first_name, artist_last_name
FROM Public_Art_Data
WHERE artist_first_name IS NOT NULL
AND artist_last_name IS NOT NULL

-- 7: Fix the dirty artist data

SELECT *
FROM Public_Art_Data
WHERE sac_id = 'ESD00.074.06' -- James Jr. Washington /

SELECT *
FROM Public_Art_Data
WHERE sac_id = 'PR99.044' -- Fels, Donald; Feddersen, Joe; Quick to see Smith, Jaune /

SELECT *
FROM Public_Art_Data
WHERE sac_id = 'PR99.043' -- Fels, Donald; Feddersen, Joe; Quick to see Smith, Jaune /

SELECT *
FROM Public_Art_Data
WHERE sac_id = 'PR99.046' -- Fels, Donald; Feddersen, Joe; Quick to see Smith, Jaune /

SELECT *
FROM Public_Art_Data
WHERE sac_id = 'PR99.045' -- Fels, Donald; Feddersen, Joe; Quick to see Smith, Jaune /

SELECT *
FROM Public_Art_Data
WHERE sac_id = 'NEA97.024' -- Beliz Brother and Mark Calderon /

SELECT *
FROM Public_Art_Data
WHERE sac_id = 'PR97.022' -- Beliz Brother and Mark Calderon /

SELECT *
FROM Public_Art_Data
WHERE sac_id = 'LIB05.006' -- D' Agostino, Fernanda

DELETE seattle_public_art_artist
WHERE last_name = 'Fels, Donald; Feddersen, Joe; Quick to see Smith, Jaune'

DELETE seattle_public_art_artist
WHERE last_name = 'Brother and Mark Calderon'

DELETE seattle_public_art_artist
WHERE first_name = 'Fernanda'

DELETE seattle_public_art_artist
WHERE first_name = 'James Jr.'

INSERT seattle_public_art_artist VALUES ('Donald', 'Fels', NULL);

INSERT seattle_public_art_artist VALUES ('Joe', 'Feddersen', NULL);

INSERT seattle_public_art_artist VALUES ('Jaune', 'Quick to see Smith', NULL);

INSERT seattle_public_art_artist VALUES ('James', 'Washington', 'Jr.');

INSERT seattle_public_art_artist VALUES ('Beliz', 'Brother', NULL);

INSERT seattle_public_art_artist VALUES ('Mark', 'Calderon', NULL)

INSERT seattle_public_art_artist VALUES ('Fernanda', 'D'' Agostino', NULL)

-- 8: Create the many-to-many relationship between art and artist

CREATE TABLE seattle_public_art_artist_work (
    sac_id varchar(200),
    title varchar(200),
    artist_first_name varchar(100),
    artist_last_name varchar(100),
    PRIMARY KEY(sac_id, title, artist_first_name, artist_last_name)
)

DROP TABLE seattle_public_art_artist_work;

-- 9
SELECT p.sac_id, p.title,  a.first_name, a.last_name
FROM seattle_public_art_artist a, Public_Art_Data p
WHERE a.first_name = p.artist_first_name
AND a.last_name = p.artist_last_name
AND sac_id IS NOT NULL

INSERT INTO seattle_public_art_artist_work
SELECT DISTINCT p.sac_id, p.title, a.first_name, a.last_name
FROM seattle_public_art_artist a, Public_Art_Data p
WHERE a.first_name = p.artist_first_name
AND a.last_name = p.artist_last_name
AND sac_id IS NOT NULL

SELECT * FROM seattle_public_art_artist_work; 

INSERT seattle_public_art_artist_work VALUES ( 'PR99.044', 'Bronze Imbeds', 'Jaune', 'Quick to see Smith');
INSERT seattle_public_art_artist_work  VALUES ('PR99.043', 'Pavers', 'Jaune', 'Quick to see Smith');
INSERT seattle_public_art_artist_work  VALUES ('PR99.046', 'Viewers', 'Jaune', 'Quick to see Smith');
INSERT seattle_public_art_artist_work  VALUES ('PR99.045', 'Bronze Plaques and Medallion', 'Jaune', 'Quick to see Smith');

INSERT seattle_public_art_artist_work VALUES ( 'PR99.044', 'Bronze Imbeds', 'Donald', 'Fels');
INSERT seattle_public_art_artist_work  VALUES ('PR99.043', 'Pavers', 'Donald', 'Fels');
INSERT seattle_public_art_artist_work  VALUES ('PR99.046', 'Viewers', 'Donald', 'Fels');
INSERT seattle_public_art_artist_work  VALUES ('PR99.045', 'Bronze Plaques and Medallion', 'Donald', 'Fels');
INSERT seattle_public_art_artist_work VALUES ( 'PR99.044', 'Bronze Imbeds', 'Joe', 'Feddersen');
INSERT seattle_public_art_artist_work  VALUES ('PR99.043', 'Pavers', 'Joe', 'Feddersen');
INSERT seattle_public_art_artist_work  VALUES ('PR99.046', 'Viewers', 'Joe', 'Feddersen');
INSERT seattle_public_art_artist_work  VALUES ('PR99.045', 'Bronze Plaques and Medallion', 'Joe', 'Feddersen');

INSERT seattle_public_art_artist_work VALUES ('ESD00.074.06', 'Coelacanths', 'James', 'Washington')

INSERT seattle_public_art_artist_work VALUES ('NEA97.024', 'Water Borne', 'Beliz', 'Brother')
INSERT seattle_public_art_artist_work VALUES ('NEA97.024', 'Water Borne', 'Mark', 'Calderon')

INSERT seattle_public_art_artist_work VALUES ('LIB05.006', 'Into the Green Wood', 'Fernanda', 'D'' Agostino')



-- 10
SELECT artist_first_name, artist_last_name, count(*)
FROM seattle_public_art_artist_work w, seattle_public_art art
WHERE art.sac_id = w.sac_id
AND art.title = w.title
GROUP BY artist_first_name, artist_last_name
ORDER BY count(*) DESC
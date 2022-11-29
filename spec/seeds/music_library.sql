DROP TABLE IF EXISTS artists; 

-- Table Definition
CREATE TABLE artists (
    id SERIAL PRIMARY KEY,
    name text,
    genre text
);

DROP TABLE IF EXISTS albums; 

-- Table Definition
CREATE TABLE albums (
    id SERIAL PRIMARY KEY,
    title text,
    release_year int4,
    artist_id int4
);
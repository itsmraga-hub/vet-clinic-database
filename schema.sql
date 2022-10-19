/* Database schema to keep the structure of entire database. */

-- CREATE TABLE animals (
--     name varchar(100)
-- );

CREATE TABLE ANIMALS(
    id INT PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    date_of_birth DATE,
    escape_attempts INT NOT NULL,
    neutered BOOL,
    weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN species TEXT;

-- CREATE owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    age INT
);

-- CREATE species table
CREATE TABLE species(
    id SERIAL PRIMARY KEY,
    name TEXT
);

-- Modify animals table

-- create sequence to set primary key to AUTO INCREMENT
CREATE SEQUENCE animals_id_seq owned BY animals.id;

ALTER TABLE ANIMALS ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');

SELECT SETVAL(pg_get_serial_sequence('animals', 'id'), max(id)) FROM animals;

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species;

ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners;

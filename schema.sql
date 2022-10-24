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


-- Create a table named vets with the following columns:

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150),
    age INT,
    date_of_graduation DATE
);

/* There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship. */

CREATE TABLE specializations (
    species_id INT REFERENCES species (id),
    vets_id INT REFERENCES vets (id)
);

/* There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit. */

CREATE TABLE visits (
    animals_id INT REFERENCES animals (id),
    vets_id INT REFERENCES vets (id),
    date_of_visit DATE
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

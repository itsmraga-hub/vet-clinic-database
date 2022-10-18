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

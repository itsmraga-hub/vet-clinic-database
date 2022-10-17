/* Database schema to keep the structure of entire database. */

-- CREATE TABLE animals (
--     name varchar(100)
-- );

CREATE TABLE animals(
    id INT primary key not null,
    name TEXT not null,
    date_of_birth DATE,
    escape_attempts INT not null,
    neutered BOOL,
    weight_kg DECIMAL
);
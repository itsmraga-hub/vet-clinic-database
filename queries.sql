/*Queries that provide answers to the questions from all projects.*/

-- SELECT * from animals WHERE name = 'Luna';

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT * FROM animals WHERE neutered AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered;

SELECT * FROM animals WHERE NOT name = 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


-- Set all species to unspecified and then rollback

BEGIN;
UPDATE ANIMALS SET species = 'unspecified';
SELECT * FROM ANIMALS; -- To verify changes occurred
ROLLBACK;
SELECT * FROM ANIMALS; -- To verify changes were not saved.


-- Update species to digimon and pokemon

BEGIN;
UPDATE ANIMALS SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE ANIMALS SET species = 'pokemon' WHERE NOT name LIKE '%mon';
SELECT * FROM ANIMALS; -- To verify changes occurred
COMMIT; --To save the changes
SELECT * FROM ANIMALS; -- To make sure changes were saved and persist


-- Delete all records and rollback

BEGIN;
DELETE FROM ANIMALS;
SELECT * FROM ANIMALS; -- Displays 0
ROLLBACK;
SELECT * FROM ANIMALS; -- Displays all 11 animals.


-- Transaction 4

BEGIN;
DELETE FROM ANIMALS WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_after_january_2022;
UPDATE ANIMALS SET weight_kg = -1 * weight_kg;
ROLLBACK TO SAVEPOINT delete_after_january_2022;
UPDATE ANIMALS SET weight_kg = -1 * weight_kg WHERE weight_kg < 0;
COMMIT;


-- Aggregate Transactions

-- How many animals are there?
SELECT count(animals) FROM animals; -- 10


-- How many animals have never tried to escape?
SELECT count(animals) FROM animals WHERE escape_attempts = 0; -- 2


-- What is the average weight of animals?
SELECT avg(weight_kg) FROM animals; -- 15.55000


-- Who escapes the most, neutered or not neutered animals?
SELECT SUM(escape_attempts) FROM animals WHERE neutered; -- 20
SELECT SUM(escape_attempts) FROM animals WHERE NOT neutered; -- 4
-- not neutered escape the most


-- What is the minimum and maximum weight of each type of animal?
-- Minimum of type digimon
SELECT MIN(weight_kg) FROM animals WHERE species = 'digimon'; -- 5.7
-- Maximum of type digimon
SELECT MAX(weight_kg) FROM animals WHERE species = 'digimon'; -- 45
-- Minimum of type pokemon
SELECT MIN(weight_kg) FROM animals WHERE species = 'pokemon'; -- 11
-- Maximum of type pokemon
SELECT MAX(weight_kg) FROM animals WHERE species = 'pokemon'; -- 17


-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
-- Average escape attempts of type digimon
SELECT AVG(escape_attempts) FROM animals WHERE species = 'digimon' AND date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'; -- 0
-- Average escape attempts of type pokemon
SELECT AVG(escape_attempts) FROM animals WHERE species = 'pokemon' AND date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'; -- 3.0

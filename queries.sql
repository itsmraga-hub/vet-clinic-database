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



/* Write queries (using JOIN) to answer the following questions: */


-- What animals belong to Melody Pond?

SELECT * FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)

SELECT * FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT animals.name, owners.full_name FROM owners INNER JOIN animals ON animals.owner_id = owners.id WHERE owners.full_name = 'Sam Smith';

SELECT animals.name, owners.full_name FROM owners INNER JOIN animals ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell';

SELECT animals.name, owners.full_name FROM owners INNER JOIN animals ON animals.owner_id = owners.id WHERE owners.full_name = 'Bob';

SELECT animals.name, owners.full_name FROM owners INNER JOIN animals ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, owners.full_name FROM owners INNER JOIN animals ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester';

SELECT animals.name, owners.full_name FROM owners INNER JOIN animals ON animals.owner_id = owners.id WHERE owners.full_name = 'Jodie Whittaker';


-- How many animals are there per species?

SELECT COUNT(animals) FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon'; -- 4

SELECT COUNT(animals) FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Digimon'; -- 6

-- List all Digimon owned by Jennifer Orwell.

SELECT * FROM animals INNER JOIN owners ON animals.owner_id = owners.id INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT * FROM animals INNER JOIN owners ON animals.owner_id = owners.id INNER JOIN species ON animals.species_id = species.id WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

-- Who owns the most animals?

SELECT animals.owner_id, owners.full_name, COUNT(animals.owner_id) FROM animals INNER JOIN owners ON animals.owner_id = owners.id GROUP BY animals.owner_id, owners.full_name ORDER BY COUNT(*) DESC LIMIT 1;


/* Write queries to answer the following: */

-- Who was the last animal seen by William Tatcher?
-- SELECT max(date_of_visit) FROM visits WHERE vets_id = 1;
SELECT animals.name FROM visits JOIN vets ON visits.vets_id = vets.id JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'William Tatcher' ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT COUNT(DISTINCT(animals.name)) FROM visits JOIN animals ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.

SELECT vets.name as vet_name, species.name as SPECIES_NAME FROM species RIGHT JOIN specializations ON specializations.species_id = species.id RIGHT JOIN vets ON specializations.vets_id = vets.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT * FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON visits.vets_id = vets.id WHERE visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' AND vets.name = 'Stephanie Mendez';

-- What animal has the most visits to vets?

SELECT COUNT(animals.name), animals.name FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id GROUP BY animals.name ORDER BY COUNT(animals.name) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT animals.name, vets.name, visits.date_of_visit FROM visits JOIN vets ON visits.vets_id = vets.id JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'Maisy Smith' ORDER BY visits.date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT visits.date_of_visit, animals.*, vets.* FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON visits.vets_id = vets.id ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) FROM vets LEFT JOIN specializations ON specializations.species_id = vets.id LEFT JOIN species ON species.id = specializations.species_id LEFT JOIN visits ON vets.id = visits.animals_id WHERE species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT COUNT(animals.id), animals.* FROM animals JOIN vets ON visits.vets_id = vets.id JOIN visits ON animals.id = visits.animals_id WHERE vets.name = 'Maisy Smith' GROUP BY animals.id ORDER BY COUNT(animals.id) DESC LIMIT 1;

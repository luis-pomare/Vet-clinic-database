/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = 'true' and escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name = 'Pikachu' OR name = 'Agumon';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Execute the second group of queries
BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT s1;
UPDATE animals
SET weight_kg = -1*weight_kg;
ROLLBACK TO s1;
UPDATE animals
SET weight_kg = -1*weight_kg
WHERE weight_kg < 0;
COMMIT;

-- Answer analitycal questions
SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT SUM(escape_attempts), neutered FROM animals
GROUP BY neutered; 

SELECT MAX(weight_kg), MIN(weight_kg), species
FROM animals
GROUP BY species;

SELECT AVG(escape_attempts), species
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP by species;

-- Answer join questions
SELECT *
FROM owners JOIN animals
ON owners.id = animals.owner_id
WHERE owners.full_name = 'Melody Pond';

SELECT *
FROM species JOIN animals
ON species.id = animals.species_id
WHERE species.name = 'Pokemon';

SELECT owners.id, owners.full_name, animals.id, animals.name, animals.owner_id
FROM owners LEFT JOIN animals
ON owners.id = animals.owner_id;

SELECT species.name, COUNT(species.name)
FROM animals JOIN species
ON species_id = species.id 
GROUP BY species.id;

SELECT owners.id, owners.full_name, animals.id, animals.name, animals.owner_id
FROM owners LEFT JOIN animals
ON owners.id = animals.owner_id
WHERE owners.full_name = 'Jennifer Orwell';

SELECT owners.id, owners.full_name, animals.id, animals.name, animals.owner_id
FROM owners LEFT JOIN animals
ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT owner_id, full_name, COUNT(owner_id)
FROM animals JOIN owners
ON owner_id = owners.id
GROUP BY full_name, owner_id
ORDER BY COUNT(owner_id) DESC LIMIT 1;

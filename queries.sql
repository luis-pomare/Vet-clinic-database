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

SELECT owners.id, owners.full_name, animals.id, animals.name, animals.owner_id, animals.species_id
FROM owners LEFT JOIN animals
ON owners.id = animals.owner_id
WHERE owners.full_name = 'Jennifer Orwell' AND animals.species_id = 2;

SELECT owners.id, owners.full_name, animals.id, animals.name, animals.owner_id
FROM owners LEFT JOIN animals
ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT owner_id, full_name, COUNT(owner_id)
FROM animals JOIN owners
ON owner_id = owners.id
GROUP BY full_name, owner_id
ORDER BY COUNT(owner_id) DESC LIMIT 1;

-- Answer junction tables questions
SELECT animal_id, animals.name, visit_date, vet_id, vets.name FROM
animals JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visit_date DESC LIMIT 1;

SELECT vet_id, vets.name, animal_id, animals.name, visit_date FROM
animals JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.id, vets.name AS veterinarian, specie_id, species.name FROM
vets LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON specializations.specie_id = species.id;

SELECT animal_id, animals.name, visit_date, vet_id, vets.name FROM
animals JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
AND visit_date BETWEEN '2020-04-30' and '2020-08-30'
ORDER BY visit_date;

SELECT animals.id, animals.name
FROM animals JOIN visits
ON animals.id = visits.animal_id;

SELECT animals.name, COUNT(*) AS vet_visits
FROM animals JOIN visits
ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY vet_visits DESC LIMIT 1;

SELECT vets.name AS vet, animals.name AS patient, visit_date FROM 
animals JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visit_date LIMIT 1;

SELECT animals.*, vets.*, visits.visit_date FROM 
animals JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
ORDER BY visit_date DESC LIMIT 1;

SELECT specializations.specie_id, animals.species_id FROM
animals RIGHT JOIN visits 
ON animals.id = visits.animal_id
JOIN specializations ON visits.vet_id = specializations.vet_id
WHERE specializations.specie_id = animals.species_id;

SELECT species.name FROM animals
JOIN species ON species.id = animals.species_id
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(animals.id) DESC LIMIT 1;

-- Queries for performance measurement
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';

-- To improve the performance of first query.
CREATE INDEX animal_id_asc ON visits(animal_id ASC);

-- To improve the performance of second query.
CREATE INDEX vet_id_index ON visits(vet_id ASC);

-- To improve the performance of third query.
CREATE INDEX email_asc ON owners(email ASC);

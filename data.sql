/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', '2020-02-03', 10.23, '1', 0),
('Gabumon', '2018-11-15', 8, '1', 2),
('Pikachu', '2021-01-7', 15.04, '0', 1),
('Devimon', '2017-05-12', 11, '1', 5);

-- Second activity: query and update animals table

-- Insert second group of animals
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES 
('Charmander', '2020-02-08', -11, '0', 0),
('Plantmon', '2021-11-15', -5.7, '1', 2),
('Squirtle', '1993-04-02', -12.13, '0', 3),
('Angemon', '2005-06-12', -45, '1', 1),
('Boarmon', '2005-06-7', 20.4, '1', 7),
('Blossom', '1998-10-13', 17, '1', 3),
('Ditto', '2022-05-14', 22, '1', 4);  

-- Insert owners' data into owners table
BEGIN;
INSERT INTO owners(full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dian Winchester', 14),
('Jodie Whittaker', 38);
COMMIT;

-- Insert the species data into the species table
BEGIN;
INSERT INTO species(name)
VALUES
('Pokemon'),
('Digimon');
COMMIT;

-- Modify the animals table so it includes the species_id values
BEGIN;
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon%';

UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;
COMMIT;

-- Modify the animals table to include the owner_id value
BEGIN;
UPDATE animals
SET owner_id = 1 WHERE name = 'Agumon';

UPDATE animals
SET owner_id = 2 WHERE name = 'Gabumon' or name = 'Pikachu';

UPDATE animals
SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';
COMMIT;

-- Populate the vets table with the veterinarians' data.
INSERT INTO vets(name, age, date_of_graduation)
VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-8');

-- Populated the specializations table
INSERT INTO specializations(vet_id, specie_id)
VALUES
(1, 1),
(3, 1),
(3, 2),
(4, 2);

-- Fill in out the visits table
INSERT INTO visits(animal_id, vet_id, visit_date)
VALUES
(1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(2, 4, '2021-02-02'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),
(3, 2, '2020-05-14'),
(4, 3, '2021-05-04'),
(5, 4, '2021-02-24'),
(6, 2, '2019-12-21'),
(6, 1, '2020-08-10'),
(6, 2, '2021-04-07'),
(7, 3, '2019-09-29'),
(8, 4, '2020-10-03'),
(8, 4, '2020-11-04'),
(9, 2, '2019-01-24'),
(9, 2, '2019-05-15'),
(9, 2, '2020-02-27'),
(9, 2, '2020-08-03'),
(10, 3, '2020-05-24'),
(10, 1, '2021-01-11');

-- Data for performance
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

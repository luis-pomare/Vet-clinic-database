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
('Charmander', '2020-02-08', 11, '0', 0),
('Plantmon', '2021-11-15', 5.7, '1', 2),
('Squirtle', '1993-04-02', 12.13, '0', 3),
('Angemon', '2005-06-12', 45, '1', 1),
('Boarmon', '2005-06-7', 20.4, '1', 7),
('Blossom', '1998-10-13', 17, '1', 3),
('Ditto', '2022-05-14', 22, '1', 4);  

-- Database schema to keep the structure of entire database.

CREATE DATABASE vet_clinic;
CREATE TABLE animals(
    id INT,
    name VARCHAR,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN(1),
    weight_kg DECIMAL
);

-- Fix the ID column to be the identity of the table
ALTER TABLE animals ALTER COLUMN id SET NOT NULL;
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

-- Add id column as primary key
ALTER TABLE animals
ADD PRIMARY KEY(id);

-- Add species column
ALTER TABLE animals
ADD species VARCHAR(150);

-- Add owners table
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(150),
    age INT
);

-- Add species table
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(150)
);

--Modify animals table
ALTER TABLE animals
DROP COLUMN  species;

ALTER TABLE animals
ADD species_id INT;

ALTER TABLE animals 
ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
ADD owner_id INT,
ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

-- Create the veterinarians table
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(150),
    age INT,
    date_of_graduation DATE
);

-- Create specializations
CREATE TABLE specializations(
    specie_id INT,
    vet_id INT
);

-- Create visits
CREATE TABLE visits(
    animal_id INT,
    vet_id INT,
    visit_date DATE
);

-- Add an email column to owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Add id column to visits table to improve performance
ALTER TABLE visits
ADD COLUMN id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;

-- To improve the performance of first query.
CREATE INDEX animal_id_asc ON visits(animal_id ASC);

-- To improve the performance of second query.
CREATE INDEX to_vet_2 ON visits(vet_id) WHERE vet_id = 2;

-- To improve the performance of third query.
CREATE INDEX email_asc ON owners(email ASC);

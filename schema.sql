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

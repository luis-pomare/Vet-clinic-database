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
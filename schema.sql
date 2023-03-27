/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;
CREATE TABLE animals(
    id INT,
    name VARCHAR,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN(1),
    weight_kg DECIMAL
);
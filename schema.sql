/* Database schema to keep the structure of entire database. */

-- Create the "animals" table
CREATE TABLE animals (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL(10,2) NOT NULL
);

-- Add the "species" column to the "animals" table
ALTER TABLE animals
ADD species VARCHAR(255);

-- Create the "owners" table
CREATE TABLE owners (
   id SERIAL PRIMARY KEY,
   full_name VARCHAR(255) NOT NULL,
   age INT NOT NULL
);

-- Create the "species" table
CREATE TABLE species (
   id SERIAL PRIMARY KEY,
   name VARCHAR(255) NOT NULL
);

-- Add a new column 'species_id' of type INT
ALTER TABLE animals
ADD species_id INT;

-- Add a new column 'owner_id' of type INT
ALTER TABLE animals
ADD owner_id INT;

-- Drop the 'species' column
ALTER TABLE animals
DROP COLUMN species;

-- Modify the 'id' column to be a serial (auto-increment) primary key
-- First, create a new sequence for the serial column
CREATE SEQUENCE animals_id_seq;

-- Then, set the 'id' column to use the new sequence
ALTER TABLE animals
ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');

-- Finally, set the 'id' column as the primary key
ALTER TABLE animals
ADD PRIMARY KEY (id);

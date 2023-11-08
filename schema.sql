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

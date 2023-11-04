/*Queries that provide answers to the questions from all projects.*/

-- Select animals with names ending in 'mon'
SELECT * FROM animals WHERE name LIKE '%mon';

-- Select names of animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- Select names of neutered animals with less than 3 escape attempts
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

-- Select the date of birth for animals with names 'Agumon' and 'Pikachu'
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- Select names and escape attempts of animals with weight over 10.5 kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Select all neutered animals
SELECT * FROM animals WHERE neutered = TRUE;

-- Select all animals except 'Gabumon'
SELECT * FROM animals WHERE name NOT IN ('Gabumon');

-- Select animals with weight between 10.4 kg and 17.3 kg
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) 
FROM animals 
WHERE YEAR(date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

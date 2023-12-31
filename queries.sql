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

-- PROJECT 2 --

/* To start a transaction and update the animals specise column and then rollback the changes */
 BEGIN;
 UPDATE animals SET species = 'unspecified';
 SELECT * FROM animals;
 ROLLBACK;
SELECT * FROM animals;

 /* Inside a transaction */
 BEGIN;
 /* 1: Update the animals table by setting the species column to digimon for all animals that have a name ending in mon */
 UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

/* 2: Update the animals table by setting the species column to pokemon for all animals that don't have species already set. */
UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';

/* Verify that changes were made. */
SELECT * FROM animals;

/* Commit the transaction. */
COMMIT;

/* Verify that changes persist after commit. */
SELECT * FROM animals;

/* Inside a transaction delete all records in the animals table, then roll back the transaction. */
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Inside a transaction: */
BEGIN;
/* 1:Delete all animals born after Jan 1st, 2022. */
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;

/* Create a savepoint for the transaction.*/
SAVEPOINT SP1;

/* Update all animals' weight to be their weight multiplied by -1 */
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;

/* Update all animals' weights that are negative to be their weight multiplied by -1. */
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/* Extra Queries */

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


-- What animals belong to Melody Pond?
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are Pokemon (their type is Pokemon).
SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name, COALESCE(a.name, 'No animals owned') AS owned_animals
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT s.name AS species, COUNT(a.id) AS num_animals
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT o.full_name, COUNT(a.id) AS num_animals_owned
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY num_animals_owned DESC
LIMIT 1;


-- Who was the last animal seen by William Tatcher?
SELECT visits.animal
FROM visits
WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY visit_date DESC
LIMIT 1;


-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animal) AS num_animals
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');


-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, COALESCE(specializations.species, 'No Specialization') AS specialization
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT visits.animal
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
    AND visit_date >= '2020-04-01'
    AND visit_date <= '2020-08-30';

--What animal has the most visits to vets?
SELECT visits.animal, COUNT(*) AS num_visits
FROM visits
GROUP BY visits.animal
ORDER BY num_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT visits.animal, visits.visit_date
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY visit_date
LIMIT 1;


-- Details for the most recent visit: animal information, vet information, and date of visit.
SELECT visits.animal, vets.name AS vet_name, visits.visit_date
FROM visits
INNER JOIN vets ON visits.vet_id = vets.id
ORDER BY visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS num_visits_no_specialization
FROM visits
LEFT JOIN specializations ON visits.vet_id = specializations.vet_id
WHERE specializations.species IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species, COUNT(*) AS num_visits
FROM visits
INNER JOIN specializations ON visits.vet_id = specializations.vet_id
WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY species
ORDER BY num_visits DESC
LIMIT 1;


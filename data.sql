/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
  ('Charmander', '2020-02-08', 0, FALSE, -11, 'unknown'),
  ('Plantmon', '2021-11-15', 2, TRUE, -5.7, 'unknown'),
  ('Squirtle', '1993-04-02', 3, FALSE, -12.13, 'unknown'),
  ('Angemon', '2005-06-12', 1, TRUE, -45, 'unknown'),
  ('Boarmon', '2005-06-07', 7, TRUE, 20.4, 'unknown'),
  ('Blossom', '1998-10-13', 3, TRUE, 17, 'unknown'),
  ('Ditto', '2022-05-14', 4, TRUE, 22, 'unknown'),
  ('Agumon', '2020-02-03', 0, TRUE, 10.23, 'unknown'),
  ('Gabumon', '2018-11-15', 2, TRUE, 8, 'unknown'),
  ('Pikachu', '2021-01-07', 1, FALSE, 15.04, 'unknown'),
  ('Devimon', '2017-05-12', 5, TRUE, 11, 'unknown');


-- data for the "owners" table
INSERT INTO owners (full_name, age) VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- data for the "species" table
INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon');

-- Update animals to include species_id value
UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN 2 -- If the name ends in "mon," it will be Digimon (species_id = 2)
    ELSE 1 -- All other animals are Pokemon (species_id = 1)
END;


-- Sam Smith owns Agumon:
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu:
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon:
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

-- Melody Pond owns Charmander, Squirtle, and Blossom:
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Dean Winchester owns Angemon and Boarmon:
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');


-- Insert data into the vets table
INSERT INTO vets (name, age, date_of_graduation) VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

-- Insert data into the specializations table
INSERT INTO specializations (vet_id, species) VALUES
    (1, 'Pokemon'),
    (3, 'Digimon'),
    (3, 'Pokemon'),
    (4, 'Digimon');

-- Insert data into the visits table
INSERT INTO visits (animal, vet_id, visit_date) VALUES
    ('Agumon', 1, '2020-05-24'),
    ('Agumon', 3, '2020-07-22'),
    ('Gabumon', 4, '2021-02-02'),
    ('Pikachu', 2, '2020-01-05'),
    ('Pikachu', 2, '2020-03-08'),
    ('Pikachu', 2, '2020-05-14'),
    ('Devimon', 3, '2021-05-04'),
    ('Charmander', 4, '2021-02-24'),
    ('Plantmon', 1, '2020-08-10'),
    ('Plantmon', 2, '2021-04-07'),
    ('Squirtle', 3, '2019-09-29'),
    ('Angemon', 4, '2020-10-03'),
    ('Angemon', 4, '2020-11-04'),
    ('Boarmon', 2, '2019-01-24'),
    ('Boarmon', 2, '2019-05-15'),
    ('Boarmon', 2, '2020-02-27'),
    ('Boarmon', 2, '2020-08-03'),
    ('Blossom', 3, '2020-05-24'),
    ('Blossom', 1, '2021-01-11');

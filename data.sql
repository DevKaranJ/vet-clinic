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
/*Queries that provide answers to the questions from all projects.*/

 SELECT * FROM animals WHERE name  LIKE '%mon';
 SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
 SELECT * FROM animals WHERE neutered = TRUE AND escape_attempts < 3; 
 SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
 SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
 SELECT * FROM animals WHERE neutered = TRUE;
 SELECT * FROM animals WHERE name <> 'Gabumon';
 SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_above_jan2022;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TOdelete_above_jan2022;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, AVG(escape_attempts) AS average FROM animals GROUP BY neutered ORDER BY average DESC LIMIT 1;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

 SELECT a.name FROM animals AS a JOIN owners AS b ON a.owner_id = b.id WHERE b.full_name = 'Melody Pond';
 SELECT a.name FROM animals AS a JOIN species AS s ON a.species_id = s.id WHERE s.name = 'Pokemon';
 SELECT a.name AS animal_name , o.full_name AS owner_name FROM animals AS a RIGHT JOIN owners As o ON a.owner_id = o.id;
 SELECT COUNT(a.*), s.name FROM animals AS a JOIN species AS s ON a.species_id = s.id GROUP BY s.name;
 SELECT a.name FROM animals AS a JOIN species AS s ON a.species_id = s.id JOIN owners as o ON a.owner_id = o.id WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';
 SELECT a.name FROM animals AS a JOIN owners AS o ON a.owner_id = o.id WHERE a.escape_attempts = 0 AND o.full_name = 'Dean Winchester';
 SELECT COUNT(a.owner_id) AS count, o.full_name FROM animals AS a JOIN owners AS o ON a.owner_id = o.id GROUP BY o.full_name  ORDER BY count DESC LIMIT 1;


SELECT a.name, v.date_of_visit FROM animals a 
  JOIN visits v ON a.id = v.animals_id 
  JOIN vets vt ON v.vet_id = vt.id 
  WHERE vt.name = 'William Tatcher' 
  ORDER BY v.date_of_visit 
  DESC LIMIT 1;
   
SELECT COUNT(DISTINCT a.name) FROM visits as visit 
  JOIN animals AS a ON a.id = visit.animals_id 
  JOIN vets AS v ON v.id = visit.vet_id 
  WHERE v.name = 'Stephanie Mendez';

SELECT v.name AS vet_name, s.name AS species FROM specialization AS sp 
  JOIN species AS s ON s.id = sp.species_id 
  RIGHT JOIN vets AS v ON v.id = sp.vet_id;

SELECT a.name AS animal_visited FROM visits AS visit 
  JOIN animals AS a ON a.id = visit.animals_id 
  JOIN vets AS v ON v.id = visit.vet_id 
  WHERE v.name = 'Stephanie Mendez' 
  AND visit.date_of_visit 
  BETWEEN '2020-04-1' 
  AND '2020-08-30'; 

SELECT a.name, COUNT(visit.*) FROM visits AS visit 
  JOIN animals AS a ON visit.animals_id = a.id 
  GROUP BY a.name 
  ORDER BY COUNT(visit.*) 
  DESC LIMIT 1;

SELECT a.name FROM visits AS visit 
  JOIN animals AS a ON a.id = visit.animals_id 
  JOIN vets AS v ON v.id = visit.vet_id 
  WHERE v.name = 'Maisy Smith' 
  ORDER BY visit.date_of_visit
  ASC LIMIT 1;

SELECT 
  a.name AS animal_name, 
  a.weight_kg AS animal_weight, 
  a.neutered AS is_neutered, 
  sp.name AS speicy, 
  a.escape_attempts, 
  v.name AS vet_name, 
  v.age AS vet_age, 
  v.date_of_graduation AS vet_graduation,
  visit.date_of_visit FROM visits AS visit 
  JOIN animals AS a ON a.id = visit.animals_id 
  JOIN vets AS v ON v.id = visit.vet_id 
  JOIN species AS sp ON a.species_id = sp.id  
  ORDER BY visit.date_of_visit 
  DESC LIMIT 1;

SELECT COUNT(*) FROM visits v 
  JOIN animals a ON v.animals_id = a.id 
  JOIN vets vt ON v.vet_id = vt.id 
  LEFT JOIN specialization sp ON vt.id = sp.vet_id 
  AND a.species_id = sp.species_id 
  WHERE sp.vet_id IS NULL;

SELECT sp.name AS specialization, COUNT(sp.name) FROM animals AS a 
  JOIN species AS sp ON a.species_id = sp.id 
  JOIN visits AS visit ON a.id = visit.animals_id 
  JOIN vets AS v ON v.id = visit.vet_id 
  WHERE v.name = 'Maisy Smith' 
  GROUP BY sp.name 
  ORDER BY COUNT(sp.name) 
  DESC LIMIT 1; 

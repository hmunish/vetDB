/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-12';
SELECT * FROM animals WHERE neutered = 'true' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/*Setting species to unspecified & rolling back*/

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

/*Setting species of animals*/
BEGIN:
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species = '';
COMMIT;

/*Deleting all rows & rolling back the transaction*/
BEGIN;
DELETE FROM animals;
ROLLBACK;

/*Creating savepoint & updating*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/*Aggregate functions*/
SELECT count(*) FROM animals;
SELECT count(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered,SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, min(weight_kg), max(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/*JOIN SELECT queries*/
SELECT name as animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name= 'Melody Pond';
SELECT animals.name AS animal_name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name AS owner_name, animals.name AS animal_name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id ORDER BY owners.full_name;
SELECT species.name AS species , COUNT(animals.id) AS total_animals FROM species LEFT JOIN animals ON species.id = animals.species_id GROUP BY species.name;
SELECT animals.name AS animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell';   
SELECT animals.name AS animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT owners.full_name AS name , COUNT(animals.id) AS total_animals FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY total_animals DESC LIMIT 1;



SELECT animals.name, visits.visit_date
  FROM visits
  LEFT JOIN animals ON animals.id = visits.animal_id
  LEFT JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'William Tatcher'
  ORDER BY visits.visit_date DESC
  LIMIT 1;

SELECT DISTINCT animals.name
  FROM visits
  LEFT JOIN animals ON animals.id = visits.animal_id
  LEFT JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez';

SELECT vets.*, species.name
  FROM vets
  LEFT JOIN specializations ON vets.id = specializations.vet_id
  LEFT JOIN species ON specializations.species_id = species.id;

 SELECT animals.name, visits.visit_date
  FROM visits
  LEFT JOIN animals ON animals.id = visits.animal_id
  LEFT JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez'
  AND visit_date > '2020-04-01' AND visit_date < '2020-08-30';

SELECT a.name FROM animals a JOIN visits v ON a.id = v.animal_id GROUP BY a.name ORDER BY COUNT(a.id) DESC LIMIT 1;

SELECT animals.name, visits.visit_date
  FROM visits
  LEFT JOIN animals ON animals.id = visits.animal_id
  LEFT JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visits.visit_date ASC
  LIMIT 1;

  SELECT animals.*, vets.*, visits.visit_date
  FROM visits
  LEFT JOIN animals ON animals.id = visits.animal_id
  LEFT JOIN vets ON vets.id = visits.vet_id
  ORDER BY visits.visit_date DESC
  LIMIT 1;

SELECT count(*)
  FROM visits
  LEFT JOIN animals ON animals.id = visits.animal_id
  LEFT JOIN vets ON vets.id = visits.vet_id
  WHERE animals.species_id NOT IN (SELECT species_id FROM specializations WHERE vet_id = vets.id);

SELECT animals.*, vets.*, visits.visit_date
  FROM visits
  LEFT JOIN animals ON animals.id = visits.animal_id
  LEFT JOIN vets ON vets.id = visits.vet_id
  ORDER BY visits.visit_date DESC
  LIMIT 1;

  /* Performance Analyze */ 
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
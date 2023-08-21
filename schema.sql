/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;
CREATE TABLE animals( 
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INT, 
    neutered boolean,
    weight_kg DECIMAL,
 );

ALTER TABLE animals ADD species VARCHAR(250);

CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY, full_name VARCHAR(250), age INT, PRIMARY KEY (id));
CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(250), PRIMARY KEY (id));


ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD PRIMARY KEY (id);
ALTER TABLE animals ADD species_id INT REFERENCES species(id);
ALTER TABLE animals ADD owner_id INT REFERENCES owners(id);

CREATE TABLE vets(id INT GENERATED ALWAYS AS IDENTITY,
 name VARCHAR(250),
 age INT, date_of_graduation DATE,
 PRIMARY KEY (id));

CREATE TABLE specialization(id INT GENERATED ALWAYS AS IDENTITY,
 vet_id INT REFERENCES vets(id),
 species_id INT REFERENCES species(id),
 PRIMARY KEY (id));

 CREATE TABLE visits(id INT GENERATED ALWAYS AS IDENTITY,
 vet_id INT REFERENCES vets(id),
 animals_id INT REFERENCES animals(id),
 date_of_visit DATE,
 PRIMARY KEY (id));

ALTER TABLE visits RENAME COLUMN animals_id TO animal_id;
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX idx_animal_id ON visits(animal_id);
CREATE INDEX idx_email ON owners(email);
CREATE INDEX idx_vet_id ON visits (vet_id);
CLUSTER visits USING idx_vet_id;


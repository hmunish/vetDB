/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts integer NOT NULL,
    neutered boolean NOT NULL,
    weight_kg double precision NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 5 );
ALTER TABLE IF EXISTS animals ADD COLUMN species character varying(256);

/*Create owners table*/

CREATE TABLE owners (
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    full_name character varying(256) NOT NULL,
    age integer NOT NULL,
    PRIMARY KEY (id)
);

/*Create species table*/

CREATE TABLE species (
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name character varying NOT NULL,
    PRIMARY KEY (id)
);

/*DELETE species column from animals table*/
ALTER TABLE animals DROP COLUMN species;

/*Add species_id & owner_id columns*/
ALTER TABLE animals ADD COLUMN owner_id INTEGER;
ALTER TABLE animals ADD COLUMN species_id INTEGER;

/*Add Foreign key*/
ALTER TABLE IF EXISTS animals
    ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id)
    REFERENCES owners (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS animals
    ADD CONSTRAINT fk_species FOREIGN KEY (species_id)
    REFERENCES species (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


/*Add vets table*/
CREATE TABLE vets
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    name character varying(255),
    age integer,
    date_of_graduation date,
    PRIMARY KEY (id)
);

/*Add specializations table*/
CREATE TABLE specializations ( species_id int, vet_id int);

/*Add visits table*/
CREATE TABLE visits (animal_id int, vet_id int, visit_date date);

/*Add email column to owners table*/
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

/*Drop Not Null constraints on owners table full_name & age column*/
ALTER TABLE owners ALTER COLUMN full_name DROP NOT NULL;
ALTER TABLE owners ALTER COLUMN age DROP NOT NULL;

/*Create index to improve performances*/
CREATE INDEX visits_animal_id_inx ON visits(animal_id);
CREATE INDEX visits_vet_id_inx ON visits(vet_id);
CREATE INDEX owners_email_inx ON owners(email);

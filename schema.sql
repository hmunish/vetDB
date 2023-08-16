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

/*Add Foreign key*/
ALTER TABLE IF EXISTS animals
    ADD CONSTRAINT species_id FOREIGN KEY (id)
    REFERENCES species (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

ALTER TABLE IF EXISTS animals
    ADD CONSTRAINT customer_id FOREIGN KEY (id)
    REFERENCES owners (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

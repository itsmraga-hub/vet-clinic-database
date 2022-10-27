CREATE TABLE "animals"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL,
    "escape_attempts" INTEGER NOT NULL,
    "neutered" BOOLEAN NOT NULL,
    "weight_kg" DECIMAL(8, 2) NOT NULL,
    "species_id" INTEGER NOT NULL,
    "owners_id" INTEGER NOT NULL
);
CREATE INDEX "animals_id_index" ON
    "animals"("id");
ALTER TABLE
    "animals" ADD PRIMARY KEY("id");
CREATE TABLE "species"(
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL
);
CREATE INDEX "species_id_index" ON
    "species"("id");
ALTER TABLE
    "species" ADD PRIMARY KEY("id");
CREATE TABLE "owners"(
    "id" INTEGER NOT NULL,
    "full_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "email" VARCHAR(255) NOT NULL
);
CREATE INDEX "owners_id_index" ON
    "owners"("id");
ALTER TABLE
    "owners" ADD PRIMARY KEY("id");
CREATE TABLE "vets"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,
    "date_of_graduation" DATE NOT NULL
);
CREATE INDEX "vets_id_index" ON
    "vets"("id");
ALTER TABLE
    "vets" ADD PRIMARY KEY("id");
CREATE TABLE "visits"(
    "animals_id" INTEGER NOT NULL,
    "vets_id" INTEGER NOT NULL,
    "date_of_visit" DATE NOT NULL
);
CREATE TABLE "specializations"(
    "species_id" INTEGER NOT NULL,
    "vets_id" INTEGER NOT NULL
);
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_owners_id_foreign" FOREIGN KEY("owners_id") REFERENCES "owners"("id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_animals_id_foreign" FOREIGN KEY("animals_id") REFERENCES "animals"("id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_vets_id_foreign" FOREIGN KEY("vets_id") REFERENCES "vets"("id");
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_vets_id_foreign" FOREIGN KEY("vets_id") REFERENCES "vets"("id");
CREATE DATABASE IF NOT EXISTS basket CHARSET utf8mb4;
USE basket;

-- Création des tables
CREATE TABLE IF NOT EXISTS poste(
id_poste INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_poste VARCHAR(50) UNIQUE NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS `phase`(
id_phase INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_phase VARCHAR(50) UNIQUE NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS adresse(
id_adresse INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_rue VARCHAR(50) NOT NULL,
num_rue INT NOT NULL,
code_postal INT NOT NULL,
ville VARCHAR(50) NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS club(
id_club INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_club VARCHAR(50) UNIQUE NOT NULL,
id_adresse INT NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS lieu(
id_lieu INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_lieu VARCHAR(50) NOT NULL,
id_adresse INT NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS equipe(
id_equipe INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_equipe VARCHAR(50) NOT NULL UNIQUE,
id_club INT NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS joueur(
id_joueur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_joueur VARCHAR(50) NOT NULL,
prenom_joueur VARCHAR(50) NOT NULL,
id_poste INT,
id_equipe INT
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS competition(
id_competition INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_competition VARCHAR(50) NOT NULL UNIQUE,
date_debut DATETIME NOT NULL,
date_fin DATETIME NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS partie(
id_partie INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
score_equipe_1 INT NOT NULL,
score_equipe_2 INT NOT NULL,
id_equipe_1 INT NOT NULL,
id_equipe_2 INT NOT NULL,
id_competition INT NOT NULL,
id_phase INT NOT NULL
)Engine=InnoDB;

-- Création de la table d'association
CREATE TABLE IF NOT EXISTS competition_lieu(
id_competition INT,
id_lieu INT,
PRIMARY KEY(id_competition, id_lieu)
)Engine=InnoDB;

-- Ajout des contraintes foreign key
ALTER TABLE joueur
ADD CONSTRAINT fk_occuper_poste
FOREIGN KEY(id_poste)
REFERENCES poste(id_poste);

ALTER TABLE joueur
ADD CONSTRAINT fk_appartenir_equipe
FOREIGN KEY(id_equipe)
REFERENCES equipe(id_equipe);

ALTER TABLE equipe
ADD CONSTRAINT fk_posseder_club
FOREIGN KEY(id_club)
REFERENCES club(id_club)
ON DELETE CASCADE;

ALTER TABLE club
ADD CONSTRAINT fk_situer_adresse
FOREIGN KEY(id_adresse)
REFERENCES adresse(id_adresse)
ON DELETE CASCADE;

ALTER TABLE lieu
ADD CONSTRAINT fk_completer_lieu
FOREIGN KEY(id_adresse)
REFERENCES adresse(id_adresse)
ON DELETE CASCADE;

ALTER TABLE partie
ADD CONSTRAINT fk_concourir_equipe
FOREIGN KEY(id_equipe_1)
REFERENCES equipe(id_equipe)
ON DELETE CASCADE;

ALTER TABLE partie
ADD CONSTRAINT fk_participer_equipe
FOREIGN KEY(id_equipe_2)
REFERENCES equipe(id_equipe)
ON DELETE CASCADE;

ALTER TABLE partie
ADD CONSTRAINT fk_derouler_competition
FOREIGN KEY(id_competition)
REFERENCES competition(id_competition)
ON DELETE CASCADE;

ALTER TABLE partie
ADD CONSTRAINT fk_detailler_phase
FOREIGN KEY(id_phase)
REFERENCES `phase`(id_phase)
ON DELETE CASCADE;

ALTER TABLE competition_lieu
ADD CONSTRAINT fk_localiser_lieu
FOREIGN KEY(id_lieu)
REFERENCES lieu(id_lieu)
ON DELETE CASCADE;

ALTER TABLE competition_lieu
ADD CONSTRAINT fk_localiser_competition
FOREIGN KEY(id_competition)
REFERENCES competition(id_competition)
ON DELETE CASCADE;


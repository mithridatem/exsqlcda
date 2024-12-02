-- Création de la base de données livre
CREATE DATABASE IF NOT EXISTS livres CHARSET utf8mb4;
USE livres;

-- Création des tables
CREATE TABLE IF NOT EXISTS `role`(
id_role INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_role VARCHAR(50) UNIQUE NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS genre(
id_genre INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_genre VARCHAR(50) UNIQUE NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS livre(
id_livre INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
titre VARCHAR(50) NOT NULL,
`description` VARCHAR(255) NOT NULL,
nbr_page INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS utilisateur(
id_utilisateur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_utilisateur VARCHAR(50) NOT NULL,
prénom VARCHAR(50) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
mdp VARCHAR(100) NOT NULL,
id_role INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS reservation(
id_reservation INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
date_debut DATETIME NOT NULL,
date_fin DATETIME NOT NULL,
id_utilisateur INT NOT NULL,
id_livre INT NOT NULL
)ENGINE=InnoDB;

-- Création table d'association
CREATE TABLE IF NOT EXISTS livre_genre(
id_livre INT,
id_genre INT, 
PRIMARY KEY(id_livre, id_genre)
)ENGINE=InnoDB;

-- Ajout des contraintes foreign key
ALTER TABLE utilisateur
ADD CONSTRAINT fk_posseder_role
FOREIGN KEY(id_role)
REFERENCES `role`(id_role)
ON DELETE CASCADE;

ALTER TABLE reservation
ADD CONSTRAINT fk_inclure_livre
FOREIGN KEY(id_livre)
REFERENCES livre(id_livre)
ON DELETE CASCADE;

ALTER TABLE reservation
ADD CONSTRAINT fk_reserver_utilisateur
FOREIGN KEY(id_utilisateur)
REFERENCES utilisateur(id_utilisateur)
ON DELETE CASCADE;

ALTER TABLE livre_genre
ADD CONSTRAINT fk_detailler_genre
FOREIGN KEY(id_genre)
REFERENCES genre(id_genre);

ALTER TABLE livre_genre
ADD CONSTRAINT fk_detailler_livre
FOREIGN KEY(id_livre)
REFERENCES livre(id_livre);

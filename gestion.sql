-- Création de la base de données
CREATE DATABASE IF NOT EXISTS gestion CHARSET utf8mb4;
USE gestion;

-- Création des tables
CREATE TABLE IF NOT EXISTS `role`(
id_role INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_role VARCHAR(50) UNIQUE NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS adresse(
id_adresse INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_rue VARCHAR(50) NOT NULL,
num_rue INT NOT NULL,
code_postal INT UNIQUE NOT NULL,
ville VARCHAR(50) NOT NULL,
pays VARCHAR(50) UNIQUE NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS utilisateur(
id_utilisateur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
mdp VARCHAR(100) NOT NULL,
id_role INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `client`(
id_client INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_client VARCHAR(50) NOT NULL,
prenom_client VARCHAR(50) NOT NULL,
telephone_client INT NOT NULL,
id_adresse INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fournisseur(
id_fournisseur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_fournisseur VARCHAR(50) UNIQUE NOT NULL,
telephone_fournisseur INT NOT NULL,
id_adresse INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS matiere_premiere(
id_matiere_premiere INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_matiere_premiere VARCHAR(50) NOT NULL,
quantite_matiere INT NOT NULL,
prix_achat DECIMAL(5,2)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS produit(
id_produit INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_produit VARCHAR(50) NOT NULL,
prix_vente DECIMAL(5,2) NOT NULL,
quantite_produit INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS commercial(
id_commercial INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_commercial VARCHAR(50) NOT NULL,
prenom_commercial VARCHAR(50) NOT NULL
)ENGINE=InnoDB;

-- Création des tables association
CREATE TABLE IF NOT EXISTS fournir(
id_matiere_premiere INT,
id_fournisseur INT,
PRIMARY KEY(id_matiere_premiere, id_fournisseur)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS concevoir(
id_matiere_premiere INT,
id_produit INT,
PRIMARY KEY(id_matiere_premiere, id_produit)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS promovoir(
id_produit INT,
id_commercial INT,
PRIMARY KEY(id_produit,id_commercial)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS acheter(
id_produit INT,
id_client INT,
quantite_achat INT NOT NULL,
PRIMARY KEY(id_produit, id_client)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fideliser(
id_client INT,
id_commercial INT,
chiffre_affaire DECIMAL(10,2)NOT NULL,
PRIMARY KEY(id_client, id_commercial)
)ENGINE=InnoDB;

-- Ajout des contraintes Foreign Key

ALTER TABLE utilisateur
ADD CONSTRAINT fk_assigner_role
FOREIGN KEY(id_role)
REFERENCES `role`(id_role)
ON DELETE CASCADE;

ALTER TABLE `client`
ADD CONSTRAINT fk_localiser_adresse
FOREIGN KEY(id_adresse)
REFERENCES adresse(id_adresse)
ON DELETE CASCADE;

ALTER TABLE fournisseur
ADD CONSTRAINT fk_situer_adresse
FOREIGN KEY(id_adresse)
REFERENCES adresse(id_adresse)
ON DELETE CASCADE;

ALTER TABLE fournir
ADD CONSTRAINT fk_fournir_fournisseur
FOREIGN KEY(id_fournisseur)
REFERENCES fournisseur(id_fournisseur);

ALTER TABLE fournir
ADD CONSTRAINT fk_fournir_matiere_premiere
FOREIGN KEY(id_matiere_premiere)
REFERENCES matiere_premiere(id_matiere_premiere);

ALTER TABLE concevoir
ADD CONSTRAINT fk_concevoir_matiere_premiere
FOREIGN KEY(id_matiere_premiere)
REFERENCES matiere_premiere(id_matiere_premiere);

ALTER TABLE concevoir
ADD CONSTRAINT fk_concevoir_produit
FOREIGN KEY(id_produit)
REFERENCES produit(id_produit);

ALTER TABLE promovoir
ADD CONSTRAINT fk_promovoir_produit
FOREIGN KEY(id_produit)
REFERENCES produit(id_produit);

ALTER TABLE promovoir
ADD CONSTRAINT fk_promovoir_commercial
FOREIGN KEY(id_commercial)
REFERENCES commercial(id_commercial);

ALTER TABLE fideliser
ADD CONSTRAINT fk_fideliser_commercial
FOREIGN KEY(id_commercial)
REFERENCES commercial(id_commercial);

ALTER TABLE fideliser
ADD CONSTRAINT fk_fideliser_client
FOREIGN KEY(id_client)
REFERENCES `client`(id_client);

ALTER TABLE acheter
ADD CONSTRAINT fk_acheter_client
FOREIGN KEY(id_client)
REFERENCES `client`(id_client);

ALTER TABLE acheter
ADD CONSTRAINT fk_acheter_produit
FOREIGN KEY(id_produit)
REFERENCES produit(id_produit);
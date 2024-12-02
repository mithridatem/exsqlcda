-- Création de la base
CREATE DATABASE IF NOT EXISTS blog CHARSET utf8mb4;
USE blog;

-- Création des tables
CREATE TABLE IF NOT EXISTS category(
id_category INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
category_name VARCHAR(50) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS media(
id_media INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
media_url VARCHAR(255) NOT NULL,
media_slug VARCHAR(50) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS roles(
id_roles INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
roles_name VARCHAR(50) UNIQUE NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS article(
id_article INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
article_title VARCHAR(50) NOT NULL,
article_content TEXT NOT NULL,
article_creation_date DATE NOT NULL,
article_update_date DATE,
article_slug VARCHAR(50) NOT NULL,
article_validation TINYINT(1) DEFAULT 0,
article_author_fk INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `account`(
id_account INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
account_firstname VARCHAR(50) NOT NULL,
account_lastname VARCHAR(50) NOT NULL,
account_email VARCHAR(50) UNIQUE NOT NULL,
account_password VARCHAR(100) NOT NULL,
account_nicktname VARCHAR(50) UNIQUE NOT NULL,
account_avatar VARCHAR(255),
account_activation TINYINT(1) DEFAULT 0 NOT NULL,
account_desactivation_date DATE,
roles_id_fk INT NOT NULL 
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS note(
id_note INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
note_value INT UNIQUE,
note_reaction TINYINT(1),
article_id_fk INT NOT NULL,
account_id_fk INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS commentary(
id_commentary INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
commentary_content VARCHAR(255) NOT NULL,
commentary_creaton_date DATETIME NOT NULL,
commentary_validation TINYINT(1) DEFAULT 0 NOT NULL,
commentary_author_fk INT NOT NULL,
article_id_fk INT NOT NULL
)ENGINE=InnoDB;

-- Créations des tables d'association
CREATE TABLE IF NOT EXISTS article_category(
article_id INT NOT NULL,
category_id INT NOT NULL,
PRIMARY KEY(article_id, category_id)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS article_media(
article_id INT NOT NULL,
media_id INT NOT NULL,
PRIMARY KEY(article_id, media_id)
)ENGINE=InnoDB;

-- Ajout des contraintes Foreign Key
ALTER TABLE `account`
ADD CONSTRAINT fk_to_have_roles
FOREIGN KEY(roles_id_fk)
REFERENCES roles(id_roles)
ON DELETE CASCADE;

ALTER TABLE article
ADD CONSTRAINT fk_to_write_account
FOREIGN KEY(article_author_fk)
REFERENCES `account`(id_account)
ON DELETE CASCADE; 

ALTER TABLE commentary
ADD CONSTRAINT fk_to_comment_account
FOREIGN KEY(commentary_author_fk)
REFERENCES `account`(id_account)
ON DELETE CASCADE; 

ALTER TABLE commentary
ADD CONSTRAINT fk_to_add_article
FOREIGN KEY(article_id_fk)
REFERENCES article(id_article)
ON DELETE CASCADE; 

ALTER TABLE note
ADD CONSTRAINT fk_to_score_account
FOREIGN KEY(account_id_fk)
REFERENCES `account`(id_account)
ON DELETE CASCADE; 

ALTER TABLE note
ADD CONSTRAINT fk_to_rate_article
FOREIGN KEY(article_id_fk)
REFERENCES article(id_article)
ON DELETE CASCADE; 

-- Ajout des Foreign Key tables association
ALTER TABLE article_media
ADD CONSTRAINT fk_article_media_article
FOREIGN KEY(article_id)
REFERENCES article(id_article);

ALTER TABLE article_media
ADD CONSTRAINT fk_article_media_media
FOREIGN KEY(media_id)
REFERENCES media(id_media);

ALTER TABLE article_category
ADD CONSTRAINT fk_article_category_article
FOREIGN KEY(article_id)
REFERENCES article(id_article)
ON DELETE CASCADE;

ALTER TABLE article_category
ADD CONSTRAINT fk_article_category_category
FOREIGN KEY(category_id)
REFERENCES category(id_category)
ON DELETE CASCADE;

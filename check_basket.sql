USE basket;
-- la valeur du score_equipe_1 dans la table partie ne peut pas être inférieur ou égal à 0,
ALTER TABLE partie
ADD CONSTRAINT ck_score_min_equipe_1
CHECK(score_equipe_1 >= 0);
-- la valeur du score_equipe_2 dans la table partie ne peut pas être inférieur ou égal à 0,
ALTER TABLE partie
ADD CONSTRAINT ck_score_min_equipe_2
CHECK(score_equipe_2 >= 0);
-- la valeur du nom_equipe dans la table equipe ne peut pas avoir moins de 4 lettres,
ALTER TABLE equipe
ADD CONSTRAINT ck_taille_min_nom_equipe
CHECK(CHAR_LENGTH(nom_equipe) > 4);
-- la valeur du code_postal dans la table adresse doit toujours avoir 5 chiffres.
ALTER TABLE adresse
ADD CONSTRAINT ck_taille_min_nom_equipe
CHECK(CHAR_LENGTH(code_postal) = 5);


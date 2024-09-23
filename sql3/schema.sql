-- compléter l'entête 
-- ==================

-- NOM    :
-- Prénom :

-- NOM    :
-- Prénom :

-- Groupe :
-- binome :

-- ================================================

-- nettoyer le compte
-- ------------------
drop type T_un_type force;


-- Définition des types de données
-- -------------------------------

create type T_un_type as object (
 un_attribut Number
)
;
/
--drop type Matiere force;
--/
create type Matiere as object(
nom varchar2(30)
);
/
--drop type Piece force;
--/
create type Piece as object(
nom varchar2(30)
compose_par ref Matiere);
/

show errors







-- liste de tous les types créés
@liste


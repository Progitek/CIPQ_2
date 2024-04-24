$PBExportHeader$n_cst_eleveur.sru
forward
global type n_cst_eleveur from n_base
end type
end forward

global type n_cst_eleveur from n_base autoinstantiate
end type

forward prototypes
public function boolean of_formationgedis (long al_noeleveur)
end prototypes

public function boolean of_formationgedis (long al_noeleveur);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_formationgedis
//
//	Accès:  			Public
//
//	Argument:		no d'éleveur
//
//	Retourne:  		TRUE - il est formation gédis
//
// Description:	Fonction pour trouver si l'éleveur est gédis
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-11-22	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long ll_gedis = 0

SELECT 	FormationGedis INTO :ll_gedis
FROM 		t_eleveur
WHERE		no_eleveur = :al_noeleveur
USING 	SQLCA;

IF ll_gedis = 1 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

on n_cst_eleveur.create
call super::create
end on

on n_cst_eleveur.destroy
call super::destroy
end on


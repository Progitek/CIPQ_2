$PBExportHeader$pro_n_cst_entrepotglobal.sru
$PBExportComments$Extension Application Manager service
forward
global type pro_n_cst_entrepotglobal from n_base
end type
end forward

global type pro_n_cst_entrepotglobal from n_base
end type
global pro_n_cst_entrepotglobal pro_n_cst_entrepotglobal

type variables
n_cst_entrepot inv_Entrepot
end variables

forward prototypes
public function integer of_ajoutedonnee (string as_identifiant, any aa_object)
public function any of_retournedonnee (string as_identifiant)
public function any of_retournedonnee (string as_identifiant, boolean ab_reset)
end prototypes

public function integer of_ajoutedonnee (string as_identifiant, any aa_object);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_AjouteDonnee
//
//	Accès:  			Public
//
//	Arguments:		as_identifiant - repère
//						aa_object		- ce que l'on entrepose
//
//	Retourne:  		integer
//
//	Description:	Pour entreposer des valeurs globalement
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

any la_object

la_object = aa_object

if IsValid(inv_Entrepot) then
	return inv_Entrepot.of_Entrepose(lower(as_identifiant),la_object)
end if	
end function

public function any of_retournedonnee (string as_identifiant);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_RetourneDonnee
//
//	Accès:  			Public
//
//	Argument:		identifiant (repère)
//
//	Retourne:  		any
//
//	Description:	Pour retourner une valeur entreposée globalement
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

return THIS.of_retournedonnee(as_identifiant, TRUE)
end function

public function any of_retournedonnee (string as_identifiant, boolean ab_reset);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_RetourneDonnee
//
//	Accès:  			Public
//
//	Arguments:		identifiant (repère)
//						Reset de la variable?
//
//	Retourne:  		any
//
//	Description:	Pour retourner une valeur entreposée globalement
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

return inv_Entrepot.of_Demande(lower(as_identifiant), ab_reset)
end function

on pro_n_cst_entrepotglobal.create
call super::create
end on

on pro_n_cst_entrepotglobal.destroy
call super::destroy
end on


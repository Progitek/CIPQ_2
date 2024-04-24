$PBExportHeader$pro_n_cst_entrepot.sru
$PBExportComments$Service d'entrepôt non global
forward
global type pro_n_cst_entrepot from nonvisualobject
end type
end forward

global type pro_n_cst_entrepot from nonvisualobject autoinstantiate
end type

type variables
any 		ia_Entrepot[]
string 	is_Identifiant[]

long 		il_Compteur
end variables

forward prototypes
public function any of_demande (string as_identifiant)
public function integer of_entrepose (string as_identifiant, any aa_objet)
private function long of_retourneposition (string as_identifiant)
public function any of_demande (string as_identifiant, boolean ab_reset)
end prototypes

public function any of_demande (string as_identifiant);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_Demande
//
//	Accès:  			Public
//
//	Argument:		as_identifiant - identifiant de l'item recherché
//
//	Retourne:  		valeur any						
//
//	Description:	Cette fonction permet de retourner une valeur (any) sauvegardée
//						auparavent contenue dans l'entrepôt (valeur toujours disponible)
//						selon l'identifiant
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

RETURN THIS.of_demande( as_identifiant, TRUE)
end function

public function integer of_entrepose (string as_identifiant, any aa_objet);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_Entrepose
//
//	Accès:  			Public
//
//	Arguments:		as_identifiant - identifiant de l'élément à stocker
//						aa_objet			- élément à stocker
//
//	Retourne:  		1 si la fonction a bien fonctionné
//
//	Description:	Cette fonction permet d'entreposer une valeur (any) dans l'entrepôt 
//						(valeur toujours disponible) avec un identifiant
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

long		ll_Position

ll_Position = THIS.of_RetournePosition(as_Identifiant)

IF ll_Position > 0 THEN
	is_Identifiant[ll_Position] = as_Identifiant
	ia_Entrepot[ll_Position] = aa_Objet
ELSE
	il_Compteur++
	is_Identifiant[il_Compteur] = as_Identifiant
	ia_Entrepot[il_Compteur] = aa_Objet
END IF

RETURN 1
end function

private function long of_retourneposition (string as_identifiant);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_RetournePosition
//
//	Accès:  			Private
//
//	Argument:		as_identifiant - identifiant de l'élément à rechercher
//
//	Retourne:  		La position si l'élément a été trouvé, sinon retourne 0
//
//	Description:	Permet de trouver la position d'un identifiant dans l'entrepôt
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

long		ll_Position

FOR ll_Position = 1 TO il_Compteur
	IF is_identifiant[ll_position] = as_identifiant THEN
		RETURN ll_Position
	END IF
NEXT

RETURN 0
end function

public function any of_demande (string as_identifiant, boolean ab_reset);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_Demande
//
//	Accès:  			Public
//
//	Argument:		as_identifiant - identifiant de l'item recherché
//						ab_reset			- Vidé la variable après?
//
//	Retourne:  		valeur any						
//
//	Description:	Cette fonction permet de retourner une valeur (any) sauvegardée
//						auparavent contenue dans l'entrepôt (valeur toujours disponible)
//						selon l'identifiant
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-01-07	Mathieu Gendron	Reset du contenu de la variable
//
//////////////////////////////////////////////////////////////////////////////

long		ll_Position
string 	ls_Null
any		la_local, la_null
SetNull(ls_Null)

ll_Position = of_RetournePosition(as_Identifiant)
IF ll_Position > 0 THEN
	la_local = ia_entrepot[ll_Position]
	IF ab_reset THEN
		la_null = la_local
		SetNull(la_null)
		ia_entrepot[ll_Position] = la_null
	END IF
	
	RETURN la_local
ELSE
	RETURN ls_Null
END IF
end function

on pro_n_cst_entrepot.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_entrepot.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


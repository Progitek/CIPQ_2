$PBExportHeader$n_cst_rapport_simple.sru
forward
global type n_cst_rapport_simple from n_base
end type
end forward

global type n_cst_rapport_simple from n_base autoinstantiate
end type

type variables
n_cst_param_rapport_simple inv_param
end variables

forward prototypes
public function integer of_creer_rapport_simple (string as_dw_source, string as_nom_rapport, integer al_preview)
public function integer of_creer_rapport_simple_dynamique (string as_dw_source, string as_nom_rapport, long al_preview)
end prototypes

public function integer of_creer_rapport_simple (string as_dw_source, string as_nom_rapport, integer al_preview);n_ds lds_datawindow
String ls_dwsyn, ls_errors,ls_editmask, ls_format, ls_text, ls_chk
string ls_table
string ls_sql
long ll_acc, ll_acc2
string ls_colonne[]
dec ldec_taille[]
string ls_dddw
long ll_x, ll_width
long ll_rtn 

// ouvrir la fenetre de sélection des champs.
w_selectionner_champs_rapport_simple lw_window
inv_param.is_dw_source = as_dw_source
inv_param.is_titre = as_nom_rapport
OpenWithParm(lw_window,inv_param)

// Initialisation des colonnes de la fenetre
inv_param = Message.powerObjectParm
IF isValid(inv_param) THEN
	
	w_rapport_simple lw_rapport_simple

	OpenSheetWithParm(lw_rapport_simple,inv_param, gnv_app.of_GetFrame(),6,Layered!)

	RETURN 1
	
END IF 
RETURN 1

end function

public function integer of_creer_rapport_simple_dynamique (string as_dw_source, string as_nom_rapport, long al_preview);n_ds lds_datawindow
String ls_dwsyn, ls_errors,ls_editmask, ls_format, ls_text, ls_chk
string ls_table
string ls_sql
long ll_acc, ll_acc2
string ls_colonne[]
dec ldec_taille[]
string ls_dddw
long ll_x, ll_width
long ll_rtn 

// ouvrir la fenetre de sélection des champs.
w_selectionner_champs_rapport_simple lw_window
inv_param.is_dw_source = as_dw_source
inv_param.is_titre = as_nom_rapport
OpenWithParm(lw_window,inv_param)

// Initialisation des colonnes de la fenetre
inv_param = Message.powerObjectParm
IF isValid(inv_param) THEN

	ldec_taille = inv_param.idec_taille
	ls_colonne = inv_param.is_colonne
	
	// S'assurer que la fonction a retournée des colonnes.
	IF Upperbound(ls_colonne) > 0 THEN
		
		// Ouverture de la datawindow pour aller chercher les informations
		lds_datawindow = CREATE n_ds
		lds_datawindow.dataobject = as_dw_source
		lds_datawindow.settransobject(SQLCA)
		


//ICI

		IF al_preview = 0 THEN
			w_rapport_simple lw_rapport
			OpenSheet(lw_rapport,gnv_app.of_GetFrame(),6,Layered!)

			lw_rapport.title = inv_param.is_titre
		END IF 
		
		IF IsValid(lds_datawindow) THEN Destroy(lds_datawindow)
		
	END IF
END IF


RETURN 1
end function

on n_cst_rapport_simple.create
call super::create
end on

on n_cst_rapport_simple.destroy
call super::destroy
end on


$PBExportHeader$pro_n_ds.sru
$PBExportComments$(PRO) Extension Datastore class
forward
global type pro_n_ds from pfc_n_ds
end type
end forward

global type pro_n_ds from pfc_n_ds
end type
global pro_n_ds pro_n_ds

forward prototypes
public function string of_obtenirexpressionclesprimaires (long al_rangee)
end prototypes

public function string of_obtenirexpressionclesprimaires (long al_rangee);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_ObtenirExpressionClesPrimaires
//
//	Accès:			Public
//
//	Argument: 		al_rangee  - Rangée pour laquelle on veut obtenir les clés primaires
//
//	Retourne:  		expression pour trouver la rangée avec les clés primaires
//
//	Description:  	Retourne l'expression qui permet de trouver la rangée avec ses clés
// 					primaires
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

string 	ls_expr_find, ls_colonne_nom, ls_valeur, ls_type_colonne, ls_expr_col
long 		ll_nb_colonnes, ll_compteur_colonnes
dwItemStatus	ldw_ItemStatus

IF al_rangee = 0 OR this.rowcount() < 1 THEN
	RETURN ls_expr_find
END IF

ldw_ItemStatus =this.GetItemStatus(al_rangee,0,Primary!)
//IF ldw_ItemStatus = New! OR ldw_ItemStatus = NewModified! OR IsNull(ldw_ItemStatus) THEN
//	RETURN ls_expr_find
//END IF

// obtenir les clés primaires et leurs valeurs pour la rangée passée en paramètre

ll_nb_colonnes = Long(this.Describe("DataWindow.Column.Count"))

FOR ll_compteur_colonnes = 1 TO ll_nb_colonnes
	ls_colonne_nom = this.Describe("#" + String(ll_compteur_colonnes) + ".Name")
	IF Lower( this.Describe( ls_colonne_nom + ".key") ) = "yes" THEN
		// obtenir la valeur de la colonne

		ls_type_colonne = THIS.Describe(ls_colonne_nom + ".coltype" )

		CHOOSE CASE lower( Left( ls_type_colonne, 5 ) )
			CASE "char(","varch"
				ls_valeur = THIS.GetItemString( al_rangee, ls_colonne_nom )
				ls_valeur = gnv_app.inv_string.of_GlobalReplace(ls_valeur,"~"","~~~"")
				ls_valeur = gnv_app.inv_string.of_GlobalReplace(ls_valeur,"'","''")
				ls_expr_col = ls_colonne_nom + " = ~'" + ls_valeur + "~'"
			CASE "date"
				// transformer la date à un format string normalisé...
				ls_valeur = String( THIS.GetItemDate( al_rangee, ls_colonne_nom ),"yyyy-mm-dd" )
				ls_expr_col = ls_colonne_nom + " = ~'" + ls_valeur + "~'"
			CASE "datet"
				// transformer le datetime à un format string normalisé...
				ls_valeur = String( THIS.GetItemDateTime( al_rangee, ls_colonne_nom ), &
						"yyyy-mm-dd hh:mm:ss.ffffff" )
				ls_expr_col = ls_colonne_nom + " = ~'" + ls_valeur + "~'"
				IF ls_valeur = "" THEN SetNull(ls_valeur)
			CASE "decim", "long", "ulong"
				ls_valeur = String( THIS.GetItemDecimal( al_rangee, ls_colonne_nom) )
				ls_expr_col = ls_colonne_nom + " = " + ls_valeur
			CASE "numbe", "real"
				ls_valeur = String( THIS.GetItemNumber( al_rangee, ls_colonne_nom) )
				ls_expr_col = ls_colonne_nom + " = " + ls_valeur
			CASE "time"
				// transformer le time à un format string normalisé...
				ls_valeur = String( THIS.GetItemTime( al_rangee, ls_colonne_nom ), &
						"hh:mm:ss.ffffff" )
				ls_expr_col = ls_colonne_nom + " = ~'" + ls_valeur + "~'"

			CASE ELSE
				ls_expr_col = ""
		END CHOOSE

		IF Isnull(ls_valeur) THEN
			ls_expr_col = "IsNull(" + ls_colonne_nom + ")"
		END IF

		IF ls_expr_find = "" THEN
			ls_expr_find = ls_expr_col
		ELSE
			ls_expr_find = ls_expr_find + " and " + ls_expr_col
		END IF

	END IF
NEXT


RETURN ls_expr_find
end function

on pro_n_ds.create
call super::create
end on

on pro_n_ds.destroy
call super::destroy
end on

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.Retrieve()
end event


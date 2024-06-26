﻿$PBExportHeader$pro_w_rapport.srw
forward
global type pro_w_rapport from w_sheet
end type
type dw_preview from u_dw within pro_w_rapport
end type
end forward

global type pro_w_rapport from w_sheet
integer width = 4713
integer height = 2568
string title = "Rapport"
dw_preview dw_preview
end type
global pro_w_rapport pro_w_rapport

type variables
n_cst_imprimer 		inv_imprime
end variables

forward prototypes
public function integer of_setimprimer (boolean ab_switch)
end prototypes

public function integer of_setimprimer (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_SetImprime 				
//
//	Accès:  			Public
//
//	Argument:  		ab_Switch - Service d'impression instancié
//
//	Retourne:  		-1 - Erreur
//
//	Description:	Service de gestion de l'objet n_cst_imprimer
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur		Description
//
//////////////////////////////////////////////////////////////////////////////

If isnull( ab_switch ) then
	Return -1
End If

If ab_switch Then
	If isnull( inv_imprime) or Not IsValid(inv_imprime) Then
		// Instantiation du service
		inv_imprime = create n_cst_imprimer
		
		inv_imprime.of_SetRequestor( This, dw_preview )
		inv_imprime.is_titre_original = This.title
		inv_imprime.of_zoomvalue()
		
		this.SetRedraw( False )
		inv_imprime.of_apercu()
		dw_preview.TriggerEvent(clicked!)
		This.SetRedraw( True )
			
		Return 1
	End If
Else
	If IsValid( inv_imprime ) Then
		Destroy inv_imprime
	End If
	
	
	Return 1
End If
	
Return 0
end function

on pro_w_rapport.create
int iCurrent
call super::create
this.dw_preview=create dw_preview
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_preview
end on

on pro_w_rapport.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_preview)
end on

event pfc_preopen;call super::pfc_preopen;// Active le service d'impression
THIS.of_SetImprimer ( True )
end event

event close;call super::close;THIS.of_SetImprimer ( FALSE )
end event

event rbuttondown;call super::rbuttondown;dw_preview.triggerevent("rbuttondown")
end event

event pfc_postopen;call super::pfc_postopen;menu lm_menu
string	ls_exclude[], ls_objects[], ls_tag, ls_null[]
long		ll_cpt, ll_upper, ll_upperex = 0

dw_preview.of_setfilter(TRUE)
dw_preview.inv_filter.of_setstyle(2)
dw_preview.inv_filter.of_setcolumndisplaynamestyle(2)

//Rendu à vérifier ici
//Mettre les exclure_mr en exception
ll_upper = dw_preview.inv_dwsrv.of_Getobjects(ls_objects[], "column", "*", FALSE)
FOR ll_cpt = 1 TO ll_upper
	ls_tag = lower(dw_preview.Describe(ls_objects[ll_cpt] + "_t.Tag"))
	IF POS(ls_tag, "exclure_mr") <> 0 THEN
		ll_upperex = UpperBound(ls_exclude[]) + 1
		ls_exclude[ll_upperex] = ls_objects[ll_cpt]
	END IF
END FOR

ls_objects = ls_null

//Mettre les computed fields en exception
ll_upper = dw_preview.inv_dwsrv.of_Getobjects(ls_objects[], "compute", "*", FALSE)
FOR ll_cpt = 1 TO ll_upper
	ll_upperex = UpperBound(ls_exclude[]) + 1
	ls_exclude[ll_upperex] = ls_objects[ll_cpt]
END FOR

IF ll_upperex > 0 THEN
	dw_preview.inv_filter.of_setexclude(ls_exclude[])
END IF

dw_preview.inv_filter.of_setvisibleonly(TRUE)
end event

type dw_preview from u_dw within pro_w_rapport
event pro_keypress pbm_dwnkey
event pro_majnopage ( )
integer x = 23
integer y = 12
integer width = 3822
integer height = 2296
integer taborder = 10
boolean hscrollbar = true
boolean border = true
end type

event pro_keypress;IF key = KeyPageDown! or key = KeyPageUp! THEN
	THIS.PostEvent("pro_majnopage")
END IF
end event

event pro_majnopage();//Mise à jour du titre
inv_imprime.of_MajNoPage()
end event

event clicked;call super::clicked;// Gestion du zoom in/out
//
inv_imprime.of_ZoomClick()
end event

event pro_derniereligne;// On OVERRIDE le script de l'ancêtre afin d'utiliser
// les boutons de navigation par page et non par
// enregistrement.
//
Pointer lptr_anc

lptr_anc = SetPointer( HourGlass! )

inv_imprime.of_SetPage( inv_imprime.of_PageCount() )

This.SetFocus()
SetPointer (lptr_anc )
end event

event pro_ligneprecedente;// On OVERRIDE le script de l'ancêtre afin d'utiliser
// les boutons de navigation par page et non par
// enregistrement.
//
Pointer lptr_anc

lptr_anc = SetPointer( HourGlass! )
This.ScrollPriorPage( )
This.PostEvent( "pro_majnopage" )
This.SetFocus()
SetPointer (lptr_anc )
end event

event pro_lignesuivante;// On OVERRIDE le script de l'ancêtre afin d'utiliser
// les boutons de navigation par page et non par
// enregistrement.
//
Pointer lptr_anc

lptr_anc = SetPointer( HourGlass! )
This.ScrollNextPage( )
This.PostEvent( "pro_majnopage" )
This.SetFocus()
SetPointer (lptr_anc )
end event

event pro_postscrollvertical;//Override
end event

event pro_premiereligne;// On OVERRIDE le script de l'ancêtre afin d'utiliser
// les boutons de navigation par page et non par
// enregistrement.
//
Pointer lptr_anc

lptr_anc = SetPointer( HourGlass! )
This.ScrollToRow( 1 )
This.PostEvent( "pro_majnopage" )
This.SetFocus()
SetPointer (lptr_anc )
end event

event constructor;call super::constructor;

// Active le service de PrintPreview (fenêtre de changement de zoom, etc.)
THIS.of_SetPrintPreview(TRUE)

// Active le service de Report
THIS.of_SetReport(TRUE)

// Rend la datawindow 'ReadOnly'
THIS.of_SetUpdateable( False )


end event

event pfc_printpreview;//override

RETURN TRUE
end event

event pfc_zoom;call super::pfc_zoom;// Gère l'affichage du curseur en mode PrintPreview. Suite à
// un changement de zoom.
//
Long ll_value, ll_other_value

If AncestorReturnValue <> inv_PrintPreview.FAILURE Then
	ll_value = AncestorReturnValue
	If ll_value <> 100 Then
		inv_imprime.il_zoom_value = ll_value
		ll_other_value = 100
	Else
		ll_other_value = inv_imprime.il_zoom_value
	End If
	inv_imprime.of_SetCurseur( ll_other_value, ll_value )
End If

Return AncestorReturnValue
end event

event rowfocuschanged;// Le script de l'ancêtre ne doit pas être exécuté
// donc, l'option OVERRIDE ANCESTOR SCRIPT est coché
// dans le menu DESIGN

This.PostEvent("pro_majnopage")
end event

event rowfocuschanging;// Le script de l'ancêtre ne doit pas être exécuté
// donc, l'option OVERRIDE ANCESTOR SCRIPT est coché
// dans le menu DESIGN
end event

event scrollvertical;call super::scrollvertical;// Execute la fonction de pagination lorsque 
// l'utilisateur utilise la barre de défilement
// verticale.
//
SetPointer(HourGlass!)
This.PostEvent( "pro_majnopage" )
end event

event pfc_sortdlg;call super::pfc_sortdlg;//Bug d'affichage de PB

THIS.Post GroupCalc()
RETURN AncestorReturnValue
end event

event pfc_filterdlg;call super::pfc_filterdlg;// Ajuster filtre_t

string	ls_filtre, ls_describe

//Vérifier si filtre_t est présent
IF THIS.of_objetexiste("filtre_t") = TRUE THEN
	ls_filtre = gnv_app.inv_entrepotglobal.of_retournedonnee("Filtre affichage", FALSE)
	THIS.object.filtre_t.text = ls_filtre
END IF

this.groupCalc()

RETURN AncestorReturnValue
end event


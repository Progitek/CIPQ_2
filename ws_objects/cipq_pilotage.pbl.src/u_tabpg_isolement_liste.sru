﻿$PBExportHeader$u_tabpg_isolement_liste.sru
forward
global type u_tabpg_isolement_liste from u_tabpg
end type
type uo_toolbar_haut from u_cst_toolbarstrip within u_tabpg_isolement_liste
end type
type uo_toolbar_bas from u_cst_toolbarstrip within u_tabpg_isolement_liste
end type
type dw_isolement_etat_physique from u_dw within u_tabpg_isolement_liste
end type
type dw_isolement_verrat from u_dw within u_tabpg_isolement_liste
end type
type gb_1 from u_gb within u_tabpg_isolement_liste
end type
type gb_ep from u_gb within u_tabpg_isolement_liste
end type
end forward

global type u_tabpg_isolement_liste from u_tabpg
integer width = 4425
integer height = 1828
long backcolor = 15793151
uo_toolbar_haut uo_toolbar_haut
uo_toolbar_bas uo_toolbar_bas
dw_isolement_etat_physique dw_isolement_etat_physique
dw_isolement_verrat dw_isolement_verrat
gb_1 gb_1
gb_ep gb_ep
end type
global u_tabpg_isolement_liste u_tabpg_isolement_liste

on u_tabpg_isolement_liste.create
int iCurrent
call super::create
this.uo_toolbar_haut=create uo_toolbar_haut
this.uo_toolbar_bas=create uo_toolbar_bas
this.dw_isolement_etat_physique=create dw_isolement_etat_physique
this.dw_isolement_verrat=create dw_isolement_verrat
this.gb_1=create gb_1
this.gb_ep=create gb_ep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar_haut
this.Control[iCurrent+2]=this.uo_toolbar_bas
this.Control[iCurrent+3]=this.dw_isolement_etat_physique
this.Control[iCurrent+4]=this.dw_isolement_verrat
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_ep
end on

on u_tabpg_isolement_liste.destroy
call super::destroy
destroy(this.uo_toolbar_haut)
destroy(this.uo_toolbar_bas)
destroy(this.dw_isolement_etat_physique)
destroy(this.dw_isolement_verrat)
destroy(this.gb_1)
destroy(this.gb_ep)
end on

type uo_toolbar_haut from u_cst_toolbarstrip within u_tabpg_isolement_liste
event destroy ( )
string tag = "resize=frbsr"
integer x = 55
integer y = 1080
integer width = 4325
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long 		ll_row, ll_nolot
string	ls_tatouage
w_lot_verrats_isolement	lw_window

CHOOSE CASE as_button
	CASE "Rechercher..."
		parent.of_getparentwindow( lw_window)
		IF lw_window.event pfc_save() >= 0 THEN
			IF dw_isolement_verrat.RowCount() > 0 THEN
				dw_isolement_verrat.SetRow(1)
				dw_isolement_verrat.ScrollToRow(1)
				dw_isolement_verrat.event pfc_finddlg()
			END IF
		END IF
	CASE "Ajouter un verrat"
		dw_isolement_verrat.event pfc_insertrow()
	
	CASE "Supprimer un verrat"
		dw_isolement_verrat.event pfc_deleterow()
		
	CASE "Imprimer le dossier"
		
		ll_row = dw_isolement_verrat.GetRow()
		w_r_dossier_verrat_isolement	lw_window_v
		parent.of_getparentwindow( lw_window)
		IF ll_row > 0 THEN
			IF lw_window.event pfc_save() >= 0 THEN
				ll_nolot = dw_isolement_verrat.object.nolot[ll_row]
				ls_tatouage = dw_isolement_verrat.object.tatouage[ll_row]
					
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", string(ll_nolot))
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("type lien dossier", "verrat")
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien isolement tatouage", ls_tatouage)
				OpenSheet(lw_window_v, gnv_app.of_GetFrame(), 6, layered!)
			END IF				
		END IF
END CHOOSE
end event

event constructor;call super::constructor;uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Rechercher...", "Search!")
uo_toolbar_haut.of_displaytext(true)

dw_isolement_verrat.Of_SetLinkage(TRUE)
dw_isolement_verrat.inv_linkage.of_SetTransObject(SQLCA)

end event

type uo_toolbar_bas from u_cst_toolbarstrip within u_tabpg_isolement_liste
event destroy ( )
string tag = "resize=frbsr"
integer x = 55
integer y = 1688
integer width = 4325
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un état physique"
		dw_isolement_etat_physique.event pfc_insertrow()
END CHOOSE
end event

type dw_isolement_etat_physique from u_dw within u_tabpg_isolement_liste
integer x = 41
integer y = 1256
integer width = 4343
integer height = 432
integer taborder = 40
string dataobject = "d_isolement_etat_physique"
end type

event constructor;call super::constructor;SetRowFocusIndicator(Hand!)
end event

type dw_isolement_verrat from u_dw within u_tabpg_isolement_liste
integer x = 37
integer y = 48
integer width = 4343
integer height = 1032
integer taborder = 10
string dataobject = "d_isolement_verrat"
end type

event clicked;call super::clicked;long	ll_cause
menu	lm_item, lm_menu
n_cst_menu	lnv_menu

lm_menu = gnv_app.of_getframe().MenuID

IF row > 0 THEN
	
	IF dwo.name = "p_reforme" THEN
		ll_cause = THIS.object.id_cause[row]
	
		IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
			
			IF ll_cause <> 0 AND IsNull(ll_cause) = FALSE THEN
				gnv_app.inv_entrepotglobal.of_ajoutedonnee( "lien cause", string(ll_cause))
			END IF
			
			IF lnv_menu.of_GetMenuReference (lm_menu,"m_causesdesreformesdesverrats", lm_item) > 0 THEN
				IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
					lm_item.event clicked()
				END IF
			END IF 
		END IF
		
	END IF
	
END IF
end event

event pfc_insertrow;call super::pfc_insertrow;long	ll_rang, ll_rowcount, ll_cpt, ll_ligne_upper = 1

IF AncestorReturnValue > 0 THEN
	THIS.object.dateentreverrat[AncestorReturnValue] = Today()
	
	//Mettre le rang au plus élevé
	//Prendre la valeur de la dernière rangée + 1
	ll_rowcount = THIS.rowcount()
	
	IF ll_rowcount > 1 THEN
		FOR ll_cpt = 1 TO ll_rowcount
			IF THIS.object.norang[ll_cpt] > ll_ligne_upper THEN 
				ll_ligne_upper = THIS.object.norang[ll_cpt]
			END IF
		END FOR
		ll_rang = ll_ligne_upper + 1
	ELSE
		ll_rang = 1
	END IF
	
	THIS.object.norang[AncestorReturnValue] = ll_rang
	
END IF

RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF


long		ll_row
datetime	ld_entree, ld_sortie

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	
	ld_entree = THIS.object.dateentreverrat[ll_row]
	ld_sortie = THIS.object.datesortieverrat[ll_row]
	
	IF ld_sortie < ld_entree THEN
		gnv_app.inv_error.of_message( "CIPQ0039")
		RETURN FAILURE
	END IF
	
END IF
RETURN ancestorreturnvalue
end event

event pfc_finddlg;call super::pfc_finddlg;SetPointer(Hourglass!)

THIS.object.datawindow.retrieve.asneeded = FALSE

CALL SUPER::pfc_finddlg
end event

event constructor;call super::constructor;THIS.of_setfind(TRUE)
end event

type gb_1 from u_gb within u_tabpg_isolement_liste
integer x = 23
integer width = 4384
integer height = 1204
integer taborder = 0
long backcolor = 15793151
string text = "Verrat"
end type

type gb_ep from u_gb within u_tabpg_isolement_liste
integer x = 23
integer y = 1204
integer width = 4384
integer height = 616
integer taborder = 0
long backcolor = 15793151
string text = "État physique"
end type


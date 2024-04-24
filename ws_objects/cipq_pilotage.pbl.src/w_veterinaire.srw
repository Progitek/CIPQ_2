$PBExportHeader$w_veterinaire.srw
forward
global type w_veterinaire from w_sheet_frame
end type
type dw_veterinaire from u_dw within w_veterinaire
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_veterinaire
end type
type rr_1 from roundrectangle within w_veterinaire
end type
end forward

global type w_veterinaire from w_sheet_frame
string tag = "menu=m_livreurs"
integer x = 214
integer y = 221
integer width = 4635
dw_veterinaire dw_veterinaire
uo_toolbar_haut uo_toolbar_haut
rr_1 rr_1
end type
global w_veterinaire w_veterinaire

on w_veterinaire.create
int iCurrent
call super::create
this.dw_veterinaire=create dw_veterinaire
this.uo_toolbar_haut=create uo_toolbar_haut
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_veterinaire
this.Control[iCurrent+2]=this.uo_toolbar_haut
this.Control[iCurrent+3]=this.rr_1
end on

on w_veterinaire.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_veterinaire)
destroy(this.uo_toolbar_haut)
destroy(this.rr_1)
end on

event pfc_postopen;call super::pfc_postopen;dw_veterinaire.event pfc_retrieve()
end event

event open;call super::open;uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter un vétérinaire", "C:\ii4net\CIPQ\images\ajout_personne.ico")
uo_toolbar_haut.of_AddItem("Supprimer ce vétérinaire", "C:\ii4net\CIPQ\images\suppr_personne.ico")
uo_toolbar_haut.of_AddItem("Rechercher un vétérinaire...", "Search!")
uo_toolbar_haut.of_AddItem("Fusionner", "Custom038!")
uo_toolbar_haut.of_AddItem("Enregistrer", "Save!")
uo_toolbar_haut.of_AddItem("Fermer", "Exit!")
uo_toolbar_haut.of_displaytext(true)

dw_veterinaire.Of_SetLinkage(TRUE)
dw_veterinaire.inv_linkage.of_SetTransObject(SQLCA)
end event

type st_title from w_sheet_frame`st_title within w_veterinaire
string text = "Vétérinaires"
end type

type p_8 from w_sheet_frame`p_8 within w_veterinaire
integer x = 64
integer y = 48
integer width = 91
integer height = 76
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\people6.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_veterinaire
end type

type dw_veterinaire from u_dw within w_veterinaire
integer x = 69
integer y = 224
integer width = 4466
integer height = 2020
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_veterinaire"
end type

event constructor;call super::constructor;THIS.of_setfind( true)
end event

event pfc_retrieve;call super::pfc_retrieve;RETURN This.Retrieve()
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_veterinaire", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_veterinaire
event destroy ( )
string tag = "resize=frbsr"
integer y = 2280
integer width = 4599
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un vétérinaire"
		dw_veterinaire.event pfc_insertrow()
	CASE "Supprimer ce vétérinaire"
		dw_veterinaire.event pfc_deleterow()
	CASE "Rechercher un vétérinaire..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_veterinaire.RowCount() > 0 THEN
				dw_veterinaire.SetRow(1)
				dw_veterinaire.ScrollToRow(1)
				dw_veterinaire.event pfc_finddlg()
			END IF
		END IF	
	CASE "Fusionner"		
			open(w_choixfusionner)
	CASE "Enregistrer"
	   event pfc_save()
	CASE "Fermer"
		event pfc_close()
END CHOOSE

end event

type rr_1 from roundrectangle within w_veterinaire
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 188
integer width = 4549
integer height = 2076
integer cornerheight = 40
integer cornerwidth = 46
end type


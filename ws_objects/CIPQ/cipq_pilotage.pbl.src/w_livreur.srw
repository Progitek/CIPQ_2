$PBExportHeader$w_livreur.srw
forward
global type w_livreur from w_sheet_frame
end type
type dw_livreur from u_dw within w_livreur
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_livreur
end type
type uo_toolbar from u_cst_toolbarstrip within w_livreur
end type
type dw_livreur_transporteur from u_dw within w_livreur
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_livreur
end type
type gb_1 from u_gb within w_livreur
end type
type rr_1 from roundrectangle within w_livreur
end type
end forward

global type w_livreur from w_sheet_frame
string tag = "menu=m_livreurs"
integer x = 214
integer y = 221
dw_livreur dw_livreur
uo_toolbar_haut uo_toolbar_haut
uo_toolbar uo_toolbar
dw_livreur_transporteur dw_livreur_transporteur
uo_toolbar_bas uo_toolbar_bas
gb_1 gb_1
rr_1 rr_1
end type
global w_livreur w_livreur

on w_livreur.create
int iCurrent
call super::create
this.dw_livreur=create dw_livreur
this.uo_toolbar_haut=create uo_toolbar_haut
this.uo_toolbar=create uo_toolbar
this.dw_livreur_transporteur=create dw_livreur_transporteur
this.uo_toolbar_bas=create uo_toolbar_bas
this.gb_1=create gb_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_livreur
this.Control[iCurrent+2]=this.uo_toolbar_haut
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.dw_livreur_transporteur
this.Control[iCurrent+5]=this.uo_toolbar_bas
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rr_1
end on

on w_livreur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_livreur)
destroy(this.uo_toolbar_haut)
destroy(this.uo_toolbar)
destroy(this.dw_livreur_transporteur)
destroy(this.uo_toolbar_bas)
destroy(this.gb_1)
destroy(this.rr_1)
end on

event pfc_postopen;call super::pfc_postopen;dw_livreur.event pfc_retrieve()
end event

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter un livreur", "C:\ii4net\CIPQ\images\ajout_personne.ico")
uo_toolbar_haut.of_AddItem("Supprimer ce livreur", "C:\ii4net\CIPQ\images\suppr_personne.ico")
uo_toolbar_haut.of_AddItem("Rechercher un livreur...", "Search!")
uo_toolbar_haut.of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un transporteur", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_bas.of_AddItem("Supprimer ce transporteur", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_bas.of_displaytext(true)

dw_livreur.Of_SetLinkage(TRUE)
dw_livreur_transporteur.Of_SetLinkage(TRUE)

dw_livreur_transporteur.inv_linkage.of_SetMaster(dw_livreur)
dw_livreur_transporteur.inv_Linkage.of_SetStyle(dw_livreur_transporteur.inv_Linkage.RETRIEVE)
dw_livreur_transporteur.inv_linkage.of_Register("id_livreur","id_livreur")

dw_livreur.inv_linkage.of_SetTransObject(SQLCA)
end event

type st_title from w_sheet_frame`st_title within w_livreur
string text = "Livreurs"
end type

type p_8 from w_sheet_frame`p_8 within w_livreur
integer x = 64
integer y = 48
integer width = 91
integer height = 76
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\people6.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_livreur
end type

type dw_livreur from u_dw within w_livreur
integer x = 69
integer y = 224
integer width = 4375
integer height = 720
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_livreur"
end type

event constructor;call super::constructor;THIS.of_setfind( true)
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Livreur", TRUE)
END IF


IF AncestorReturnValue > 0 AND ib_en_insertion THEN
	n_ds lds_no_auto
	
	lds_no_auto = CREATE n_ds
	lds_no_auto.dataobject = "ds_livreur_no_auto"
	lds_no_auto.of_setTransobject(SQLCA)
	IF lds_no_auto.retrieve() > 0 THEN
		this.object.id_livreur[AncestorReturnValue] = lds_no_auto.object.maximum[1]
	END IF 
END IF

RETURN AncestorReturnValue
end event

event pfc_retrieve;call super::pfc_retrieve;RETURN This.Retrieve()
end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_livreur
event destroy ( )
string tag = "resize=frbsr"
integer x = 105
integer y = 984
integer width = 4352
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un livreur"
		dw_livreur.event pfc_insertrow()
	CASE "Supprimer ce livreur"
		dw_livreur.event pfc_deleterow()
	CASE "Rechercher un livreur..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_livreur.RowCount() > 0 THEN
				dw_livreur.SetRow(1)
				dw_livreur.ScrollToRow(1)
				dw_livreur.event pfc_finddlg()
			END IF
		END IF		
		
END CHOOSE

end event

type uo_toolbar from u_cst_toolbarstrip within w_livreur
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2220
integer width = 4544
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
		
	CASE "Fermer", "Close"		
		Close(parent)

END CHOOSE

end event

type dw_livreur_transporteur from u_dw within w_livreur
integer x = 160
integer y = 1208
integer width = 4233
integer height = 700
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_livreur_transporteur"
end type

event constructor;call super::constructor;SetRowFocusindicator(Hand!)
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_TransporteurLivreur", TRUE)
END IF

RETURN ancestorreturnvalue
end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_livreur
event destroy ( )
string tag = "resize=frbsr"
integer x = 151
integer y = 1928
integer width = 4261
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un transporteur"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_livreur_transporteur.SetFocus()		
			dw_livreur_transporteur.event pfc_insertrow()
		END IF
		
	CASE "Supprimer ce transporteur"
		dw_livreur_transporteur.event pfc_deleterow()

END CHOOSE

end event

type gb_1 from u_gb within w_livreur
integer x = 105
integer y = 1140
integer width = 4357
integer height = 940
integer taborder = 0
long backcolor = 15793151
string text = "Transporteurs"
end type

type rr_1 from roundrectangle within w_livreur
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 188
integer width = 4549
integer height = 1964
integer cornerheight = 40
integer cornerwidth = 46
end type


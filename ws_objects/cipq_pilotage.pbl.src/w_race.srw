$PBExportHeader$w_race.srw
forward
global type w_race from w_sheet_frame
end type
type uo_toolbar from u_cst_toolbarstrip within w_race
end type
type dw_race from u_dw within w_race
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_race
end type
type dw_race_produit from u_dw within w_race
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_race
end type
type gb_1 from groupbox within w_race
end type
type rr_1 from roundrectangle within w_race
end type
end forward

global type w_race from w_sheet_frame
string tag = "menu=m_races"
uo_toolbar uo_toolbar
dw_race dw_race
uo_toolbar_haut uo_toolbar_haut
dw_race_produit dw_race_produit
uo_toolbar_bas uo_toolbar_bas
gb_1 gb_1
rr_1 rr_1
end type
global w_race w_race

on w_race.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.dw_race=create dw_race
this.uo_toolbar_haut=create uo_toolbar_haut
this.dw_race_produit=create dw_race_produit
this.uo_toolbar_bas=create uo_toolbar_bas
this.gb_1=create gb_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.dw_race
this.Control[iCurrent+3]=this.uo_toolbar_haut
this.Control[iCurrent+4]=this.dw_race_produit
this.Control[iCurrent+5]=this.uo_toolbar_bas
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rr_1
end on

on w_race.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.dw_race)
destroy(this.uo_toolbar_haut)
destroy(this.dw_race_produit)
destroy(this.uo_toolbar_bas)
destroy(this.gb_1)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter une race", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_haut.of_AddItem("Rechercher une race...", "Search!")
uo_toolbar_haut.of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter une association", "AddWatch5!")
uo_toolbar_bas.of_AddItem("Supprimer cette association", "DeleteWatch5!")
uo_toolbar_bas.of_displaytext(true)
end event

event pfc_postopen;call super::pfc_postopen;dw_race.event pfc_retrieve()
end event

type st_title from w_sheet_frame`st_title within w_race
integer x = 242
integer y = 60
integer height = 76
string text = "Races"
end type

type p_8 from w_sheet_frame`p_8 within w_race
integer x = 50
integer y = 32
integer width = 174
integer height = 128
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\certificat.jpg"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_race
integer height = 136
end type

type uo_toolbar from u_cst_toolbarstrip within w_race
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

type dw_race from u_dw within w_race
integer x = 96
integer y = 256
integer width = 4393
integer height = 408
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_race"
end type

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.REtrieve()
end event

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)

SetRowFocusIndicator(Hand!)
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Race", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_race
event destroy ( )
string tag = "resize=frbsr"
integer x = 105
integer y = 720
integer width = 4384
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter une race"
		dw_race.event pfc_insertrow()
	CASE "Supprimer cette race"
		dw_race.event pfc_deleterow()
	CASE "Rechercher une race..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_race.RowCount() > 0 THEN
				dw_race.SetRow(1)
				dw_race.ScrollToRow(1)
				dw_race.event pfc_finddlg()
			END IF
		END IF		
		
END CHOOSE

end event

type dw_race_produit from u_dw within w_race
integer x = 151
integer y = 1048
integer width = 4288
integer height = 900
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_race_produit"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_race)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("coderace","coderace")
this.Of_SetDropDownSearch(TRUE)
this.inv_dropdownsearch.of_register()

SetRowFocusindicator(Hand!)
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_AssociationRaceProd", TRUE)
END IF

RETURN AncestorReturnValue
end event

event itemchanged;call super::itemchanged;string	ls_nomproduit
IF dwo.name = "codeprod" THEN
	//Récupérer la description du produit
	  SELECT t_Produit.NomProduit
	  INTO	:ls_nomproduit
    FROM t_Produit 
   WHERE t_Produit.NoProduit = :data ;
	
	THIS.object.t_produit_nomproduit[row] = ls_nomproduit
END IF

return this.inv_dropdownsearch.event pro_itemchanged(row, dwo, data)
end event

event editchanged;call super::editchanged;this.inv_dropdownsearch.event pfc_editchanged(row, dwo, data)
end event

event itemfocuschanged;call super::itemfocuschanged;this.inv_dropdownsearch.event pfc_itemfocuschanged(row, dwo)
end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_race
event destroy ( )
string tag = "resize=frbsr"
integer x = 151
integer y = 1956
integer width = 4283
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter une association"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_race_produit.SetFocus()		
			dw_race_produit.event pfc_insertrow()
		END IF
		
	CASE "Supprimer cette association"
		dw_race_produit.event pfc_deleterow()

END CHOOSE

end event

type gb_1 from groupbox within w_race
integer x = 105
integer y = 960
integer width = 4384
integer height = 1132
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Association de produits par race"
end type

type rr_1 from roundrectangle within w_race
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 192
integer width = 4549
integer height = 1964
integer cornerheight = 40
integer cornerwidth = 46
end type


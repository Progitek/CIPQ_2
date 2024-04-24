$PBExportHeader$w_parametre.srw
forward
global type w_parametre from w_sheet_frame
end type
type dw_parametre from u_dw within w_parametre
end type
type dw_association from u_dw within w_parametre
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_parametre
end type
type uo_toolbar from u_cst_toolbarstrip within w_parametre
end type
type cb_1 from commandbutton within w_parametre
end type
type cb_2 from commandbutton within w_parametre
end type
type cb_3 from commandbutton within w_parametre
end type
type gb_1 from u_gb within w_parametre
end type
type rr_1 from roundrectangle within w_parametre
end type
end forward

global type w_parametre from w_sheet_frame
string tag = "menu=m_configuration"
string title = "Configuration"
dw_parametre dw_parametre
dw_association dw_association
uo_toolbar_bas uo_toolbar_bas
uo_toolbar uo_toolbar
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
gb_1 gb_1
rr_1 rr_1
end type
global w_parametre w_parametre

on w_parametre.create
int iCurrent
call super::create
this.dw_parametre=create dw_parametre
this.dw_association=create dw_association
this.uo_toolbar_bas=create uo_toolbar_bas
this.uo_toolbar=create uo_toolbar
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.gb_1=create gb_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_parametre
this.Control[iCurrent+2]=this.dw_association
this.Control[iCurrent+3]=this.uo_toolbar_bas
this.Control[iCurrent+4]=this.uo_toolbar
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.rr_1
end on

on w_parametre.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_parametre)
destroy(this.dw_association)
destroy(this.uo_toolbar_bas)
destroy(this.uo_toolbar)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter une association", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_bas.of_AddItem("Supprimer une association", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_bas.of_displaytext(true)
end event

type st_title from w_sheet_frame`st_title within w_parametre
integer height = 80
string text = "Configuration"
end type

type p_8 from w_sheet_frame`p_8 within w_parametre
integer x = 64
integer y = 48
integer width = 96
integer height = 84
string picturename = "C:\ii4net\CIPQ\images\bons.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_parametre
end type

type dw_parametre from u_dw within w_parametre
integer x = 101
integer y = 244
integer width = 4384
integer height = 692
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_parametre"
boolean vscrollbar = false
end type

event constructor;call super::constructor;THIS.retrieve()
end event

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.Retrieve()
end event

event pfc_preupdate;call super::pfc_preupdate;IF AncestorReturnValue > 0 AND ib_en_insertion THEN
	n_ds lds_no_auto
	
	lds_no_auto = CREATE n_ds
	lds_no_auto.dataobject = "ds_classe_produit_no_auto"
	lds_no_auto.of_setTransobject(SQLCA)
	IF lds_no_auto.retrieve() > 0 THEN
		this.object.noclasse[AncestorReturnValue] = lds_no_auto.object.maximum[1]
	END IF 
END IF

RETURN AncestorReturnValue



end event

event clicked;call super::clicked;string ls_fichier,ls_exec_name
integer il_result

if dwo.name = 'wordpath' then
	il_result = GetFileOpenName("Fichier excutable de MS Word", ls_fichier, ls_exec_name, "*.exe","Executables (*.exe), *.exe","C:\Program Files\Microsoft Office", 18)
	if il_result <> 0 then
		setitem(row, 'wordpath', ls_fichier)
	end if
end if
end event

type dw_association from u_dw within w_parametre
integer x = 146
integer y = 1008
integer width = 4279
integer height = 920
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_association"
end type

event constructor;call super::constructor;SetRowFocusindicator(Hand!)
THIS.retrieve()
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_AssociationProd", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_parametre
event destroy ( )
string tag = "resize=frbsr"
integer x = 160
integer y = 1956
integer width = 4274
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter une association"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_association.SetFocus()		
			dw_association.event pfc_insertrow()
		END IF
		
	CASE "Supprimer une association"
		dw_association.event pfc_deleterow()
		
	
END CHOOSE
end event

type uo_toolbar from u_cst_toolbarstrip within w_parametre
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2220
integer width = 4544
integer taborder = 40
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

type cb_1 from commandbutton within w_parametre
integer x = 3566
integer y = 328
integer width = 727
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Débarrer la punaise"
end type

event clicked;update t_centrecipq set punaise_open = 0;
commit;
end event

type cb_2 from commandbutton within w_parametre
integer x = 3566
integer y = 448
integer width = 727
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Débarrer la répartition"
end type

event clicked;update t_commande set locked = 'C' where locked <> 'C';
commit;
end event

type cb_3 from commandbutton within w_parametre
integer x = 3566
integer y = 564
integer width = 727
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Maintenance  progitek"
end type

event clicked;open(w_codesql)
end event

type gb_1 from u_gb within w_parametre
integer x = 105
integer y = 920
integer width = 4384
integer height = 1192
integer taborder = 0
long backcolor = 15793151
string text = "Association de produit"
end type

type rr_1 from roundrectangle within w_parametre
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 180
integer width = 4549
integer height = 2000
integer cornerheight = 40
integer cornerwidth = 46
end type


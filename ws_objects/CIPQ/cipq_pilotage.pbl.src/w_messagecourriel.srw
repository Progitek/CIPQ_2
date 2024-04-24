$PBExportHeader$w_messagecourriel.srw
forward
global type w_messagecourriel from w_sheet
end type
type st_10 from statictext within w_messagecourriel
end type
type st_9 from statictext within w_messagecourriel
end type
type st_8 from statictext within w_messagecourriel
end type
type st_7 from statictext within w_messagecourriel
end type
type st_6 from statictext within w_messagecourriel
end type
type st_5 from statictext within w_messagecourriel
end type
type st_3 from statictext within w_messagecourriel
end type
type st_2 from statictext within w_messagecourriel
end type
type st_1 from statictext within w_messagecourriel
end type
type st_dateliv from statictext within w_messagecourriel
end type
type uo_toolbar from u_cst_toolbarstrip within w_messagecourriel
end type
type dw_messagecourriel from u_dw within w_messagecourriel
end type
type p_8 from picture within w_messagecourriel
end type
type st_title from st_uo_transparent within w_messagecourriel
end type
type rr_1 from roundrectangle within w_messagecourriel
end type
type rr_infopat from roundrectangle within w_messagecourriel
end type
end forward

global type w_messagecourriel from w_sheet
string tag = "menu=m_centrescipq"
integer x = 214
integer y = 221
integer width = 3689
integer height = 2096
string title = "Centres CIPQ"
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_3 st_3
st_2 st_2
st_1 st_1
st_dateliv st_dateliv
uo_toolbar uo_toolbar
dw_messagecourriel dw_messagecourriel
p_8 p_8
st_title st_title
rr_1 rr_1
rr_infopat rr_infopat
end type
global w_messagecourriel w_messagecourriel

on w_messagecourriel.create
int iCurrent
call super::create
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_dateliv=create st_dateliv
this.uo_toolbar=create uo_toolbar
this.dw_messagecourriel=create dw_messagecourriel
this.p_8=create p_8
this.st_title=create st_title
this.rr_1=create rr_1
this.rr_infopat=create rr_infopat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_10
this.Control[iCurrent+2]=this.st_9
this.Control[iCurrent+3]=this.st_8
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_dateliv
this.Control[iCurrent+11]=this.uo_toolbar
this.Control[iCurrent+12]=this.dw_messagecourriel
this.Control[iCurrent+13]=this.p_8
this.Control[iCurrent+14]=this.st_title
this.Control[iCurrent+15]=this.rr_1
this.Control[iCurrent+16]=this.rr_infopat
end on

on w_messagecourriel.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_dateliv)
destroy(this.uo_toolbar)
destroy(this.dw_messagecourriel)
destroy(this.p_8)
destroy(this.st_title)
destroy(this.rr_1)
destroy(this.rr_infopat)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

//uo_toolbar.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
//uo_toolbar.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
	
uo_toolbar.of_displaytext(true)
end event

event pfc_postopen;call super::pfc_postopen;dw_messagecourriel.event pfc_retrieve()
end event

type st_10 from statictext within w_messagecourriel
integer x = 3173
integer y = 808
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "<<no_verrat>>"
alignment alignment = Right!
boolean focusrectangle = false
end type

type st_9 from statictext within w_messagecourriel
integer x = 2770
integer y = 800
integer width = 357
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "No verrat : "
boolean focusrectangle = false
end type

type st_8 from statictext within w_messagecourriel
integer x = 3122
integer y = 548
integer width = 494
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "<<qte_expedie>>"
alignment alignment = Right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_messagecourriel
integer x = 2770
integer y = 484
integer width = 338
integer height = 156
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Qte expédié : "
boolean focusrectangle = false
end type

type st_6 from statictext within w_messagecourriel
integer x = 3173
integer y = 700
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "<<nom_produit>>"
alignment alignment = Right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_messagecourriel
integer x = 3122
integer y = 408
integer width = 494
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "<<qte_commande>>"
alignment alignment = Right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_messagecourriel
integer x = 2770
integer y = 636
integer width = 270
integer height = 144
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Nom produit : "
boolean focusrectangle = false
end type

type st_2 from statictext within w_messagecourriel
integer x = 2770
integer y = 340
integer width = 389
integer height = 176
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Qte commande: "
boolean focusrectangle = false
end type

type st_1 from statictext within w_messagecourriel
integer x = 3136
integer y = 264
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "<<date_livraison>>"
alignment alignment = Right!
boolean focusrectangle = false
end type

type st_dateliv from statictext within w_messagecourriel
integer x = 2770
integer y = 196
integer width = 306
integer height = 148
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Date de livraison : "
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_messagecourriel
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 1708
integer width = 3602
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	//CASE "Add","Ajouter"
	//	dw_messagecourriel.event pfc_insertrow()
	//CASE "Supprimer", "Delete"
	//	dw_messagecourriel.event pfc_deleterow()		
	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
	CASE "Fermer", "Close"		
		Close(parent)

END CHOOSE

end event

type dw_messagecourriel from u_dw within w_messagecourriel
integer x = 91
integer y = 188
integer width = 2656
integer height = 1452
integer taborder = 10
string dataobject = "d_messagecourriel"
end type

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.RETRIEVE()
end event

type p_8 from picture within w_messagecourriel
string tag = "resize=frb"
integer x = 69
integer y = 44
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\maison.jpg"
boolean focusrectangle = false
end type

type st_title from st_uo_transparent within w_messagecourriel
string tag = "resize=frbsr"
integer x = 174
integer y = 44
integer width = 1161
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
long backcolor = 15793151
string text = "Message prédéfini"
end type

type rr_1 from roundrectangle within w_messagecourriel
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 32
integer y = 152
integer width = 3593
integer height = 1528
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_infopat from roundrectangle within w_messagecourriel
string tag = "resize=frbsr"
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 32
integer y = 28
integer width = 3598
integer height = 100
integer cornerheight = 75
integer cornerwidth = 75
end type


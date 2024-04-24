$PBExportHeader$w_recolte_message.srw
forward
global type w_recolte_message from w_response
end type
type cb_cancel from commandbutton within w_recolte_message
end type
type dw_recolte_message from u_dw within w_recolte_message
end type
type uo_toolbar from u_cst_toolbarstrip within w_recolte_message
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_recolte_message
end type
type rr_1 from roundrectangle within w_recolte_message
end type
end forward

global type w_recolte_message from w_response
string tag = "menu=m_recoltes"
integer width = 2459
integer height = 1244
string title = "Commentaires de récolte"
boolean controlmenu = false
long backcolor = 12639424
cb_cancel cb_cancel
dw_recolte_message dw_recolte_message
uo_toolbar uo_toolbar
uo_toolbar2 uo_toolbar2
rr_1 rr_1
end type
global w_recolte_message w_recolte_message

type variables
string	is_codeverrat = ""
end variables

on w_recolte_message.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.dw_recolte_message=create dw_recolte_message
this.uo_toolbar=create uo_toolbar
this.uo_toolbar2=create uo_toolbar2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.dw_recolte_message
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.uo_toolbar2
this.Control[iCurrent+5]=this.rr_1
end on

on w_recolte_message.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.dw_recolte_message)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar2)
destroy(this.rr_1)
end on

event pfc_preopen;call super::pfc_preopen;is_codeverrat = gnv_app.inv_entrepotglobal.of_retournedonnee("lien commentaires recolte")
end event

event pfc_postopen;call super::pfc_postopen;long 	ll_nbrow, ll_row


//Lancer le retrieve
ll_nbrow  = dw_recolte_message.retrieve(is_codeverrat)
IF ll_nbrow < 1 THEN
	//Insérer à vide
	ll_row = dw_recolte_message.event pfc_insertrow()
	dw_recolte_message.object.noverrat[ll_row] = is_codeverrat
	//Sauvegarde à vide
	THIS.event pfc_save()
END IF

uo_toolbar.of_settheme("classic")

uo_toolbar.of_DisplayBorder(true)

uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)

uo_toolbar.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar2.of_AddItem("Annuler", "C:\ii4net\CIPQ\images\annuler.gif")
uo_toolbar.of_displaytext(true)
uo_toolbar2.of_displaytext(true)
end event

type cb_cancel from commandbutton within w_recolte_message
integer x = 1166
integer y = 1328
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "cancel"
boolean cancel = true
end type

event clicked;Close(parent)
end event

type dw_recolte_message from u_dw within w_recolte_message
integer x = 64
integer y = 64
integer width = 2309
integer height = 876
integer taborder = 10
string dataobject = "d_recolte_message"
boolean vscrollbar = false
boolean livescroll = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_recolte_message
event destroy ( )
integer x = 41
integer y = 1036
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;parent.event pfc_save()

close(parent)
end event

type uo_toolbar2 from u_cst_toolbarstrip within w_recolte_message
event destroy ( )
integer x = 1888
integer y = 1036
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(Parent)
end event

type rr_1 from roundrectangle within w_recolte_message
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 32
integer y = 28
integer width = 2377
integer height = 944
integer cornerheight = 40
integer cornerwidth = 46
end type


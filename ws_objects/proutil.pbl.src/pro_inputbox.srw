﻿$PBExportHeader$pro_inputbox.srw
forward
global type pro_inputbox from pfc_w_response
end type
type uo_toolbar2 from u_cst_toolbarstrip within pro_inputbox
end type
type uo_toolbar from u_cst_toolbarstrip within pro_inputbox
end type
type sle_input from singlelineedit within pro_inputbox
end type
type st_question from statictext within pro_inputbox
end type
type cb_3 from commandbutton within pro_inputbox
end type
type cb_annuler from commandbutton within pro_inputbox
end type
type cb_ok from commandbutton within pro_inputbox
end type
type rr_1 from roundrectangle within pro_inputbox
end type
end forward

global type pro_inputbox from pfc_w_response
integer x = 214
integer y = 221
integer width = 2199
integer height = 960
boolean controlmenu = false
long backcolor = 15793151
boolean center = true
boolean ib_isupdateable = false
uo_toolbar2 uo_toolbar2
uo_toolbar uo_toolbar
sle_input sle_input
st_question st_question
cb_3 cb_3
cb_annuler cb_annuler
cb_ok cb_ok
rr_1 rr_1
end type
global pro_inputbox pro_inputbox

type variables
str_inputbox st_input
end variables

forward prototypes
public subroutine uf_traduction ()
end prototypes

public subroutine uf_traduction ();uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)
uo_toolbar.of_AddItem("OK", "C:\ii4net\dentitek\images\ok.gif")

uo_toolbar2.of_AddItem("Annuler", "C:\ii4net\dentitek\images\annuler.gif")

uo_toolbar.of_displaytext(true)
uo_toolbar2.of_displaytext(true)
end subroutine

on pro_inputbox.create
int iCurrent
call super::create
this.uo_toolbar2=create uo_toolbar2
this.uo_toolbar=create uo_toolbar
this.sle_input=create sle_input
this.st_question=create st_question
this.cb_3=create cb_3
this.cb_annuler=create cb_annuler
this.cb_ok=create cb_ok
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar2
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.sle_input
this.Control[iCurrent+4]=this.st_question
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_annuler
this.Control[iCurrent+7]=this.cb_ok
this.Control[iCurrent+8]=this.rr_1
end on

on pro_inputbox.destroy
call super::destroy
destroy(this.uo_toolbar2)
destroy(this.uo_toolbar)
destroy(this.sle_input)
destroy(this.st_question)
destroy(this.cb_3)
destroy(this.cb_annuler)
destroy(this.cb_ok)
destroy(this.rr_1)
end on

event open;call super::open;



pro_inputbox.title =  st_input.as_title
st_question.text = st_input.as_question

if left(st_input.as_title,12) = 'Mot de passe' or left(st_input.as_title,8) = 'Password' then
	sle_input.password = true
end if
end event

event pfc_preopen;call super::pfc_preopen;st_input = message.powerobjectparm
end event

type uo_toolbar2 from u_cst_toolbarstrip within pro_inputbox
string tag = "resize=frbsr"
integer x = 1650
integer y = 772
integer width = 507
integer taborder = 30
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;cb_annuler.event clicked( )
end event

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

type uo_toolbar from u_cst_toolbarstrip within pro_inputbox
string tag = "resize=frbsr"
integer x = 18
integer y = 768
integer width = 507
integer taborder = 20
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;cb_ok.event clicked( )
end event

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

type sle_input from singlelineedit within pro_inputbox
integer x = 18
integer y = 652
integer width = 2139
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_question from statictext within pro_inputbox
integer x = 50
integer y = 40
integer width = 2075
integer height = 568
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean focusrectangle = false
end type

type cb_3 from commandbutton within pro_inputbox
boolean visible = false
integer x = 521
integer y = 912
integer width = 1170
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type cb_annuler from commandbutton within pro_inputbox
boolean visible = false
integer x = 32
integer y = 912
integer width = 489
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annuler"
boolean cancel = true
end type

event clicked;string ls_null

setnull(ls_null)

closewithreturn(parent,ls_null)
end event

type cb_ok from commandbutton within pro_inputbox
boolean visible = false
integer x = 1696
integer y = 912
integer width = 489
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
boolean default = true
end type

event clicked;closewithreturn(parent,sle_input.text)
end event

type rr_1 from roundrectangle within pro_inputbox
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15780518
integer x = 23
integer y = 20
integer width = 2130
integer height = 604
integer cornerheight = 40
integer cornerwidth = 46
end type


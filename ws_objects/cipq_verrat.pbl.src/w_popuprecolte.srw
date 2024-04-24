$PBExportHeader$w_popuprecolte.srw
$PBExportComments$Extension Popup Window class
forward
global type w_popuprecolte from pro_w_popup
end type
type st_2 from statictext within w_popuprecolte
end type
type cb_1 from commandbutton within w_popuprecolte
end type
type p_1 from picture within w_popuprecolte
end type
type st_1 from statictext within w_popuprecolte
end type
type rr_1 from roundrectangle within w_popuprecolte
end type
type rr_2 from roundrectangle within w_popuprecolte
end type
end forward

global type w_popuprecolte from pro_w_popup
integer x = 214
integer y = 221
integer width = 2386
integer height = 740
long backcolor = 12639424
boolean center = true
st_2 st_2
cb_1 cb_1
p_1 p_1
st_1 st_1
rr_1 rr_1
rr_2 rr_2
end type
global w_popuprecolte w_popuprecolte

on w_popuprecolte.create
int iCurrent
call super::create
this.st_2=create st_2
this.cb_1=create cb_1
this.p_1=create p_1
this.st_1=create st_1
this.rr_1=create rr_1
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.rr_1
this.Control[iCurrent+6]=this.rr_2
end on

on w_popuprecolte.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.rr_1)
destroy(this.rr_2)
end on

type st_2 from statictext within w_popuprecolte
integer x = 73
integer y = 52
integer width = 2226
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Avertissement !"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_popuprecolte
integer x = 1906
integer y = 504
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Fermer"
boolean flatstyle = true
end type

event clicked;close(w_popuprecolte)
end event

type p_1 from picture within w_popuprecolte
integer x = 128
integer y = 248
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\exclamationrouge.gif"
boolean focusrectangle = false
end type

type st_1 from statictext within w_popuprecolte
integer x = 315
integer y = 236
integer width = 1943
integer height = 240
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Vous devez enregistrer avant de faire une nouvelle récolte"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_popuprecolte
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 37
integer y = 32
integer width = 2281
integer height = 100
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_popuprecolte
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15793151
integer x = 37
integer y = 156
integer width = 2277
integer height = 328
integer cornerheight = 40
integer cornerwidth = 46
end type


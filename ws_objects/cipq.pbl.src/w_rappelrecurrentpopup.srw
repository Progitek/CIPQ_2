﻿$PBExportHeader$w_rappelrecurrentpopup.srw
forward
global type w_rappelrecurrentpopup from w_response
end type
type st_1 from statictext within w_rappelrecurrentpopup
end type
type sle_temps from singlelineedit within w_rappelrecurrentpopup
end type
type uo_1 from u_cst_toolbarstrip within w_rappelrecurrentpopup
end type
type rr_1 from roundrectangle within w_rappelrecurrentpopup
end type
end forward

global type w_rappelrecurrentpopup from w_response
integer width = 2487
integer height = 1608
long backcolor = 15780518
st_1 st_1
sle_temps sle_temps
uo_1 uo_1
rr_1 rr_1
end type
global w_rappelrecurrentpopup w_rappelrecurrentpopup

on w_rappelrecurrentpopup.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_temps=create sle_temps
this.uo_1=create uo_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_temps
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.rr_1
end on

on w_rappelrecurrentpopup.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_temps)
destroy(this.uo_1)
destroy(this.rr_1)
end on

type st_1 from statictext within w_rappelrecurrentpopup
integer x = 87
integer y = 184
integer width = 1093
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15780518
string text = "Temps de rappels dans le dossier patient"
boolean focusrectangle = false
end type

type sle_temps from singlelineedit within w_rappelrecurrentpopup
integer x = 1193
integer y = 172
integer width = 370
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type uo_1 from u_cst_toolbarstrip within w_rappelrecurrentpopup
integer x = 9
integer y = 1412
integer width = 2455
integer taborder = 10
end type

on uo_1.destroy
call u_cst_toolbarstrip::destroy
end on

type rr_1 from roundrectangle within w_rappelrecurrentpopup
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 12639424
integer x = 18
integer y = 12
integer width = 2450
integer height = 104
integer cornerheight = 40
integer cornerwidth = 46
end type

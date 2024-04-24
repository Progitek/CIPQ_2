$PBExportHeader$w_logerreur.srw
forward
global type w_logerreur from w_sheet
end type
type cbx_tous from checkbox within w_logerreur
end type
type st_1 from statictext within w_logerreur
end type
type cb_3 from commandbutton within w_logerreur
end type
type em_date from editmask within w_logerreur
end type
type dw_logserreur from u_dw within w_logerreur
end type
type cb_2 from commandbutton within w_logerreur
end type
type cb_1 from commandbutton within w_logerreur
end type
type rr_1 from roundrectangle within w_logerreur
end type
type rr_2 from roundrectangle within w_logerreur
end type
end forward

global type w_logerreur from w_sheet
integer width = 4754
integer height = 2324
string icon = "AppIcon!"
boolean center = true
cbx_tous cbx_tous
st_1 st_1
cb_3 cb_3
em_date em_date
dw_logserreur dw_logserreur
cb_2 cb_2
cb_1 cb_1
rr_1 rr_1
rr_2 rr_2
end type
global w_logerreur w_logerreur

on w_logerreur.create
int iCurrent
call super::create
this.cbx_tous=create cbx_tous
this.st_1=create st_1
this.cb_3=create cb_3
this.em_date=create em_date
this.dw_logserreur=create dw_logserreur
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rr_1=create rr_1
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_tous
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.em_date
this.Control[iCurrent+5]=this.dw_logserreur
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.rr_1
this.Control[iCurrent+9]=this.rr_2
end on

on w_logerreur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_tous)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.em_date)
destroy(this.dw_logserreur)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;em_date.text = string(today())
dw_logserreur.retrieve(today(),0)
end event

type cbx_tous from checkbox within w_logerreur
integer x = 1271
integer y = 2028
integer width = 814
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Tous les transactions"
end type

type st_1 from statictext within w_logerreur
integer x = 59
integer y = 32
integer width = 1271
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Liste des transactions exportées"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_logerreur
integer x = 631
integer y = 2020
integer width = 613
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rechecher"
end type

event clicked;date ldt_today
long ll_tous

em_date.getdata(ldt_today)
if cbx_tous.checked then
	ll_tous = 1
else
	ll_tous = 0
end if

dw_logserreur.retrieve(ldt_today, ll_tous)
end event

type em_date from editmask within w_logerreur
integer x = 4160
integer y = 28
integer width = 526
integer height = 96
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
boolean dropdowncalendar = true
end type

type dw_logserreur from u_dw within w_logerreur
integer x = 32
integer y = 164
integer width = 4649
integer height = 1820
integer taborder = 10
string dataobject = "d_logserreur"
end type

type cb_2 from commandbutton within w_logerreur
integer x = 4091
integer y = 2020
integer width = 613
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Fermer"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_logerreur
integer x = 5
integer y = 2020
integer width = 613
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Imprimer"
end type

event clicked;printsetup()
dw_logserreur.print()
end event

type rr_1 from roundrectangle within w_logerreur
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer y = 148
integer width = 4709
integer height = 1864
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_logerreur
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15793151
integer x = 14
integer y = 16
integer width = 4695
integer height = 120
integer cornerheight = 40
integer cornerwidth = 46
end type


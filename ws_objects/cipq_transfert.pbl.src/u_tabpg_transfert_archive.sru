﻿$PBExportHeader$u_tabpg_transfert_archive.sru
forward
global type u_tabpg_transfert_archive from u_tabpg
end type
type pb_go from picturebutton within u_tabpg_transfert_archive
end type
type em_date from u_em within u_tabpg_transfert_archive
end type
type st_1 from statictext within u_tabpg_transfert_archive
end type
type dw_transfert_centre_archive from u_dw within u_tabpg_transfert_archive
end type
end forward

global type u_tabpg_transfert_archive from u_tabpg
integer width = 4425
integer height = 1828
long backcolor = 15793151
string text = "Archives"
long tabbackcolor = 15793151
pb_go pb_go
em_date em_date
st_1 st_1
dw_transfert_centre_archive dw_transfert_centre_archive
end type
global u_tabpg_transfert_archive u_tabpg_transfert_archive

on u_tabpg_transfert_archive.create
int iCurrent
call super::create
this.pb_go=create pb_go
this.em_date=create em_date
this.st_1=create st_1
this.dw_transfert_centre_archive=create dw_transfert_centre_archive
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_go
this.Control[iCurrent+2]=this.em_date
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_transfert_centre_archive
end on

on u_tabpg_transfert_archive.destroy
call super::destroy
destroy(this.pb_go)
destroy(this.em_date)
destroy(this.st_1)
destroy(this.dw_transfert_centre_archive)
end on

type pb_go from picturebutton within u_tabpg_transfert_archive
integer x = 1161
integer y = 16
integer width = 101
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "C:\ii4net\CIPQ\images\rechercher.jpg"
alignment htextalign = left!
end type

event clicked;SetPointer(HourGlass!)

date	ld_cur
long	ll_retour

ld_cur = Date(em_date.text)
If Not IsNull(ld_cur) THEN
	ll_retour = dw_transfert_centre_archive.Retrieve(ld_cur)
END IF
end event

type em_date from u_em within u_tabpg_transfert_archive
integer x = 782
integer y = 20
integer width = 375
integer height = 84
integer taborder = 10
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

event modified;call super::modified;SetPointer(HourGlass!)
pb_go.event clicked()
end event

type st_1 from statictext within u_tabpg_transfert_archive
integer x = 37
integer y = 28
integer width = 718
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Sélectionnez une date:"
boolean focusrectangle = false
end type

type dw_transfert_centre_archive from u_dw within u_tabpg_transfert_archive
integer x = 18
integer y = 160
integer width = 4434
integer height = 1636
integer taborder = 10
string dataobject = "d_transfert_centre_archive"
end type

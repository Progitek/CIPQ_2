$PBExportHeader$w_melangeerr.srw
forward
global type w_melangeerr from w_sheet
end type
type uo_apply from u_cst_toolbarstrip within w_melangeerr
end type
type uo_annuler from u_cst_toolbarstrip within w_melangeerr
end type
type dw_3 from u_dw within w_melangeerr
end type
type st_3 from statictext within w_melangeerr
end type
type dw_2 from u_dw within w_melangeerr
end type
type st_2 from statictext within w_melangeerr
end type
type dw_1 from u_dw within w_melangeerr
end type
type st_1 from statictext within w_melangeerr
end type
end forward

global type w_melangeerr from w_sheet
integer width = 3991
integer height = 2052
uo_apply uo_apply
uo_annuler uo_annuler
dw_3 dw_3
st_3 st_3
dw_2 dw_2
st_2 st_2
dw_1 dw_1
st_1 st_1
end type
global w_melangeerr w_melangeerr

on w_melangeerr.create
int iCurrent
call super::create
this.uo_apply=create uo_apply
this.uo_annuler=create uo_annuler
this.dw_3=create dw_3
this.st_3=create st_3
this.dw_2=create dw_2
this.st_2=create st_2
this.dw_1=create dw_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_apply
this.Control[iCurrent+2]=this.uo_annuler
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.st_1
end on

on w_melangeerr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_apply)
destroy(this.uo_annuler)
destroy(this.dw_3)
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.st_1)
end on

type uo_apply from u_cst_toolbarstrip within w_melangeerr
integer x = 3419
integer y = 1740
integer taborder = 30
end type

on uo_apply.destroy
call u_cst_toolbarstrip::destroy
end on

type uo_annuler from u_cst_toolbarstrip within w_melangeerr
integer x = 37
integer y = 1732
integer taborder = 30
end type

on uo_annuler.destroy
call u_cst_toolbarstrip::destroy
end on

type dw_3 from u_dw within w_melangeerr
integer x = 87
integer y = 1040
integer width = 3749
integer taborder = 20
end type

type st_3 from statictext within w_melangeerr
integer x = 37
integer y = 928
integer width = 800
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Correction a apporter"
boolean focusrectangle = false
end type

type dw_2 from u_dw within w_melangeerr
integer x = 87
integer y = 612
integer width = 3749
integer taborder = 10
end type

type st_2 from statictext within w_melangeerr
integer x = 37
integer y = 472
integer width = 800
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Annulation de la ligne érronée"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_melangeerr
integer x = 87
integer y = 144
integer width = 3749
integer taborder = 10
end type

type st_1 from statictext within w_melangeerr
integer x = 37
integer y = 28
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ligne erronée"
boolean focusrectangle = false
end type


$PBExportHeader$pro_tabpg_security.sru
forward
global type pro_tabpg_security from pfc_u_tabpg
end type
type dw_1 from datawindow within pro_tabpg_security
end type
end forward

global type pro_tabpg_security from pfc_u_tabpg
integer width = 3150
integer height = 1976
dw_1 dw_1
end type
global pro_tabpg_security pro_tabpg_security

on pro_tabpg_security.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on pro_tabpg_security.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within pro_tabpg_security
integer width = 3141
integer height = 1972
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


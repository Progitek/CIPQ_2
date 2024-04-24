$PBExportHeader$w_waitivos.srw
forward
global type w_waitivos from window
end type
type st_1 from statictext within w_waitivos
end type
end forward

global type w_waitivos from window
integer width = 1504
integer height = 344
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
end type
global w_waitivos w_waitivos

on w_waitivos.create
this.st_1=create st_1
this.Control[]={this.st_1}
end on

on w_waitivos.destroy
destroy(this.st_1)
end on

type st_1 from statictext within w_waitivos
integer x = 270
integer y = 64
integer width = 914
integer height = 112
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "En attente de IVOS"
boolean focusrectangle = false
end type


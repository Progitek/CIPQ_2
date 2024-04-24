$PBExportHeader$pro_w_sortdragdrop.srw
$PBExportComments$(PRO) Extension Drag/Drop Style Sort dialog window
forward
global type pro_w_sortdragdrop from pfc_w_sortdragdrop
end type
type uo_toolbar from u_cst_toolbarstrip within pro_w_sortdragdrop
end type
type uo_toolbar2 from u_cst_toolbarstrip within pro_w_sortdragdrop
end type
type rr_1 from roundrectangle within pro_w_sortdragdrop
end type
end forward

global type pro_w_sortdragdrop from pfc_w_sortdragdrop
string tag = "exclure_securite"
integer width = 2203
integer height = 1004
string title = "Trier"
long backcolor = 12639424
uo_toolbar uo_toolbar
uo_toolbar2 uo_toolbar2
rr_1 rr_1
end type
global pro_w_sortdragdrop pro_w_sortdragdrop

on pro_w_sortdragdrop.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.uo_toolbar2=create uo_toolbar2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.uo_toolbar2
this.Control[iCurrent+3]=this.rr_1
end on

on pro_w_sortdragdrop.destroy
call super::destroy
destroy(this.uo_toolbar)
destroy(this.uo_toolbar2)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")

uo_toolbar.of_DisplayBorder(true)

uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)

uo_toolbar.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar2.of_AddItem("Annuler", "C:\ii4net\CIPQ\images\annuler.gif")
uo_toolbar.POST of_displaytext(true)
uo_toolbar2.POST of_displaytext(true)
end event

type dw_sorted from pfc_w_sortdragdrop`dw_sorted within pro_w_sortdragdrop
integer x = 1019
integer width = 1120
string dragicon = "C:\ii4net\CIPQ\images\dragdrop_gauche.ico"
boolean border = true
end type

type st_3 from pfc_w_sortdragdrop`st_3 within pro_w_sortdragdrop
integer x = 1033
long backcolor = 15793151
string text = "Trier les colonnes"
end type

type st_4 from pfc_w_sortdragdrop`st_4 within pro_w_sortdragdrop
integer x = 1865
integer width = 270
long backcolor = 15793151
string text = "Croissant"
end type

type st_2 from pfc_w_sortdragdrop`st_2 within pro_w_sortdragdrop
integer x = 69
long backcolor = 15793151
string text = "Colonnes disponibles pour le tri"
end type

type dw_sortcolumns from pfc_w_sortdragdrop`dw_sortcolumns within pro_w_sortdragdrop
integer x = 59
integer width = 937
string dragicon = "C:\ii4net\CIPQ\images\dragdrop_droite.ico"
boolean hscrollbar = false
boolean border = true
end type

type cb_ok from pfc_w_sortdragdrop`cb_ok within pro_w_sortdragdrop
integer y = 996
end type

type cb_cancel from pfc_w_sortdragdrop`cb_cancel within pro_w_sortdragdrop
integer y = 996
end type

type cb_dlghelp from pfc_w_sortdragdrop`cb_dlghelp within pro_w_sortdragdrop
boolean visible = false
integer x = 2094
integer y = 820
end type

type uo_toolbar from u_cst_toolbarstrip within pro_w_sortdragdrop
integer x = 1097
integer y = 800
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;cb_ok.event clicked( )
end event

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

type uo_toolbar2 from u_cst_toolbarstrip within pro_w_sortdragdrop
integer x = 1664
integer y = 800
integer width = 507
integer taborder = 20
boolean bringtotop = true
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;cb_cancel.event clicked( )
end event

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

type rr_1 from roundrectangle within pro_w_sortdragdrop
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 27
integer y = 16
integer width = 2139
integer height = 744
integer cornerheight = 40
integer cornerwidth = 46
end type


﻿$PBExportHeader$w_traite_commande_recolte.srw
forward
global type w_traite_commande_recolte from w_response
end type
type dw_traite_commande_recolte from u_dw within w_traite_commande_recolte
end type
type p_1 from picture within w_traite_commande_recolte
end type
type st_1 from statictext within w_traite_commande_recolte
end type
type uo_toolbar from u_cst_toolbarstrip within w_traite_commande_recolte
end type
type rr_1 from roundrectangle within w_traite_commande_recolte
end type
type rr_2 from roundrectangle within w_traite_commande_recolte
end type
end forward

global type w_traite_commande_recolte from w_response
integer width = 1797
integer height = 1276
string title = "Verrats récoltés"
long backcolor = 12639424
dw_traite_commande_recolte dw_traite_commande_recolte
p_1 p_1
st_1 st_1
uo_toolbar uo_toolbar
rr_1 rr_1
rr_2 rr_2
end type
global w_traite_commande_recolte w_traite_commande_recolte

on w_traite_commande_recolte.create
int iCurrent
call super::create
this.dw_traite_commande_recolte=create dw_traite_commande_recolte
this.p_1=create p_1
this.st_1=create st_1
this.uo_toolbar=create uo_toolbar
this.rr_1=create rr_1
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_traite_commande_recolte
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.uo_toolbar
this.Control[iCurrent+5]=this.rr_1
this.Control[iCurrent+6]=this.rr_2
end on

on w_traite_commande_recolte.destroy
call super::destroy
destroy(this.dw_traite_commande_recolte)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.uo_toolbar)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

dw_traite_commande_recolte.Retrieve(gnv_app.inv_entrepotglobal.of_retournedonnee("produit recolte traite"))
end event

type dw_traite_commande_recolte from u_dw within w_traite_commande_recolte
integer x = 59
integer y = 244
integer width = 1650
integer height = 752
integer taborder = 10
string dataobject = "d_traite_commande_recolte"
boolean vscrollbar = false
boolean ib_isupdateable = false
end type

type p_1 from picture within w_traite_commande_recolte
integer x = 69
integer y = 52
integer width = 114
integer height = 104
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\link.bmp"
boolean focusrectangle = false
end type

type st_1 from statictext within w_traite_commande_recolte
integer x = 274
integer y = 60
integer width = 1051
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Verrats récoltés"
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_traite_commande_recolte
event destroy ( )
integer x = 1248
integer y = 1076
integer width = 507
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type rr_1 from roundrectangle within w_traite_commande_recolte
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 212
integer width = 1737
integer height = 828
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_traite_commande_recolte
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 1737
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type


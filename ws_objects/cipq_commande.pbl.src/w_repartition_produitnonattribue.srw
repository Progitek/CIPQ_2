$PBExportHeader$w_repartition_produitnonattribue.srw
forward
global type w_repartition_produitnonattribue from w_response
end type
type uo_toolbarprint from u_cst_toolbarstrip within w_repartition_produitnonattribue
end type
type dw_repartition_produitnonattribue from u_dw within w_repartition_produitnonattribue
end type
type p_1 from picture within w_repartition_produitnonattribue
end type
type st_1 from statictext within w_repartition_produitnonattribue
end type
type uo_toolbar from u_cst_toolbarstrip within w_repartition_produitnonattribue
end type
type rr_1 from roundrectangle within w_repartition_produitnonattribue
end type
type rr_2 from roundrectangle within w_repartition_produitnonattribue
end type
end forward

global type w_repartition_produitnonattribue from w_response
integer x = 214
integer y = 221
integer width = 3200
integer height = 2340
string title = "Produits non-attribués"
long backcolor = 12639424
uo_toolbarprint uo_toolbarprint
dw_repartition_produitnonattribue dw_repartition_produitnonattribue
p_1 p_1
st_1 st_1
uo_toolbar uo_toolbar
rr_1 rr_1
rr_2 rr_2
end type
global w_repartition_produitnonattribue w_repartition_produitnonattribue

on w_repartition_produitnonattribue.create
int iCurrent
call super::create
this.uo_toolbarprint=create uo_toolbarprint
this.dw_repartition_produitnonattribue=create dw_repartition_produitnonattribue
this.p_1=create p_1
this.st_1=create st_1
this.uo_toolbar=create uo_toolbar
this.rr_1=create rr_1
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbarprint
this.Control[iCurrent+2]=this.dw_repartition_produitnonattribue
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.rr_1
this.Control[iCurrent+7]=this.rr_2
end on

on w_repartition_produitnonattribue.destroy
call super::destroy
destroy(this.uo_toolbarprint)
destroy(this.dw_repartition_produitnonattribue)
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

uo_toolbarprint.of_settheme("classic")
uo_toolbarprint.of_DisplayBorder(true)
uo_toolbarprint.of_AddItem("Imprimer", "Print!")
uo_toolbarprint.POST of_displaytext(true)

dw_repartition_produitnonattribue.Retrieve(date(gnv_app.inv_entrepotglobal.of_retournedonnee("repartition non attribue date")))
end event

type uo_toolbarprint from u_cst_toolbarstrip within w_repartition_produitnonattribue
event destroy ( )
integer x = 18
integer y = 2136
integer width = 507
integer taborder = 40
end type

on uo_toolbarprint.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;if dw_repartition_produitnonattribue.rowcount( ) > 0 then
	dw_repartition_produitnonattribue.event pfc_print()
end if
end event

type dw_repartition_produitnonattribue from u_dw within w_repartition_produitnonattribue
integer x = 59
integer y = 244
integer width = 3063
integer height = 1824
integer taborder = 10
string dataobject = "d_repartition_produitnonattribue"
boolean ib_isupdateable = false
end type

type p_1 from picture within w_repartition_produitnonattribue
integer x = 69
integer y = 44
integer width = 137
integer height = 116
string picturename = "C:\ii4net\CIPQ\images\lookup.bmp"
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_repartition_produitnonattribue
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
string text = "Produits non-attribués"
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_repartition_produitnonattribue
event destroy ( )
integer x = 2661
integer y = 2136
integer width = 507
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type rr_1 from roundrectangle within w_repartition_produitnonattribue
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 212
integer width = 3150
integer height = 1900
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_repartition_produitnonattribue
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 3150
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type


$PBExportHeader$pro_w_find.srw
$PBExportComments$(PRO) Extension Find window
forward
global type pro_w_find from pfc_w_find
end type
type uo_toolbar from u_cst_toolbarstrip within pro_w_find
end type
type uo_toolbar_annuler from u_cst_toolbarstrip within pro_w_find
end type
type rr_1 from roundrectangle within pro_w_find
end type
end forward

global type pro_w_find from pfc_w_find
integer width = 2263
integer height = 544
string title = "Rechercher"
long backcolor = 15793151
boolean center = true
uo_toolbar uo_toolbar
uo_toolbar_annuler uo_toolbar_annuler
rr_1 rr_1
end type
global pro_w_find pro_w_find

on pro_w_find.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_annuler=create uo_toolbar_annuler
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.uo_toolbar_annuler
this.Control[iCurrent+3]=this.rr_1
end on

on pro_w_find.destroy
call super::destroy
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_annuler)
destroy(this.rr_1)
end on

event open;call super::open;THIS.height = 564

uo_toolbar.of_settheme("classic")

uo_toolbar.of_DisplayBorder(true)

uo_toolbar_annuler.of_settheme("classic")
uo_toolbar_annuler.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Suivant", "Search!")
uo_toolbar_annuler.of_AddItem("Annuler", "C:\ii4net\CIPQ\images\annuler.gif")
uo_toolbar.POST of_displaytext(true)
uo_toolbar_annuler.POST of_displaytext(true)
end event

type st_findwhere from pfc_w_find`st_findwhere within pro_w_find
integer x = 78
integer y = 200
long backcolor = 12639424
string text = "Regarder dans:"
end type

type st_searchfor from pfc_w_find`st_searchfor within pro_w_find
integer x = 78
integer y = 104
long backcolor = 12639424
string text = "Rechercher:"
end type

type ddlb_findwhere from pfc_w_find`ddlb_findwhere within pro_w_find
integer x = 617
integer y = 200
integer taborder = 20
boolean sorted = true
integer accelerator = 0
end type

type st_searchdirection from pfc_w_find`st_searchdirection within pro_w_find
integer x = 78
long backcolor = 12639424
string text = "Sens:"
end type

type cbx_wholeword from pfc_w_find`cbx_wholeword within pro_w_find
boolean visible = false
integer x = 1632
integer y = 312
integer width = 389
long backcolor = 12639424
string text = "Mot complet"
end type

type cbx_matchcase from pfc_w_find`cbx_matchcase within pro_w_find
integer x = 997
integer y = 312
integer width = 631
long backcolor = 12639424
string text = "Respecter la casse"
end type

type cb_findnext from pfc_w_find`cb_findnext within pro_w_find
integer x = 2313
integer y = 88
string text = "Suivant"
boolean default = true
end type

type cb_cancel from pfc_w_find`cb_cancel within pro_w_find
integer x = 2313
integer y = 200
string text = "Annuler"
end type

type sle_findwhat from pfc_w_find`sle_findwhat within pro_w_find
integer x = 617
integer y = 100
integer taborder = 10
end type

type ddlb_searchdirection from pfc_w_find`ddlb_searchdirection within pro_w_find
integer x = 617
string item[] = {"Bas","Haut"}
end type

type cb_dlghelp from pfc_w_find`cb_dlghelp within pro_w_find
boolean visible = false
integer x = 2112
integer y = 732
integer taborder = 0
end type

type uo_toolbar from u_cst_toolbarstrip within pro_w_find
integer x = 1705
integer y = 92
integer width = 466
integer taborder = 40
boolean bringtotop = true
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;
cb_findnext.event clicked( )
end event

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

type uo_toolbar_annuler from u_cst_toolbarstrip within pro_w_find
integer x = 1705
integer y = 204
integer width = 466
integer taborder = 50
boolean bringtotop = true
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;
cb_cancel.event clicked( )
end event

on uo_toolbar_annuler.destroy
call u_cst_toolbarstrip::destroy
end on

type rr_1 from roundrectangle within pro_w_find
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 12639424
integer x = 27
integer y = 40
integer width = 2199
integer height = 392
integer cornerheight = 40
integer cornerwidth = 46
end type


$PBExportHeader$w_modules.srw
forward
global type w_modules from w_child
end type
type dw_projets from u_dw within w_modules
end type
type st_1 from statictext within w_modules
end type
type cb_print from commandbutton within w_modules
end type
type dw_modules from u_dw within w_modules
end type
type cb_close from commandbutton within w_modules
end type
type cb_update from commandbutton within w_modules
end type
type cb_delete from commandbutton within w_modules
end type
type cb_insert from commandbutton within w_modules
end type
end forward

global type w_modules from w_child
integer width = 3630
integer height = 1944
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean ib_isupdateable = false
dw_projets dw_projets
st_1 st_1
cb_print cb_print
dw_modules dw_modules
cb_close cb_close
cb_update cb_update
cb_delete cb_delete
cb_insert cb_insert
end type
global w_modules w_modules

type variables
public long il_idprojet
public boolean change = false
end variables

forward prototypes
public subroutine save ()
end prototypes

public subroutine save ();//if dw_infordv.update() = 1 then
//	commit using SQLCA;
//	change = false
//else
//	rollback using SQLCA;
//end if
//dw_infordv.retrieve()
end subroutine

on w_modules.create
int iCurrent
call super::create
this.dw_projets=create dw_projets
this.st_1=create st_1
this.cb_print=create cb_print
this.dw_modules=create dw_modules
this.cb_close=create cb_close
this.cb_update=create cb_update
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_projets
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.dw_modules
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_update
this.Control[iCurrent+7]=this.cb_delete
this.Control[iCurrent+8]=this.cb_insert
end on

on w_modules.destroy
call super::destroy
destroy(this.dw_projets)
destroy(this.st_1)
destroy(this.cb_print)
destroy(this.dw_modules)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.cb_delete)
destroy(this.cb_insert)
end on

event open;call super::open;pro_resize luo_size
luo_size.uf_resizew(this,3630,1945)
end event

type dw_projets from u_dw within w_modules
integer y = 96
integer width = 1312
integer height = 1732
integer taborder = 20
string title = "Projets"
string dataobject = "d_projets"
end type

event constructor;dw_projets.of_SetLinkage(TRUE)
dw_modules.of_SetLinkage(TRUE)
dw_projets.inv_linkage.of_SetTransObject(SQLCA)
dw_modules.inv_linkage.of_SetTransObject(SQLCA)
dw_modules.inv_linkage.of_SetMaster(dw_projets)
dw_modules.inv_linkage.of_Register("id_projet","id_projet")
dw_modules.inv_linkage.of_SetStyle(dw_modules.inv_linkage.RETRIEVE)
dw_projets.retrieve()
end event

event rowfocuschanged;call super::rowfocuschanged;il_idprojet = getitemnumber(currentrow,'id_projet')
end event

type st_1 from statictext within w_modules
integer width = 3259
integer height = 92
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Modules"
boolean focusrectangle = false
end type

type cb_print from commandbutton within w_modules
integer x = 1435
integer y = 1832
integer width = 672
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimer"
end type

event clicked;printsetup()
dw_modules.print()
end event

type dw_modules from u_dw within w_modules
event ue_insert ( )
event ue_update ( )
event ue_delete ( )
integer x = 1321
integer y = 96
integer width = 2235
integer height = 1732
integer taborder = 10
string title = "Modules"
string dataobject = "d_modules"
boolean border = false
end type

event ue_insert();long ll_newrow

if il_idprojet > 0 then
	ll_newrow = insertRow(0)
	SetItem(ll_newrow,'id_projet',il_idprojet)
	scrollToRow(ll_newrow)
	setFocus()
	change = true
else
	messagebox('Erreur!','Aucun projet sélectionné',StopSign!)
end if
end event

event ue_update();if update() = 1 then
	commit using sqlca;
	change = false
else
	rollback using sqlca;
	error_type(50)
end if
end event

event ue_delete();deleterow(getrow())
change = true
end event

event editchanged;change = true
end event

event itemchanged;change = true
end event

type cb_close from commandbutton within w_modules
integer x = 2903
integer y = 1832
integer width = 695
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fermer"
end type

event clicked;if change then
	if error_type(200) = 1 then
		dw_modules.event ue_update()
	end if
end if
close(parent)
end event

type cb_update from commandbutton within w_modules
integer x = 2107
integer y = 1832
integer width = 795
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sauvegarde"
end type

event clicked;dw_modules.event ue_update()
end event

type cb_delete from commandbutton within w_modules
integer x = 763
integer y = 1832
integer width = 672
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Supprimer"
end type

event clicked;dw_modules.event ue_delete()
end event

type cb_insert from commandbutton within w_modules
integer y = 1832
integer width = 763
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ajouter"
end type

event clicked;dw_modules.event ue_insert()
end event


$PBExportHeader$w_listebillets.srw
forward
global type w_listebillets from w_main
end type
type cb_1 from commandbutton within w_listebillets
end type
type cbx_billet from checkbox within w_listebillets
end type
type st_1 from statictext within w_listebillets
end type
type ddlb_projets from dropdownlistbox within w_listebillets
end type
type cb_print from commandbutton within w_listebillets
end type
type dw_listebillets from u_dw within w_listebillets
end type
type cb_close from commandbutton within w_listebillets
end type
type cb_set from commandbutton within w_listebillets
end type
end forward

global type w_listebillets from w_main
integer width = 3630
integer height = 1944
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean ib_isupdateable = false
cb_1 cb_1
cbx_billet cbx_billet
st_1 st_1
ddlb_projets ddlb_projets
cb_print cb_print
dw_listebillets dw_listebillets
cb_close cb_close
cb_set cb_set
end type
global w_listebillets w_listebillets

type variables
public long il_idbillet, il_idprojet, il_idproj[], il_indproj
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

on w_listebillets.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cbx_billet=create cbx_billet
this.st_1=create st_1
this.ddlb_projets=create ddlb_projets
this.cb_print=create cb_print
this.dw_listebillets=create dw_listebillets
this.cb_close=create cb_close
this.cb_set=create cb_set
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cbx_billet
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.ddlb_projets
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.dw_listebillets
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_set
end on

on w_listebillets.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cbx_billet)
destroy(this.st_1)
destroy(this.ddlb_projets)
destroy(this.cb_print)
destroy(this.dw_listebillets)
destroy(this.cb_close)
destroy(this.cb_set)
end on

event open;call super::open;pro_resize luo_size
luo_size.uf_resizew(this,3630,1945)

dw_listebillets.event ue_retrieve(1)
end event

type cb_1 from commandbutton within w_listebillets
integer x = 1065
integer y = 1832
integer width = 631
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiser"
end type

event clicked;dw_listebillets.event ue_retrieve(1)
end event

type cbx_billet from checkbox within w_listebillets
integer x = 2606
integer y = 20
integer width = 997
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tous les billets"
end type

event clicked;if this.checked then
	dw_listebillets.event ue_retrieve(0)
else
	dw_listebillets.event ue_retrieve(1)
end if
end event

type st_1 from statictext within w_listebillets
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Projet :"
boolean focusrectangle = false
end type

type ddlb_projets from dropdownlistbox within w_listebillets
integer x = 407
integer width = 1143
integer height = 1820
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long i = 1,ll_idprojet
string ls_projet

InsertItem('Tous',i)
il_idproj[i] = 0
i++
Declare projet cursor for
	select	id_projet,
				projet
	from		t_projets;
	
Open projet;

Fetch projet Into :ll_idprojet,:ls_projet;

Do While SQLCA.SQLCODE = 0
	InsertItem(ls_projet, i)
	il_idproj[i] = ll_idprojet
	i++
	Fetch projet Into :ll_idprojet,:ls_projet;
LOOP

Close projet;
SelectItem(0)
il_indproj = 1
end event

event selectionchanged;il_indproj = index
dw_listebillets.event ue_retrieve(1)
end event

type cb_print from commandbutton within w_listebillets
integer x = 1701
integer y = 1832
integer width = 631
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
dw_listebillets.print()
end event

type dw_listebillets from u_dw within w_listebillets
event ue_retrieve ( integer al_type )
event ue_update ( )
integer y = 104
integer width = 3593
integer height = 1724
integer taborder = 10
string title = "Liste billets"
string dataobject = "d_listebillets"
boolean hscrollbar = true
boolean border = false
boolean ib_isupdateable = false
end type

event ue_retrieve(integer al_type);long ll_idproj

if il_indproj = 1 then
	setnull(ll_idproj)
else
	ll_idproj = il_idproj[il_indproj] 
end if

Retrieve(ll_idproj,al_type)
end event

event ue_update();if update() = 1 then
	commit using sqlca;
	change = false
else
	rollback using sqlca;
	error_type(50)
end if
end event

event editchanged;call super::editchanged;change = true
end event

event itemchanged;call super::itemchanged;datawindowchild ddwc_mod

if this.getChild("id_module",ddwc_mod) = -1 then
	error_type(50)
end if
ddwc_mod.setTransObject(SQLCA)
ddwc_mod.retrieve(long(data))

change = true
end event

event constructor;call super::constructor;SetRowFocusIndicator(FocusRect!)
This.of_SetSort(True)
inv_sort.of_Setstyle(INV_SORT.SIMPLE)
inv_sort.of_Setcolumndisplaynamestyle(INV_SORT.HEADER)
inv_sort.of_Setcolumnheader(True)


end event

event doubleclicked;call super::doubleclicked;opensheetwithparm(w_billets,getitemnumber(row,'id_billet'),w_appframe,2,layered!)
end event

type cb_close from commandbutton within w_listebillets
integer x = 2962
integer y = 1832
integer width = 631
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
		dw_listebillets.event ue_update()
	end if
end if
close(parent)
end event

type cb_set from commandbutton within w_listebillets
integer y = 1832
integer width = 631
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Terminer"
end type

event clicked;//dw_billet.event ue_terminer()
end event


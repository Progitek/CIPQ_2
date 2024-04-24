$PBExportHeader$w_unlock.srw
forward
global type w_unlock from w_response
end type
type cb_2 from commandbutton within w_unlock
end type
type cb_1 from commandbutton within w_unlock
end type
type uo_toolbar from u_cst_toolbarstrip within w_unlock
end type
end forward

global type w_unlock from w_response
integer width = 1120
integer height = 1184
cb_2 cb_2
cb_1 cb_1
uo_toolbar uo_toolbar
end type
global w_unlock w_unlock

on w_unlock.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_toolbar=create uo_toolbar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_toolbar
end on

on w_unlock.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_toolbar)
end on

event open;call super::open;uo_toolbar.of_displayborder(true)
uo_toolbar.of_settheme("classics")
uo_toolbar.of_additem("Fermer","exit!")
uo_toolbar.of_displaytext(true)
end event

type cb_2 from commandbutton within w_unlock
integer x = 201
integer y = 360
integer width = 640
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Débarrer la répartition"
end type

event clicked;update t_commande set locked = 'C' where locked <> 'C';
commit;
end event

type cb_1 from commandbutton within w_unlock
integer x = 201
integer y = 196
integer width = 640
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Débarrer la punaise"
end type

event clicked;update t_centrecipq set punaise_open = 0;
commit;
end event

type uo_toolbar from u_cst_toolbarstrip within w_unlock
integer x = 9
integer y = 996
integer width = 1083
integer taborder = 10
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;close(parent)
end event


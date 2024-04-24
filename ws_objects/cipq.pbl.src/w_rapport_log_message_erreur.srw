$PBExportHeader$w_rapport_log_message_erreur.srw
forward
global type w_rapport_log_message_erreur from w_response
end type
type st_1 from statictext within w_rapport_log_message_erreur
end type
type r_2 from rectangle within w_rapport_log_message_erreur
end type
type dw_1 from u_dw within w_rapport_log_message_erreur
end type
type uo_toolbar from u_cst_toolbarstrip within w_rapport_log_message_erreur
end type
type r_1 from rectangle within w_rapport_log_message_erreur
end type
end forward

global type w_rapport_log_message_erreur from w_response
integer width = 3657
boolean controlmenu = false
long backcolor = 15780518
st_1 st_1
r_2 r_2
dw_1 dw_1
uo_toolbar uo_toolbar
r_1 r_1
end type
global w_rapport_log_message_erreur w_rapport_log_message_erreur

forward prototypes
public subroutine uf_traduction ()
end prototypes

public subroutine uf_traduction ();
uo_toolbar.of_settheme("classics")
uo_toolbar.of_displayborder(true)

if gnv_app.of_getlangue() = 'an' then
//	uo_toolbar.of_addItem("Add exam","c:\ii4net\dentitek\images\ajouter.ico")
//	uo_toolbar.of_addItem("Save","Save!")
	uo_toolbar.of_addItem("Close","Exit!")
	
else
//	uo_toolbar.of_addItem("Ajouter examen","c:\ii4net\dentitek\images\ajouter.ico")
//	uo_toolbar.of_addItem("Sauvegarder","Save!")
	uo_toolbar.of_addItem("Fermer","Exit!")
end if

uo_toolbar.of_displaytext(true)

end subroutine

on w_rapport_log_message_erreur.create
int iCurrent
call super::create
this.st_1=create st_1
this.r_2=create r_2
this.dw_1=create dw_1
this.uo_toolbar=create uo_toolbar
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.r_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.uo_toolbar
this.Control[iCurrent+5]=this.r_1
end on

on w_rapport_log_message_erreur.destroy
call super::destroy
destroy(this.st_1)
destroy(this.r_2)
destroy(this.dw_1)
destroy(this.uo_toolbar)
destroy(this.r_1)
end on

event open;call super::open;dw_1.retrieve()
end event

type st_1 from statictext within w_rapport_log_message_erreur
string tag = "resize=n"
integer x = 50
integer y = 28
integer width = 987
integer height = 88
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Logs - Messages d~'erreur"
boolean focusrectangle = false
end type

type r_2 from rectangle within w_rapport_log_message_erreur
string tag = "resize=n"
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 33554431
integer x = 23
integer y = 140
integer width = 3616
integer height = 1652
end type

type dw_1 from u_dw within w_rapport_log_message_erreur
string tag = "resize=n"
integer x = 46
integer y = 156
integer width = 3557
integer height = 1624
integer taborder = 10
string dataobject = "d_logserreur"
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type uo_toolbar from u_cst_toolbarstrip within w_rapport_log_message_erreur
string tag = "resize=n"
integer x = 23
integer y = 1800
integer width = 3616
integer taborder = 10
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event destructor;call super::destructor;call u_cst_toolbarstrip :: destroy
end event

event ue_buttonclicked;call super::ue_buttonclicked;choose case as_button
	case 'Fermer','Close'
		close(parent)
end choose 
end event

type r_1 from rectangle within w_rapport_log_message_erreur
string tag = "resize=n"
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 12
integer width = 3616
integer height = 120
end type


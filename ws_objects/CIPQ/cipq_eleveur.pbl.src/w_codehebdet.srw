$PBExportHeader$w_codehebdet.srw
forward
global type w_codehebdet from window
end type
type uo_toolbar from u_cst_toolbarstrip within w_codehebdet
end type
type dw_codehebdet from datawindow within w_codehebdet
end type
type rr_1 from roundrectangle within w_codehebdet
end type
end forward

global type w_codehebdet from window
integer width = 1723
integer height = 1484
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12639424
string icon = "AppIcon!"
boolean center = true
uo_toolbar uo_toolbar
dw_codehebdet dw_codehebdet
rr_1 rr_1
end type
global w_codehebdet w_codehebdet

type variables
string is_code
long il_eleveur
end variables

on w_codehebdet.create
this.uo_toolbar=create uo_toolbar
this.dw_codehebdet=create dw_codehebdet
this.rr_1=create rr_1
this.Control[]={this.uo_toolbar,&
this.dw_codehebdet,&
this.rr_1}
end on

on w_codehebdet.destroy
destroy(this.uo_toolbar)
destroy(this.dw_codehebdet)
destroy(this.rr_1)
end on

event open;is_code = message.stringparm
il_eleveur = long(gnv_app.inv_entrepotglobal.of_retournedonnee('noeleveur'))

dw_codehebdet.setTransObject(SQLCA)
dw_codehebdet.retrieve(is_code,il_eleveur)



//Mettre les boutons
uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

end event

type uo_toolbar from u_cst_toolbarstrip within w_codehebdet
event destroy ( )
string tag = "resize=frbsr"
integer x = 5
integer y = 1268
integer width = 1655
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long ll_row

CHOOSE CASE as_button
	CASE "Ajouter"
		ll_row = dw_codehebdet.insertrow(0)
		dw_codehebdet.setItem(ll_row,'codehebergeur',is_code)
		dw_codehebdet.setItem(ll_row,'no_eleveur',il_eleveur)
	CASE "Supprimer"
		dw_codehebdet.deleterow(dw_codehebdet.getrow())
	CASE "Enregistrer"
		dw_codehebdet.accepttext()
		dw_codehebdet.update()
	CASE "Fermer"
		close(parent)
END CHOOSE
end event

type dw_codehebdet from datawindow within w_codehebdet
integer x = 18
integer y = 160
integer width = 1641
integer height = 1080
integer taborder = 10
string title = "none"
string dataobject = "d_codehebdet"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rr_1 from roundrectangle within w_codehebdet
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15793151
integer x = 37
integer y = 32
integer width = 1627
integer height = 108
integer cornerheight = 40
integer cornerwidth = 46
end type


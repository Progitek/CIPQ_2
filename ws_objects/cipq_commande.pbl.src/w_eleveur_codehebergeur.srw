﻿$PBExportHeader$w_eleveur_codehebergeur.srw
forward
global type w_eleveur_codehebergeur from w_response
end type
type dw_eleveur_codehebergeur from u_dw within w_eleveur_codehebergeur
end type
type uo_toolbar from u_cst_toolbarstrip within w_eleveur_codehebergeur
end type
type rr_1 from roundrectangle within w_eleveur_codehebergeur
end type
end forward

global type w_eleveur_codehebergeur from w_response
integer x = 214
integer y = 221
integer width = 2185
integer height = 1296
string title = "Code d~'hébergeur pour cet éleveur"
long backcolor = 12639424
dw_eleveur_codehebergeur dw_eleveur_codehebergeur
uo_toolbar uo_toolbar
rr_1 rr_1
end type
global w_eleveur_codehebergeur w_eleveur_codehebergeur

on w_eleveur_codehebergeur.create
int iCurrent
call super::create
this.dw_eleveur_codehebergeur=create dw_eleveur_codehebergeur
this.uo_toolbar=create uo_toolbar
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_eleveur_codehebergeur
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.rr_1
end on

on w_eleveur_codehebergeur.destroy
call super::destroy
destroy(this.dw_eleveur_codehebergeur)
destroy(this.uo_toolbar)
destroy(this.rr_1)
end on

event open;call super::open;long 		ll_eleveur
string	ls_eleveur

ls_eleveur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien eleveur code hebergeur")

IF Not IsNull(ls_eleveur) AND ls_eleveur <> "" THEN
	ll_eleveur = long(ls_eleveur)
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur code hebergeur", "")
	dw_eleveur_codehebergeur.retrieve(ll_eleveur)
END IF

uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)


end event

type dw_eleveur_codehebergeur from u_dw within w_eleveur_codehebergeur
integer x = 64
integer y = 40
integer width = 2048
integer height = 976
integer taborder = 10
string dataobject = "d_eleveur_codehebergeur"
end type

type uo_toolbar from u_cst_toolbarstrip within w_eleveur_codehebergeur
event destroy ( )
integer x = 1637
integer y = 1076
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type rr_1 from roundrectangle within w_eleveur_codehebergeur
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 2135
integer height = 1024
integer cornerheight = 40
integer cornerwidth = 46
end type

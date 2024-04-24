﻿$PBExportHeader$u_tab_eleveur.sru
forward
global type u_tab_eleveur from u_tab
end type
type tabpage_eleveur_info from u_tabpg_eleveur_info within u_tab_eleveur
end type
type tabpage_eleveur_info from u_tabpg_eleveur_info within u_tab_eleveur
end type
type tabpage_eleveur_adresse from u_tabpg_eleveur_adresse within u_tab_eleveur
end type
type tabpage_eleveur_adresse from u_tabpg_eleveur_adresse within u_tab_eleveur
end type
end forward

global type u_tab_eleveur from u_tab
integer width = 4869
integer height = 2104
long backcolor = 15793151
tabpage_eleveur_info tabpage_eleveur_info
tabpage_eleveur_adresse tabpage_eleveur_adresse
end type
global u_tab_eleveur u_tab_eleveur

on u_tab_eleveur.create
this.tabpage_eleveur_info=create tabpage_eleveur_info
this.tabpage_eleveur_adresse=create tabpage_eleveur_adresse
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_eleveur_info
this.Control[iCurrent+2]=this.tabpage_eleveur_adresse
end on

on u_tab_eleveur.destroy
call super::destroy
destroy(this.tabpage_eleveur_info)
destroy(this.tabpage_eleveur_adresse)
end on

type tabpage_eleveur_info from u_tabpg_eleveur_info within u_tab_eleveur
integer x = 18
integer y = 100
integer width = 4832
integer height = 1988
string text = "Informations"
long tabbackcolor = 15793151
end type

event constructor;call super::constructor;tabpage_eleveur_info.dw_eleveur_info.Of_SetLinkage(TRUE)
tabpage_eleveur_info.dw_eleveur_info.inv_linkage.of_SetTransObject(SQLCA)


end event

type tabpage_eleveur_adresse from u_tabpg_eleveur_adresse within u_tab_eleveur
integer x = 18
integer y = 100
integer width = 4832
integer height = 1988
string text = "Adresses de facturation et de livraison, Impression des étiquettes"
long tabbackcolor = 15793151
end type

event constructor;call super::constructor;tabpage_eleveur_adresse.dw_eleveur_liv.Of_SetLinkage(TRUE)
tabpage_eleveur_adresse.dw_eleveur_liv.inv_linkage.of_setmaster( tabpage_eleveur_info.dw_eleveur_info )
tabpage_eleveur_adresse.dw_eleveur_liv.inv_linkage.of_SetTransObject(SQLCA)
tabpage_eleveur_adresse.dw_eleveur_liv.inv_linkage.of_SetStyle(tabpage_eleveur_adresse.dw_eleveur_liv.inv_Linkage.RETRIEVE)
tabpage_eleveur_adresse.dw_eleveur_liv.inv_linkage.of_Register("no_eleveur","no_eleveur")
end event


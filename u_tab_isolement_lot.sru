HA$PBExportHeader$u_tab_isolement_lot.sru
forward
global type u_tab_isolement_lot from u_tab
end type
type tabpage_isolement_principal from u_tabpg_isolement_principal within u_tab_isolement_lot
end type
type tabpage_isolement_principal from u_tabpg_isolement_principal within u_tab_isolement_lot
end type
type tabpage_isolement_calendrier from u_tabpg_isolement_calendrier within u_tab_isolement_lot
end type
type tabpage_isolement_calendrier from u_tabpg_isolement_calendrier within u_tab_isolement_lot
end type
type tabpage_isolement_calendrier_avril2007 from u_tabpg_isolement_calendrier_avril2007 within u_tab_isolement_lot
end type
type tabpage_isolement_calendrier_avril2007 from u_tabpg_isolement_calendrier_avril2007 within u_tab_isolement_lot
end type
type tabpage_isolement_calendrier_aout2009 from u_tabpg_isolement_calendrier_aout2009 within u_tab_isolement_lot
end type
type tabpage_isolement_calendrier_aout2009 from u_tabpg_isolement_calendrier_aout2009 within u_tab_isolement_lot
end type
type tabpage_isolement_calendrier_fevrier2010 from u_tabpg_isolement_calendrier_fevrier2010 within u_tab_isolement_lot
end type
type tabpage_isolement_calendrier_fevrier2010 from u_tabpg_isolement_calendrier_fevrier2010 within u_tab_isolement_lot
end type
type tabpage_isolement_liste from u_tabpg_isolement_liste within u_tab_isolement_lot
end type
type tabpage_isolement_liste from u_tabpg_isolement_liste within u_tab_isolement_lot
end type
end forward

global type u_tab_isolement_lot from u_tab
integer width = 2665
integer height = 1236
long backcolor = 15793151
tabpage_isolement_principal tabpage_isolement_principal
tabpage_isolement_calendrier tabpage_isolement_calendrier
tabpage_isolement_calendrier_avril2007 tabpage_isolement_calendrier_avril2007
tabpage_isolement_calendrier_aout2009 tabpage_isolement_calendrier_aout2009
tabpage_isolement_calendrier_fevrier2010 tabpage_isolement_calendrier_fevrier2010
tabpage_isolement_liste tabpage_isolement_liste
end type
global u_tab_isolement_lot u_tab_isolement_lot

on u_tab_isolement_lot.create
this.tabpage_isolement_principal=create tabpage_isolement_principal
this.tabpage_isolement_calendrier=create tabpage_isolement_calendrier
this.tabpage_isolement_calendrier_avril2007=create tabpage_isolement_calendrier_avril2007
this.tabpage_isolement_calendrier_aout2009=create tabpage_isolement_calendrier_aout2009
this.tabpage_isolement_calendrier_fevrier2010=create tabpage_isolement_calendrier_fevrier2010
this.tabpage_isolement_liste=create tabpage_isolement_liste
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_isolement_principal
this.Control[iCurrent+2]=this.tabpage_isolement_calendrier
this.Control[iCurrent+3]=this.tabpage_isolement_calendrier_avril2007
this.Control[iCurrent+4]=this.tabpage_isolement_calendrier_aout2009
this.Control[iCurrent+5]=this.tabpage_isolement_calendrier_fevrier2010
this.Control[iCurrent+6]=this.tabpage_isolement_liste
end on

on u_tab_isolement_lot.destroy
call super::destroy
destroy(this.tabpage_isolement_principal)
destroy(this.tabpage_isolement_calendrier)
destroy(this.tabpage_isolement_calendrier_avril2007)
destroy(this.tabpage_isolement_calendrier_aout2009)
destroy(this.tabpage_isolement_calendrier_fevrier2010)
destroy(this.tabpage_isolement_liste)
end on

type tabpage_isolement_principal from u_tabpg_isolement_principal within u_tab_isolement_lot
integer x = 18
integer y = 100
integer width = 2629
integer height = 1120
string text = "Informations g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rales"
end type

event constructor;call super::constructor;tabpage_isolement_principal.dw_isolement_principal.Of_SetLinkage(TRUE)
tabpage_isolement_principal.dw_isolement_principal.inv_linkage.of_SetTransObject(SQLCA)
end event

type tabpage_isolement_calendrier from u_tabpg_isolement_calendrier within u_tab_isolement_lot
integer x = 18
integer y = 100
integer width = 2629
integer height = 1120
string text = "Calendrier de suivi de l~'isolement"
long tabbackcolor = 15793151
end type

event constructor;call super::constructor;tabpage_isolement_calendrier.dw_isolement_calendrier.Of_SetLinkage(TRUE)
tabpage_isolement_calendrier.dw_isolement_calendrier.inv_linkage.of_SetMaster(tabpage_isolement_principal.dw_isolement_principal)
tabpage_isolement_calendrier.dw_isolement_calendrier.inv_linkage.of_SetTransObject(SQLCA)
tabpage_isolement_calendrier.dw_isolement_calendrier.inv_Linkage.of_SetStyle(tabpage_isolement_calendrier.dw_isolement_calendrier.inv_Linkage.RETRIEVE)
tabpage_isolement_calendrier.dw_isolement_calendrier.inv_linkage.of_Register("nolot","nolot")

end event

type tabpage_isolement_calendrier_avril2007 from u_tabpg_isolement_calendrier_avril2007 within u_tab_isolement_lot
integer x = 18
integer y = 100
integer width = 2629
integer height = 1120
string text = "Calendrier de suivi de l~'isolement (f$$HEX1$$e900$$ENDHEX$$vrier 2008)"
long tabbackcolor = 15793151
end type

event constructor;call super::constructor;tabpage_isolement_calendrier_avril2007.dw_isolement_calendrier_avril2007.Of_SetLinkage(TRUE)
tabpage_isolement_calendrier_avril2007.dw_isolement_calendrier_avril2007.inv_linkage.of_SetMaster(tabpage_isolement_principal.dw_isolement_principal)
tabpage_isolement_calendrier_avril2007.dw_isolement_calendrier_avril2007.inv_linkage.of_SetTransObject(SQLCA)
tabpage_isolement_calendrier_avril2007.dw_isolement_calendrier_avril2007.inv_Linkage.of_SetStyle(tabpage_isolement_calendrier_avril2007.dw_isolement_calendrier_avril2007.inv_Linkage.RETRIEVE)
tabpage_isolement_calendrier_avril2007.dw_isolement_calendrier_avril2007.inv_linkage.of_Register("nolot","nolot")

end event

type tabpage_isolement_calendrier_aout2009 from u_tabpg_isolement_calendrier_aout2009 within u_tab_isolement_lot
integer x = 18
integer y = 100
integer width = 2629
integer height = 1120
string text = "Calendrier de suivi de l~'isolement (ao$$HEX1$$fb00$$ENDHEX$$t 2009)"
long tabbackcolor = 15793151
end type

event constructor;call super::constructor;tabpage_isolement_calendrier_aout2009.dw_isolement_calendrier_aout2009.Of_SetLinkage(TRUE)
tabpage_isolement_calendrier_aout2009.dw_isolement_calendrier_aout2009.inv_linkage.of_SetMaster(tabpage_isolement_principal.dw_isolement_principal)
tabpage_isolement_calendrier_aout2009.dw_isolement_calendrier_aout2009.inv_linkage.of_SetTransObject(SQLCA)
tabpage_isolement_calendrier_aout2009.dw_isolement_calendrier_aout2009.inv_Linkage.of_SetStyle(tabpage_isolement_calendrier_aout2009.dw_isolement_calendrier_aout2009.inv_Linkage.RETRIEVE)
tabpage_isolement_calendrier_aout2009.dw_isolement_calendrier_aout2009.inv_linkage.of_Register("nolot","nolot")

end event

type tabpage_isolement_calendrier_fevrier2010 from u_tabpg_isolement_calendrier_fevrier2010 within u_tab_isolement_lot
integer x = 18
integer y = 100
integer width = 2629
integer height = 1120
string text = "Calendrier de suivi de l~'isolement (f$$HEX1$$e900$$ENDHEX$$vrier 2010)"
long tabbackcolor = 15793151
end type

event constructor;call super::constructor;tabpage_isolement_calendrier_fevrier2010.dw_isolement_calendrier_fevrier2010.Of_SetLinkage(TRUE)
tabpage_isolement_calendrier_fevrier2010.dw_isolement_calendrier_fevrier2010.inv_linkage.of_SetMaster(tabpage_isolement_principal.dw_isolement_principal)
tabpage_isolement_calendrier_fevrier2010.dw_isolement_calendrier_fevrier2010.inv_linkage.of_SetTransObject(SQLCA)
tabpage_isolement_calendrier_fevrier2010.dw_isolement_calendrier_fevrier2010.inv_Linkage.of_SetStyle(tabpage_isolement_calendrier_fevrier2010.dw_isolement_calendrier_fevrier2010.inv_Linkage.RETRIEVE)
tabpage_isolement_calendrier_fevrier2010.dw_isolement_calendrier_fevrier2010.inv_linkage.of_Register("nolot","nolot")
end event

type tabpage_isolement_liste from u_tabpg_isolement_liste within u_tab_isolement_lot
integer x = 18
integer y = 100
integer width = 2629
integer height = 1120
string text = "Liste des verrats, dossier et $$HEX1$$e900$$ENDHEX$$tat physique"
long tabbackcolor = 15793151
end type

event constructor;call super::constructor;tabpage_isolement_liste.dw_isolement_verrat.Of_SetLinkage(TRUE)
tabpage_isolement_liste.dw_isolement_verrat.inv_linkage.of_SetMaster(tabpage_isolement_principal.dw_isolement_principal)
tabpage_isolement_liste.dw_isolement_verrat.inv_linkage.of_SetTransObject(SQLCA)
tabpage_isolement_liste.dw_isolement_verrat.inv_Linkage.of_SetStyle(tabpage_isolement_liste.dw_isolement_verrat.inv_Linkage.RETRIEVE)
tabpage_isolement_liste.dw_isolement_verrat.inv_linkage.of_Register("nolot","nolot")

//tabpage_isolement_liste.dw_isolement_verrat_detail.Of_SetLinkage(TRUE)
//tabpage_isolement_liste.dw_isolement_verrat_detail.inv_linkage.of_SetMaster(tabpage_isolement_liste.dw_isolement_verrat)
//tabpage_isolement_liste.dw_isolement_verrat_detail.inv_linkage.of_SetTransObject(SQLCA)
//tabpage_isolement_liste.dw_isolement_verrat_detail.inv_Linkage.of_SetStyle(tabpage_isolement_liste.dw_isolement_verrat_detail.inv_Linkage.RETRIEVE)
//tabpage_isolement_liste.dw_isolement_verrat_detail.inv_linkage.of_Register("nolot","nolot")
//tabpage_isolement_liste.dw_isolement_verrat_detail.inv_linkage.of_Register("tatouage","tatouage")

tabpage_isolement_liste.dw_isolement_etat_physique.Of_SetLinkage(TRUE)
tabpage_isolement_liste.dw_isolement_etat_physique.inv_linkage.of_SetMaster(tabpage_isolement_liste.dw_isolement_verrat)
tabpage_isolement_liste.dw_isolement_etat_physique.inv_linkage.of_SetTransObject(SQLCA)
tabpage_isolement_liste.dw_isolement_etat_physique.inv_Linkage.of_SetStyle(tabpage_isolement_liste.dw_isolement_etat_physique.inv_Linkage.RETRIEVE)
tabpage_isolement_liste.dw_isolement_etat_physique.inv_linkage.of_Register("nolot","nolot")
tabpage_isolement_liste.dw_isolement_etat_physique.inv_linkage.of_Register("tatouage","tatouage")

end event


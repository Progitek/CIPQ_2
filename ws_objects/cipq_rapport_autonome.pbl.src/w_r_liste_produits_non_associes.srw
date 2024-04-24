﻿$PBExportHeader$w_r_liste_produits_non_associes.srw
forward
global type w_r_liste_produits_non_associes from w_rapport
end type
end forward

global type w_r_liste_produits_non_associes from w_rapport
string title = "Rapport - Liste des produits non-associés à une race"
end type
global w_r_liste_produits_non_associes w_r_liste_produits_non_associes

on w_r_liste_produits_non_associes.create
call super::create
end on

on w_r_liste_produits_non_associes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;
dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

dw_preview.retrieve( )
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_produits_non_associes
string dataobject = "d_r_liste_produits_non_associes"
end type

event dw_preview::constructor;call super::constructor;//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID
lnv_menu.of_GetMenuReference (lm_menu,"m_tiri", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_trier", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event


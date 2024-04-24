﻿$PBExportHeader$w_r_som_moy_com_orig_melange_ext.srw
forward
global type w_r_som_moy_com_orig_melange_ext from w_rapport
end type
end forward

global type w_r_som_moy_com_orig_melange_ext from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Sommaire des moyennes des commandes originales de mélange avec extensions"
end type
global w_r_som_moy_com_orig_melange_ext w_r_som_moy_com_orig_melange_ext

on w_r_som_moy_com_orig_melange_ext.create
call super::create
end on

on w_r_som_moy_com_orig_melange_ext.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
string	ls_cur

ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

gnv_app.of_domoyennecommande_orig_mel(date(ls_cur))

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(date(ls_cur))
end event

type dw_preview from w_rapport`dw_preview within w_r_som_moy_com_orig_melange_ext
string dataobject = "d_r_som_moy_com_orig_melange_ext"
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

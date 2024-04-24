﻿$PBExportHeader$w_r_liste_code_prepose.srw
forward
global type w_r_liste_code_prepose from w_rapport
end type
end forward

global type w_r_liste_code_prepose from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Liste des codes de préposés à la récoltes"
end type
global w_r_liste_code_prepose w_r_liste_code_prepose

on w_r_liste_code_prepose.create
call super::create
end on

on w_r_liste_code_prepose.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(HourGlass!)
ll_nb = dw_preview.retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_code_prepose
string dataobject = "d_r_liste_code_prepose"
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

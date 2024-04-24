﻿$PBExportHeader$w_r_liste_verrat_lus_non_entre.srw
forward
global type w_r_liste_verrat_lus_non_entre from w_rapport
end type
end forward

global type w_r_liste_verrat_lus_non_entre from w_rapport
string title = "Rapport - Liste des verrats lus dans la verraterie mais non-entré dans les récoltes"
end type
global w_r_liste_verrat_lus_non_entre w_r_liste_verrat_lus_non_entre

on w_r_liste_verrat_lus_non_entre.create
call super::create
end on

on w_r_liste_verrat_lus_non_entre.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb

dw_preview.of_SetTri(TRUE)


SetPointer(HourGlass!)
ll_nb = dw_preview.retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_verrat_lus_non_entre
string dataobject = "d_r_liste_verrat_lus_non_entre"
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

end event


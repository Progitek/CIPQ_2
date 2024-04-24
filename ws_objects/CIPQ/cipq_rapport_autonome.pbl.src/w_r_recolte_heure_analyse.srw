﻿$PBExportHeader$w_r_recolte_heure_analyse.srw
forward
global type w_r_recolte_heure_analyse from w_rapport
end type
end forward

global type w_r_recolte_heure_analyse from w_rapport
string title = "Rapport - Temps d~'attente entre les récoltes"
end type
global w_r_recolte_heure_analyse w_r_recolte_heure_analyse

on w_r_recolte_heure_analyse.create
call super::create
end on

on w_r_recolte_heure_analyse.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
date		ld_de

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")


dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve( ld_de )
end event

type dw_preview from w_rapport`dw_preview within w_r_recolte_heure_analyse
string dataobject = "d_r_recolte_heure_analyse"
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


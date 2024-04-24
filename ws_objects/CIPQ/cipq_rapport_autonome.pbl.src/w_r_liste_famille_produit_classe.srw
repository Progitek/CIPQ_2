$PBExportHeader$w_r_liste_famille_produit_classe.srw
forward
global type w_r_liste_famille_produit_classe from w_rapport
end type
end forward

global type w_r_liste_famille_produit_classe from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Liste des familles des produits avec les classes de verrats"
end type
global w_r_liste_famille_produit_classe w_r_liste_famille_produit_classe

on w_r_liste_famille_produit_classe.create
call super::create
end on

on w_r_liste_famille_produit_classe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb

SetPointer(HourGlass!)
dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_famille_produit_classe
string dataobject = "d_r_liste_famille_produit_classe"
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


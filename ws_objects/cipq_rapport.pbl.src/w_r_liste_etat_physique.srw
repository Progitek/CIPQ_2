$PBExportHeader$w_r_liste_etat_physique.srw
forward
global type w_r_liste_etat_physique from w_rapport
end type
end forward

global type w_r_liste_etat_physique from w_rapport
end type
global w_r_liste_etat_physique w_r_liste_etat_physique

on w_r_liste_etat_physique.create
call super::create
end on

on w_r_liste_etat_physique.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long ll_nolot

ll_nolot = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien lot"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", "")

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(HourGlass!)
dw_preview.retrieve(ll_nolot)
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_etat_physique
string dataobject = "d_r_liste_etat_physique"
end type

event dw_preview::constructor;call super::constructor;//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID
lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event


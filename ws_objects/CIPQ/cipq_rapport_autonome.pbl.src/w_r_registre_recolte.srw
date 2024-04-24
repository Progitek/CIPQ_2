$PBExportHeader$w_r_registre_recolte.srw
forward
global type w_r_registre_recolte from w_rapport
end type
end forward

global type w_r_registre_recolte from w_rapport
string title = "Rapport - Régistre des récoltes"
end type
global w_r_registre_recolte w_r_registre_recolte

on w_r_registre_recolte.create
call super::create
end on

on w_r_registre_recolte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long	ll_nb
date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

SetPointer(Hourglass!)

gnv_app.of_doregistrerecolte( ld_de, ld_au)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()


SetPointer(HourGlass!)

ll_nb = dw_preview.retrieve(ld_de, ld_au )
end event

type dw_preview from w_rapport`dw_preview within w_r_registre_recolte
string dataobject = "d_r_registre_recolte"
end type

event dw_preview::constructor;call super::constructor;//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID
lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event


$PBExportHeader$w_r_expedition_hebergement_som.srw
forward
global type w_r_expedition_hebergement_som from w_rapport
end type
end forward

global type w_r_expedition_hebergement_som from w_rapport
string title = "Rapport - Expéditions CIPQ Éleveur"
end type
global w_r_expedition_hebergement_som w_r_expedition_hebergement_som

on w_r_expedition_hebergement_som.create
call super::create
end on

on w_r_expedition_hebergement_som.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
string	ls_cie
date		ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")
ls_cie = gnv_app.inv_entrepotglobal.of_retournedonnee("lien centre rapport")
IF ls_cie = "" OR lower(ls_cie) = "tous" THEN SetNull(ls_cie)

SetPointer(Hourglass!)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(datetime(ld_de, 00:00:00), datetime(ld_au, 23:59:59.999999), ls_cie )
end event

type dw_preview from w_rapport`dw_preview within w_r_expedition_hebergement_som
string dataobject = "d_r_expedition_hebergement_som"
end type

event dw_preview::constructor;call super::constructor;//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID

lnv_menu.of_GetMenuReference (lm_menu,"m_trier", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event


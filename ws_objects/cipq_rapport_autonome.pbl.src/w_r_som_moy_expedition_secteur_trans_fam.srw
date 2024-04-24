$PBExportHeader$w_r_som_moy_expedition_secteur_trans_fam.srw
forward
global type w_r_som_moy_expedition_secteur_trans_fam from w_rapport
end type
end forward

global type w_r_som_moy_expedition_secteur_trans_fam from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Sommaire des moyennes des expéditions par secteur de transporteur et famille"
end type
global w_r_som_moy_expedition_secteur_trans_fam w_r_som_moy_expedition_secteur_trans_fam

on w_r_som_moy_expedition_secteur_trans_fam.create
call super::create
end on

on w_r_som_moy_expedition_secteur_trans_fam.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

gnv_app.of_DoMoyenneExpTransporteur(ld_de)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de )
end event

type dw_preview from w_rapport`dw_preview within w_r_som_moy_expedition_secteur_trans_fam
string dataobject = "d_r_som_moy_expedition_secteur_trans_fam"
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


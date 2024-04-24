$PBExportHeader$w_r_production_sperm_verrat_journaliere.srw
forward
global type w_r_production_sperm_verrat_journaliere from w_rapport
end type
end forward

global type w_r_production_sperm_verrat_journaliere from w_rapport
integer x = 214
integer y = 221
end type
global w_r_production_sperm_verrat_journaliere w_r_production_sperm_verrat_journaliere

event pfc_postopen;call super::pfc_postopen;date	ld_de

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

dw_preview.retrieve(ld_de)
end event

on w_r_production_sperm_verrat_journaliere.create
call super::create
end on

on w_r_production_sperm_verrat_journaliere.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_preview from w_rapport`dw_preview within w_r_production_sperm_verrat_journaliere
string dataobject = "d_r_production_sperm_verrat_journaliere"
end type

event dw_preview::constructor;call super::constructor;//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID

lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event


$PBExportHeader$w_r_stat_vente_dose_montant_client.srw
forward
global type w_r_stat_vente_dose_montant_client from w_rapport
end type
end forward

global type w_r_stat_vente_dose_montant_client from w_rapport
string title = "Rapport - Statistiques de ventes par clients/produits"
end type
global w_r_stat_vente_dose_montant_client w_r_stat_vente_dose_montant_client

on w_r_stat_vente_dose_montant_client.create
call super::create
end on

on w_r_stat_vente_dose_montant_client.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
date		ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")


//#temp_sta_ven_domo_cli_statfacture et #temp_sta_ven_domo_cli_statfactureDetail
gnv_app.of_Cree_TableFact_Temp("temp_sta_ven_domo_cli_statfacture")

//Première extraction
INSERT INTO #temp_sta_ven_domo_cli_statfacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE date(t_StatFacture.LIV_DATE) >= :ld_de
And date(t_StatFacture.LIV_DATE) <= :ld_au ;
COMMIT USING SQLCA;

SetPointer(Hourglass!)

//#temp_sta_ven_domo_cli_statfactureDetail
INSERT INTO #temp_sta_ven_domo_cli_statfactureDetail SELECT t_StatFactureDetail.* 
FROM #temp_sta_ven_domo_cli_statfacture 
INNER JOIN t_StatFactureDetail 
ON (#temp_sta_ven_domo_cli_statfacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#temp_sta_ven_domo_cli_statfacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;

SetPointer(Hourglass!)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve( ld_de, ld_au)
end event

type dw_preview from w_rapport`dw_preview within w_r_stat_vente_dose_montant_client
string dataobject = "d_r_stat_vente_dose_montant_client"
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


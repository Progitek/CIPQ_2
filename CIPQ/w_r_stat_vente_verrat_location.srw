HA$PBExportHeader$w_r_stat_vente_verrat_location.srw
forward
global type w_r_stat_vente_verrat_location from w_rapport
end type
end forward

global type w_r_stat_vente_verrat_location from w_rapport
string title = "Rapport - Statistiques de ventes par verrat / location"
end type
global w_r_stat_vente_verrat_location w_r_stat_vente_verrat_location

on w_r_stat_vente_verrat_location.create
call super::create
end on

on w_r_stat_vente_verrat_location.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long	ll_nb, ll_year_de, ll_year_au
date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

ll_year_de = year(ld_de)
ll_year_au = year(ld_au)

//#temp_sta_ven_velo_statfacture et #temp_sta_ven_velo_statfactureDetail
gnv_app.of_Cree_TableFact_Temp("temp_sta_ven_velo_statfacture")

//Premi$$HEX1$$e800$$ENDHEX$$re extraction
INSERT INTO #temp_sta_ven_velo_statfacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE year(t_StatFacture.LIV_DATE) >= :ll_year_de
And date(t_StatFacture.LIV_DATE) <= :ld_au ;
COMMIT USING SQLCA;

SetPointer(Hourglass!)

//#temp_sta_ven_velo_statfactureDetail
INSERT INTO #temp_sta_ven_velo_statfactureDetail SELECT t_StatFactureDetail.* 
FROM #temp_sta_ven_velo_statfacture 
INNER JOIN t_StatFactureDetail 
ON (#temp_sta_ven_velo_statfacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#temp_sta_ven_velo_statfacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;

SetPointer(Hourglass!)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve( ld_de, ld_au)
end event

type dw_preview from w_rapport`dw_preview within w_r_stat_vente_verrat_location
string dataobject = "d_r_stat_vente_verrat_location"
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


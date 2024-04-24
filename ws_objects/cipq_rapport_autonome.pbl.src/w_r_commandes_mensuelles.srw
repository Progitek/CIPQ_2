﻿$PBExportHeader$w_r_commandes_mensuelles.srw
forward
global type w_r_commandes_mensuelles from w_rapport
end type
end forward

global type w_r_commandes_mensuelles from w_rapport
string title = "Rapport - Commandes mensuelles"
end type
global w_r_commandes_mensuelles w_r_commandes_mensuelles

on w_r_commandes_mensuelles.create
call super::create
end on

on w_r_commandes_mensuelles.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long	ll_nb, ll_month, ll_year
date	ld_de

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

SetPointer(Hourglass!)

//#temp_com_men_statfacture et #temp_com_men_statfactureDetail
gnv_app.of_Cree_TableFact_Temp("temp_com_men_statfacture")

ll_month = month(ld_de)
ll_year = year(ld_de)

//Première extraction
INSERT INTO #temp_com_men_statfacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE month(t_StatFacture.LIV_DATE) = :ll_month AND year(t_StatFacture.LIV_DATE) = :ll_year;
COMMIT USING SQLCA;

//#temp_com_men_statfactureDetail
INSERT INTO #temp_com_men_statfactureDetail SELECT t_StatFactureDetail.* 
FROM #temp_com_men_statfacture 
INNER JOIN t_StatFactureDetail 
ON (#temp_com_men_statfacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#temp_com_men_statfacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;


dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de)
end event

type dw_preview from w_rapport`dw_preview within w_r_commandes_mensuelles
string dataobject = "d_r_commandes_mensuelles"
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

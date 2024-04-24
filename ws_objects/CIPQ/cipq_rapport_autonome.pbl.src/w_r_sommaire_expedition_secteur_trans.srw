﻿$PBExportHeader$w_r_sommaire_expedition_secteur_trans.srw
forward
global type w_r_sommaire_expedition_secteur_trans from w_rapport
end type
end forward

global type w_r_sommaire_expedition_secteur_trans from w_rapport
string title = "Rapport - Sommaire des expéditions par secteur de transporteur"
end type
global w_r_sommaire_expedition_secteur_trans w_r_sommaire_expedition_secteur_trans

on w_r_sommaire_expedition_secteur_trans.create
call super::create
end on

on w_r_sommaire_expedition_secteur_trans.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

//#temp_som_exp_sec_statfacture et #temp_som_exp_sec_statfactureDetail
gnv_app.of_Cree_TableFact_Temp("temp_som_exp_sec_statfacture")

//Première extraction
INSERT INTO #temp_som_exp_sec_statfacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE date(t_StatFacture.LIV_DATE) >= :ld_de
And date(t_StatFacture.LIV_DATE) <= :ld_au ;
COMMIT USING SQLCA;

//#temp_som_exp_sec_statfactureDetail
INSERT INTO #temp_som_exp_sec_statfactureDetail SELECT t_StatFactureDetail.* 
FROM #temp_som_exp_sec_statfacture 
INNER JOIN t_StatFactureDetail 
ON (#temp_som_exp_sec_statfacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#temp_som_exp_sec_statfacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;


dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de, ld_au )
end event

type dw_preview from w_rapport`dw_preview within w_r_sommaire_expedition_secteur_trans
string dataobject = "d_r_sommaire_expedition_secteur_trans"
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

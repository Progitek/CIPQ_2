﻿$PBExportHeader$w_r_commandes_journalieres.srw
forward
global type w_r_commandes_journalieres from w_rapport
end type
end forward

global type w_r_commandes_journalieres from w_rapport
string title = "Rapport - Commandes journalières"
end type
global w_r_commandes_journalieres w_r_commandes_journalieres

on w_r_commandes_journalieres.create
call super::create
end on

on w_r_commandes_journalieres.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long	ll_nb
date	ld_de

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

//#temp_com_jou_statfacture et #temp_com_jou_statfactureDetail
gnv_app.of_Cree_TableFact_Temp("temp_com_jou_statfacture")

SetPointer(Hourglass!)

//Première extraction
INSERT INTO #temp_com_jou_statfacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE date(t_StatFacture.LIV_DATE) = :ld_de;
COMMIT USING SQLCA;

//#temp_com_jou_statfactureDetail
INSERT INTO #temp_com_jou_statfactureDetail SELECT t_StatFactureDetail.* 
FROM #temp_com_jou_statfacture 
INNER JOIN t_StatFactureDetail 
ON (#temp_com_jou_statfacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#temp_com_jou_statfacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de)
end event

type dw_preview from w_rapport`dw_preview within w_r_commandes_journalieres
string dataobject = "d_r_commandes_journalieres"
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


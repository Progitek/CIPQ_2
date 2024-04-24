﻿$PBExportHeader$w_r_quantite_non_expediee.srw
forward
global type w_r_quantite_non_expediee from w_rapport
end type
end forward

global type w_r_quantite_non_expediee from w_rapport
string title = "Rapport - Quantité non-expédiée par produit"
end type
global w_r_quantite_non_expediee w_r_quantite_non_expediee

on w_r_quantite_non_expediee.create
call super::create
end on

on w_r_quantite_non_expediee.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
date		ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")

ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

SetPointer(Hourglass!)

//#temp_qua_non_exp_statfacture et #temp_qua_non_exp_statfactureDetail
gnv_app.of_Cree_TableFact_Temp("temp_qua_non_exp_statfacture")

SetPointer(Hourglass!)

//Première extraction
INSERT INTO #temp_qua_non_exp_statfacture 
SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE date(t_StatFacture.LIV_DATE)>= :ld_de And date(t_StatFacture.LIV_DATE) <= :ld_au ;
Commit USING SQLCA;

SetPointer(Hourglass!)

//extraction du détail '#temp_qua_non_exp_statfactureDetail'
INSERT INTO #temp_qua_non_exp_statfactureDetail SELECT t_StatFactureDetail.* 
FROM t_StatFacture INNER JOIN t_StatFactureDetail ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO) 
WHERE date(t_StatFacture.LIV_DATE) >= :ld_de And date(t_StatFacture.LIV_DATE) <= :ld_au ;
Commit USING SQLCA;


dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(ld_de, ld_au)
end event

type dw_preview from w_rapport`dw_preview within w_r_quantite_non_expediee
string dataobject = "d_r_quantite_non_expediee"
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

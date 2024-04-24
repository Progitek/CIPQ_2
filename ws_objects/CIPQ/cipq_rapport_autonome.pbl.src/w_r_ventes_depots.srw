﻿$PBExportHeader$w_r_ventes_depots.srw
forward
global type w_r_ventes_depots from w_rapport
end type
end forward

global type w_r_ventes_depots from w_rapport
string title = "Rapport - Ventes des dépôts"
end type
global w_r_ventes_depots w_r_ventes_depots

on w_r_ventes_depots.create
call super::create
end on

on w_r_ventes_depots.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long		ll_nb, ll_month, ll_year
string	ls_cur

ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

ll_month = month(date(ls_cur))
ll_year = year(date(ls_cur))

SetPointer(Hourglass!)

//#temp_ven_dep_StatFacture et #temp_ven_dep_StatFactureDetail
gnv_app.of_Cree_TableFact_Temp("temp_ven_dep_StatFacture")

SetPointer(Hourglass!)

//Première extraction
INSERT INTO #temp_ven_dep_StatFacture SELECT distinct t_StatFacture.* 
FROM t_StatFacture 
INNER JOIN t_StatFactureDetail 
ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO) 
WHERE t_StatFactureDetail.Id_Depot Is Not Null 
AND Month(Date_Expedie_Depot) = :ll_month 
AND Year(Date_Expedie_Depot) = :ll_year ;
COMMIT USING SQLCA;

SetPointer(Hourglass!)

INSERT INTO #temp_ven_dep_StatFactureDetail SELECT t_StatFactureDetail.* 
FROM #temp_ven_dep_StatFacture 
INNER JOIN t_StatFactureDetail 
ON (#temp_ven_dep_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#temp_ven_dep_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(date(ls_cur))
end event

event pfc_preopen;call super::pfc_preopen;//Vider les ta
end event

type dw_preview from w_rapport`dw_preview within w_r_ventes_depots
string dataobject = "d_r_ventes_depots"
end type


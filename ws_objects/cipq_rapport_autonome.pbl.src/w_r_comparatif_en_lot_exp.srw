$PBExportHeader$w_r_comparatif_en_lot_exp.srw
forward
global type w_r_comparatif_en_lot_exp from w_rapport
end type
end forward

global type w_r_comparatif_en_lot_exp from w_rapport
string title = "Rapport - Comparatif des quantitées mises en lot et expédiées par famille de produit"
end type
global w_r_comparatif_en_lot_exp w_r_comparatif_en_lot_exp

on w_r_comparatif_en_lot_exp.create
call super::create
end on

on w_r_comparatif_en_lot_exp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
date		ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

//#temp_com_en_lot_statfacture et #temp_com_en_lot_statfactureDetail
gnv_app.of_Cree_TableFact_Temp("temp_com_en_lot_statfacture")

//Première extraction
INSERT INTO #temp_com_en_lot_statfacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE date(t_StatFacture.FACT_DATE) >= :ld_de
And date(t_StatFacture.FACT_DATE) <= :ld_au ;
COMMIT USING SQLCA;

SetPointer(Hourglass!)

//#temp_com_en_lot_statfactureDetail
INSERT INTO #temp_com_en_lot_statfactureDetail SELECT t_StatFactureDetail.* 
FROM #temp_com_en_lot_statfacture 
INNER JOIN t_StatFactureDetail 
ON (#temp_com_en_lot_statfacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#temp_com_en_lot_statfacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de, ld_au )
end event

type dw_preview from w_rapport`dw_preview within w_r_comparatif_en_lot_exp
string dataobject = "d_r_comparatif_en_lot_exp"
end type


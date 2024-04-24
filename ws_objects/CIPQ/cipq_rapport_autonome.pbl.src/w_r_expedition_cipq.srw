$PBExportHeader$w_r_expedition_cipq.srw
forward
global type w_r_expedition_cipq from w_rapport
end type
end forward

global type w_r_expedition_cipq from w_rapport
string title = "Rapport - Expéditions CIPQ"
end type
global w_r_expedition_cipq w_r_expedition_cipq

on w_r_expedition_cipq.create
call super::create
end on

on w_r_expedition_cipq.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long	ll_nb
date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

//#Temp_exped_cipq_StatFacture et #Temp_exped_cipq_StatFactureDetail
gnv_app.of_Cree_TableFact_Temp("Temp_exped_cipq_StatFacture")

//Première extraction
INSERT INTO #Temp_exped_cipq_StatFacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE date(t_StatFacture.FACT_DATE) >= :ld_de
And date(t_StatFacture.FACT_DATE) <= :ld_au ;
COMMIT USING SQLCA;

SetPointer(Hourglass!)

//#Temp_exped_cipq_StatFactureDetail
INSERT INTO #Temp_exped_cipq_StatFactureDetail SELECT t_StatFactureDetail.* 
FROM #Temp_exped_cipq_StatFacture 
INNER JOIN t_StatFactureDetail 
ON (#Temp_exped_cipq_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#Temp_exped_cipq_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;

SetPointer(Hourglass!)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de, ld_au )
end event

type dw_preview from w_rapport`dw_preview within w_r_expedition_cipq
string dataobject = "d_r_expedition_cipq"
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

event dw_preview::pfc_filterdlg;call super::pfc_filterdlg;string	ls_filtre

//Vérifier si filtre_t est présent
IF THIS.of_objetexiste("filtre_t") = TRUE THEN
	ls_filtre = gnv_app.inv_entrepotglobal.of_retournedonnee("Filtre affichage", FALSE)
	IF POS(ls_filtre, "sous-groupe") > 0 THEN
		dw_preview.object.idgroupsecondaire_t.visible = 1
		dw_preview.object.nomgroupsecondaire.visible = 1
	ELSE
		dw_preview.object.idgroupsecondaire_t.visible = 0
		dw_preview.object.nomgroupsecondaire.visible = 0		
	END IF
END IF

RETURN AncestorReturnValue
end event


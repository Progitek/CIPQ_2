﻿$PBExportHeader$w_r_sommaire_facture_groupe.srw
forward
global type w_r_sommaire_facture_groupe from w_rapport
end type
end forward

global type w_r_sommaire_facture_groupe from w_rapport
string title = "Rapport - Sommaire des factures par groupe"
string menuname = "m_rapport_transfert"
event ue_transfertinternet ( )
end type
global w_r_sommaire_facture_groupe w_r_sommaire_facture_groupe

event ue_transfertinternet();gnv_app.inv_transfert_internet.of_transfertsommairefacture(dw_preview)
end event

on w_r_sommaire_facture_groupe.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_rapport_transfert" then this.MenuID = create m_rapport_transfert
end on

on w_r_sommaire_facture_groupe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
string	ls_cur
date		ld_cur

ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")
ld_cur = date(ls_cur)

SetPointer(Hourglass!)

//Préparer la table temporaire
gnv_app.of_Cree_TableFact_Temp("Temp_som_fact_grp_StatFacture")

INSERT INTO #Temp_som_fact_grp_StatFacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE t_StatFacture.FACT_DATE = :ld_cur;
COMMIT USING SQLCA;

SetPointer(Hourglass!)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(date(ls_cur))

dw_preview.Post GroupCalc()
end event

type dw_preview from w_rapport`dw_preview within w_r_sommaire_facture_groupe
string dataobject = "d_r_sommaire_facture_groupe"
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

event dw_preview::pfc_filterdlg;call super::pfc_filterdlg;dw_preview.Post GroupCalc()

//Vérifier le filtre
string	ls_filtre
ls_filtre = gnv_app.inv_entrepotglobal.of_retournedonnee("Filtre affichage", FALSE)

IF ls_filtre <> "" AND Not(IsNull(ls_filtre)) THEN
	IF POS(ls_filtre, "Sous-") > 0 THEN
		dw_preview.object.cf_som.visible = 0
		dw_preview.object.cf_totalgroupe.visible = 0
		dw_preview.object.cf_montant.visible = 0
		dw_preview.object.cf_tps.visible = 0
		dw_preview.object.cf_tvq.visible = 0
		dw_preview.object.cf_totalg.visible = 0
	END IF
END IF

RETURN AncestorReturnValue
end event


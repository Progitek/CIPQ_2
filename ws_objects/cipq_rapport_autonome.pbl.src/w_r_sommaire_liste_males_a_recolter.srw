﻿$PBExportHeader$w_r_sommaire_liste_males_a_recolter.srw
forward
global type w_r_sommaire_liste_males_a_recolter from w_rapport
end type
end forward

global type w_r_sommaire_liste_males_a_recolter from w_rapport
integer x = 214
integer y = 221
end type
global w_r_sommaire_liste_males_a_recolter w_r_sommaire_liste_males_a_recolter

event pfc_postopen;call super::pfc_postopen;//Préparer les données

long		ll_cpt, ll_rowcount, ll_jour, ll_nb
string	ls_codeverrat, ls_sql
date		ld_cur, ld_de

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

gnv_app.of_dolistemale( ld_de)

INSERT INTO #Tmp_Recolte_ValiderDelai ( DATE_valider, CodeVerrat )
SELECT 
max(#Tmp_Recolte.DATE_recolte) AS DernierDeDATE, 
#Tmp_Recolte.CodeVerrat 
FROM t_CentreCIPQ 
INNER JOIN (t_Verrat 
INNER JOIN #Tmp_Recolte 
ON (t_Verrat.CIE_NO = #Tmp_Recolte.CIE_NO) AND ((t_Verrat.CodeVerrat) = (#Tmp_Recolte.CodeVerrat))) 
ON t_CentreCIPQ.CIE = #Tmp_Recolte.CIE_NO 
WHERE t_Verrat.ELIMIN Is Null
GROUP BY #Tmp_Recolte.CodeVerrat, 
#Tmp_Recolte.CIE_NO, 
t_Verrat.CodeRACE, 
t_Verrat.Sous_Groupe, 
#Tmp_Recolte.TYPE_SEM,
t_Verrat.Emplacement, 
t_Verrat.TATOUAGE, 
t_Verrat.Classe ;
Commit using SQLCA;

n_ds lds_valider_delai

lds_valider_delai = CREATE n_ds
lds_valider_delai.dataobject = "ds_valider_delai"
lds_valider_delai.of_setTransobject(SQLCA)
ll_rowcount = lds_valider_delai.retrieve() 
FOR ll_cpt = 1 TO ll_rowcount
	ls_codeverrat = lds_valider_delai.object.codeverrat[ll_cpt]
	ld_cur = date(lds_valider_delai.object.date_valider[ll_cpt])
	ll_jour = gnv_app.of_getdelaitocome(ls_codeverrat, ld_cur, ld_de)
	lds_valider_delai.object.delai[ll_cpt] = ll_jour
END FOR
lds_valider_delai.update(TRUE,TRUE)
IF IsValid(lds_valider_delai) THEN DESTROY (lds_valider_delai)

DELETE FROM #Tmp_Recolte
FROM #Tmp_Recolte_ValiderDelai  
WHERE #Tmp_Recolte_ValiderDelai.Delai = 0 
AND (#Tmp_Recolte.CodeVerrat) = (#Tmp_Recolte_ValiderDelai.CodeVerrat) ;
Commit using SQLCA;

ls_sql = "drop table #Tmp_Recolte_ValiderDelai"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

gnv_app.of_DoEpurerListeMale(ld_de)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(ld_de)
end event

on w_r_sommaire_liste_males_a_recolter.create
call super::create
end on

on w_r_sommaire_liste_males_a_recolter.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_preview from w_rapport`dw_preview within w_r_sommaire_liste_males_a_recolter
string dataobject = "d_r_sommaire_liste_males_a_recolter"
end type

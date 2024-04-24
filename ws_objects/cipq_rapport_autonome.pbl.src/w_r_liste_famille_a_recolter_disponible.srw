$PBExportHeader$w_r_liste_famille_a_recolter_disponible.srw
forward
global type w_r_liste_famille_a_recolter_disponible from w_rapport
end type
end forward

global type w_r_liste_famille_a_recolter_disponible from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Liste des familles à récolter disponibles"
end type
global w_r_liste_famille_a_recolter_disponible w_r_liste_famille_a_recolter_disponible

on w_r_liste_famille_a_recolter_disponible.create
call super::create
end on

on w_r_liste_famille_a_recolter_disponible.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;//Préparer les données

long	ll_cpt, ll_rowcount, ll_jour
string	ls_codeverrat, ls_sql
date		ld_cur

gnv_app.of_dolistemale( date(today()) )

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

//Ancien
//SQL = "UPDATE #Tmp_Recolte_ValiderDelai SET #Tmp_Recolte_ValiderDelai.Delai = GetDelai([CodeVerrat],[Date]);"

n_ds lds_valider_delai

lds_valider_delai = CREATE n_ds
lds_valider_delai.dataobject = "ds_valider_delai"
lds_valider_delai.of_setTransobject(SQLCA)
ll_rowcount = lds_valider_delai.retrieve() 
FOR ll_cpt = 1 TO ll_rowcount
	ls_codeverrat = lds_valider_delai.object.codeverrat[ll_cpt]
	ld_cur = date(lds_valider_delai.object.date_valider[ll_cpt])
	ll_jour = gnv_app.of_getdelai(ls_codeverrat, ld_cur)
	lds_valider_delai.object.delai[ll_cpt] = ll_jour
END FOR
lds_valider_delai.update(TRUE,TRUE)
IF IsValid(lds_valider_delai) THEN DESTROY (lds_valider_delai)

DELETE FROM #Tmp_Recolte
FROM #Tmp_Recolte_ValiderDelai INNER JOIN #Tmp_Recolte ON (#Tmp_Recolte.CodeVerrat) = (#Tmp_Recolte_ValiderDelai.CodeVerrat) 
WHERE #Tmp_Recolte_ValiderDelai.Delai = 0 ;
Commit using SQLCA;

ls_sql = "drop table #Tmp_Recolte_ValiderDelai"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

dw_preview.retrieve( )
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_famille_a_recolter_disponible
string dataobject = "d_r_liste_famille_a_recolter_disponible"
end type


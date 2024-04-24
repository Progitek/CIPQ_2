$PBExportHeader$w_r_liste_males_a_recolter.srw
forward
global type w_r_liste_males_a_recolter from w_rapport
end type
type cb_rafraichir from commandbutton within w_r_liste_males_a_recolter
end type
end forward

global type w_r_liste_males_a_recolter from w_rapport
string title = "Rapport - Liste des mâles à récolter"
cb_rafraichir cb_rafraichir
end type
global w_r_liste_males_a_recolter w_r_liste_males_a_recolter

type variables
date	id_curent
end variables

forward prototypes
public subroutine of_ajuster ()
end prototypes

public subroutine of_ajuster ();//of_ajuster

//Préparer les données
long		ll_cpt, ll_rowcount, ll_jour, ll_nb
string	ls_codeverrat, ls_sql
date		ld_cur

gnv_app.of_dolistemale( id_curent)

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
GROUP BY #Tmp_Recolte.CIE_NO,
#Tmp_Recolte.CodeVerrat, 
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
	ll_jour = gnv_app.of_getdelaitocome(ls_codeverrat, ld_cur, id_curent)
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

gnv_app.of_DoEpurerListeMale(id_curent)

end subroutine

on w_r_liste_males_a_recolter.create
int iCurrent
call super::create
this.cb_rafraichir=create cb_rafraichir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_rafraichir
end on

on w_r_liste_males_a_recolter.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_rafraichir)
end on

event pfc_postopen;call super::pfc_postopen;//Préparer les données
long	ll_nb

id_curent = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

of_ajuster()

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(id_curent)
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_males_a_recolter
integer height = 2248
string dataobject = "d_r_liste_males_a_recolter"
end type

type cb_rafraichir from commandbutton within w_r_liste_males_a_recolter
integer x = 27
integer y = 2268
integer width = 402
integer height = 112
integer taborder = 109
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rafraîchir"
boolean flatstyle = true
end type

event clicked;long	ll_nb

of_ajuster()

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(id_curent)
end event


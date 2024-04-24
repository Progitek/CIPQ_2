$PBExportHeader$w_r_liste_eleveur_groupe_sous_groupe.srw
forward
global type w_r_liste_eleveur_groupe_sous_groupe from w_rapport
end type
end forward

global type w_r_liste_eleveur_groupe_sous_groupe from w_rapport
string title = "Rapport - Liste des éleveurs par groupes et sous-groupes"
end type
global w_r_liste_eleveur_groupe_sous_groupe w_r_liste_eleveur_groupe_sous_groupe

on w_r_liste_eleveur_groupe_sous_groupe.create
call super::create
end on

on w_r_liste_eleveur_groupe_sous_groupe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb, ll_groupe, ll_sous_groupe
string	ls_critere = "", ls_sql

//Récupérer les arguments
ll_groupe = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien groupe"))
ll_sous_groupe = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien sous groupe"))

//Préparer les données
select count(1) into :ll_nb from #Temp_Eleveur_Groupe;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_Eleveur_Groupe (no_eleveur integer not null,~r~n" + &
													  "groupe varchar(255) null,~r~n" + &
													  "sous_groupe varchar(255) null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	DELETE FROM #Temp_Eleveur_Groupe;
	COMMIT USING SQLCA;
end if

//Groupe et sous-groupe de facturation
If Not IsNull(ll_groupe) And ll_groupe > 0 Then
	ls_Critere = " ((t_ELEVEUR_Group.IDGroup)= " + string(ll_groupe) + ")"
End If
If Not IsNull(ll_sous_groupe) And ll_sous_groupe > 0 Then
	IF LEN(ls_critere) > 0 THEN
		ls_critere += " AND "
	END IF
	ls_Critere = ls_Critere + " ((t_ELEVEUR_GroupSecondaire.IDGroupSecondaire)= " + string(ll_sous_groupe) + ")"
End If

ls_sql = "INSERT INTO #Temp_Eleveur_Groupe ( No_Eleveur, Groupe, Sous_groupe ) " + &
	"SELECT t_Eleveur.No_Eleveur, t_ELEVEUR_Group.Description, t_ELEVEUR_GroupSecondaire.NomGroupSecondaire " + &
	"FROM (t_ELEVEUR_Group INNER JOIN t_Eleveur ON t_ELEVEUR_Group.IDGroup = t_Eleveur.Groupe) " + &
	"LEFT JOIN t_ELEVEUR_GroupSecondaire " + &
	"ON (t_Eleveur.GroupeSecondaire = t_ELEVEUR_GroupSecondaire.IDGroupSecondaire) " + &
	"AND (t_Eleveur.Groupe = t_ELEVEUR_GroupSecondaire.IDGroup) " 

If Len(ls_Critere) > 0 Then
	ls_SQL = ls_SQL + " WHERE " + ls_Critere
End If
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

// 2009-05-22 Sébastien Tremblay apparemment pas rapport...
////Code hébergeur
//If IsNull(ll_sous_groupe) Or ll_sous_groupe = 0 Then
//	ls_Critere = ""
//	If Not IsNull(ll_groupe) And ll_groupe > 0 Then
//		ls_Critere = " ((t_ELEVEUR_Group.IDGroup)= " + string(ll_groupe) + ")"
//	End If
//
//	ls_SQL = "INSERT INTO #Temp_Eleveur_Groupe ( No_Eleveur, Groupe ) " + &
//		"SELECT t_Eleveur.No_Eleveur, t_ELEVEUR_Group.Description " + &
//		"FROM (t_Eleveur INNER JOIN t_Eleveur_CodeHebergeur " + &
//		"ON t_Eleveur.No_Eleveur = t_Eleveur_CodeHebergeur.No_Eleveur) " + &
//		"INNER JOIN t_ELEVEUR_Group ON t_Eleveur_CodeHebergeur.CodeHebergeur = t_ELEVEUR_Group.Code_Hebergeur"
//		 
//	If Len(ls_Critere) > 0 Then
//		 ls_SQL = ls_SQL + " WHERE " + ls_Critere
//	End If
//	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
//	
//End If

dw_preview.of_SetTri(TRUE)

SetPointer(HourGlass!)
ll_nb = dw_preview.retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_eleveur_groupe_sous_groupe
string dataobject = "d_r_liste_eleveur_groupe_sous_groupe"
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
end event


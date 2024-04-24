﻿$PBExportHeader$w_r_facturation.srw
forward
global type w_r_facturation from w_rapport
end type
end forward

global type w_r_facturation from w_rapport
string title = "Rapport - facturation"
end type
global w_r_facturation w_r_facturation

on w_r_facturation.create
call super::create
end on

on w_r_facturation.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nbligne, ll_cpt, ll_debut, ll_fin, ll_retour
string	ls_message, ls_tri, ls_critere, ls_sql, ls_retour, ls_newsort, ls_new_sql, ls_travail[],ls_typeclient

ll_debut = long(gnv_app.inv_entrepotglobal.of_retournedonnee("debut rapport facturation"))
ll_fin = long(gnv_app.inv_entrepotglobal.of_retournedonnee("fin rapport facturation"))
ls_message = gnv_app.inv_entrepotglobal.of_retournedonnee("message rapport facturation")
ls_message = gnv_app.inv_string.of_globalreplace(ls_message, '"', '~~"')
ls_tri = gnv_app.inv_entrepotglobal.of_retournedonnee("tri rapport facturation")
ls_critere = gnv_app.inv_entrepotglobal.of_retournedonnee("critere rapport facturation")
ls_typeclient = gnv_app.inv_entrepotglobal.of_retournedonnee("client PPA facturation")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("debut rapport facturation", "")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("fin rapport facturation", "")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("message rapport facturation", "")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("tri rapport facturation", "")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere rapport facturation", "")

ls_sql = dw_preview.GetSqlSelect()
ls_travail = split(ls_sql, '/*where*/')
ls_new_sql = ls_travail[1]

ls_travail = split(ls_travail[2], '/*order*/')
ls_newsort = ls_travail[2]

IF not isnull(ls_critere) AND ls_critere <> "" THEN
	ls_new_sql += " AND" + ls_critere
END IF

IF ls_tri = "1" THEN
	ls_newsort = "~r~nORDER BY t_ELEVEUR.No_Eleveur ASC, NoFact ASC, t_StatFacture.LIV_DATE ASC, no_eleveur_cast ASC, t_ELEVEUR.Groupe ASC, t_ELEVEUR.GroupeSecondaire ASC," + ls_newsort
ELSE
	//Avec string
	ls_newsort = "~r~nORDER BY no_eleveur_cast ASC, NoFact ASC, t_StatFacture.LIV_DATE ASC, t_ELEVEUR.No_Eleveur ASC, t_ELEVEUR.Groupe ASC, t_ELEVEUR.GroupeSecondaire ASC," + ls_newsort
END IF

ls_retour = dw_preview.modify("datawindow.table.select=~""+ls_new_sql+ls_newsort+"~"")

//ll_retour = dw_preview.SetSort(ls_newsort)
//ll_retour = dw_preview.Sort( )	


SetPointer(HourGlass!)
ll_nbligne = dw_preview.retrieve(ll_debut, ll_fin)
dw_preview.object.st_message_footer.text = ls_message

if ls_typeclient = "PPA" then
	dw_preview.object.t_ppaonly.visible = true
else
	dw_preview.object.t_ppaonly.visible = false
end if
end event

type dw_preview from w_rapport`dw_preview within w_r_facturation
string dataobject = "d_r_facturation"
end type

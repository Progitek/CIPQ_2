﻿$PBExportHeader$w_r_etiquette_eleveur.srw
forward
global type w_r_etiquette_eleveur from w_rapport
end type
end forward

global type w_r_etiquette_eleveur from w_rapport
string title = "Rapport - Étiquettes d~'éleveurs"
end type
global w_r_etiquette_eleveur w_r_etiquette_eleveur

on w_r_etiquette_eleveur.create
call super::create
end on

on w_r_etiquette_eleveur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nbligne, ll_choix, ll_noeleveur
string	ls_sqlselect, ls_where, ls_filtre

ls_filtre = gnv_app.inv_entrepotglobal.of_retournedonnee("lien eleveur etiquettes filtre")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes filtre", "")

ls_where = gnv_app.inv_entrepotglobal.of_retournedonnee("lien eleveur etiquettes sql")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes sql", "")

ll_choix = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien eleveur etiquettes choix"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes choix", "")

ll_noeleveur = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien eleveur etiquettes eleveur"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes eleveur", "")

CHOOSE CASE ll_choix
	CASE 1
		dw_preview.dataobject = "d_r_etiquette_eleveur_adm"
	CASE 2
		dw_preview.dataobject = "d_r_etiquette_eleveur_liv"
	CASE 3
		dw_preview.dataobject = "d_r_etiquette_eleveur_fact"
	CASE ELSE
		dw_preview.dataobject = "d_eleveur_courrier"
END CHOOSE
		
/*
IF ll_choix = 1 THEN
	dw_preview.dataobject = "d_r_etiquette_eleveur_adm"
ELSEIF ll_choix = 2 THEN
	dw_preview.dataobject = "d_r_etiquette_eleveur_liv"
ELSE
	dw_preview.dataobject = "d_r_etiquette_eleveur_fact"
END IF
*/

dw_preview.SetTransObject(SQLCA)

//Changer le sql
If ll_choix = 4 THEN
	ls_sqlselect = dw_preview.GetSqlSelect()
	dw_preview.SetSqlSelect( rep(ls_sqlselect,'999',string(ll_noeleveur)))
ELSE
	IF ls_where <> "" AND Not IsNull(ls_where) THEN
		ls_sqlselect = dw_preview.GetSqlSelect()
		dw_preview.SetSqlSelect( ls_sqlselect + ls_where )
	END IF
END IF
dw_preview.SetTransObject(SQLCA)

//Charger le filtre
IF ls_filtre <> "" AND Not IsNull(ls_filtre) THEN
	dw_preview.SetFilter(ls_filtre)
	dw_preview.Filter()	
END IF

ll_nbligne = dw_preview.retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_r_etiquette_eleveur
string dataobject = "d_r_etiquette_eleveur_adm"
boolean ib_isupdateable = false
end type

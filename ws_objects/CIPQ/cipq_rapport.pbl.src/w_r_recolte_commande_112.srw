﻿$PBExportHeader$w_r_recolte_commande_112.srw
forward
global type w_r_recolte_commande_112 from w_rapport
end type
end forward

global type w_r_recolte_commande_112 from w_rapport
string title = "Rapport - Gestion des récoltes en comparaison avec les commandes - 112"
end type
global w_r_recolte_commande_112 w_r_recolte_commande_112

on w_r_recolte_commande_112.create
call super::create
end on

on w_r_recolte_commande_112.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;string	ls_date

ls_date = gnv_app.inv_entrepotglobal.of_retournedonnee("lien rapport recolte commande date")

dw_preview.retrieve(date(ls_date))
end event

event pfc_postopen;call super::pfc_postopen;string ls_nom_fichier, ls_cie, ls_repexport, ls_exp_rap

// Si on veut exporter les rapports de récoltes en comparaison avec les commandes
ls_exp_rap = gnv_app.of_getvaleurini("TRANSFERT", "Export_Rap")
if upper(ls_exp_rap) = 'TRUE' then
	//Vérifier le répertoire d'exportation
	ls_repexport = gnv_app.of_getvaleurini("FTP", "EXPORTPATH")
	IF LEN(ls_repexport) > 0 THEN
		IF NOT FileExists(ls_repexport) THEN
			gnv_app.inv_error.of_message("CIPQ0139")
			RETURN
		END IF
	ELSE
		gnv_app.inv_error.of_message("CIPQ0140")
		RETURN
	END IF
	IF RIGHT(ls_repexport, 1) <> "\" THEN ls_repexport += "\"
	
	ls_cie = gnv_app.of_getcompagniedefaut()
	
	ls_nom_fichier = "110P" + ls_cie + 'Rox-' + string(today(), "yyyy-mm-dd") + string(now(), " hh-mm-ss") + ".pdf"
	
	dw_preview.saveAs(ls_repexport + ls_nom_fichier, PDF!, false)
end if

// 2010-03-16 - Sébastien - Ne pas quitter, laisser la fenêtre ouverte

//long	ll_nbligne
//
//ll_nbligne = dw_preview.rowcount()
//
//do while yield()
//loop
//
//IF ll_nbligne > 0 THEN
//	dw_preview.print(false,false)
//	do while yield()
//	loop
//	close(this)
//ELSE
//	MEssagebox("Attention", "Il n'y a rien à imprimer")
//END IF
end event

type dw_preview from w_rapport`dw_preview within w_r_recolte_commande_112
string dataobject = "d_r_recolte_commande_112"
end type


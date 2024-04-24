$PBExportHeader$w_r_recolte_commande.srw
forward
global type w_r_recolte_commande from w_rapport
end type
end forward

global type w_r_recolte_commande from w_rapport
string title = "Rapport - Gestion des récoltes en comparaison avec les commandes"
end type
global w_r_recolte_commande w_r_recolte_commande

on w_r_recolte_commande.create
call super::create
end on

on w_r_recolte_commande.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;string	ls_date, ls_ciecentre, ls_odbc, ls_sql
transaction CIPQTRANS

ls_date = gnv_app.inv_entrepotglobal.of_retournedonnee("lien rapport recolte commande date")
ls_ciecentre = gnv_app.inv_entrepotglobal.of_retournedonnee("lien rapport recolte commande cie")

CHOOSE CASE ls_ciecentre
	CASE '110'
		ls_odbc = "cipq_admin"
	CASE '111'
		ls_odbc = "cipq_stlambert"
	CASE '112'
		ls_odbc = "cipq_roxton"
	CASE '113'
		ls_odbc = "cipq_stcuthbert"
	CASE '116'
		ls_odbc = "cipq_stpatrice"
END CHOOSE
			
CIPQTRANS = CREATE transaction

CIPQTRANS.DBMS       = 'ODBC'
CIPQTRANS.AutoCommit = True
CIPQTRANS.LOCK		  = "0"
CIPQTRANS.DbParm  = "ConnectString='DSN=" + ls_odbc + ";UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
connect using CIPQTRANS;

if CIPQTRANS.sqlcode <> 0 then
	
	CHOOSE CASE ls_ciecentre
		CASE '110'
			MessageBox ("Erreur de communication", "La communication avec l'administration est impossible veuillez corriger la situation",Information!, Ok!)
		CASE '111'
			MessageBox ("Erreur de communication", "La communication avec St-Lambert est impossible veuillez corriger la situation",Information!, Ok!)
		CASE '112'
			MessageBox ("Erreur de communication", "La communication avec Roxton est impossible veuillez corriger la situation",Information!, Ok!)
		CASE '113'
			MessageBox ("Erreur de communication", "La communication avec St-Cuthbert est impossible veuillez corriger la situation",Information!, Ok!)
		CASE '116'
			MessageBox ("Erreur de communication", "La communication avec St-St-Patrice est impossible veuillez corriger la situation",Information!, Ok!)
	END CHOOSE

else
	
	// Authentifier la connection pour la version 11

	ls_sql = "SET TEMPORARY OPTION CONNECTION_AUTHENTICATION='Company=Progitek;Application=Progitek;Signature=000fa55157edb8e14d818eb4fe3db41447146f1571g7cf6b1c162e7a4e4925570fc8104c82ac6d466c6'"
	execute immediate :ls_sql using CIPQTRANS;
	if sqlca.sqlcode <> 0 then
		MessageBox ("Validation d'authentification", CIPQTRANS.sqlerrtext)
	end if
	
end if

dw_preview.setTransObject(CIPQTRANS)
dw_preview.retrieve(date(ls_date), ls_ciecentre )

//IF gnv_app.of_getcompagniedefaut( ) = "111" or gnv_app.of_getcompagniedefaut( ) = "112" THEN 
//	dw_preview.Object.t_recolte_commande_qteverraterie.visible = false
//	dw_preview.Object.t_3.visible = false
//	dw_preview.Object.t_recolte_commande_qtesoldearecolter.visible = false
//	dw_preview.Object.t_7.visible = false	
//	dw_preview.Object.compute_2.visible = false	
//	dw_preview.Object.compute_8.visible = false	
//	dw_preview.Object.compute_6.visible = false	
//	dw_preview.Object.compute_12.visible = false	
//END IF


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
	
	ls_nom_fichier = "110P" + ls_cie + '-' + string(today(), "yyyy-mm-dd") + string(now(), " hh-mm-ss") + ".pdf"
	
	dw_preview.saveAs(ls_repexport + ls_nom_fichier, PDF!, false)
end if

// 2010-03-16 - Sébastien - Ne pas quitter, laisser la fenêtre ouverte

//string	ls_cie
//long		ll_nbligne
//
//ls_cie = gnv_app.of_getcompagniedefaut( )
//ll_nbligne = dw_preview.rowcount()
//
//do while yield()
//loop
//
//IF ls_cie <> "112" THEN
//	IF ll_nbligne > 0 THEN
//		dw_preview.print(false,false)
//		do while yield()
//		loop
//		close(this)
//	ELSE
//		MEssagebox("Attention", "Il n'y a rien à imprimer")
//	END IF
//END IF
end event

type dw_preview from w_rapport`dw_preview within w_r_recolte_commande
string dataobject = "d_r_recolte_commande"
boolean border = false
end type


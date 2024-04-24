HA$PBExportHeader$n_cst_transfert_centre_adm.sru
forward
global type n_cst_transfert_centre_adm from n_base
end type
end forward

global type n_cst_transfert_centre_adm from n_base autoinstantiate
end type

type variables
string	is_ecrire = "", is_entete = ""
w_exportation_pilotage iw_exportation_pilotage
w_importation iw_importation
end variables

forward prototypes
public subroutine of_updatetransfertref (string as_table, boolean ab_switch)
public subroutine of_transfert_adm ()
public function string of_checkdestdir ()
public function string of_getdestname (date ld_cur)
public function string of_checkreplexpdir ()
public subroutine of_updatetransftodo (date ad_cur)
public function boolean of_starttransfertdonnee (string as_fichier, date ad_cur)
public subroutine of_inserttolog (string as_tbl, date ad_cur, long ll_nbrenr)
public function long of_trdatatbl (string as_dirdst, string as_tbl, string as_fld, date ad_cur)
public function long of_trfactdet (string as_dirdst, string as_tbl, string as_fld, date ad_cur)
public subroutine of_maj_tbl_faite (string ls_fichier)
public subroutine of_req_tblalliancematernelle_recolte_ges ()
public function integer of_tbldest (string as_fichier, string as_tbl)
public function boolean of_importer ()
public function boolean of_downloadftpfile ()
public function boolean of_uploadftpfile ()
public function boolean of_importfichiers ()
end prototypes

public subroutine of_updatetransfertref (string as_table, boolean ab_switch);//of_UpdateTransfertRef
//as_table - ab_switch
as_table = lower(as_table)

UPDATE t_transfertafaire 
SET afaire = :ab_switch
WHERE lower(tblname) = :as_table ;

IF SQLCA.SQLCode <> 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"update t_transfertafaire of_updatetransfertref", SQLCA.SQLeRRText})
ELSE
	COMMIT USING SQLCA;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"update t_transfertafaire of_updatetransfertref", SQLCA.SQLeRRText})
	END IF
END IF

RETURN
end subroutine

public subroutine of_transfert_adm ();//of_transfert

string	ls_repexport, ls_ecrire = '', ls_string, ls_DestDir, ls_retour, ls_dest, ls_cie, &
			ls_ReplExpDir
integer	li_FileNum
long		ll_rtn
boolean	lb_NewExport = FALSE
date		ld_cur

IF gnv_app.inv_error.of_message("CIPQ0078") = 1 THEN

	SetPointer(HourGlass!)
	
	ls_cie = gnv_app.of_getcompagniedefaut( )
	
	//V$$HEX1$$e900$$ENDHEX$$rifier si le transfert est suspendu
	ls_retour = gnv_app.of_getvaleurini( "FTP", "Transfert_pilotage")
	IF upper(ls_retour) <> "TRUE" THEN
		gnv_app.inv_error.of_message("CIPQ0147")
		RETURN
	END IF
	
	//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire d'exportation
	ls_repexport = gnv_app.of_getvaleurini( "FTP", "EXPORTPATH")
	IF LEN(ls_repexport) > 0 THEN
		IF NOT FileExists(ls_repexport) THEN
			gnv_app.inv_error.of_message("CIPQ0139")
			RETURN
		END IF
	ELSE
		gnv_app.inv_error.of_message("CIPQ0140")
		RETURN
	END IF
	
	IF RIGHT(ls_repexport, 1) <> "\" THEN
		ls_repexport += "\"
	END IF
	
	//R$$HEX1$$e900$$ENDHEX$$pertoire de destination
	ls_DestDir = gnv_app.inv_transfert_centre_adm.of_checkdestdir( )
	IF ls_DestDir = "+" THEN
		messagebox("Erreur", "R$$HEX1$$e900$$ENDHEX$$pertoire de destination : +")
		RETURN
	end if
	IF NOT FileExists(ls_DestDir) THEN
		gnv_app.inv_error.of_message( "CIPQ0148", {ls_DestDir})
		RETURN
	END IF
	
	ld_cur = date(gnv_app.inv_entrepotglobal.of_retournedonnee("date transfert"))
	//genre de format de of_getdestname: 113T110-0207.txt
	IF Isnull(ld_cur) OR ld_cur < 1901-01-01 THEN
		ls_dest = gnv_app.inv_transfert_centre_adm.of_getdestname( date(today()))
		lb_NewExport = TRUE
	ELSE
		ls_dest = gnv_app.inv_transfert_centre_adm.of_getdestname( ld_cur)
	END IF
	
	IF ls_cie <> "110" AND lb_NewExport = TRUE THEN
		//Si nouveau transfert, ajouter les donn$$HEX1$$e900$$ENDHEX$$es dans la table "T_AllianceMaternelle_Recolte_GestionLot_Verrat"
		THIS.of_req_tblalliancematernelle_recolte_ges()
	END IF
	
	//Si fichier existe dans le r$$HEX1$$e900$$ENDHEX$$pertoire d'envoie, supprimer le fichier
	IF FileExists(ls_DestDir + ls_Dest) THEN
		FileDelete(ls_DestDir + ls_Dest)
	END IF
	
	ls_ReplExpDir = of_CheckReplExpDir()
	IF ls_ReplExpDir = "+" THEN RETURN
	
	IF FileExists(ls_ReplExpDir + ls_Dest) THEN
		IF gnv_app.inv_error.of_message( "CIPQ0149", {ls_Dest}) = 2 THEN
			RETURN
		END IF
	END IF
	
	//Transfert dans fichier txt situ$$HEX2$$e9002000$$ENDHEX$$dans "Z:\CIPQ\Envoie\"
	IF NOT THIS.of_starttransfertdonnee(ls_DestDir + ls_Dest, ld_cur) THEN 
		iw_exportation_pilotage.st_table.text = "$$HEX1$$c900$$ENDHEX$$criture termin$$HEX1$$e900$$ENDHEX$$e"
		RETURN
	END IF
	
	iw_exportation_pilotage.st_table.text = "$$HEX1$$c900$$ENDHEX$$criture termin$$HEX1$$e900$$ENDHEX$$e"
	
	IF Isnull(ld_cur) OR ld_cur < 1901-01-01 THEN
		THIS.of_maj_tbl_faite( ls_DestDir + ls_Dest)
	END IF
	
	iw_exportation_pilotage.st_table.text = "Copie des fichiers"
	CHOOSE CASE ls_cie
		CASE "110"
			//Copier le fichier dans le r$$HEX1$$e900$$ENDHEX$$pertoire d'export - pr$$HEX1$$ea00$$ENDHEX$$t pour envoi
			//pour 111, 112 et 113
			ll_rtn = FileCopy ( ls_DestDir + ls_Dest, ls_repexport + "TMP_111T" + ls_Dest, TRUE)
			IF ll_rtn < 0 THEN
				gnv_app.inv_error.of_message("CIPQ0151",{"Copie de fichier " + ls_DestDir + ls_Dest, ls_repexport + "TMP_111T" + ls_Dest, "of_transfert_adm"})
			else
				//Renommer le fichier
				do while yield()
				loop
				sleep(1)				
				ll_rtn = gnv_app.inv_filesrv.of_filerename( ls_repexport + "TMP_111T" + ls_Dest, ls_repexport + "111T" + ls_Dest)
				IF ll_rtn < 0 THEN
					gnv_app.inv_error.of_message("CIPQ0151",{"Rename de fichier " + ls_DestDir + ls_Dest, ls_repexport + "TMP_111T" + ls_Dest, "of_transfert_adm"})
				END IF
			END IF				
			do while yield()
			loop
			sleep(1)

			ll_rtn = FileCopy ( ls_DestDir + ls_Dest, ls_repexport + "TMP_112T" + ls_Dest, TRUE)
			IF ll_rtn < 0 THEN
				gnv_app.inv_error.of_message("CIPQ0151",{"Copie de fichier " + ls_DestDir + ls_Dest, ls_repexport + "TMP_112T" + ls_Dest, "of_transfert_adm"})
			else
				//Renommer le fichier
				do while yield()
				loop
				sleep(1)				
				ll_rtn = gnv_app.inv_filesrv.of_filerename( ls_repexport + "TMP_112T" + ls_Dest, ls_repexport + "112T" + ls_Dest)
				IF ll_rtn < 0 THEN
					gnv_app.inv_error.of_message("CIPQ0151",{"Rename de fichier " + ls_DestDir + ls_Dest, ls_repexport + "TMP_112T" + ls_Dest, "of_transfert_adm"})
				END IF
			END IF				
			do while yield()
			loop
			sleep(1)

			ll_rtn = FileCopy ( ls_DestDir + ls_Dest, ls_repexport + "TMP_113T" + ls_Dest, TRUE)
			IF ll_rtn < 0 THEN
				gnv_app.inv_error.of_message("CIPQ0151",{"Copie de fichier " + ls_DestDir + ls_Dest, ls_repexport + "TMP_113T" + ls_Dest, "of_transfert_adm"})
			else
				//Renommer le fichier
				do while yield()
				loop
				sleep(1)				
				ll_rtn = gnv_app.inv_filesrv.of_filerename( ls_repexport + "TMP_113T" + ls_Dest, ls_repexport + "113T" + ls_Dest)
				IF ll_rtn < 0 THEN
					gnv_app.inv_error.of_message("CIPQ0151",{"Rename de fichier " + ls_DestDir + ls_Dest, ls_repexport + "TMP_113T" + ls_Dest, "of_transfert_adm"})
				END IF
			END IF				
			do while yield()
			loop
			sleep(1)
			
			ll_rtn = FileCopy ( ls_DestDir + ls_Dest, ls_repexport + "TMP_116T" + ls_Dest, TRUE)
			IF ll_rtn < 0 THEN
				gnv_app.inv_error.of_message("CIPQ0151",{"Copie de fichier " + ls_DestDir + ls_Dest, ls_repexport + "TMP_116T" + ls_Dest, "of_transfert_adm"})
			else
//				//Renommer le fichier
				do while yield()
				loop
				sleep(1)				
				ll_rtn = gnv_app.inv_filesrv.of_filerename( ls_repexport + "TMP_116T" + ls_Dest, ls_repexport + "116T" + ls_Dest)
				IF ll_rtn < 0 THEN
					gnv_app.inv_error.of_message("CIPQ0151",{"Rename de fichier " + ls_DestDir + ls_Dest, ls_repexport + "TMP_116T" + ls_Dest, "of_transfert_adm"})
				END IF
			END IF				
			do while yield()
			loop
			sleep(1)
						
		CASE ELSE
			//Copier le fichier dans le r$$HEX1$$e900$$ENDHEX$$pertoire d'export - pr$$HEX1$$ea00$$ENDHEX$$t pour envoie
			//pour 110 seulement
			ll_rtn = FileCopy ( ls_DestDir + ls_Dest, ls_repexport + "TMP_110T" + ls_Dest, TRUE)
			IF ll_rtn < 0 THEN
				gnv_app.inv_error.of_message("CIPQ0151",{"Copie de fichier " + ls_DestDir + ls_Dest, ls_repexport + "TMP_110T" + ls_Dest, "of_transfert_adm"})
			else
				//Renommer le fichier
				do while yield()
				loop
				sleep(1)
								
				ll_rtn = gnv_app.inv_filesrv.of_filerename( ls_repexport + "TMP_110T" + ls_Dest, ls_repexport + "110T" + ls_Dest)
				IF ll_rtn < 0 THEN
					gnv_app.inv_error.of_message("CIPQ0151",{"Rename de fichier " + ls_DestDir + ls_Dest, ls_repexport + "TMP_110T" + ls_Dest, "of_transfert_adm"})
				END IF
			END IF				
			do while yield()
			loop
			sleep(1)
			
	END CHOOSE

	//si pas d'erreur....
	//supprimer le fichier de "Z:\CIPQ\Envoie\"
	FileDelete(ls_DestDir + ls_Dest)
	
END IF

iw_exportation_pilotage.st_table.text = "Proc$$HEX1$$e900$$ENDHEX$$dure termin$$HEX1$$e900$$ENDHEX$$e"

Messagebox("Information", "Proc$$HEX1$$e900$$ENDHEX$$dure termin$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$" + string(now()))

RETURN
end subroutine

public function string of_checkdestdir ();//of_CheckDestDir

string	ls_PathDb 

ls_PathDb = gnv_app.of_getvaleurini( "TRANSFERT", "TransfDir")

If Len(ls_PathDb) > 0 Then
	If Right(ls_PathDb, 1) <> "\" Then ls_PathDb = ls_PathDb + "\"
ELSE
	RETURN ""
End If

RETURN ls_PathDb
end function

public function string of_getdestname (date ld_cur);//of_GetDestMdbName

string 	ls_GetDestName

ls_GetDestName = gnv_app.of_getcompagniedefaut( ) + "-" + string(day(ld_cur),"00") + string(month(ld_cur),"00") + ".txt"
	
RETURN ls_GetDestName
end function

public function string of_checkreplexpdir ();//of_CheckReplExpDir

string	ls_PathDb 

ls_PathDb = gnv_app.of_getvaleurini( "REPLICATION", "ExportDir")

If Len(ls_PathDb) > 0 Then
	If Right(ls_PathDb, 1) <> "\" Then ls_PathDb = ls_PathDb + "\"
ELSE
	RETURN ""
End If

RETURN ls_PathDb

end function

public subroutine of_updatetransftodo (date ad_cur);//of_UpdateTransfToDo

UPDATE T_Transfere_Log INNER JOIN T_TransfertAFaire 
ON T_Transfere_Log.TblTransf = T_TransfertAFaire.TblName 
Set T_TransfertAFaire.afaire = 1 
WHERE date(t_Transfere_Log.DateTransf) = :ad_cur;

IF SQLCA.SQLCode <> 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"update T_Transfere_Log of_UpdateTransfToDo", SQLCA.SQLeRRText})
ELSE
	COMMIT USING SQLCA;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"update T_Transfere_Log of_UpdateTransfToDo", SQLCA.SQLeRRText})
	END IF
END IF
end subroutine

public function boolean of_starttransfertdonnee (string as_fichier, date ad_cur);//of_StartTransfertDonnee
boolean	lb_retour = FALSE, lb_dolog = FALSE
n_ds 		lds_transfert_env
long		ll_nbr, ll_cpt, ll_position, ll_retour, ll_afaire, ll_nbEnregistrement = 0, ll_rtn
string	ls_table, ls_fct, ls_fld, ls_cie, ls_entete_ligne = "", ls_date_log
datetime	ldt_now

is_ecrire = ""
is_entete = ""

IF (Not IsNull(ad_cur)) AND ad_cur > 1901-01-01 THEN
	THIS.of_UpdateTransfToDo(ad_cur)
	ls_date_log = "'" + string(ad_cur, "yyyy-mm-dd") + "'"
ELSE
	ls_date_log = "null"
END IF

IF NOT IsValid(iw_exportation_pilotage) THEN
	RETURN FALSE
END IF

ls_cie = gnv_app.of_getcompagniedefaut( )

lds_transfert_env = CREATE n_ds
lds_transfert_env.dataobject = "ds_transfert_env"
lds_transfert_env.of_setTransobject(SQLCA)
ll_nbr = lds_transfert_env.retrieve(ls_cie)


FOR ll_cpt = 1 TO ll_nbr
	//Faire le tour des transferts $$HEX2$$e0002000$$ENDHEX$$envoyer
	
	SetNull(ll_afaire)
	lb_dolog = FALSE
	ll_nbEnregistrement = 0
	ls_entete_ligne = ""
	
	ls_fct = lds_transfert_env.object.fct[ll_cpt]
	ls_table = lower(lds_transfert_env.object.tblname[ll_cpt])
	ls_fld = lds_transfert_env.object.fld[ll_cpt]
	iw_exportation_pilotage.st_table.text = "Table trait$$HEX1$$e900$$ENDHEX$$e: " + ls_table
	
	//Ajuster la barre de progression
	ll_position = round( (ll_cpt / ll_nbr)  * 100,0)
	iw_exportation_pilotage.of_setposition(ll_position)
	
	IF IsNull(ls_fct) THEN
		SetNull(ll_afaire)
		
		SELECT t_transfertafaire.afaire 
		INTO :ll_afaire
		FROM t_transfertafaire
		WHERE	lower(t_transfertafaire.tblname) = :ls_table ;
		
		IF Not IsNull(ll_afaire) THEN
			IF ll_afaire = 1 THEN
				//Pr$$HEX1$$e900$$ENDHEX$$parer le transfert
				ll_nbEnregistrement = THIS.of_TblDest( as_fichier, ls_table)
				lb_dolog = TRUE
			END IF
		END IF
		
	ELSE
		CHOOSE CASE lower(ls_fct)
			CASE "trdatatbl"
				ll_nbEnregistrement = THIS.of_trdatatbl( as_fichier, ls_table, ls_fld, ad_cur)
			CASE "trfactdet"
				ll_nbEnregistrement = THIS.of_trfactdet( as_fichier, ls_table, ls_fld, ad_cur)
		END CHOOSE
		
		lb_dolog = TRUE
	END IF
	
	//Pr$$HEX1$$e900$$ENDHEX$$parer l'ent$$HEX1$$ea00$$ENDHEX$$te
	IF ll_nbEnregistrement > 0 AND Not IsNull(ll_nbEnregistrement) THEN
		ldt_now = datetime(today(),now())
		ls_entete_ligne = "INSERT INTO t_Transfert_Reception (Centre, DateTransfert, TblName, NbEnregistrement, DateDonnees) VALUES " + &
			"('" + ls_cie + "', '" + string(ldt_now, "yyyy-mm-dd hh:mm:ss") + "', '" + ls_table + "', " + &
			string(ll_nbEnregistrement) + ", " + ls_date_log + ");~r~n"
		is_entete = is_entete + ls_entete_ligne
	END IF
	
	IF lb_dolog = TRUE THEN
		THIs.of_inserttolog( ls_table, ad_cur, ll_nbEnregistrement)
		do while yield()
		loop
	END IF
	
END FOR

//$$HEX1$$c900$$ENDHEX$$crire le fichier $$HEX2$$e0002000$$ENDHEX$$envoyer
IF trim(is_ecrire) <> "" AND LEN(is_ecrire) > 19 THEN
	iw_exportation_pilotage.st_table.text = "$$HEX1$$c900$$ENDHEX$$criture du fichier en cours"
	ll_rtn = gnv_app.inv_filesrv.of_filewrite( as_fichier, is_entete + is_ecrire )
	IF ll_rtn < 0 THEN
		gnv_app.inv_error.of_message("CIPQ0151",{"$$HEX1$$c900$$ENDHEX$$crire le fichier $$HEX2$$e0002000$$ENDHEX$$envoyer", as_fichier, "of_starttransfertdonnee (centre adm)"})
	END IF
	
	do while yield()
	loop
ELSE
	iw_exportation_pilotage.of_setPosition(100)
	IF IsValid(lds_transfert_env) THEN DESTROY(lds_transfert_env)

	Messagebox("Attention", "Il n'y a aucune donn$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$exporter.")
	
	RETURN FALSE
END IF

update t_users set password = login_user where password is null and typepass = 'user';
if SQLCA.SQLCode <> 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"R$$HEX1$$e900$$ENDHEX$$initialisation des mots de passe", SQLCA.SQLErrText})
end if

iw_exportation_pilotage.of_setPosition(100)

IF IsValid(lds_transfert_env) THEN DESTROY(lds_transfert_env)

RETURN TRUE
end function

public subroutine of_inserttolog (string as_tbl, date ad_cur, long ll_nbrenr);//of_inserttolog

datetime	ldt_cur
string	ls_user

ls_user = gnv_app.of_getuserid( )

IF IsNull(ad_cur) OR ad_cur < 1901-01-01 THEN
	ldt_cur = datetime(today())
ELSE
	ldt_cur = datetime(ad_cur)
END IF

INSERT INTO T_Transfere_Log (DateTransf, TblTransf, UserName, NbEnregistrement)
VALUES (:ldt_cur, :as_tbl, :ls_user, :ll_nbrenr);
IF SQLCA.SQLCode <> 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"Insertion dans les logs", SQLCA.SQLeRRText})
ELSE
	COMMIT USING SQLCA;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"Insertion dans les logs", SQLCA.SQLeRRText})
	END IF
END IF
end subroutine

public function long of_trdatatbl (string as_dirdst, string as_tbl, string as_fld, date ad_cur);//of_trdatatbl
string	ls_sql, ls_errors, ls_presentation_str, ls_dwsyntax_str, ls_string, ls_fichier, ls_cleprimaire, ls_delete
n_ds		lds_tempo
long		ll_rtn, ll_pos, ll_cpt
int		li_FileNum
dec		ldec_valeur

//D$$HEX1$$e900$$ENDHEX$$terminer le sql
ls_sql = "select * from " + as_tbl + " WHERE "

IF IsNull(ad_cur) OR ad_cur < 1901-01-01 THEN
	CHOOSE CASE lower(as_tbl)
		CASE "t_commandeoriginale"
			ls_sql = ls_sql + "(t_commandeoriginale.TransDate Is Null) and date(" + &
				"t_commandeoriginale.DateCommande) <= date(today())"
		CASE ELSE
			ls_sql = ls_sql + "(" + as_tbl + ".TransDate Is Null)"
			// 2009-06-04 S$$HEX1$$e900$$ENDHEX$$bastien Tremblay Pour ne pas retransf$$HEX1$$e900$$ENDHEX$$rer ce qui est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$
			//"or date(" + as_tbl + ".TransDate) = date(today())"
	END CHOOSE
ELSE
	ls_sql = ls_sql + "date(" + as_tbl + ".TransDate) = date('" + string(ad_cur, "yyyy-mm-dd") + "')"
END IF

ls_presentation_str = "style(type=grid)"

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ls_ERRORS)

lds_tempo = CREATE n_ds
ll_rtn = lds_tempo.Create( ls_dwsyntax_str, ls_ERRORS)
IF ll_rtn < 0 THEN
	gnv_app.inv_error.of_message("CIPQ0151",{"Create de dw " + as_tbl, ls_ERRORS, "of_trdatatbl"})
END IF				

lds_tempo.of_settransobject(SQLCA)
ll_rtn = lds_tempo.Retrieve()
ls_string = ""
//IF IsNull(ad_cur) OR ad_cur < 1901-01-01 THEN
	//Le saveas $$HEX1$$e900$$ENDHEX$$crase le fichier et ajoute une entete avec le create
	ls_fichier = "Z:\cipq\" + as_tbl + ".txt"
	lds_tempo.SaveAs(ls_fichier, SQLInsert!, FALSE)
	IF FileExists(ls_fichier) THEN
		li_FileNum = FileOpen(ls_fichier, TextMode!)
		IF li_FileNum < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{"Ouverture de fichier", ls_fichier, "of_trdatatbl"})
		END IF		
		FileReadEX(li_FileNum, ls_string)
		FileClose(li_FileNum)
		
		//Ajuster le contenu du export
		ll_pos = POS(ls_string, "INSERT")
		IF ll_pos > 0 THEN
			ls_string = MID(ls_string, ll_pos)
		ELSE
			ls_string = ""
		END IF
		
		DO WHILE YIELD()
		LOOP
	ELSE
		gnv_app.inv_error.of_message("CIPQ0153", {ls_fichier, "of_trdatatbl" })
	END IF

	// 2009-11-06 - S$$HEX1$$e900$$ENDHEX$$bastien - Pour ne pas $$HEX1$$ea00$$ENDHEX$$tre oblig$$HEX2$$e9002000$$ENDHEX$$de tout parcourir $$HEX2$$e0002000$$ENDHEX$$l'importation,
	//	on ajoute les delete directement dans le fichier
	IF gnv_app.of_getcompagniedefaut() = '110' then
		FOR ll_cpt = 1 TO ll_rtn
			//Selon la table, la cl$$HEX2$$e9002000$$ENDHEX$$est diff$$HEX1$$e900$$ENDHEX$$rente
			ls_cleprimaire = lds_tempo.of_ObtenirExpressionClesPrimaires(ll_cpt)
			ls_delete += "DELETE FROM " + as_tbl + " WHERE " + ls_cleprimaire + ";~r~n"
		NEXT
	END IF
	
//ELSE
//	//Si c'est dans le pass$$HEX1$$e900$$ENDHEX$$, il faut g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer les update NON
//	FOR ll_cpt = 1 TO ll_rtn
//		//Selon la table, la cl$$HEX2$$e9002000$$ENDHEX$$est diff$$HEX1$$e900$$ENDHEX$$rente
//		ls_cleprimaire = lds_tempo.of_ObtenirExpressionClesPrimaires(ll_cpt)
//		ldec_valeur = lds_tempo.GetItemDecimal(ll_cpt, as_fld)
//		ls_string = ls_string + "UPDATE " + as_tbl + " SET " + as_fld + " = " + string(ldec_valeur) + &
//			" WHERE " + ls_cleprimaire + "; ~r~n"
//	END FOR
//	
//END IF
is_ecrire = is_ecrire + "~r~n" + ls_delete + ls_string + " "

IF ISvalid(lds_tempo) THEN Destroy(lds_tempo)

If IsNull(ll_rtn) THEN ll_rtn = 0

IF FileExists(ls_fichier) THEN
	FileDelete(ls_fichier)
END IF

RETURN ll_rtn
end function

public function long of_trfactdet (string as_dirdst, string as_tbl, string as_fld, date ad_cur);//of_TrFactDet
string	ls_sql, ls_errors, ls_presentation_str, ls_dwsyntax_str, ls_string, ls_fichier, ls_cleprimaire, &
			ls_cie_no, ls_liv_no
n_ds		lds_tempo
long		ll_rtn, ll_pos, ll_cpt, ll_ligne_no
int		li_FileNum
dec		ldec_valeur

//D$$HEX1$$e900$$ENDHEX$$terminer le sql

ls_sql = "select " + as_tbl + ".* from " + as_tbl + " INNER JOIN T_StatFacture " +  &
	" ON (T_StatFacture.LIV_NO = " + as_tbl + ".LIV_NO) AND (T_StatFacture.CIE_NO = " + as_tbl + ".CIE_NO) "

IF IsNull(ad_cur) OR ad_cur < 1901-01-01 THEN
	ls_sql = ls_sql + " WHERE (T_StatFacture.TransDate Is Null)"
	//2009-06-04 S$$HEX1$$e900$$ENDHEX$$bastien Tremblay Pour ne pas retransf$$HEX1$$e900$$ENDHEX$$rer ce qui est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$
	//" or date(T_StatFacture.TransDate) = date(today())"
ELSE
	ls_sql = ls_sql + " WHERE date(T_StatFacture.TransDate) = date('" + string(ad_cur, "yyyy-mm-dd") + "')"
END IF

ls_presentation_str = "style(type=grid)"
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ls_ERRORS)

lds_tempo = CREATE n_ds
ll_rtn = lds_tempo.Create( ls_dwsyntax_str, ls_ERRORS)

IF ll_rtn < 0 THEN
	gnv_app.inv_error.of_message("CIPQ0151",{"Create de dw " + as_tbl, ls_ERRORS, "of_trfactdet"})
END IF		
lds_tempo.of_settransobject(SQLCA)
ll_rtn = lds_tempo.Retrieve()
ls_string = ""
//IF IsNull(ad_cur) OR ad_cur < 1901-01-01 THEN
	//Le saveas $$HEX1$$e900$$ENDHEX$$crase le fichier et ajoute une entete avec le create
	ls_fichier = "Z:\cipq\" + as_tbl + ".txt"
	lds_tempo.SaveAs(ls_fichier, SQLInsert!, FALSE)
	IF FileExists(ls_fichier) THEN
		li_FileNum = FileOpen(ls_fichier, TextMode!)
		IF li_FileNum < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151", {"Ouverture de fichier", ls_fichier, "of_trfactdet"})
		END IF	
		FileReadEX(li_FileNum, ls_string)
		FileClose(li_FileNum)
		
		//Ajuster le contenu du export
		ll_pos = POS(ls_string, "INSERT")
		IF ll_pos > 0 THEN
			ls_string = MID(ls_string, ll_pos)
		ELSE
			ls_string = ""
		END IF
		
		DO WHILE YIELD()
		LOOP
	ELSE
		gnv_app.inv_error.of_message("CIPQ0153", {ls_fichier, "of_trfactdet" })
	END IF
//ELSE
//	//Si c'est dans le pass$$HEX1$$e900$$ENDHEX$$, il faut g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer les update   NON
//	FOR ll_cpt = 1 TO ll_rtn
//		//seulement la table t_statfacturedetail
//		ls_cie_no = lds_tempo.object.t_statfacturedetail_cie_no[ll_cpt]
//		ls_liv_no = lds_tempo.object.t_statfacturedetail_liv_no[ll_cpt]
//		ll_ligne_no = lds_tempo.object.t_statfacturedetail_ligne_no[ll_cpt]
//		ls_cleprimaire = "cie_no = '" + ls_cie_no + "' AND liv_no = '" + ls_liv_no + "' AND ligne_no = " + string(ll_ligne_no)
//		ldec_valeur = lds_tempo.GetItemDecimal(ll_cpt, "t_statfacturedetail_" + as_fld)
//		ls_string = ls_string + "UPDATE " + as_tbl + " SET " + as_fld + " = " + string(ldec_valeur) + &
//			" WHERE " + ls_cleprimaire + "; ~r~n"
//		
//	END FOR
//	
//END IF
is_ecrire = is_ecrire + "~r~n" + ls_string + " "

IF ISvalid(lds_tempo) THEN Destroy(lds_tempo)

If IsNull(ll_rtn) THEN ll_rtn = 0

IF FileExists(ls_fichier) THEN
	FileDelete(ls_fichier)
END IF

RETURN ll_rtn
end function

public subroutine of_maj_tbl_faite (string ls_fichier);//of_MAJ_Tbl_Faite

UPDATE T_TransfertAFaire SET afaire = 0;
IF SQLCA.SQLCode <> 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite Mise $$HEX2$$e0002000$$ENDHEX$$jour T_TransfertAFaire", SQLCA.SQLeRRText})
ELSE
	COMMIT USING SQLCA;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faiteMise $$HEX2$$e0002000$$ENDHEX$$jour T_TransfertAFaire", SQLCA.SQLeRRText})
	END IF
END IF

IF gnv_app.of_getcompagniedefaut( ) = "110" THEN
	UPDATE t_Verrat_FicheSante SET t_Verrat_FicheSante.TransDate = Date(today()) WHERE t_Verrat_FicheSante.TransDate Is Null;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_Verrat_FicheSante", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_Verrat_FicheSante", SQLCA.SQLeRRText})
		END IF
	END IF	
ELSE
	//Ne pas updater les archives
	UPDATE T_StatFacture SET T_StatFacture.TransDate = Date(today()) WHERE t_StatFacture.TransDate Is Null
	and T_StatFacture.liv_Date > '2007-01-01';
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_statfacture", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_statfacture", SQLCA.SQLeRRText})
		END IF
	END IF	
	
	UPDATE t_RECOLTE SET t_RECOLTE.TransDate = Date(today()) WHERE t_RECOLTE.TransDate Is Null 
	and t_RECOLTE.date_recolte > '2007-01-01';
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_RECOLTE", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_RECOLTE", SQLCA.SQLeRRText})
		END IF
	END IF	
	
	UPDATE t_CommandeOriginale SET t_CommandeOriginale.TransDate = Date(today()) 
   WHERE t_CommandeOriginale.TransDate Is Null 
	and date(t_CommandeOriginale.DateCommande) <= date(today())
	and t_CommandeOriginale.datecommande > '2007-01-01' ;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_CommandeOriginale", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_CommandeOriginale", SQLCA.SQLeRRText})
		END IF
	END IF	
	
	UPDATE t_AllianceMaternelle_Lot_Distribue SET t_AllianceMaternelle_Lot_Distribue.TransDate = Date(today()) 
   WHERE t_AllianceMaternelle_Lot_Distribue.TransDate Is Null;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_AllianceMaternelle_Lot_Distribue", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_AllianceMaternelle_Lot_Distribue", SQLCA.SQLeRRText})
		END IF
	END IF	
	
	UPDATE t_AllianceMaternelle_Recolte_GestionLot_Verrat 
	SET t_AllianceMaternelle_Recolte_GestionLot_Verrat.TransDate = Date(today())
   WHERE t_AllianceMaternelle_Recolte_GestionLot_Verrat.TransDate Is Null;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_AllianceMaternelle_Recolte_GestionLot_Verrat", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_AllianceMaternelle_Recolte_GestionLot_Verrat", SQLCA.SQLeRRText})
		END IF
	END IF	
	
	UPDATE t_recolte_cote_peremption 
	SET t_recolte_cote_peremption.TransDate = Date(today())
   WHERE t_recolte_cote_peremption.TransDate Is Null;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_recolte_cote_peremption", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"of_maj_tbl_faite maj t_recolte_cote_peremption", SQLCA.SQLeRRText})
		END IF
	END IF	
END IF
end subroutine

public subroutine of_req_tblalliancematernelle_recolte_ges ();//of_Req_tblAllianceMaternelle_Recolte_Ges

string	ls_cie

ls_cie = gnv_app.of_getcompagniedefaut( )

//Si nouveau transfert, ajouter les donn$$HEX1$$e900$$ENDHEX$$es dans la table "T_AllianceMaternelle_Recolte_GestionLot_Verrat"
//Ancien Req_tblAllianceMaternelle_Recolte_GestionLot_Verrat_Ajout
INSERT INTO t_AllianceMaternelle_Recolte_GestionLot_Verrat 
( CIE_NO, DateRecolte, Famille, NoLot, CodeVerrat, TATOUAGE, QteDoseRecolte, QteDoseDistribue )
SELECT DISTINCT
:ls_cie AS NO_CIE, 
t_Recolte_GestionLot_Detail.DateRecolte, 
t_Recolte_GestionLot_Detail.Famille, 
t_Recolte_GestionLot_Detail.NoLot, 
t_Recolte_GestionLot_Detail.CodeVerrat, 
t_Verrat.TATOUAGE, 
t_Recolte_GestionLot_Detail.QteDoseRecolte, 
isnull(QteDoseMelange,0) + isnull(QteDosePure,0) AS QteDoseDistribue
FROM 
t_Recolte_GestionLot_Detail 
INNER JOIN 
(
SELECT 
t_Recolte_GestionLot_Produit.DateRecolte, 
t_Recolte_GestionLot_Produit.Famille, 
t_Recolte_GestionLot_Produit.NoProduit,
t_Recolte_GestionLot_Produit.NoLot
FROM t_Recolte_GestionLot_Produit 
INNER JOIN t_Produit 
ON t_Recolte_GestionLot_Produit.NoProduit = t_Produit.NoProduit
GROUP BY 
t_Recolte_GestionLot_Produit.DateRecolte, 
t_Recolte_GestionLot_Produit.Famille, 
t_Recolte_GestionLot_Produit.NoProduit, 
t_Recolte_GestionLot_Produit.NoLot, 
t_Produit.AllianceMaternelle
HAVING t_Produit.AllianceMaternelle = 1
) as Req_t_Recolte_GestionLot_Produit_AllianceMaternelle 
ON (date(t_Recolte_GestionLot_Detail.DateRecolte) = date(Req_t_Recolte_GestionLot_Produit_AllianceMaternelle.DateRecolte)) 
AND (upper(t_Recolte_GestionLot_Detail.Famille) = upper(Req_t_Recolte_GestionLot_Produit_AllianceMaternelle.Famille)) 
AND (t_Recolte_GestionLot_Detail.NoLot = Req_t_Recolte_GestionLot_Produit_AllianceMaternelle.NoLot) 
LEFT JOIN t_Verrat 
ON t_Recolte_GestionLot_Detail.CodeVerrat = t_Verrat.CodeVerrat
WHERE
date(t_Recolte_GestionLot_Detail.DateRecolte) >= DATEADD ( day, -5, current date)
And date(t_Recolte_GestionLot_Detail.DateRecolte) <= current date
GROUP BY 
NO_CIE, 
t_Recolte_GestionLot_Detail.DateRecolte, 
t_Recolte_GestionLot_Detail.Famille, 
t_Recolte_GestionLot_Detail.NoLot, 
t_Recolte_GestionLot_Detail.CodeVerrat, 
t_Verrat.TATOUAGE, 
t_Recolte_GestionLot_Detail.QteDoseRecolte, 
QteDoseDistribue
// S$$HEX1$$e900$$ENDHEX$$bastien - 2008-10-30
// Pour $$HEX1$$e900$$ENDHEX$$liminer la possibilit$$HEX2$$e9002000$$ENDHEX$$de doublon
having not exists
(select 1 from t_AllianceMaternelle_Recolte_GestionLot_Verrat
where cie_no = no_cie
and dateRecolte = t_Recolte_GestionLot_Detail.DateRecolte
and famille = t_Recolte_GestionLot_Detail.Famille
and noLot = t_Recolte_GestionLot_Detail.NoLot
and codeVerrat = t_Recolte_GestionLot_Detail.CodeVerrat)
USING SQLCA;

IF SQLCA.SQLCode <> 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"of_Req_tblAllianceMaternelle_Recolte_Ges", SQLCA.SQLeRRText})
ELSE
	COMMIT USING SQLCA;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_Req_tblAllianceMaternelle_Recolte_Ges", SQLCA.SQLeRRText})
	END IF
END IF


RETURN
end subroutine

public function integer of_tbldest (string as_fichier, string as_tbl);//of_TblDest
string	ls_sql, ls_errors, ls_presentation_str, ls_dwsyntax_str, ls_string, ls_fichier
n_ds		lds_tempo
long		ll_rtn, ll_pos
int		li_FileNum

//D$$HEX1$$e900$$ENDHEX$$terminer le sql

ls_sql = "select * from " + as_tbl 

ls_presentation_str = "style(type=grid)"
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ls_ERRORS)

lds_tempo = CREATE n_ds
ll_rtn = lds_tempo.Create( ls_dwsyntax_str, ls_ERRORS)
lds_tempo.of_settransobject(SQLCA)
ll_rtn = lds_tempo.Retrieve()

ls_fichier = "Z:\cipq\" + as_tbl + ".txt"
//Le saveas $$HEX1$$e900$$ENDHEX$$crase le fichier et ajoute une entete avec le create
lds_tempo.SaveAs(ls_fichier, SQLInsert!, FALSE)
ls_string = ""
IF FileExists(ls_fichier) THEN
	li_FileNum = FileOpen(ls_fichier, TextMode!)
	IF li_FileNum < 0 THEN
		gnv_app.inv_error.of_message("CIPQ0151",{"Ouverture de fichier", ls_fichier, "of_TblDest"})
	END IF		
	
	FileReadEX(li_FileNum, ls_string)
	FileClose(li_FileNum)
	
	//Ajuster le contenu du export
	ll_pos = POS(ls_string, "INSERT")
	IF ll_pos > 0 THEN
		ls_string = MID(ls_string, ll_pos)
	ELSE
		ls_string = ""
	END IF
	
	DO WHILE YIELD()
	LOOP
ELSE
	gnv_app.inv_error.of_message("CIPQ0153", {ls_fichier, "of_TblDest" })
END IF

IF TRIM(ls_string) <> "" THEN
	is_ecrire = is_ecrire + "~r~nDELETE FROM " + as_tbl + ";"
	is_ecrire = is_ecrire + "~r~n" + ls_string + " "
END IF

IF ISvalid(lds_tempo) THEN Destroy(lds_tempo)

If IsNull(ll_rtn) THEN ll_rtn = 0

IF FileExists(ls_fichier) THEN 
	FileDelete(ls_fichier)
END IF

RETURN ll_rtn
end function

public function boolean of_importer ();//Importer
//Fonction pour importer les donn$$HEX1$$e900$$ENDHEX$$es de pilotage

string	ls_destdir, ls_GetDestName, ls_cie, ls_contenu, ls_sql[], ls_exec_sql, ls_ligne[], ls_vide[], ls_centre,&
			ls_statfact[], ls_recolte[], ls_commorig[], ls_allmatern[], ls_recolte_cote[], ls_nouv_contenu[], ls_centre_sec = ''
int		li_FileNum
long		ll_upper, ll_cpt_ligne, ll_nbmots
boolean	lb_erreurSQL, lb_pas_imp_bons, lb_imp
datetime	ldt_derniere_fact, ldt_livraison

// 2009-11-25 S$$HEX1$$e900$$ENDHEX$$bastien Tremblay -  se servir directement du nom du fichier
//ld_cur = date(gnv_app.inv_entrepotglobal.of_retournedonnee("date transfert"))
//ls_provenance = gnv_app.inv_entrepotglobal.of_retournedonnee("provenance transfert")

ls_GetDestName = gnv_app.inv_entrepotglobal.of_retournedonnee("fichier importation transfert")

lb_pas_imp_bons = gnv_app.inv_entrepotglobal.of_retournedonnee("ne pas importer bons transfert")

ls_destdir = gnv_app.of_getvaleurini( "IMPORT", "ImportDir")
If Right(ls_destdir, 1) <> "\" Then ls_destdir = ls_destdir + "\"

ls_centre = gnv_app.of_getcompagniedefaut( )

//Valider ficher d'importation
//ls_GetDestName = ls_centre + "T" + ls_provenance + "-" + string(day(ld_cur),"00") + string(month(ld_cur),"00") + ".txt"

IF NOT FileExists(ls_destdir + ls_GetDestName) THEN
	gnv_app.inv_error.of_message("CIPQ0154", {ls_destdir + ls_GetDestName})
	RETURN FALSE
END IF

//Extraire le contenu
li_FileNum = FileOpen(ls_destdir + ls_GetDestName, TextMode!)
IF li_FileNum < 0 THEN
	gnv_app.inv_error.of_message("CIPQ0151",{"Ouverture de fichier", ls_destdir + ls_GetDestName, "Importation de fichier (centre-adm)"})
END IF
FileReadEX(li_FileNum, ls_contenu)
FileClose(li_FileNum)

ls_contenu = TRIM(ls_contenu)

IF ls_contenu = "" OR IsNull(ls_contenu) THEN
	gnv_app.inv_error.of_message("CIPQ0155")
	RETURN FALSE
END IF

IF ls_centre = "110" THEN
	
	// 2008-12-07 Mathieu Gendron R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer la derni$$HEX1$$e800$$ENDHEX$$re date de facturation
	select 	max(fact_date) 
	INTO		:ldt_derniere_fact
	from 		t_statfacture 
	where 	fact_date is not null;
	
	
	// ******* SEBAS - 2008-10-30 *******
	//Ajouter les "delete" pour pr$$HEX1$$e900$$ENDHEX$$venir les erreurs de doublon
	ll_upper = gnv_app.inv_string.of_parsetoarray(ls_contenu, ");", ls_sql)
	for ll_cpt_ligne = 1 to ll_upper
		lb_imp = true
		
		choose case true
			// Cas particulier pour les t_statfactureDetail - S$$HEX1$$e900$$ENDHEX$$bastien - 2010-04-01
			case pos(upper(ls_sql[ll_cpt_ligne]), "INSERT INTO T_STATFACTUREDETAIL") > 0
				if lb_pas_imp_bons then
					ls_sql[ll_cpt_ligne] = gnv_app.inv_string.of_globalreplace(ls_sql[ll_cpt_ligne], '~r~n', '')
					
					ls_ligne = ls_vide
					ll_nbmots = gnv_app.inv_string.of_parsetoarray(ls_sql[ll_cpt_ligne], ",", ls_ligne)
					
					// Enlever le premier caract$$HEX1$$e800$$ENDHEX$$re zarbi
					ls_cie = right(ls_ligne[1], 5)
					ls_ligne[2] = mid(ls_ligne[2], 2)
					
					// Ajouter la cl$$HEX2$$e9002000$$ENDHEX$$primaire aux statfactures $$HEX2$$e0002000$$ENDHEX$$supprimer
					lb_imp = (trouvevect(" (cie_no = "+ls_cie+" and liv_no = "+ls_ligne[2]+")", ls_statfact) > 0)
				end if
				
			// Pour les t_recolte_cote_peremption
			case pos(upper(ls_sql[ll_cpt_ligne]), "INSERT INTO T_RECOLTE_COTE_PEREMPTION") > 0
				ls_sql[ll_cpt_ligne] = gnv_app.inv_string.of_globalreplace(ls_sql[ll_cpt_ligne], '~r~n', '')
				
				ls_ligne = ls_vide
				ll_nbmots = gnv_app.inv_string.of_parsetoarray(ls_sql[ll_cpt_ligne], ",", ls_ligne)
				
				// Enlever le premier caract$$HEX1$$e800$$ENDHEX$$re zarbi
				ls_ligne[1] = mid(ls_ligne[1], pos(ls_ligne[1], '(') + 2)
				ls_ligne[2] = mid(ls_ligne[2], 2)
				ls_ligne[3] = mid(ls_ligne[3], 2)
				ls_ligne[4] = mid(ls_ligne[4], 2)
				
				// Ajouter la cl$$HEX2$$e9002000$$ENDHEX$$primaire aux cotes $$HEX2$$e0002000$$ENDHEX$$supprimer
				ls_recolte_cote[upperbound(ls_recolte_cote)+1] = " (cie_no = "+ls_ligne[1]+" and date_recolte = "+ls_ligne[2]+ " and famille = "+ls_ligne[3]+ " and nolot = "+ls_ligne[4] + ")"
				
			// Pour les t_statfacture
			case pos(upper(ls_sql[ll_cpt_ligne]), "INSERT INTO T_STATFACTURE") > 0
				ls_sql[ll_cpt_ligne] = gnv_app.inv_string.of_globalreplace(ls_sql[ll_cpt_ligne], '~r~n', '')
				
				ls_ligne = ls_vide
				ll_nbmots = gnv_app.inv_string.of_parsetoarray(ls_sql[ll_cpt_ligne], ",", ls_ligne)
				
				// Enlever le premier caract$$HEX1$$e800$$ENDHEX$$re zarbi
				ls_cie = right(ls_ligne[1], 5)
				ls_ligne[2] = mid(ls_ligne[2], 2)
				ls_ligne[8] = mid(ls_ligne[8], 2)
				
				// 2008-12-07 Mathieu Gendron Valider si l'importation est pour une date inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date de facturation
				// Comparer la date de livraison (8) $$HEX2$$e0002000$$ENDHEX$$la date de derni$$HEX1$$e800$$ENDHEX$$re facturation
				ldt_livraison = datetime(mid(ls_ligne[8],2,10))
				IF ldt_derniere_fact >= ldt_livraison THEN
					if lb_pas_imp_bons then
						lb_imp = false
					else
						Messagebox("Attention","Il est impossible d'importer des bons de livraison qui sont d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$factur$$HEX1$$e900$$ENDHEX$$s. Le traitement est interrompu.")
						RETURN FALSE
					end if
				ELSE
					// Ajouter la cl$$HEX2$$e9002000$$ENDHEX$$primaire aux statfactures $$HEX2$$e0002000$$ENDHEX$$supprimer
					ls_statfact[upperbound(ls_statfact)+1] = " (cie_no = "+ls_cie+" and liv_no = "+ls_ligne[2]+")"
				END IF
				
			// Pour les t_recolte
			case pos(upper(ls_sql[ll_cpt_ligne]), "INSERT INTO T_RECOLTE") > 0
				ls_sql[ll_cpt_ligne] = gnv_app.inv_string.of_globalreplace(ls_sql[ll_cpt_ligne], '~r~n', '')
				
				ls_ligne = ls_vide
				ll_nbmots = gnv_app.inv_string.of_parsetoarray(ls_sql[ll_cpt_ligne], ",", ls_ligne)
				
				// Enlever le premier caract$$HEX1$$e800$$ENDHEX$$re zarbi
				ls_ligne[1] = mid(ls_ligne[1], pos(ls_ligne[1], '(') + 2)
				ls_ligne[2] = mid(ls_ligne[2], 2)
				
				// Ajouter la cl$$HEX2$$e9002000$$ENDHEX$$primaire aux r$$HEX1$$e900$$ENDHEX$$coltes $$HEX2$$e0002000$$ENDHEX$$supprimer
				ls_recolte[upperbound(ls_recolte)+1] = " (cie_no = "+ls_ligne[2]+" and norecolte = "+ls_ligne[1]+")"
			// Pour les t_commandeoriginale
			case pos(upper(ls_sql[ll_cpt_ligne]), "INSERT INTO T_COMMANDEORIGINALE") > 0
				ls_sql[ll_cpt_ligne] = gnv_app.inv_string.of_globalreplace(ls_sql[ll_cpt_ligne], '~r~n', '')
				
				ls_ligne = ls_vide
				ll_nbmots = gnv_app.inv_string.of_parsetoarray(ls_sql[ll_cpt_ligne], ",", ls_ligne)
				
				// Enlever le premier caract$$HEX1$$e800$$ENDHEX$$re zarbi
				ls_cie = right(ls_ligne[1], 5)
				ls_ligne[2] = mid(ls_ligne[2], 2)
				
				// Ajouter la cl$$HEX2$$e9002000$$ENDHEX$$primaire aux commandes originales $$HEX2$$e0002000$$ENDHEX$$supprimer
				ls_commorig[upperbound(ls_commorig)+1] = " (cieno = "+ls_cie+" and nocommande = "+ls_ligne[2]+")"
			// Pour les t_alliancematernelle_recolte_gestionlot_verrat
			case pos(upper(ls_sql[ll_cpt_ligne]), "INSERT INTO T_ALLIANCEMATERNELLE_RECOLTE_GESTIONLOT_VERRAT") > 0
				ls_sql[ll_cpt_ligne] = gnv_app.inv_string.of_globalreplace(ls_sql[ll_cpt_ligne], '~r~n', '')
				
				ls_ligne = ls_vide
				ll_nbmots = gnv_app.inv_string.of_parsetoarray(ls_sql[ll_cpt_ligne], ",", ls_ligne)
				
				// Enlever le premier caract$$HEX1$$e800$$ENDHEX$$re zarbi
				ls_cie = right(ls_ligne[1], 5)
				ls_ligne[2] = mid(ls_ligne[2], 2)
				ls_ligne[3] = mid(ls_ligne[3], 2)
				ls_ligne[4] = mid(ls_ligne[4], 2)
				ls_ligne[5] = mid(ls_ligne[5], 2)
				
				// Ajouter la cl$$HEX2$$e9002000$$ENDHEX$$primaire aux commandes originales $$HEX2$$e0002000$$ENDHEX$$supprimer
				ls_allmatern[upperbound(ls_allmatern)+1] = " (cie_no = "+ls_cie+" and daterecolte = "+ls_ligne[2]+" and famille = "+ls_ligne[3]+" and nolot = "+ls_ligne[4]+" and codeverrat = "+ls_ligne[5]+")"
		end choose
		
		// S$$HEX1$$e900$$ENDHEX$$bastien - 2009-10-29, case $$HEX2$$e0002000$$ENDHEX$$cocher "ne pas importer les bons de livraison"
		if lb_pas_imp_bons and lb_imp then
			ls_nouv_contenu[upperbound(ls_nouv_contenu) + 1] = ls_sql[ll_cpt_ligne]
		end if
	next

	// Suppression des t_recolte_cote_peremption
	if upperbound(ls_recolte_cote) > 0 then
		gnv_app.inv_string.of_arraytostring(ls_recolte_cote, " or", ls_exec_sql)
		gnv_app.inv_audit.of_runsql_audit("delete from t_recolte_cote_peremption where" + ls_exec_sql, "t_recolte_cote_peremption", "Destruction", "of_importer")
	end if
	
	// Suppression des t_statfacture et des d$$HEX1$$e900$$ENDHEX$$tails
	if upperbound(ls_statfact) > 0 then
		gnv_app.inv_string.of_arraytostring(ls_statfact, " or", ls_exec_sql)
		gnv_app.inv_audit.of_runsql_audit("delete from t_statfacture where" + ls_exec_sql, "t_statfacture", "Destruction", "of_importer")
		gnv_app.inv_audit.of_runsql_audit("delete from t_statfacturedetail where" + ls_exec_sql, "t_statfacture", "Destruction", "of_importer")
	end if
	
	// Suppression des t_recolte
	if upperbound(ls_recolte) > 0 then
		gnv_app.inv_string.of_arraytostring(ls_recolte, " or", ls_exec_sql)
		gnv_app.inv_audit.of_runsql_audit("delete from t_recolte where" + ls_exec_sql, "t_recolte", "Destruction", "of_importer")
	end if
	
	// Suppression des t_commandeoriginale
	if upperbound(ls_commorig) > 0 then
		gnv_app.inv_string.of_arraytostring(ls_commorig, " or", ls_exec_sql)
		gnv_app.inv_audit.of_runsql_audit("delete from t_commandeoriginale where" + ls_exec_sql, "t_commandeoriginale", "Destruction", "of_importer")
	end if
	
	// Suppression des t_alliancematernelle_recolte_gestionlot_verrat
	if upperbound(ls_allmatern) > 0 then
		gnv_app.inv_string.of_arraytostring(ls_allmatern, " or", ls_exec_sql)
		gnv_app.inv_audit.of_runsql_audit("delete from t_alliancematernelle_recolte_gestionlot_verrat where" + ls_exec_sql, "t_alliancematernelle_recolte_gestionlot_verrat", "Destruction", "of_importer")
	end if
	// **********************************
	
	// S$$HEX1$$e900$$ENDHEX$$bastien - 2009-10-29, case $$HEX2$$e0002000$$ENDHEX$$cocher "ne pas importer les bons de livraison"
	if lb_pas_imp_bons then gnv_app.inv_string.of_arraytostring(ls_nouv_contenu, ");~r~n", ls_contenu)
END IF
lb_erreurSQL = false
//Rouler le fichier
EXECUTE IMMEDIATE :ls_contenu USING SQLCA;
IF SQLCA.SQLCode <> 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"(T) SQL import$$HEX1$$e900$$ENDHEX$$s du fichier: " + ls_destdir + ls_GetDestName, SQLCA.SQLeRRText})
	lb_erreurSQL = true
ELSE
	COMMIT USING SQLCA;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"(T) SQL import$$HEX1$$e900$$ENDHEX$$s du fichier: " + ls_destdir + ls_GetDestName, SQLCA.SQLeRRText})
		lb_erreurSQL = true
	END IF
END IF

// Si des erreurs se sont produites lors de l'importation (SQL)
if lb_erreurSQL then
	rollback using SQLCA;
end if

//$$HEX2$$c0002000$$ENDHEX$$la fin, faire certains ajustement
IF POS(ls_contenu, "t_eleveur ") > 0 THEN
	//Si table 't_Eleveur', MAJ de 't_Commande.CodeTransport' et de 't_CommandeRepetitive.CodeTransport'
	//$$HEX2$$c0002000$$ENDHEX$$faire au cas o$$HEX2$$f9002000$$ENDHEX$$le code de transport du client a chang$$HEX2$$e9002000$$ENDHEX$$entre temps
	UPDATE t_Commande INNER JOIN t_eleveur ON t_eleveur.No_Eleveur = t_Commande.No_Eleveur 
	SET t_Commande.CodeTransport = t_eleveur.CodeTransport 
	WHERE date(t_Commande.DateCommande) > date(today()) ;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"MAJ de t_Commande.CodeTransport", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"MAJ de t_Commande.CodeTransport", SQLCA.SQLeRRText})
		END IF
	END IF

	UPDATE t_CommandeRepetitive INNER JOIN t_eleveur 
	ON t_eleveur.No_Eleveur = t_CommandeRepetitive.No_Eleveur 
	SET t_CommandeRepetitive.CodeTransport = t_eleveur.CodeTransport;
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"MAJ de t_CommandeRepetitive.CodeTransport", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"MAJ de t_CommandeRepetitive.CodeTransport", SQLCA.SQLeRRText})
		END IF
	END IF
End If

//Apr$$HEX1$$e800$$ENDHEX$$s l'importation, on supprime toute commande r$$HEX1$$e900$$ENDHEX$$p$$HEX1$$e900$$ENDHEX$$titive dont le client serait devenu soit inactif
DELETE FROM t_CommandeRepetitive
FROM t_CommandeRepetitive
INNER JOIN t_CommandeRepetitiveDetail
ON (t_CommandeRepetitive.NoRepeat = t_CommandeRepetitiveDetail.NoRepeat) 
AND (t_CommandeRepetitive.CieNo = t_CommandeRepetitiveDetail.CieNo) 
INNER JOIN t_Eleveur 
ON t_Eleveur.No_Eleveur = t_CommandeRepetitive.No_Eleveur
WHERE t_Eleveur.chkActivite = 0;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"Supprime commande r$$HEX1$$e900$$ENDHEX$$p$$HEX1$$e900$$ENDHEX$$titive client serait devenu inactif", SQLCA.SQLeRRText})
ELSE
	COMMIT USING SQLCA;
	IF SQLCA.SQLCode < 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"Supprime commande r$$HEX1$$e900$$ENDHEX$$p$$HEX1$$e900$$ENDHEX$$titive client serait devenu inactif", SQLCA.SQLeRRText})
	END IF
END IF
//Le delete cascade d$$HEX1$$e900$$ENDHEX$$truit les d$$HEX1$$e900$$ENDHEX$$tails

//Et on supprime toutes commande sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date du jour 
//dont le client serait devenu inactif ou dans le rouge
ls_exec_sql = "DELETE FROM t_Commande " + &
	"FROM t_Commande " + &
	"INNER JOIN t_ELEVEUR ON t_ELEVEUR.No_Eleveur = t_Commande.No_Eleveur " + &
	"WHERE (t_Eleveur.Rouge =-1 OR t_Eleveur.chkActivite = 0) AND date(t_Commande.DateCommande) > Date(today())"


gnv_app.inv_audit.of_runsql_audit( ls_exec_sql, "t_Commande", "Destruction", "of_importer")
//Le delete cascade d$$HEX1$$e900$$ENDHEX$$truit les d$$HEX1$$e900$$ENDHEX$$tails

// Si on n'est pas $$HEX2$$e0002000$$ENDHEX$$l'administration
if ls_centre <> '110' then
	
	choose case ls_centre
		case '111'
			ls_centre_sec = '115'
		case '112'
			ls_centre_sec = '114'
	end choose
	
	if ls_centre = '111' then
	// Supprimer les fiches sant$$HEX2$$e9002000$$ENDHEX$$des autres centres
		delete from t_Verrat_FicheSante where cie_no <> :ls_centre and cie_no <> :ls_centre_sec and cie_no <> '118' and cie_no <> '119';
		if SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"Suppression des fiches sant$$HEX2$$e9002000$$ENDHEX$$des autres centres", SQLCA.SQLErrText})
		end if
	else
		// Supprimer les fiches sant$$HEX2$$e9002000$$ENDHEX$$des autres centres
		delete from t_Verrat_FicheSante where cie_no <> :ls_centre and cie_no <> :ls_centre_sec;
		if SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"Suppression des fiches sant$$HEX2$$e9002000$$ENDHEX$$des autres centres", SQLCA.SQLErrText})
		end if
	end if

	// Supprimer les mots de passe demand$$HEX1$$e900$$ENDHEX$$s
	delete from t_password
	from t_password inner join t_users on t_users.id_user = t_password.id_user
	where t_users.password is null and t_users.typepass = 'user';
	if SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"R$$HEX1$$e900$$ENDHEX$$initialisation des mots de passe", SQLCA.SQLErrText})
	end if
	
	update t_users set password = login_user where password is null and typepass = 'user';
	if SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"R$$HEX1$$e900$$ENDHEX$$initialisation des mots de passe", SQLCA.SQLErrText})
	end if
end if

FileDelete (ls_destdir + ls_GetDestName)

//Termin$$HEX1$$e900$$ENDHEX$$
iw_importation.st_table.text = "Proc$$HEX1$$e900$$ENDHEX$$dure termin$$HEX1$$e900$$ENDHEX$$e"

Messagebox("Information", "Proc$$HEX1$$e900$$ENDHEX$$dure termin$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$" + string(now()))

RETURN TRUE
end function

public function boolean of_downloadftpfile ();string ls_valeur, ls_sourcdir, ls_destdir
n_cst_dirattrib luo_attrib[]
long j, ll_rtn

// iMPORTATION des fichiers du centre 110

ls_valeur = "VPN" + gnv_app.of_getcompagniedefaut( )
ls_sourcdir = gnv_app.of_getvaleurini("FTP",ls_valeur)
IF LEN(ls_sourcdir) > 0 THEN
	IF NOT FileExists(ls_sourcdir) THEN
		gnv_app.inv_error.of_message("CIPQ0156")
		RETURN FALSE
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0157")
	RETURN FALSE
END IF
IF RIGHT(ls_sourcdir, 1) <> "\" THEN ls_sourcdir += "\"

ls_destdir = gnv_app.of_getvaleurini("FTP","IMPORTPATH")
IF LEN(ls_destdir) > 0 THEN
	IF NOT FileExists(ls_destdir) THEN
		gnv_app.inv_error.of_message("CIPQ0142")
		RETURN FALSE
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0141")
	RETURN FALSE
END IF
IF RIGHT(ls_destdir, 1) <> "\" THEN ls_destdir += "\"

gnv_app.inv_filesrv.of_dirlist(ls_sourcdir + gnv_app.of_getcompagniedefaut( ) + "*.zip", 33, luo_attrib)

for j = 1 to upperbound(luo_attrib)

	//	// N'importer que les fichiers appartenant au centre d$$HEX1$$e900$$ENDHEX$$fini dans les options
	If Left(luo_attrib[j].is_filename, Len(gnv_app.of_getcompagniedefaut( ))) = gnv_app.of_getcompagniedefaut( ) Then
		//D$$HEX1$$e900$$ENDHEX$$placer le fichier dans import
		ll_rtn = FileMove(ls_sourcdir + luo_attrib[j].is_filename, ls_destdir + 'Tmp' + luo_attrib[j].is_filename)
		IF ll_rtn < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{ls_sourcdir + luo_attrib[j].is_filename, ls_destdir + 'Tmp' + luo_attrib[j].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - D$$HEX1$$e900$$ENDHEX$$placer le fichier dans import"})
		END IF
		
		// On renomme le fichier pour enlever le pr$$HEX1$$e900$$ENDHEX$$fixe "Tmp" (la copie est termin$$HEX1$$e900$$ENDHEX$$e)
		ll_rtn = gnv_app.inv_filesrv.of_filerename(ls_destdir + 'Tmp' + luo_attrib[j].is_filename, ls_destdir + luo_attrib[j].is_filename)
		IF ll_rtn < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{ls_destdir + 'Tmp' + luo_attrib[j].is_filename, ls_destdir + luo_attrib[j].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - Renommer le fichier dans import"})
		END IF
		
	END IF
	
next

return true

//// DownloadFTPFile
//// Fonction pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les fichiers qui sont destin$$HEX1$$e900$$ENDHEX$$s
//// au centre administratif dans le FTP
//
//string ls_destdir, ls_cie, ls_sourcdir
//long ll_cpt, ll_rtn
//
////V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire d'importation
//ls_destdir = gnv_app.of_getvaleurini("FTP", "IMPORTPATH")
//IF LEN(ls_destdir) > 0 THEN
//	IF NOT FileExists(ls_destdir) THEN
//		gnv_app.inv_error.of_message("CIPQ0142")
//		RETURN FALSE
//	END IF
//ELSE
//	gnv_app.inv_error.of_message("CIPQ0141")
//	RETURN FALSE
//END IF
//
//IF RIGHT(ls_destdir, 1) <> "\" THEN ls_destdir += "\"
//
////V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire du FTP
//ls_sourcdir = gnv_app.of_getvaleurini("FTP", "FTP_PATH")
//IF LEN(ls_sourcdir) > 0 THEN
//	IF NOT FileExists(ls_sourcdir) THEN
//		gnv_app.inv_error.of_message("CIPQ0156")
//		RETURN FALSE
//	END IF
//ELSE
//	gnv_app.inv_error.of_message("CIPQ0157")
//	RETURN FALSE
//END IF
//
//IF RIGHT(ls_sourcdir, 1) <> "\" THEN ls_sourcdir += "\"
//
//ls_cie = gnv_app.of_getcompagniedefaut()
//
////D$$HEX1$$e900$$ENDHEX$$placer les fichiers
//n_cst_dirattrib lnv_dirlistattrib[]
//gnv_app.inv_filesrv.of_dirlist(ls_sourcdir + ls_cie + "*.*", 0, lnv_dirlistattrib)
//FOR ll_cpt = 1 TO UpperBound(lnv_dirlistattrib)
//
//	// N'importer que les fichiers appartenant au centre d$$HEX1$$e900$$ENDHEX$$fini dans les options
//	If Left(lnv_dirlistattrib[ll_cpt].is_filename, Len(ls_cie)) = ls_cie Then
//		//D$$HEX1$$e900$$ENDHEX$$placer le fichier dans import
//		ll_rtn = FileMove(ls_sourcdir + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename)
//		IF ll_rtn < 0 THEN
//			gnv_app.inv_error.of_message("CIPQ0151",{ls_sourcdir + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - D$$HEX1$$e900$$ENDHEX$$placer le fichier dans import"})
//		END IF
//		
//		// On renomme le fichier pour enlever le pr$$HEX1$$e900$$ENDHEX$$fixe "Tmp" (la copie est termin$$HEX1$$e900$$ENDHEX$$e)
//		ll_rtn = gnv_app.inv_filesrv.of_filerename(ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + lnv_dirlistattrib[ll_cpt].is_filename)
//		IF ll_rtn < 0 THEN
//			gnv_app.inv_error.of_message("CIPQ0151",{ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - Renommer le fichier dans import"})
//		END IF
//		
//	END IF
//
//NEXT
//
//RETURN TRUE
//
end function

public function boolean of_uploadftpfile ();// UploadFTPFile
// Fonction pour envoyer les fichiers qui sont destin$$HEX1$$e900$$ENDHEX$$s
// aux centres dans le FTP

string ls_destdir, ls_sourcdir
long ll_cpt, ll_rtn

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire d'importation
//ls_destdir = gnv_app.of_getvaleurini("FTP", "FTP_PATH")
//IF LEN(ls_destdir) > 0 THEN
//	IF NOT FileExists(ls_destdir) THEN
//		gnv_app.inv_error.of_message("CIPQ0156")
//		RETURN FALSE
//	END IF
//ELSE
//	gnv_app.inv_error.of_message("CIPQ0157")
//	RETURN FALSE
//END IF

IF RIGHT(ls_destdir, 1) <> "\" THEN ls_destdir += "\"

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire du FTP
ls_sourcdir = gnv_app.of_getvaleurini("FTP", "EXPORTPATH")
IF LEN(ls_sourcdir) > 0 THEN
	IF NOT FileExists(ls_sourcdir) THEN
		gnv_app.inv_error.of_message("CIPQ0139")
		RETURN FALSE
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0140")
	RETURN FALSE
END IF

IF RIGHT(ls_sourcdir, 1) <> "\" THEN ls_sourcdir += "\"

//D$$HEX1$$e900$$ENDHEX$$placer les fichiers
n_cst_dirattrib lnv_dirlistattrib[]
gnv_app.inv_filesrv.of_dirlist(ls_sourcdir + "*.zip", 0, lnv_dirlistattrib)
FOR ll_cpt = 1 TO UpperBound(lnv_dirlistattrib)
	
	CHOOSE CASE left(lnv_dirlistattrib[ll_cpt].is_filename,3)
		CASE '110'
			ls_destdir = gnv_app.of_getvaleurini("FTP","VPN110")
		CASE '111'
			ls_destdir = gnv_app.of_getvaleurini("FTP","VPN111")
		CASE '112'
			ls_destdir = gnv_app.of_getvaleurini("FTP","VPN112")
		CASE '113'
			ls_destdir = gnv_app.of_getvaleurini("FTP","VPN113")
		CASE '116'
			ls_destdir = gnv_app.of_getvaleurini("FTP","VPN116")
	END CHOOSE
	
	IF LEN(ls_destdir) > 0 THEN
		IF NOT FileExists(ls_destdir) THEN
			gnv_app.inv_error.of_message("CIPQ0156")
			RETURN FALSE
		END IF
	ELSE
		gnv_app.inv_error.of_message("CIPQ0157")
		RETURN FALSE
	END IF

	// N'importer que les fichiers appartenant au centre d$$HEX1$$e900$$ENDHEX$$fini dans les options
	If upper(Left(lnv_dirlistattrib[ll_cpt].is_filename, 3)) <> 'TMP' Then
		//D$$HEX1$$e900$$ENDHEX$$placer le fichier dans import
		ll_rtn = FileMove(ls_sourcdir + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename)
		IF ll_rtn < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{ls_sourcdir + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - D$$HEX1$$e900$$ENDHEX$$placer le fichier dans import"})
		END IF
		
		// On renomme le fichier pour enlever le pr$$HEX1$$e900$$ENDHEX$$fixe "Tmp" (la copie est termin$$HEX1$$e900$$ENDHEX$$e)
		ll_rtn = gnv_app.inv_filesrv.of_filerename(ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + lnv_dirlistattrib[ll_cpt].is_filename)
		IF ll_rtn < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - Renommer le fichier dans import"})
		END IF
		
	END IF

NEXT

RETURN TRUE

end function

public function boolean of_importfichiers ();// DownloadFTPFile
// Fonction pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les fichiers qui sont destin$$HEX1$$e900$$ENDHEX$$s
// au centre administratif dans le FTP

string ls_destdir, ls_cie, ls_sourcdir, ls_savedir, ls_nom_fichier, ls_fichier, ls_ext, ls_dest_alt_dir
long ll_cpt, ll_rtn

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire d'importation
ls_sourcdir = gnv_app.of_getvaleurini("FTP", "IMPORTPATH")
IF LEN(ls_sourcdir) > 0 THEN
	IF NOT FileExists(ls_sourcdir) THEN
		gnv_app.inv_error.of_message("CIPQ0142")
		RETURN FALSE
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0141")
	RETURN FALSE
END IF

IF RIGHT(ls_sourcdir, 1) <> "\" THEN ls_sourcdir += "\"

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire de sauvegarde des fichiers import$$HEX1$$e900$$ENDHEX$$s
ls_savedir = gnv_app.of_getvaleurini("FTP", "IMPORTPATHOLD")
IF LEN(ls_savedir) > 0 THEN
	IF NOT FileExists(ls_savedir) THEN
		gnv_app.inv_error.of_message("CIPQ0143")
		RETURN FALSE
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0144")
	RETURN FALSE
END IF

IF RIGHT(ls_savedir, 1) <> "\" THEN ls_savedir += "\"

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire de traitement des fichiers import$$HEX1$$e900$$ENDHEX$$s
ls_destdir = gnv_app.of_getvaleurini("IMPORT", "ImportDir")
IF LEN(ls_destdir) > 0 THEN
	IF NOT FileExists(ls_destdir) THEN
		gnv_app.inv_error.of_message("CIPQ0150")
		RETURN FALSE
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0150")
	RETURN FALSE
END IF

IF RIGHT(ls_destdir, 1) <> "\" THEN ls_destdir += "\"

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire de traitement des fichiers rapports import$$HEX1$$e900$$ENDHEX$$s
ls_dest_alt_dir = gnv_app.of_getvaleurini("IMPORT", "ReportDir")
IF RIGHT(ls_dest_alt_dir, 1) <> "\" THEN ls_dest_alt_dir += "\"

ls_cie = gnv_app.of_getcompagniedefaut()

//D$$HEX1$$e900$$ENDHEX$$placer les fichiers
n_cst_dirattrib lnv_dirlistattrib[]
gnv_app.inv_filesrv.of_dirlist(ls_sourcdir + ls_cie + "*.*", 0, lnv_dirlistattrib)
FOR ll_cpt = 1 TO UpperBound(lnv_dirlistattrib)
	if upper(mid(lnv_dirlistattrib[ll_cpt].is_filename, 4, 1)) = 'P' then
		// D$$HEX1$$e900$$ENDHEX$$placer le fichier dans le r$$HEX1$$e900$$ENDHEX$$pertoire des fichiers rapports
		
		ll_rtn = FileMove(ls_sourcdir + lnv_dirlistattrib[ll_cpt].is_filename, ls_dest_alt_dir + lnv_dirlistattrib[ll_cpt].is_filename)
		IF ll_rtn < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{ls_sourcdir + lnv_dirlistattrib[ll_cpt].is_filename, ls_dest_alt_dir + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - D$$HEX1$$e900$$ENDHEX$$placer le fichier dans rapports"})
		END IF
	else
		
		// Copie de sauvegarde du fichier
		ll_rtn = FileCopy(ls_sourcdir + lnv_dirlistattrib[ll_cpt].is_filename, ls_savedir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, TRUE)
		IF ll_rtn < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{ls_sourcdir + lnv_dirlistattrib[ll_cpt].is_filename, ls_savedir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - Copier le fichier dans importold"})
		END IF
		
		do while yield()
		loop
		
		// On renomme le fichier pour enlever le pr$$HEX1$$e900$$ENDHEX$$fixe "Tmp" (la copie est termin$$HEX1$$e900$$ENDHEX$$e)
		
		//2008-11-26 Mathieu Gendron V$$HEX1$$e900$$ENDHEX$$rifier si le fichier existe deja
		IF NOT FileExists(ls_savedir + lnv_dirlistattrib[ll_cpt].is_filename) THEN
			ll_rtn = gnv_app.inv_filesrv.of_filerename(ls_savedir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_savedir + lnv_dirlistattrib[ll_cpt].is_filename)
			IF ll_rtn < 0 THEN
				gnv_app.inv_error.of_message("CIPQ0151",{ls_savedir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_savedir + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - Renommer le fichier dans importold"})
			END IF
		ELSE
			ll_rtn = gnv_app.inv_filesrv.of_filerename(ls_savedir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_savedir + string(hour(now())) + "_" + string(minute(now())) + "_" + lnv_dirlistattrib[ll_cpt].is_filename)
			IF ll_rtn < 0 THEN
				gnv_app.inv_error.of_message("CIPQ0151",{ls_savedir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_savedir + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - Renommer le fichier dans importold"})
			END IF
		END IF
		
		// D$$HEX1$$e900$$ENDHEX$$placer le fichier dans le r$$HEX1$$e900$$ENDHEX$$pertoire de traitement
		
		ll_rtn = FileMove(ls_sourcdir + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename)
		IF ll_rtn < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{ls_sourcdir + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - D$$HEX1$$e900$$ENDHEX$$placer le fichier dans recoie"})
		END IF
	
		do while yield()
		loop
		
		// On renomme le fichier pour enlever le pr$$HEX1$$e900$$ENDHEX$$fixe "Tmp" (la copie est termin$$HEX1$$e900$$ENDHEX$$e)
		
		// 2009-11-25 S$$HEX1$$e900$$ENDHEX$$bastien Tremblay - V$$HEX1$$e900$$ENDHEX$$rifier si le fichier existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$
		if FileExists(ls_destdir + lnv_dirlistattrib[ll_cpt].is_filename) then
			ll_rtn = lastPos(lnv_dirlistattrib[ll_cpt].is_filename, '.')
			if ll_rtn > 0 then
				ls_fichier = left(lnv_dirlistattrib[ll_cpt].is_filename, ll_rtn - 1)
				ls_ext = mid(lnv_dirlistattrib[ll_cpt].is_filename, ll_rtn)
			else
				ls_fichier = lnv_dirlistattrib[ll_cpt].is_filename
				ls_ext = ""
			end if
			ll_rtn = 0
			
			do
				ll_rtn ++
				ls_nom_fichier = ls_fichier + '-' + string(ll_rtn) + ls_ext
			loop while FileExists(ls_destdir + ls_nom_fichier)
		else
			ls_nom_fichier = lnv_dirlistattrib[ll_cpt].is_filename
		end if
		
		ll_rtn = gnv_app.inv_filesrv.of_filerename(ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + ls_nom_fichier)
		IF ll_rtn < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{ls_destdir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_destdir + ls_nom_fichier, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (centre admin) - Renommer le fichier dans recoie"})
		END IF
	end if
NEXT

RETURN TRUE

end function

on n_cst_transfert_centre_adm.create
call super::create
end on

on n_cst_transfert_centre_adm.destroy
call super::destroy
end on


﻿$PBExportHeader$n_cst_transfert_internet.sru
forward
global type n_cst_transfert_internet from n_base
end type
end forward

global type n_cst_transfert_internet from n_base autoinstantiate
end type

type variables
string is_produit[], is_sous-groupe[], is_no_facture[]
dec    idec_prix[]
long   il_no_eleveur[]
end variables

forward prototypes
public subroutine of_transfertproductionspermatique (u_dw adw_current)
public subroutine of_transfertsommairefacture (u_dw adw_current)
public subroutine of_transfertdetailfacture (u_dw adw_current)
public subroutine of_transfertexpheb (u_dw adw_current, string as_typerapport)
end prototypes

public subroutine of_transfertproductionspermatique (u_dw adw_current);//of_TransfertProductionSpermatique

string	ls_path, ls_fichier, ls_source, ls_CIE_NO, ls_CodeVerrat, ls_CodeRACE, ls_TYPE_SEM, ls_date, ls_sql, &
			ls_code_hebergeur = "", ls_code_hebergeur_new
n_tr		ltr_mdb
date		ld_de, ld_au
long		ll_cpt, ll_Nbr_Sperm, ll_MOTILITE_P, ll_PREPOSE
date		ldt_DATE
dec		ldec_VOLUME, ldec_Concentration, ldec_AMPO_TOTAL

ls_path = gnv_app.of_getvaleurini( "ELEVEUR", "EXPORT_MDB_DIR")

//Valider s'il c'est toujours le même groupe d'hébergeur
FOR ll_cpt = 1 TO adw_current.RowCount()
	//ls_code_hebergeur_new = adw_current.object.codehebergeur[ll_cpt]
	ls_code_hebergeur_new = adw_current.object.code_hebergeur[ll_cpt]
	If ll_cpt <> 1 THEN
		IF ls_code_hebergeur_new <> ls_code_hebergeur THEN
			Messagebox("Attention", "Il est impossible d'exporter pour plus d'un hébergeur à la fois.")
			RETURN
		END IF
	END IF
	ls_code_hebergeur = ls_code_hebergeur_new
END FOR


IF NOT(ls_path = "" OR IsNull(ls_path)) THEN
	IF RIGHT(ls_path,1) <> "\" THEN ls_path += "\"
	
	SetPointer(Hourglass!)
	
	//Préparer le fichier
	ls_source = ls_path + "CIPQ_PrSperm.mdb"
	ls_fichier = ls_code_hebergeur + "_CIPQ_PrSperm_" + string(year(today())) + string(month(today()),"00") + string(day(today()),"00") + ".mdb"
	ls_fichier = "U:\transfert\" + ls_fichier
	
	gnv_app.inv_filesrv.of_filecopy( ls_source, ls_fichier, FALSE)

	do while yield()
	loop
	
	// Se connecter
	ltr_mdb = CREATE n_tr
	
	SQLCA.of_copyto(ltr_mdb)
	
 	ltr_mdb.DBMS = "OLE DB"
	ltr_mdb.AutoCommit = False
	ltr_mdb.DBParm = "DATASOURCE='" + ls_fichier + "',PROVIDER='Microsoft.Jet.OLEDB.4.0',PROVIDERSTRING=''PBTrimCharColumns='Yes'',OJSyntax='ANSI'"	

	ltr_mdb.of_connect()
	
	//Vider la table
	DELETE FROM Tmp_ProductionSpermatique USING ltr_mdb ;
	
	//Procéder au transfert
	FOR ll_cpt = 1 TO adw_current.RowCount()
		
		
		SetPointer(Hourglass!)
		
		ls_CIE_NO = left(adw_current.object.cie_no[ll_cpt], 3)
		IF IsNull(ls_CIE_NO) THEN ls_CIE_NO = ""
		ls_CodeVerrat = left(adw_current.object.codeverrat[ll_cpt], 12)
		IF IsNull(ls_CodeVerrat) THEN ls_CodeVerrat = ""
		ls_CodeRACE = left(adw_current.object.coderace[ll_cpt], 4)
		IF IsNull(ls_CodeRACE) THEN ls_CodeRACE = ""
		ldt_DATE = date(adw_current.object.date_recolte[ll_cpt])
		ldec_VOLUME = adw_current.object.volume[ll_cpt]
		IF IsNull(ldec_VOLUME) THEN ldec_VOLUME = 0
		ldec_Concentration = adw_current.object.concentration[ll_cpt]
		IF IsNull(ldec_Concentration) THEN ldec_Concentration = 0
		ll_Nbr_Sperm = adw_current.object.nbr_sperm[ll_cpt]
		IF IsNull(ll_Nbr_Sperm) THEN ll_Nbr_Sperm = 0
		ll_MOTILITE_P = adw_current.object.motilite_p[ll_cpt]
		IF IsNull(ll_MOTILITE_P) THEN ll_MOTILITE_P = 0
		ldec_AMPO_TOTAL = adw_current.object.ampo_total[ll_cpt]
		IF IsNull(ldec_AMPO_TOTAL) THEN ldec_AMPO_TOTAL = 0
		ls_TYPE_SEM = left(adw_current.object.type_sem[ll_cpt], 2)
		IF IsNull(ls_TYPE_SEM) THEN ls_TYPE_SEM = ""
		ll_PREPOSE = adw_current.object.PREPOSE[ll_cpt]
		IF IsNull(ll_PREPOSE) THEN ll_PREPOSE = 0
		ls_date = "#" + string(ldt_DATE, "MM/dd/yyyy") + "#"
		IF IsNull(ls_date) THEN ls_date = ""
		
		ls_sql = "INSERT INTO Tmp_ProductionSpermatique VALUES" + &
			" ('" + ls_cie_no + "', '" + ls_codeverrat + "', '" + ls_coderace + "'," + ls_date + &
			", " + string(ldec_VOLUME) + ", " + string(ldec_Concentration) + ", " + &
			string(ll_Nbr_Sperm) + ", " + string(ll_MOTILITE_P) + ", " + string(ldec_AMPO_TOTAL) + &
			", '" + ls_TYPE_SEM + "', " + string(ll_prepose) + ")"
			
		IF IsNull(ls_sql) THEN
			gnv_app.inv_error.of_message("CIPQ0158", {"Verrat: " + ls_CodeVerrat})
		ELSE
			EXECUTE IMMEDIATE :ls_sql USING ltr_mdb;
			commit using ltr_mdb ;
		END IF 
	END FOR
		
	ltr_mdb.of_disconnect( )
	If IsValid(ltr_mdb) THEN Destroy(ltr_mdb)
	
ELSE
	Messagebox("Erreur", "Impossible de continuer, la valeur EXPORT_MDB_DIR de cipq.ini est indéfinie.")
	
END IF

RETURN
end subroutine

public subroutine of_transfertsommairefacture (u_dw adw_current);//of_TransfertSommaireFacture

string	ls_path, ls_fichier, ls_source, ls_nom, ls_no_facture, ls_sql, ls_sous_groupe, ls_groupe
n_tr		ltr_mdb
long		ll_cpt, ll_no_eleveur, ll_ancien_groupe, ll_groupe, ll_sous_groupe
decimal 	ldec_tps, ldec_tvq, ldec_pourc_tps, ldec_pourc_tvq, ldec_total, ldec_sous_total

ll_ancien_groupe = -1
ll_groupe = 0

ls_path = gnv_app.of_getvaleurini( "ELEVEUR", "EXPORT_MDB_DIR")

SetPointer(Hourglass!)

IF NOT(ls_path = "" OR IsNull(ls_path)) THEN
	IF RIGHT(ls_path,1) <> "\" THEN ls_path += "\"
	
	SetPointer(Hourglass!)
	ltr_mdb = CREATE n_tr

	//Procéder au transfert
	
	//Looper selon les groupes
	FOR ll_cpt = 1 TO adw_current.RowCount()
		
		SetPointer(Hourglass!)
		
		ll_groupe = adw_current.object.idgroup[ll_cpt]
		
		//Si changement de groupe, recréer un nouveau fichier
		IF ll_groupe <> ll_ancien_groupe THEN
			
			ltr_mdb.of_disconnect( )
			ls_groupe = LEFT(adw_current.object.description[ll_cpt] , 4)
			If isNull(ls_groupe) THEN ls_groupe = ""
			
			//Préparer le fichier
			ls_source = ls_path + "SomFact.mdb"
			ls_fichier = ls_groupe + "_SomFact_" + string(year(today())) + string(month(today()),"00") + string(day(today()),"00") + ".mdb"
			ls_fichier = "U:\transfert\" + ls_fichier
			
			gnv_app.inv_filesrv.of_filecopy( ls_source, ls_fichier, FALSE)
		
			do while yield()
			loop
			
			// Se connecter
			SQLCA.of_copyto(ltr_mdb)
			
			ltr_mdb.DBMS = "OLE DB"
			ltr_mdb.AutoCommit = False
			ltr_mdb.DBParm = "DATASOURCE='" + ls_fichier + "',PROVIDER='Microsoft.Jet.OLEDB.4.0',PROVIDERSTRING=''PBTrimCharColumns='Yes'',OJSyntax='ANSI'"	
		
			ltr_mdb.of_connect()			
				
			ll_ancien_groupe = ll_groupe
		END IF
		
		ll_sous_groupe = adw_current.object.idgroupsecondaire[ll_cpt]
		ll_no_eleveur = adw_current.object.no_eleveur[ll_cpt]
		IF IsNull(ll_no_eleveur) THEN ll_no_eleveur = 0
		ls_nom = adw_current.object.nom[ll_cpt]
		ls_nom = left(gnv_app.inv_string.of_globalreplace(ls_nom, "'", "''" ), 30)
		IF IsNull(ls_nom) THEN ls_nom = ''
		ls_no_facture = left(adw_current.object.fact_no[ll_cpt], 8)
		IF IsNull(ls_no_facture) THEN ls_no_facture = ''
		ldec_sous_total = Round(adw_current.object.sommedevente[ll_cpt],2)
		IF IsNull(ldec_sous_total) THEN ldec_sous_total = 0
		ldec_tps = adw_current.object.cf_tps_ligne[ll_cpt]
		IF IsNull(ldec_tps) THEN ldec_tps = 0
		ldec_tvq = adw_current.object.cf_tvq_ligne[ll_cpt]
		IF IsNull(ldec_tvq) THEN ldec_tvq = 0
		ldec_total = Round(adw_current.object.cf_total_ligne[ll_cpt],2)
		IF IsNull(ldec_total) THEN ldec_total = 0
		ldec_pourc_tps = adw_current.object.pourc_fed[ll_cpt]
		IF IsNull(ldec_pourc_tps) THEN ldec_pourc_tps = 0
		ldec_pourc_tvq = adw_current.object.pourc_prov[ll_cpt]
		IF IsNull(ldec_pourc_tvq) THEN ldec_pourc_tvq = 0
		ls_sous_groupe = adw_current.object.nomgroupsecondaire[ll_cpt]
		ls_sous_groupe = left(gnv_app.inv_string.of_globalreplace(ls_sous_groupe, "'", "''" ), 50)
		IF IsNull(ls_sous_groupe) THEN ls_sous_groupe = ''
		
		ls_sql = "INSERT INTO SommaireFacture VALUES" + &
			"('" + ls_sous_groupe + "', " + string(ll_no_eleveur) + ", '" + ls_nom + "', '" + ls_no_facture + &
			"', " + string(ldec_sous_total) + ", " + string(ldec_pourc_tps) + ", " + string(ldec_pourc_tvq) + ", " + &
			string(ldec_tps) + ", " + string(ldec_tvq) + ", " + string(ldec_total) + ")"

		IF IsNull(ls_sql) THEN
			gnv_app.inv_error.of_message("CIPQ0158", {"Éleveur: " + string(ll_no_eleveur)})
		ELSE
			EXECUTE IMMEDIATE :ls_sql USING ltr_mdb;
			commit using ltr_mdb ;
		END IF

	END FOR
	
	ltr_mdb.of_disconnect( )
	If IsValid(ltr_mdb) THEN Destroy(ltr_mdb)
	
ELSE
	Messagebox("Erreur", "Impossible de continuer, la valeur EXPORT_MDB_DIR de cipq.ini est indéfinie.")
	
END IF

RETURN
end subroutine

public subroutine of_transfertdetailfacture (u_dw adw_current);//of_TransfertDetailFacture
string	ls_path, ls_fichier, ls_source, ls_nom, ls_no_facture, ls_sql, ls_sous_groupe, ls_groupe, &
			ls_adresse, ls_rue, ls_ville, ls_conte, ls_code_post, ls_produit, ls_description, &
			ls_sous_groupe_tempo = "", ls_produit_tempo = "", ls_no_facture_tempo = "", ls_prix
n_tr		ltr_mdb
long		ll_cpt, ll_no_eleveur, ll_ancien_groupe, ll_groupe, ll_sous_groupe, ll_no_eleveur_tempo = 0,ll_count
decimal 	ldec_tps, ldec_tvq, ldec_pourc_tps, ldec_pourc_tvq, ldec_total, ldec_sous_total, ldec_qte, ldec_prix, &
			ldec_qtetempo, ldec_prixtempo
			
string   ls_tab_produit[]
long     i, ll_query, ll_nb

ll_ancien_groupe = -1
ll_groupe = 0

ls_path = gnv_app.of_getvaleurini( "ELEVEUR", "EXPORT_MDB_DIR")

SetPointer(Hourglass!)
/*
ls_sql = "create table #TMP_LIGNE_TRANS (produit varchar(16) not null,~r~n" + &
													  "sousgroup varchar(50) not null,~r~n" + &
													  "no_fact varchar(8) not null,~r~n" + &
													  "prix double null,~r~n" + &
													  "no_eleveur integer not null)"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
*/
IF NOT(ls_path = "" OR IsNull(ls_path)) THEN
	IF RIGHT(ls_path,1) <> "\" THEN ls_path += "\"
	
	SetPointer(Hourglass!)
	ltr_mdb = CREATE n_tr

	//Procéder au transfert
	
	//Looper selon les groupes
	
	//adw_current.SetSort("description asc, nomgroupsecondaire asc, no_eleveur asc, fact_no asc, embal asc")
	
	FOR ll_cpt = 1 TO adw_current.RowCount()
		
		SetPointer(Hourglass!)
		
		ll_groupe = adw_current.object.idgroup[ll_cpt]
		
		//Si changement de groupe, recréer un nouveau fichier
		IF ll_groupe <> ll_ancien_groupe OR (IsNull(ll_groupe) AND NOT IsNull(ll_ancien_groupe )) OR &
			(IsNull(ll_ancien_groupe) AND NOT IsNull(ll_groupe )) THEN
			
			ldec_qte = 0
			ldec_total = 0
			
			ltr_mdb.of_disconnect( )
			ls_groupe = LEFT(adw_current.object.description[ll_cpt] , 4)
			If isNull(ls_groupe) THEN ls_groupe = ""
			
			//Préparer le fichier
			ls_source = ls_path + "SomDetFact.mdb"
			ls_fichier = ls_groupe + "_SomDetFact_" + string(year(today())) + string(month(today()),"00") + string(day(today()),"00") + ".mdb"
			ls_fichier = "U:\transfert\" + ls_fichier
			
			gnv_app.inv_filesrv.of_filecopy( ls_source, ls_fichier, FALSE)
		
			do while yield()
			loop
			
			// Se connecter
			SQLCA.of_copyto(ltr_mdb)
			
			ltr_mdb.DBMS = "OLE DB"
			ltr_mdb.AutoCommit = False
			ltr_mdb.DBParm = "DATASOURCE='" + ls_fichier + "',PROVIDER='Microsoft.Jet.OLEDB.4.0',PROVIDERSTRING=''PBTrimCharColumns='Yes'',OJSyntax='ANSI'"	
		
			ltr_mdb.of_connect()			
				
			ll_ancien_groupe = ll_groupe
		END IF
		
		ll_sous_groupe = adw_current.object.idgroupsecondaire[ll_cpt]
		ll_no_eleveur_tempo = adw_current.object.no_eleveur[ll_cpt]
		ls_nom = adw_current.object.nom[ll_cpt]
		ls_nom = left(gnv_app.inv_string.of_globalreplace(ls_nom, "'", "''" ), 30)
		IF IsNull(ls_nom) THEN ls_nom = ''
		ls_adresse = adw_current.object.adresse[ll_cpt]
		ls_adresse = left(gnv_app.inv_string.of_globalreplace(ls_adresse, "'", "''" ), 6)
		IF IsNull(ls_adresse) THEN ls_adresse = ''
		ls_rue = adw_current.object.rue[ll_cpt]
		ls_rue = left(gnv_app.inv_string.of_globalreplace(ls_rue, "'", "''" ), 23)
		IF IsNull(ls_rue) THEN ls_rue = ''
		ls_ville = adw_current.object.ville[ll_cpt]
		ls_ville = left(gnv_app.inv_string.of_globalreplace(ls_ville, "'", "''" ), 30)
		IF IsNull(ls_ville) THEN ls_ville = ''
		ls_conte = adw_current.object.conte[ll_cpt]
		ls_conte = left(gnv_app.inv_string.of_globalreplace(ls_conte, "'", "''" ), 15)
		IF IsNull(ls_conte) THEN ls_conte = ''
		ls_code_post = adw_current.object.code_post[ll_cpt]
		ls_code_post = left(gnv_app.inv_string.of_globalreplace(ls_code_post, "'", "''" ), 7)
		IF IsNull(ls_code_post) THEN ls_code_post = ''
		ls_no_facture_tempo = adw_current.object.fact_no[ll_cpt]
		ls_no_facture_tempo = left(gnv_app.inv_string.of_globalreplace(ls_no_facture_tempo, "'", "''" ), 8)
		IF IsNull(ls_no_facture_tempo) THEN ls_no_facture_tempo = ''
		ls_produit_tempo = adw_current.object.cf_produit[ll_cpt]
		ls_produit_tempo = left(gnv_app.inv_string.of_globalreplace(ls_produit_tempo, "'", "''" ), 255)
		IF IsNull(ls_produit_tempo) THEN ls_produit_tempo = ''
		ls_description = adw_current.object.cf_desc[ll_cpt]
		ls_description = left(gnv_app.inv_string.of_globalreplace(ls_description, "'", "''" ), 255)
		IF IsNull(ls_description) THEN ls_description = ''
		ldec_qtetempo = adw_current.object.sommedeqte_exp[ll_cpt]
		IF IsNull(ldec_qtetempo) THEN ldec_qtetempo = 0
		ldec_prixtempo = round(adw_current.object.uprix[ll_cpt], 2)
		IF IsNull(ldec_prixtempo) THEN ldec_prixtempo = 0
		
		ldec_pourc_tps = adw_current.object.pourc_fed[ll_cpt]
		IF IsNull(ldec_pourc_tps) THEN ldec_pourc_tps = 0
		ldec_pourc_tvq = adw_current.object.pourc_prov[ll_cpt]
		IF IsNull(ldec_pourc_tvq) THEN ldec_pourc_tvq = 0
		
		ls_sous_groupe_tempo = adw_current.object.nomgroupsecondaire[ll_cpt]
		ls_sous_groupe_tempo = left(gnv_app.inv_string.of_globalreplace(ls_sous_groupe_tempo, "'", "''" ), 50)
		IF IsNull(ls_sous_groupe_tempo) THEN ls_sous_groupe_tempo = ''
		
		  
		IF ls_produit <> ls_produit_tempo OR ls_sous_groupe <> ls_sous_groupe_tempo OR &
		ll_no_eleveur_tempo <> ll_no_eleveur OR ls_no_facture_tempo <> ls_no_facture OR &
		ldec_prixtempo <> ldec_prix THEN
		

	/*	SELECT count(1) 
		  INTO :ll_count
		  FROM #TMP_LIGNE_TRANS 
		 WHERE produit   = :ls_produit_tempo 
		   AND sousgroup = :ls_sous_groupe_tempo 
			AND no_fact   = :ls_no_facture_tempo
		   AND prix      = :ldec_prixtempo
		   AND no_eleveur= :ll_no_eleveur_tempo;
COMMIT USING SQLCA;

		if ll_count = 0 then
			
			INSERT INTO #TMP_LIGNE_TRANS(produit,sousgroup,no_fact,prix,no_eleveur)
	      VALUES (:ls_produit_tempo,:ls_sous_groupe_tempo,:ls_no_facture_tempo,:ldec_prixtempo,:ll_no_eleveur_tempo);
			COMMIT USING SQLCA;
*/
			ls_produit     = ls_produit_tempo
			ls_sous_groupe = ls_sous_groupe_tempo
			ll_no_eleveur  = ll_no_eleveur_tempo
			ls_no_facture  = ls_no_facture_tempo
			ldec_prix      = ldec_prixtempo
			ldec_qte       = ldec_qtetempo
			ldec_total     = round(ldec_qtetempo * ldec_prix, 2)
			
			IF IsNull(ldec_total) THEN ldec_total = 0
			
			ls_sql = "INSERT INTO SommaireDetailFacture VALUES" + &
				"('" + ls_sous_groupe + "', " + string(ll_no_eleveur) + ", '" + ls_nom + "', '" + ls_adresse + &
				"', '" + ls_rue + "', '" + ls_ville + "', '" + ls_conte + "', '" + ls_code_post + "', '" + &
				ls_no_facture + "', '" + ls_produit + "', '" + ls_description + "', " + string(ldec_qte) + &
				", " + string(ldec_prix) + ", " + string(ldec_total) + ", " + string(ldec_pourc_tps) + &
				", " + string(ldec_pourc_tvq) + ")"
			
		ELSE
			
			ldec_qte += ldec_qtetempo
			ldec_total += round(ldec_qtetempo * ldec_prix, 2)
			IF IsNull(ldec_total) THEN ldec_total = 0
			
			ls_sql = "UPDATE SommaireDetailFacture SET Qté = " + string(ldec_qte) + ", Total = " + string(ldec_total) + &
			" WHERE [Sous-groupe] = '" + ls_sous_groupe + "' AND [No éleveur] = " + string(ll_no_eleveur) + &
			" AND [No facture] = '" + ls_no_facture + "' AND Produit = '" + ls_produit + "' AND Prix = " + string(ldec_prix)
				
		END IF
		
		IF IsNull(ls_sql) THEN
			gnv_app.inv_error.of_message("CIPQ0158", {"Éleveur: " + string(ll_no_eleveur)})
		ELSE
			EXECUTE IMMEDIATE :ls_sql USING ltr_mdb;
			commit using ltr_mdb ;
		END IF
	END FOR
	
	ltr_mdb.of_disconnect( )
	If IsValid(ltr_mdb) THEN Destroy(ltr_mdb)
	
ELSE
	Messagebox("Erreur", "Impossible de continuer, la valeur EXPORT_MDB_DIR de cipq.ini est indéfinie.")
	
END IF

RETURN
end subroutine

public subroutine of_transfertexpheb (u_dw adw_current, string as_typerapport);//of_TransfertExpHeb

string	ls_path, ls_fichier, ls_source, ls_nom, ls_no_facture, ls_sql, ls_nom_fichier_base, ls_code_heb, &
			ls_old_code_heb, ls_adresse, ls_rue, ls_ville, ls_conte, ls_code_post, ls_date_de, ls_date_au, &
			ls_livdate, ls_prod_no, ls_datastore, ls_nomsousgroupe = "", ls_check_code_hebergeur_new, &
			ls_check_code_hebergeur
n_tr		ltr_mdb
date		ld_de, ld_au, ld_liv_date
long		ll_cpt, ll_no_eleveur, ll_rowcount
dec		ldec_totalexped
n_ds		lds_retrieve

// Le rapport est seulement exporté pour la version détaillé

// L'exportation se fait sur les 4 types suivants: 
// produit, éleveur, semence CIPQ (produit), semence CIPQ (éleveur)
CHOOSE CASE as_typerapport
	CASE "produit"
		ls_nom_fichier_base = "HebProd"
	CASE "éleveur"
		ls_nom_fichier_base = "HebElev"
	CASE "semence CIPQ (produit)"
		ls_nom_fichier_base = "SemCIPQ_P"
	CASE "semence CIPQ (éleveur)"
		ls_nom_fichier_base = "SemCIPQ_E"
END CHOOSE

ls_code_heb = "départ"
ls_old_code_heb = "départ"

ls_path = gnv_app.of_getvaleurini( "ELEVEUR", "EXPORT_MDB_DIR")

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de", FALSE))
ls_date_de = "#" + string(ld_de, "MM/dd/yyyy") + "#"
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au", FALSE))
ls_date_au = "#" + string(ld_au, "MM/dd/yyyy") + "#"

SetPointer(Hourglass!)

IF NOT(ls_path = "" OR IsNull(ls_path)) THEN
	do while yield()
	loop
	
	IF RIGHT(ls_path,1) <> "\" THEN ls_path += "\"
	

	
	SetPointer(Hourglass!)
	ltr_mdb = CREATE n_tr

	//Procéder au transfert
	
	lds_retrieve = CREATE n_ds
	
	//Le SQL est dynamique
	CHOOSE CASE as_typerapport
		CASE "produit"
			ls_datastore = "ds_expheb_produit"
		CASE "éleveur"
			ls_datastore = "ds_expheb_eleveur"
		CASE "semence CIPQ (produit)"
			ls_datastore = "ds_expheb_cipq_produit"
		CASE "semence CIPQ (éleveur)"
			ls_datastore = "ds_expheb_cipq_eleveur"
	END CHOOSE
	
	lds_retrieve.dataobject = ls_datastore
	lds_retrieve.of_settransobject(SQLCA)
	ll_rowcount = lds_retrieve.retrieve(ld_de, ld_au)
	
	//Valider s'il c'est toujours le même groupe d'hébergeur
	FOR ll_cpt = 1 TO adw_current.RowCount()
		ls_check_code_hebergeur_new = adw_current.object.code_hebergeur[ll_cpt]
		If ll_cpt <> 1 THEN
			IF ls_check_code_hebergeur_new <> ls_check_code_hebergeur THEN
				Messagebox("Attention", "Il est impossible d'exporter pour plus d'un hébergeur à la fois.")
				RETURN
			END IF
		END IF
		ls_check_code_hebergeur = ls_check_code_hebergeur_new
	END FOR
	
	//Les changements se font sur le code d'hébergeur
	FOR ll_cpt = 1 TO ll_rowcount
		
		SetPointer(Hourglass!)
		
		ls_code_heb = lds_retrieve.object.code_hebergeur[ll_cpt]
		If IsNull(ls_code_heb) THEN ls_code_heb = ""
		
		IF ls_code_heb = ls_check_code_hebergeur THEN
		
			//Si changement d'hébergeur, recréer un nouveau fichier
			IF ls_code_heb <> ls_old_code_heb OR ls_old_code_heb = 'départ' THEN
				
				ltr_mdb.of_disconnect( )
				
				//Préparer le fichier
				ls_source = ls_path + ls_nom_fichier_base + ".mdb"
				ls_fichier = ls_code_heb + "_" + ls_nom_fichier_base + &
					"_" + string(year(today())) + string(month(today()),"00") + string(day(today()),"00") + ".mdb"
				ls_fichier = "U:\transfert\" + ls_fichier
				
				gnv_app.inv_filesrv.of_filecopy( ls_source, ls_fichier, FALSE)
			
				do while yield()
				loop
				
				// Se connecter
				SQLCA.of_copyto(ltr_mdb)
				
				ltr_mdb.DBMS = "OLE DB"
				ltr_mdb.AutoCommit = False
				ltr_mdb.DBParm = "DATASOURCE='" + ls_fichier + "',PROVIDER='Microsoft.Jet.OLEDB.4.0',PROVIDERSTRING=''PBTrimCharColumns='Yes'',OJSyntax='ANSI'"	
			
				ltr_mdb.of_connect()			
					
				ls_old_code_heb = ls_code_heb
			END IF
			
			IF lower(as_typerapport) = "produit" THEN
				ls_nomsousgroupe = lds_retrieve.object.nomsousgroupe[ll_cpt]
				IF IsNull(ls_nomsousgroupe) THEN ls_nomsousgroupe = ""
				ls_nomsousgroupe = left(gnv_app.inv_string.of_globalreplace(ls_nomsousgroupe, "'", "''" ), 255)
			END IF
			
			ll_no_eleveur = lds_retrieve.object.no_eleveur[ll_cpt]
			ls_nom = lds_retrieve.object.nom[ll_cpt]
			ls_nom = left(gnv_app.inv_string.of_globalreplace(ls_nom, "'", "''" ), 30)
			IF IsNull(ls_nom) THEN ls_nom = ""
			ls_adresse = lds_retrieve.object.adresse[ll_cpt]
			ls_adresse = left(gnv_app.inv_string.of_globalreplace(ls_adresse, "'", "''" ), 6)
			IF IsNull(ls_adresse) THEN ls_adresse = ""
			ls_rue = lds_retrieve.object.rue[ll_cpt]
			ls_rue = left(gnv_app.inv_string.of_globalreplace(ls_rue, "'", "''" ), 23)
			IF IsNull(ls_rue) THEN ls_rue = ""
			ls_ville = lds_retrieve.object.Ville[ll_cpt]
			ls_ville = left(gnv_app.inv_string.of_globalreplace(ls_ville, "'", "''" ), 30)
			IF IsNull(ls_ville) THEN ls_ville = ""
			ls_conte = left(lds_retrieve.object.Conte[ll_cpt], 15)
			IF IsNull(ls_conte) THEN ls_conte = ""
			ls_code_post = left(lds_retrieve.object.code_post[ll_cpt], 7)
			IF IsNull(ls_code_post) THEN ls_code_post = ""
			
			ls_prod_no = left(lds_retrieve.object.prod_no[ll_cpt], 15)
			IF IsNull(ls_prod_no) THEN ls_prod_no = ""
			ldec_totalexped = lds_retrieve.object.totalexped[ll_cpt]
			
			CHOOSE CASE as_typerapport
				CASE "produit"
					ls_sql = "INSERT INTO TempTblRapLoc VALUES " + &
						"(" + ls_date_de + ", " + ls_date_au + ", '" + ls_nomsousgroupe + "', " + string(ll_no_eleveur) + ", '" + ls_nom + &
						"', '" + ls_adresse + "', '" + ls_rue + "', '" + ls_ville + "', '" + ls_conte + "', '" + &
						ls_code_post + "', '" + ls_prod_no + "', " + string(ldec_totalexped) + &
						")"
						
				CASE "éleveur", "semence CIPQ (éleveur)"
					ld_liv_date = date(lds_retrieve.object.fact_liv_date[ll_cpt])
					ls_livdate = "#" + string(ld_liv_date, "MM/dd/yyyy") + "#"
					IF IsNull(ls_livdate) THEN ls_livdate = ""
					ls_sql = "INSERT INTO TempTblRapLoc VALUES " + &
						"(" + ls_date_de + ", " + ls_date_au + ", " + string(ll_no_eleveur) + ", '" + ls_nom + &
						"', '" + ls_adresse + "', '" + ls_rue + "', '" + ls_ville + "', '" + ls_conte + "', '" + &
						ls_code_post + "', " + ls_livdate + ", '" + ls_prod_no + "', " + string(ldec_totalexped) + &
						")"
						
				CASE "semence CIPQ (produit)"
					ls_sql = "INSERT INTO TempTblRapLoc VALUES " + &
						"(" + ls_date_de + ", " + ls_date_au + ",  " + string(ll_no_eleveur) + ", '" + ls_nom + &
						"', '" + ls_adresse + "', '" + ls_rue + "', '" + ls_ville + "', '" + ls_conte + "', '" + &
						ls_code_post + "', '" + ls_prod_no + "', " + string(ldec_totalexped) + &
						")"
			END CHOOSE
			
			IF IsNull(ls_sql) THEN
				gnv_app.inv_error.of_message("CIPQ0158", {"Éleveur: " + string(ll_no_eleveur)})
			ELSE
				EXECUTE IMMEDIATE :ls_sql USING ltr_mdb;
				commit using ltr_mdb ;
			END IF 
		END IF			
	END FOR
		
	ltr_mdb.of_disconnect( )
	If IsValid(ltr_mdb) THEN Destroy(ltr_mdb)
	
	If IsValid(lds_retrieve) THEN Destroy(lds_retrieve)

ELSE
	Messagebox("Erreur", "Impossible de continuer, la valeur EXPORT_MDB_DIR de cipq.ini est indéfinie.")
			 
END IF
		
RETURN
end subroutine

on n_cst_transfert_internet.create
call super::create
end on

on n_cst_transfert_internet.destroy
call super::destroy
end on


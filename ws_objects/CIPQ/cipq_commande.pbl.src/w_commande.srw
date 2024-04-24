$PBExportHeader$w_commande.srw
forward
global type w_commande from w_sheet_frame
end type
type dw_commande from u_dw within w_commande
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_commande
end type
type st_afficher from statictext within w_commande
end type
type em_date from u_em within w_commande
end type
type gb_1 from groupbox within w_commande
end type
type rr_1 from roundrectangle within w_commande
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_commande
end type
type uo_fin from u_cst_toolbarstrip within w_commande
end type
type dw_commande_item from u_dw within w_commande
end type
type st_affichees from statictext within w_commande
end type
type rb_dujour from u_rb within w_commande
end type
type rb_tout from u_rb within w_commande
end type
type st_3 from statictext within w_commande
end type
type ddlb_client from u_ddlb within w_commande
end type
type pb_go from picturebutton within w_commande
end type
type gb_2 from u_gb within w_commande
end type
end forward

global type w_commande from w_sheet_frame
string tag = "menu=m_enregistrerlescommandes"
dw_commande dw_commande
uo_toolbar_bas uo_toolbar_bas
st_afficher st_afficher
em_date em_date
gb_1 gb_1
rr_1 rr_1
uo_toolbar_haut uo_toolbar_haut
uo_fin uo_fin
dw_commande_item dw_commande_item
st_affichees st_affichees
rb_dujour rb_dujour
rb_tout rb_tout
st_3 st_3
ddlb_client ddlb_client
pb_go pb_go
gb_2 gb_2
end type
global w_commande w_commande

type variables
boolean	ib_insertion_temp = FALSE
long		il_client_retrieve
long        il_noeleveur
date		id_date_retrieve
string      is_centre
end variables

forward prototypes
public subroutine of_checkdatecommande ()
public subroutine of_afficherclient (long al_client)
public subroutine of_setcodetransport (string as_code_transport)
public subroutine of_savedetailtoprinter (string as_cie, string as_nocommande, string as_mode)
public subroutine of_savedetailtoprinteritem (date ad_datecommande, string as_noeleveur, string as_nocommande, string as_itemcommande, string as_mode)
public subroutine of_enregistrerrepetitive ()
public function long of_recupererprochainno (string as_cie)
public function long of_recupererprochainnumeroitem ()
public function integer of_changerclient (long al_no_client, long al_row)
public subroutine of_message ()
end prototypes

public subroutine of_checkdatecommande ();date 	ld_commande
long	ll_row

ll_row = dw_commande.GetRow()
IF ll_row > 0 THEN
	ld_commande = date(dw_commande.object.datecommande[ll_row])
	If ld_commande < today() Then
		//Enlevé suite à rencontre
		//gnv_app.inv_error.of_message("CIPQ0044")
	End If
END IF
end subroutine

public subroutine of_afficherclient (long al_client);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_afficherclient
//
//	Accès:  			Public
//
//	Argument:		al_client - no du client
//
//	Retourne:  		Rien
//
// Description:	Fonction pour afficher les informations clients
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-10-16	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

//Charger les informations de ce client
n_ds		lds_eleveur
long		ll_nbrow, ll_noeleveur, ll_livr, ll_transp, ll_row, ll_gedis, ll_hors, ll_null
string	ls_texte, ls_msg, ls_adresse, ls_ville, ls_code, ls_conte, ls_tel, ls_codetrans, ls_RepId, &
			ls_cie, ls_nomrep, ls_null, ls_codetransport_temp

ll_noeleveur = al_client
ls_cie = gnv_app.of_getcompagniedefaut()

SetNull(ll_null)
SetNull(ls_null)

lds_eleveur = CREATE n_ds

lds_eleveur.dataobject = "ds_eleveur"
lds_eleveur.of_setTransobject(SQLCA)
ll_nbrow = lds_eleveur.Retrieve(ll_noeleveur)

ll_row = dw_commande.GetRow()

IF ll_nbrow > 0 THEN
	
	//Afficher le message d'avertissement
	ll_livr = lds_eleveur.object.livraisonspecial[ll_nbrow]
	IF ll_livr = 1 THEN
		ls_msg = trim(lds_eleveur.object.livraisonspecialmsg[ll_nbrow])
		
		IF IsNull(ls_msg) OR ls_msg = "" THEN
			//gnv_app.inv_error.of_message("CIPQ0041")
		ELSE
			//gnv_app.inv_error.of_message("CIPQ0042", {ls_msg})
			dw_commande.object.t_livraison.visible = TRUE
			ls_msg = gnv_app.inv_string.of_globalreplace( ls_msg, '"', "'")
			dw_commande.object.t_livraison.text = "Message: " + ls_msg
			dw_commande.object.t_exception.visible = TRUE
		END IF
	ELSE
		dw_commande.object.t_livraison.visible = FALSE
		dw_commande.object.t_exception.visible = FALSE
	END IF
		
	//Bâtir la string du client
	ls_adresse = trim(lds_eleveur.object.liv_adr_a[ll_nbrow])
	IF IsNull(ls_adresse) OR ls_adresse = "" THEN
		
		//Bâtir l'Adresse
		ls_adresse = trim(lds_eleveur.object.adresse[ll_nbrow])
		If Not IsNull(ls_adresse) and ls_adresse <> "" THEN
			ls_adresse += ", "
		END IF
		ls_texte = ls_adresse
		
		ls_adresse = trim(lds_eleveur.object.rue[ll_nbrow])
		IF IsNull(ls_adresse) THEN ls_adresse = ""
		
		ls_texte = ls_texte + ls_adresse
		
	ELSE
		
		ls_texte = ls_adresse
	END IF
	
	ls_ville = trim(lds_eleveur.object.liv_vil_a[ll_nbrow])
	If IsNull(ls_ville) OR ls_ville = "" THEN
		ls_ville = trim(lds_eleveur.object.ville[ll_nbrow])
		IF IsNull(ls_ville) THEN ls_ville = ""
	END IF
	ls_texte = ls_texte + "~r~n" + ls_ville
	
	ls_code = trim(lds_eleveur.object.liv_cod_a[ll_nbrow])
	If IsNull(ls_code) OR ls_code = "" THEN
		ls_code = trim(lds_eleveur.object.code_post[ll_nbrow])
		IF IsNull(ls_code) THEN ls_code = ""
	END IF
	IF LEN(ls_code) >= 6 THEN
		ls_code = LEFT(ls_code, 3) + " " + RIGHT(ls_code,3)
	END IF		
	ls_texte = ls_texte + ", " + ls_code
	
	ls_conte = trim(lds_eleveur.object.liv_conte[ll_nbrow])
	If IsNull(ls_conte) OR ls_conte = "" THEN
		ls_conte = trim(lds_eleveur.object.conte[ll_nbrow])
		IF IsNull(ls_conte) THEN ls_conte = ""
	END IF
	ls_texte = ls_texte + "~r~n" + ls_conte
	
	ls_tel = trim(lds_eleveur.object.liv_tel_a[ll_nbrow])
	If IsNull(ls_tel) OR ls_tel = "" THEN
		ls_tel = trim(lds_eleveur.object.telephone[ll_nbrow])
		IF IsNull(ls_tel) THEN ls_tel = ""
	END IF
	IF LEN(ls_tel) >= 10 THEN
		ls_tel = "(" + LEFT(ls_tel, 3) + ") " + MID(ls_tel,4,3) + "-" + MID(ls_tel,7,4)
	END IF
	ls_texte = ls_texte + "~t" + ls_tel		
	
			
			
	dw_commande.object.cc_client[ll_row] = ls_texte
	
	//Transporteur
	ll_transp = lds_eleveur.object.liv_notran[ll_nbrow]
	If IsNull(ll_transp) OR ll_transp = 0 THEN
		ll_transp = lds_eleveur.object.secteur_transporteur[ll_nbrow]
		IF IsNull(ll_transp) THEN ll_transp = 0
	END IF
	dw_commande.object.cc_transporteur[ll_row] = ll_transp
	
	//Code de transport
	ls_codetrans = trim(lds_eleveur.object.codetransport[ll_nbrow])
	//Si la valeur est vide, mettre le code d etransport par défaut
	ls_codetransport_temp = dw_commande.object.codetransport[ll_row]
	IF IsNull(ls_codetransport_temp) OR ls_codetransport_temp = "" THEN
		dw_commande.object.codetransport[ll_row] = ls_codetrans
		ls_codetransport_temp = ls_codetrans
	END IF
	
	//Formation gedis
	ll_gedis = lds_eleveur.object.formationgedis[ll_nbrow]
	IF ll_gedis = 1 THEN
		dw_commande.object.cc_gedis[ll_row] = 1
	ELSE
		dw_commande.object.cc_gedis[ll_row] = 0
	END IF
	
	of_setcodetransport(ls_codetransport_temp)
	
	// TO DO
	//D'où vient ce putain de champ???		
	//Me.chkHorQue = myrec("HOR-QU")
	
	ls_RepId = trim(lds_eleveur.object.id_rep[ll_nbrow])
	
	
	//Ajout du texte du représentant
	SELECT	non_rep
	INTO 		:ls_nomrep 
	FROM 		t_Eleveur_Rep
	WHERE 	Id_Rep = :ls_repid
	USING 	SQLCA;
	
	dw_commande.object.t_rep.text = ls_nomrep
	
	//chkhorsque
	ll_hors = lds_eleveur.object.t_regionagri_hor_qu[ll_nbrow]
	IF ll_hors = 1 THEN
		dw_commande.object.chkhorque[ll_row] = 1
	ELSE
		dw_commande.object.chkhorque[ll_row] = 0
	END IF
	
ELSE
	//Mettre tout à null
	dw_commande.object.t_livraison.visible = FALSE
	dw_commande.object.t_livraison.text = ""
	dw_commande.object.t_exception.visible = FALSE
	

	dw_commande.object.t_prix.text = ""
	dw_commande.object.t_codetransport.text = ""
	
	dw_commande.object.cc_client[ll_row] = ""
	
	dw_commande.object.cc_gedis[ll_row] = 0
	
	dw_commande.object.cc_transporteur[ll_row] = ll_null
	dw_commande.object.codetransport[ll_row] = ls_null

	dw_commande.object.t_rep.text = ""
	dw_commande.object.chkhorque[ll_row] = 0
	
END IF
end subroutine

public subroutine of_setcodetransport (string as_code_transport);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_setcodetransport
//
//	Accès:  			Public
//
//	Argument:		code de transport
//
//	Retourne:  		Rien
//
// Description:	Fonction pour retrouver les valeurs des codes et des prix
//						en fonction du code
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-10-15	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

datawindowchild 	ldwc_codetransport

decimal		ldec_prix
long			ll_row_dwc, ll_row
string		ls_trans

dw_commande.AcceptText()

ll_row = dw_commande.GetRow()
dw_commande.GetChild('codetransport', ldwc_codetransport)
ldwc_codetransport.setTransObject(SQLCA)

ll_row_dwc = ldwc_codetransport.Find("codetransport = '" + as_code_transport + "'", 1, ldwc_codetransport.RowCount())
IF ll_row_dwc > 0 THEN
	ls_trans = ldwc_codetransport.GetItemString(ll_row_dwc,"codetransport")
	ldec_prix = ldwc_codetransport.GetItemDecimal(ll_row_dwc,"prix")
	
	dw_commande.object.t_prix.text = string(ldec_prix, "#,##0.00 $; (#,##0.00 $)")
	dw_commande.object.t_codetransport.text = ls_trans
	
	IF ls_trans = "LC" OR ls_trans = "LSPE" OR ls_trans = "LP" OR ls_trans = "LV" THEN
		dw_commande.object.livrampm[ll_row] = "AM"
	ELSE
		dw_commande.object.livrampm[ll_row] = "PM"
	END IF
ELSE
	dw_commande.object.t_prix.text = ""
	dw_commande.object.t_codetransport.text = ""

END IF
end subroutine

public subroutine of_savedetailtoprinter (string as_cie, string as_nocommande, string as_mode);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_savedetailtoprinter
//
//	Accès:  			Public
//
//	Arguments:		as_cie
//						as_nocommande
//						as_mode
//						
//
//	Retourne:  		Rien
//
// Description:	Mettre dans la table de l'impression différée
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-11-29	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

string	ls_aString = "", ls_sql, ls_nocommande, ls_verrat, ls_produit
long		ll_cpt, ll_rowcount, ll_qte, ll_rowparent, ll_noeleveur
datetime	ldt_commande

//Générer la ligne à imprimer
ll_rowcount = dw_commande_item.RowCount()
ll_rowparent = dw_commande.GetRow()

FOR ll_cpt = 1 TO ll_rowcount
	ll_qte = dw_commande_item.object.qtecommande[ll_cpt]
	
	IF Not IsNull(ll_qte) AND ll_qte <> 0 THEN
		
		ldt_commande = dw_commande.object.datecommande[ll_rowparent]
		ll_noeleveur = dw_commande.object.no_eleveur[ll_rowparent]
		ls_nocommande = string(dw_commande.object.nocommande[ll_rowparent])
		
		ls_produit = dw_commande_item.object.noproduit[ll_cpt]
		ls_verrat = dw_commande_item.object.codeverrat[ll_cpt]
		
		ls_aString = string(ldt_commande,"yyyy-mm-dd") + "; " + as_Mode + ": " + string(now(), "hh:mm") + "; " + &
			string(ll_noeleveur) + "; NoComm: " + as_NoCommande
		ls_aString = ls_aString + "; Com:" + string(ll_qte) + " "
		
		If Not IsNull(ls_produit) Then
			 ls_aString = ls_aString + ls_produit
		End If
		
		If Not IsNull(ls_verrat) AND ls_verrat <> "" Then
			 ls_aString = ls_aString + ", Verrat:" + ls_verrat
		End If
		
		ls_aString = ls_aString + " Par: " + gnv_app.of_getuserid( )
		
		//Écrire dans 'Tmp_ImpressionCommande'
		ls_sql = "INSERT INTO Tmp_ImpressionCommande ( DescriptionCommande ) SELECT '" + ls_aString + "' AS Description"
		
		EXECUTE IMMEDIATE :ls_sql USING SQLCA;		
		
	END IF
	
END FOR



COMMIT USING SQLCA;
end subroutine

public subroutine of_savedetailtoprinteritem (date ad_datecommande, string as_noeleveur, string as_nocommande, string as_itemcommande, string as_mode);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_savedetailtoprinteritem
//
//	Accès:  			Public
//
//	Argument:		ad_datecommande
//						as_noeleveur
//						as_nocommande
//						as_itemcommande
//						as_mode
//
//	Retourne:  		Rien
//
// Description:	Mettre dans la table de l'impression différée
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-12-06	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

string	ls_aString, ls_sql

//Générer la ligne à imprimer
ls_aString = string(ad_DateCommande, "yyyy-mm-dd") + "; " + as_Mode + ": " + string(now(), "hh:mm") + "; " + as_NoEleveur + "; NoComm: " + as_NoCommande + "; Item: " + as_ItemCommande

ls_aString = ls_aString + " Par: " + gnv_app.of_getuserid( )

//Écrire dans 'Tmp_ImpressionCommande'
ls_sql = "INSERT INTO Tmp_ImpressionCommande ( DescriptionCommande ) SELECT '" + ls_aString + "' AS Description"

EXECUTE IMMEDIATE :ls_sql USING SQLCA;

COMMIT USING SQLCA;
end subroutine

public subroutine of_enregistrerrepetitive ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_enregistrerrepetitive
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour enregistrer la commande en cours comme
//						commande répétitive
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-12-06	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long			ll_row, ll_repeat, ll_count, ll_noeleveur, ll_max, ll_cpt, ll_noligne, ll_noligneheader, ll_choix, &
				ll_quantite
string		ls_cie, ls_typetransport, ls_ampm, ls_message, ls_boncommandeclient, ls_sql, ls_noproduit, &
				ls_codeverrat, ls_description
date			ld_commande
n_cst_menu	lnv_menu
menu			lm_item, lm_menu

//Procéder à l'enregistrement etc.

ll_row = dw_commande.GetRow()

IF ll_row > 0 THEN
	ll_repeat = dw_commande.object.repeat[ll_row]
	ls_cie = dw_commande.object.nocommande[ll_row]
	ll_noeleveur = dw_commande.object.no_eleveur[ll_row]
	ld_commande = date(dw_commande.object.datecommande[ll_row])
	ls_typetransport = dw_commande.object.codetransport[ll_row]
	ls_ampm = dw_commande.object.livrampm[ll_row]
	ls_boncommandeclient = dw_commande.object.boncommandeclient[ll_row]
	If IsNull(ls_boncommandeclient) THEN ls_boncommandeclient = ""
	ls_message = dw_commande.object.message_commande[ll_row]
	If IsNull(ls_message) THEN ls_message = ""
	
	//Vérifier si c'Est déjà une commande répétitive
	IF ll_repeat = 1 THEN
		gnv_app.inv_error.of_message("CIPQ0061")
		RETURN
	END IF

	IF gnv_app.inv_error.of_message("CIPQ0062") = 1 THEN

		//Vérifie la présence d'une commande répétitive pour le client.
		SELECT 	count(1) INTO :ll_count FROM t_CommandeRepetitive
		WHERE		cieno = :ls_cie AND no_eleveur = :ll_noeleveur USING SQLCA;
		
		IF ll_count > 0 THEN
			//Il y en a une, voulez-vous ajouter?
			IF gnv_app.inv_error.of_message("CIPQ0063") = 2 THEN
				RETURN
			END IF
		END IF
		
		//Récupère le plus grand numéro de commande répétitive
		SELECT DISTINCT Max(cast(NoRepeat as integer)) INTO :ll_max
		FROM t_CommandeRepetitive GROUP BY CieNo HAVING CieNo = :ls_cie USING SQLCA;
		If IsNull(ll_max) THEN ll_max = 0
		ll_max++
		
		//Créer la commande répétitive
		ls_sql = "INSERT INTO t_commanderepetitive (DateDernierRepeat, cieno, NoRepeat, no_eleveur, CodeTransport, LivrAMPM, BonCommandeClient, message_commande ) " + &
			"VALUES ('" + string(ld_commande,"yyyy-mm-dd") + "','" + ls_cie + "', '" + string(ll_max) + "', " + string(ll_noeleveur) + ",  '" + ls_typetransport + &
			"', '" + ls_ampm + "', '" + ls_boncommandeclient + "', '" + ls_message + "' )" 
			
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_commanderepetitive", "Insertion", THIS.Title)

		FOR ll_cpt = 1 TO dw_commande_item.RowCount()

			ll_noligne = dw_commande_item.object.noligne[ll_cpt]
			ll_noligneheader = dw_commande_item.object.noligneheader[ll_cpt]
			If IsNull(ll_noligneheader) THEN ll_noligneheader = 0
			ll_choix = dw_commande_item.object.choix[ll_cpt]
			ls_noproduit = dw_commande_item.object.noproduit[ll_cpt]
			ls_codeverrat = dw_commande_item.object.codeverrat[ll_cpt]
			If IsNull(ls_codeverrat) THEN ls_codeverrat = ""
			ll_quantite = dw_commande_item.object.qtecommande[ll_cpt]
			ls_description = dw_commande_item.object.description[ll_cpt]
			If IsNull(ls_description) THEN ls_description = ""
			
			ls_sql = "INSERT INTO t_CommandeRepetitiveDetail ( CieNo, NoRepeat, NoLigne, NoLigneHeader, Choix, NoProduit, CodeVerrat, QteCommande, Description ) " + &
				"VALUES ( '" +ls_cie + "', '" + string(ll_max) + "', " + string(ll_noligne) + ", " + string(ll_noligneheader) + ", " + &
				string(ll_choix) + ", '" + ls_noproduit + "', '" + ls_codeverrat + "', " + string(ll_quantite) + &
				", '" + ls_description + "')"

			gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_commanderepetitivedetail", "Insertion", THIS.Title)	
		END FOR
		
		//Desirez-vous visualiser la nouvelle commande répétitive
//		IF gnv_app.inv_error.of_message("CIPQ0064") <> 1 THEN
//			RETURN
//		END IF
		
		lm_menu = gnv_app.of_getframe().MenuID
		
		IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
			IF lnv_menu.of_GetMenuReference (lm_menu,"m_commandesrepetitives", lm_item) > 0 THEN
				IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
					gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rep date", string(ld_commande))
					gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rep norepeat", string(ll_max))
					gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rep cie", ls_cie)
					gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rep no eleveur", string(ll_noeleveur))
					lm_item.event clicked()
				END IF
			END IF 
		END IF
	END IF
	
END IF
end subroutine

public function long of_recupererprochainno (string as_cie);RETURN gnv_app.of_recupererprochainno(as_cie)
end function

public function long of_recupererprochainnumeroitem ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_recupererprochainnumeroitem
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Numéro 
//
// Description:	Fonction pour trouver la valeur du prochain numéro 
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-11-12	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	max(noligne) + 1
INTO		:ll_no
FROM		t_commandedetail
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

public function integer of_changerclient (long al_no_client, long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_changerclient
//
//	Accès:  			Public
//
//	Argument:		no client
//						row
//
//	Retourne:  		Integer
//
// Description:	Fonction appelée quand la dddw client est changée
//	
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-11-09	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

//Charger les informations de ce client
long		ll_noeleveur, ll_trouve, ll_no, ll_find
date 		ld_datecommande, ld_hier, ld_demain
string	ls_cie
boolean	lb_duplic  = FALSE

IF ib_insertion_temp THEN RETURN 0

ll_noeleveur = al_no_client

THIS.of_afficherclient( ll_noeleveur)
ls_cie = gnv_app.of_getcompagniedefaut()

IF dw_commande.ib_en_insertion THEN
	
	//Vérifier pour la duplication
	ld_datecommande = date(dw_commande.object.datecommande[al_row])
	ld_hier = relativedate(ld_datecommande, -1)
	ld_demain = relativedate(ld_datecommande, 1)
	
	SELECT 	count(no_eleveur) INTO :ll_trouve
	FROM		t_commande INNER JOIN t_commandedetail ON t_commandedetail.cieno = t_commande.cieno AND t_commandedetail.nocommande = t_commande.nocommande
	WHERE		no_eleveur = :ll_noeleveur AND date(datecommande) > :ld_hier AND date(datecommande) < :ld_demain
				AND qtecommande > 0
	USING 	SQLCA;
	
	IF ll_trouve = 0 THEN
		//Vérifier s'il y a une commande vide pour ce client
		SELECT 	count(no_eleveur) INTO :ll_trouve
		FROM		t_commande LEFT JOIN t_commandedetail ON t_commandedetail.cieno = t_commande.cieno AND t_commandedetail.nocommande = t_commande.nocommande
		WHERE		t_commandedetail.cieno is null AND no_eleveur = :ll_noeleveur
					AND datecommande > :ld_hier AND date(datecommande) < :ld_demain
		USING		SQLCA;
	END IF
	
	IF ll_trouve > 0 THEN
		//Il y a eu une commande saisie aujourd'hui
		IF gnv_app.inv_error.of_message("CIPQ0046") <> 1 THEN
			
			//Le gars ne veut plus saisir une commande, il veut plutôt aller rechercher l'ancienne 
			//un retrieve et pointer sur la bonne ligne
			
			dw_commande.DeleteRow(al_row)
			dw_commande.Update(TRUE, TRUE)
			
			ll_find = dw_commande.Find("no_eleveur = " + string(ll_noeleveur) + " AND string(datecommande, 'yyyy-mm-dd') > '" + string(ld_hier, "yyyy-mm-dd") + "' AND string(datecommande, 'yyyy-mm-dd') < '" + string(ld_demain, "yyyy-mm-dd") + "'" , 1, dw_commande.rowCount() )
			
			IF ll_find <= 0 THEN
				gnv_app.inv_error.of_message("CIPQ0018", {"Il est impossible d'afficher la commande. Vous devez rafraichir votre écran avec la flèche verte et recommencer l'opération."})
				ll_find = dw_commande.getRow()
			END IF
			
			dw_commande.ib_en_insertion = FALSE
			dw_commande.SetRow(ll_find)
			dw_commande.ScrollToRow(ll_find)
			dw_commande.event rowfocuschanged(ll_find)
								
			RETURN 0
			
			lb_duplic = TRUE
			
		END IF
	ELSE
		
		//Vérifier s'il y a déjà eu une commande transférée aujourd'hui 2008-12-08
		SELECT 	count(no_eleveur) INTO :ll_trouve
		FROM		t_commande INNER JOIN t_commandedetail ON t_commandedetail.cieno = t_commande.cieno AND t_commandedetail.nocommande = t_commande.nocommande
		WHERE		no_eleveur = :ll_noeleveur AND date(datecommande) > :ld_hier AND date(datecommande) < :ld_demain
					AND isnull(qtecommande,0) = 0 AND isnull(qtetransfert,0) <> 0
		USING 	SQLCA;
		
		IF ll_trouve > 0 THEN
			Messagebox("Attention", "Il y a déjà eu une commande transférée pour ce client aujourd'hui.")
		ELSE
			
			SELECT 	count(no_eleveur) INTO :ll_trouve
			FROM		t_commande_validation
			WHERE		no_eleveur = :ll_noeleveur AND date(datecommande) > :ld_hier AND date(datecommande) < :ld_demain
			USING 	SQLCA;
			
			//Il y a eu une commande TRAITÉE aujourd'hui
			IF ll_trouve > 0 THEN
				gnv_app.inv_error.of_message("CIPQ0045")
			END IF
		END IF
	END IF
	
	IF lb_duplic = FALSE THEN
//		ll_no = of_recupererprochainno(ls_cie)
//		dw_commande.object.nocommande[al_row] = string(ll_no)
	END IF	
	
END IF

dw_commande.object.cieno[al_row] = ls_cie
dw_commande.object.t_no.text = ls_cie + " -"

dw_commande.AcceptText()

//Charger les items - requery
dw_commande_item.event pfc_retrieve()

//Lancer la sauvegarde
IF dw_commande.ib_en_insertion THEN
	//THIS.event pfc_save()
END IF

RETURN 1
end function

public subroutine of_message ();long ll_envoyer,i,ll_commande,ll_row, ll_activesms,ll_expedie,j, ll_err
string ls_courriel, ls_sujet, ls_body, ls_filename,ls_erreur, ls_commande, ls_nomprod,ls_noverrat,ls_qteexpedie,ls_commandeboucle, ls_emailexp, ls_emaildest
string ls_numerocell,ls_codeverrat
string ls_eleveurcell, ls_entete,ls_footer
date ldt_commande

is_centre         = gnv_app.of_getcompagniedefaut( )
ls_commande = ""

// COMMANDE
select isnull(smtpuserid,''), isnull(NumeroCell,''), isnull(activeSMS,0) into :ls_emailexp,:ls_numerocell, :ll_activesms from t_centrecipq where cie = :is_centre;

if ll_activesms = 1 and len(ls_numerocell) = 10 then
	
	select isnull(trim(courriel),''),isnull(trim(cellulaire),'') into :ls_emaildest, :ls_eleveurcell from t_eleveur where no_eleveur = :il_noeleveur; 

	if (ls_eleveurcell <> '' and len(ls_eleveurcell) = 10) then 		
			select sujetcourriel, messagecourriel into :ls_sujet, :ls_body from t_messagecourriel where titrecourriel = 'Enregistrer les commandes';	
			ls_entete = mid(ls_body,1,pos(ls_body,'/*DEBUTCOMMANDE*/') - 1)
			ls_commandeboucle = mid(ls_body,pos(ls_body,'/*DEBUTCOMMANDE*/') + 17,pos(ls_body,'/*FINCOMMANDE*/') - pos(ls_body,'/*DEBUTCOMMANDE*/') - 17 )

			for i =1 to dw_commande_item.rowcount()
				ls_commande += ls_commandeboucle
				ll_commande  = dw_commande_item.getItemNumber(i,'qtecommande')
				if isnull(ll_commande) then ll_commande = 0
				ll_expedie = dw_commande_item.getItemNumber(i,'qteexpedie')
				if isnull(ll_expedie) then ll_expedie = 0
				ls_nomprod = dw_commande_item.getItemString(i,'t_produit_nomproduit')
				if isnull(ls_nomprod) then ls_nomprod = ''
				ls_codeverrat = dw_commande_item.getItemString(i,'codeverrat')
				if isnull(ls_codeverrat) then ls_codeverrat = ''
				ldt_commande= date(dw_commande.getItemDatetime(dw_commande.getrow(),'datecommande'))
				if isnull(ldt_commande) then ldt_commande = 1900-01-01
				//---------------------------------------------------------------------------------------------------------------------------------------------
				ls_commande = rep(ls_commande,'<<qte_commande>>',string(ll_commande))
				ls_commande = rep(ls_commande,'<<qte_expedie>>',string(ll_expedie))
				ls_commande = rep(ls_commande,'<<nom_produit>>', ls_nomprod)
				ls_commande = rep(ls_commande,'<<no_verrat>>',ls_codeverrat )
			next
			
			ls_footer = mid(ls_body,pos(ls_body,'/*FINCOMMANDE*/') + 17,len(ls_body) - pos(ls_body,'/*FINCOMMANDE*/'))				
			ls_body = rep(ls_entete + ' ' + ls_commande + ' ' + ls_footer,'<<date_livraison>>',string(relativedate(date(ldt_commande),1)))

			insert into t_message(dateenvoye, priorite, message_de, message_a, sujet, message_texte, fichier_attache, source, statut,statut_lu, statut_affiche, typemessagerie, couleur, email, envoyer, sms, nomemail, id_user, nomordinateur, nomreel,failmsg,no_eleveur)
			values(string(date(:ldt_commande)) + ' 07:30:00.000', 0, :ls_numerocell, :ls_eleveurcell, :ls_sujet, :ls_body,null, 'e', 'a', 'o','o', 'U', 15780518, 1, 0, 1,'',0,'','',:ls_erreur,:il_noeleveur);
			
			if SQLCA.SQLCode = 0 then
				commit using SQLCA;
			else
				rollback using SQLCA;
			end if
	end if
	if  (ls_emaildest <> '') then
		
		n_ds lds_imprimer_etiquette
		lds_imprimer_etiquette = CREATE n_ds
		lds_imprimer_etiquette.dataobject = "d_r_boncommande_pdf"
		lds_imprimer_etiquette.of_setTransobject(SQLCA)
		lds_imprimer_etiquette.retrieve(il_noeleveur)	
		for i =1 to dw_commande_item.rowcount()
			ll_row = lds_imprimer_etiquette.insertrow(0)
			lds_imprimer_etiquette.setitem(ll_row,'qtecommande',dw_commande_item.getItemNumber(i,'qtecommande'))
			lds_imprimer_etiquette.setitem(ll_row,'nomproduit',dw_commande_item.getItemString(i,'t_produit_nomproduit'))
			lds_imprimer_etiquette.setitem(ll_row,'codeverrat',dw_commande_item.getItemString(i,'codeverrat'))
			lds_imprimer_etiquette.setitem(ll_row,'datecommande',string(date(dw_commande.getItemDatetime(dw_commande.getrow(),'datecommande'))))
		next
		
		ls_sujet = 'Cipq - Bon de commande'
		ls_body = 'Pour votre livraison du  ' + string(date(dw_commande.getItemDatetime(dw_commande.getrow(),'datecommande')))
		
		ls_filename = "c:\ii4net\cipq\boncommande\bc_"+ string(il_noeleveur) + '_' + string(now(),"ddmmyyyyhhmmss") + '.PDF'
		
		if lds_imprimer_etiquette.saveas(ls_filename, PDF!,false ) = 1 then
					
			insert into t_message(dateenvoye, priorite, message_de, message_a, sujet, message_texte, fichier_attache, source, statut,statut_lu, statut_affiche, typemessagerie, couleur, email, envoyer, sms, nomemail, id_user, nomordinateur, nomreel,failmsg,no_eleveur)
			values(string(date(:ldt_commande)) + ' 07:30:00.000', 0, :ls_emailexp, :ls_emaildest, :ls_sujet, :ls_body, :ls_filename, 'e', 'a', 'o','o', 'U', 15780518, 1, 0, 0,'',0,'','',:ls_erreur,:il_noeleveur);
			
			if SQLCA.SQLCode = 0 then
				commit using SQLCA;
			else
				rollback using SQLCA;
			end if
		end if		
		
	end if
	
end if
end subroutine

on w_commande.create
int iCurrent
call super::create
this.dw_commande=create dw_commande
this.uo_toolbar_bas=create uo_toolbar_bas
this.st_afficher=create st_afficher
this.em_date=create em_date
this.gb_1=create gb_1
this.rr_1=create rr_1
this.uo_toolbar_haut=create uo_toolbar_haut
this.uo_fin=create uo_fin
this.dw_commande_item=create dw_commande_item
this.st_affichees=create st_affichees
this.rb_dujour=create rb_dujour
this.rb_tout=create rb_tout
this.st_3=create st_3
this.ddlb_client=create ddlb_client
this.pb_go=create pb_go
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_commande
this.Control[iCurrent+2]=this.uo_toolbar_bas
this.Control[iCurrent+3]=this.st_afficher
this.Control[iCurrent+4]=this.em_date
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.rr_1
this.Control[iCurrent+7]=this.uo_toolbar_haut
this.Control[iCurrent+8]=this.uo_fin
this.Control[iCurrent+9]=this.dw_commande_item
this.Control[iCurrent+10]=this.st_affichees
this.Control[iCurrent+11]=this.rb_dujour
this.Control[iCurrent+12]=this.rb_tout
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.ddlb_client
this.Control[iCurrent+15]=this.pb_go
this.Control[iCurrent+16]=this.gb_2
end on

on w_commande.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_commande)
destroy(this.uo_toolbar_bas)
destroy(this.st_afficher)
destroy(this.em_date)
destroy(this.gb_1)
destroy(this.rr_1)
destroy(this.uo_toolbar_haut)
destroy(this.uo_fin)
destroy(this.dw_commande_item)
destroy(this.st_affichees)
destroy(this.rb_dujour)
destroy(this.rb_tout)
destroy(this.st_3)
destroy(this.ddlb_client)
destroy(this.pb_go)
destroy(this.gb_2)
end on

event open;call super::open;long	ll_nbligne

em_date.text = string(today(),"yyyy-mm-dd")
SetNull(il_client_retrieve)
id_date_retrieve = date(today())
SetNull(il_client_retrieve)
ll_nbligne = dw_commande.retrieve(id_date_retrieve, il_client_retrieve)
st_affichees.text = "Affichées: " + string(ll_nbligne)

ib_insertion_temp = TRUE
dw_commande.event pfc_insertrow()
dw_commande.SetFocus()
ib_insertion_temp = FALSE

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un item", "AddWatch5!")
uo_toolbar_bas.of_AddItem("Supprimer cet item", "DeleteWatch5!")
uo_toolbar_bas.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter une commande", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_haut.of_AddItem("Supprimer cette commande", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_haut.of_displaytext(true)

uo_fin.of_settheme("classic")
uo_fin.of_DisplayBorder(true)
uo_fin.of_AddItem("Enregistrer", "Save!")
//uo_fin.of_AddItem("Enregistrer comme commande répétitive...", "C:\ii4net\CIPQ\images\commande_rep.bmp")
uo_fin.of_AddItem("Rechercher...", "Search!")
uo_fin.of_AddItem("Fermer", "Exit!")
uo_fin.of_displaytext(true)

//Supprimer les validations antérieures  
DELETE FROM t_Commande_Validation WHERE date(t_Commande_Validation.DateCommande) <= date(today());
commit using sqlca;
//Faire une fois par jour 2008-12-12
//IF SQLCA.sqlnrows > 0 THEN
	INSERT INTO t_Commande_Validation ( DateCommande, No_Eleveur ) 
	SELECT DISTINCT datetime(dateformat(t_statfacture.liv_date, 'yyyy-mm-dd') || ' 00:00:00'), t_statfacture.No_Eleveur 
	FROM t_statfacture WHERE date(t_statfacture.liv_date) = Date(today()) 
	AND t_statfacture.no_eleveur NOT IN (
	SELECT no_eleveur from t_commande_validation WHERE date(datecommande) = date(today())
	);	
	
//END IF
commit using sqlca;

//ajouter les commandes du jour (répétitives, transférées) 
INSERT INTO t_Commande_Validation ( DateCommande, No_Eleveur )
SELECT DISTINCT datetime(dateformat(t_Commande.DateCommande, 'yyyy-mm-dd') || ' 00:00:00'), t_Commande.No_Eleveur 
FROM t_Commande WHERE date(t_Commande.DateCommande) = Date(today()) 
AND t_commande.no_eleveur NOT IN (
SELECT no_eleveur from t_commande_validation WHERE date(datecommande) = date(today())
);

end event

event pfc_postopen;call super::pfc_postopen;long	ll_nbrow, ll_cpt
n_ds 	lds_eleveur

lds_eleveur = CREATE n_ds
lds_eleveur.dataobject = "ds_commande"
lds_eleveur.SetTransobject(SQLCA)
ll_nbrow = lds_eleveur.retrieve()

ddlb_client.additem("Tous")

FOR ll_cpt = 1 TO ll_nbrow
	ddlb_client.additem(string(lds_eleveur.object.no_eleveur[ll_cpt]))
END FOR

ddlb_client.SelectItem(1)

IF IsValid(lds_eleveur) THEN DesTroy(lds_eleveur)
end event

type st_title from w_sheet_frame`st_title within w_commande
integer x = 206
integer y = 32
string text = "Enregistrer les commandes"
end type

type p_8 from w_sheet_frame`p_8 within w_commande
integer x = 59
integer y = 28
integer width = 128
integer height = 96
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\tel.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_commande
integer y = 12
end type

type dw_commande from u_dw within w_commande
integer x = 59
integer y = 164
integer width = 4466
integer height = 1080
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_commande"
end type

event itemchanged;call super::itemchanged;boolean	lb_rtn
string	ls_commande
//Avant d'accepter toute forme de modification, vérifier si la rangée est Locked
IF row > 0 AND ib_en_insertion = FALSE THEN
	ls_commande = THIS.object.nocommande[row]
	IF Not IsNull(ls_commande) AND ls_commande <> "" THEN
		lb_rtn = gnv_app.of_chkiflockandlock( ls_commande, TRUE)
		IF lb_rtn = TRUE THEN
			THIS.ib_suppression_message_itemerror = TRUE
			RETURN 1
		END IF
	END IF
END IF

Choose case dwo.name
	
	CASE "no_eleveur"
		
		long	ll_no_eleveur_old
		
		ll_no_eleveur_old = THIS.object.no_eleveur[row]
		
		//On peut changer le client sauf quand il y a des items de facturation
		IF dw_commande_item.RowCount() > 0 THEN
			gnv_app.inv_error.of_message("CIPQ0056")
			THIS.object.no_eleveur[row] = ll_no_eleveur_old
			RETURN 2
		END IF
		
		//Vérifier si le no du client est dans la liste
		Datawindowchild	ldwc_eleveur
		long	ll_rowdddw
		
		THIS.GetChild('no_eleveur', ldwc_eleveur)
		ldwc_eleveur.setTransObject(SQLCA)
		ll_rowdddw = ldwc_eleveur.Find("no_eleveur = " + data , 1, ldwc_eleveur.RowCount())
		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw = 0 THEN		
			gnv_app.inv_error.of_message("PRO0011")
			THIS.ib_suppression_message_itemerror = TRUE
			THIS.SetColumn("no_eleveur")
			SetText("")
			RETURN 1
		END IF
			
		//Charger les informations de ce client
		long		ll_noeleveur
		IF Not IsNull(data) AND data <> "" THEN
			ll_noeleveur = long(data)
			il_noeleveur = ll_noeleveur
			parent.of_changerclient(ll_noeleveur,row)
		END IF
		
	CASE "codetransport"
		THIS.AcceptText()
		of_setcodetransport(data)
		
END CHOOSE


end event

event itemfocuschanged;call super::itemfocuschanged;Choose case dwo.name
	
	CASE "no_eleveur"
		of_CheckDateCommande()
		
END CHOOSE
end event

event buttonclicked;call super::buttonclicked;long		ll_eleveur
string	ls_retour

CHOOSE CASE dwo.name
		
	CASE "b_code"
		
		w_eleveur_codehebergeur	lw_wind
		ll_eleveur = THIS.object.no_eleveur[row]
		
		IF not isnull(ll_eleveur) AND ll_eleveur > 0 THEN
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur code hebergeur", string(ll_eleveur))
			Open(lw_wind)
		END IF
		
	CASE "b_sommaire"
		
		w_commande_sommaire	lw_winds
		
		ll_eleveur = THIS.object.no_eleveur[row]
		IF not isnull(ll_eleveur) AND ll_eleveur > 0 THEN
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur commande sommaire", string(ll_eleveur))
			//OpenSheet(lw_winds, gnv_app.of_GetFrame(), 6, layered!)
			Open(lw_winds)
			//Lancer un rafraichir
			ls_retour = gnv_app.inv_entrepotglobal.of_retournedonnee("donnee sommaire commande", TRUE)
			IF ls_retour = "oui" THEN
				Messagebox("Attention", "Des changements ont été apportés, les données actuelles seront rafraichies.")
				pb_go.event clicked()
			END IF
			
		ELSE
			Messagebox("Attention", "Vous n'avez pas sélectionné d'éleveur.")
		END IF
		
	CASE "b_recherche"
		w_eleveur_rech	lw_wind_rech
		long	ll_no_eleveur

		//Vérifier s'il y a des items
		IF dw_commande_item.RowCount() > 0 THEN
			gnv_app.inv_error.of_message("CIPQ0043")
			RETURN 
		END IF
		
		IF ib_en_insertion THEN
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("insertion eleveur rech", "oui")
		ELSE
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("insertion eleveur rech", "non")
		END IF
		
		Open(lw_wind_rech)
		
		ll_no_eleveur = long(gnv_app.inv_entrepotglobal.of_retournedonnee("retour eleveur rech"))
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("insertion eleveur rech", "")
		
		IF not isnull(ll_no_eleveur) AND ll_no_eleveur > 0 THEN
			dw_commande.object.no_eleveur[row] = ll_no_eleveur
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("retour eleveur rech", "")
			
			parent.of_changerclient(ll_no_eleveur,row)
		END IF
		
END CHOOSE
end event

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)

THIS.of_setpremierecolonneinsertion("no_eleveur")
end event

event rowfocuschanged;call super::rowfocuschanged;string	ls_cie, ls_commande
long		ll_noeleveur

IF CurrentRow > 0 THEN
	
	IF This.Rowcount() > 0 THEN
		ls_cie = THIS.object.cieno[currentrow] 
		ls_commande = THIS.object.nocommande[currentrow]
		
		IF ib_en_insertion = FALSE THEN
			//Charger les informations de ce client
			ll_noeleveur = THIS.object.no_eleveur[currentrow]
			IF Not IsNull(ll_noeleveur) AND ll_noeleveur <> 0 THEN
				parent.of_changerclient(ll_noeleveur, currentrow)
			END IF
		
			dw_commande_item.Retrieve(ls_cie, ls_commande)
			
			dw_commande.Setitemstatus( currentrow, 0, Primary!, NotModified!)
			
		ELSE
			SetNull(ll_noeleveur)
			parent.of_changerclient(ll_noeleveur, currentrow)
		END IF
	END IF
	
END IF
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	date	ld_date
	
	em_date.getData(ld_date)
	
	IF IsNull(ld_date) THEN ld_date = date(today())
	
	THIS.object.datecommande[AncestorReturnValue] = datetime(ld_date, now())
	THIS.object.t_exception.visible = FALSE
	THIS.object.t_livraison.text = ""
	
END IF

RETURN AncestorReturnValue
end event

event pfc_predeleterow;call super::pfc_predeleterow;boolean	lb_askedbyclient = FALSE
string	ls_cie, ls_nocommande, ls_transfererpar, ls_sql
long		ll_row, ll_cpt, ll_compteur, ll_rtn, ll_no_client
date		ld_today

IF AncestorReturnValue > 0 THEN
	
	ll_row = THIS.GetRow()
	ll_no_client = THIS.object.no_eleveur[ll_row]
	
	IF NOT IsNull(ll_no_client) THEN
		//Vérifier s'il y a des fils
		IF dw_commande_item.RowCount() > 0 THEN
			IF gnv_app.inv_error.of_message( "CIPQ0057" ) = 1 THEN
				lb_askedbyclient = TRUE
			END IF
		END IF
	END IF
	
	ls_nocommande = THIS.object.nocommande[ll_row]
	ls_cie = THIS.object.cieno[ll_row]
	
	IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "SaveToPrinter")) = "TRUE" THEN 
		parent.of_savedetailtoprinter( ls_cie, ls_nocommande, "Supprimer")
	END IF
	
	ls_transfererpar = THIS.object.transferepar[ll_row]
	
	IF lb_askedbyclient = TRUE AND ( IsNull(ls_transfererpar) OR ls_transfererpar = "" ) THEN
		
		//Rafraichir la partie du bas pour mettre à jour le champ "compteur"
		ll_rtn = dw_commande_item.Retrieve(ls_cie, ls_nocommande)
		
		//Supprimer les commandes originales non transférée, si pas d'un transfert, et si commande cancellé par le client
		FOR ll_cpt = 1 TO ll_rtn
			ll_compteur = dw_commande_item.object.compteur[ll_cpt]
			
			//Delete de la commande originale
			ls_sql = "DELETE FROM t_CommandeOriginale WHERE t_CommandeOriginale.CieNo='" + ls_cie + &
				"' AND t_CommandeOriginale.NoCommande='" + ls_nocommande + &
				"' AND t_CommandeOriginale.NoLigne=" + string(ll_compteur)
			
			gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeOriginale", "Suppression", parent.Title)
			
		END FOR
	
	END IF
	
	//Si delete, delete dans 't_Commande_Validation'
	/*IF Not IsNull(ll_no_client) THEN
		ld_today = Today()
		
		ls_sql = "delete FROM t_Commande_Validation " + &
			"WHERE date(DateCommande) = '" + string(ld_today,"yyyy-mm-dd") + &
			"' AND No_Eleveur = " + string(ll_no_client)
			
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_Commande_Validation", "Destruction", parent.title)
	END IF*/
END IF


RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

long		ll_row
string	ls_nocommande, ls_cie

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	
	ls_nocommande = THIS.object.nocommande[ll_row]
	ls_cie = THIS.object.cieno[ll_row]
	IF IsNull(ls_nocommande) THEN
		ls_nocommande = string(parent.of_recupererprochainno(ls_cie))
		THIS.object.nocommande[ll_row] = ls_nocommande
	END IF
	
	//Vérifier si la commande a été imprimée
	IF gnv_app.of_verifiersicommandeimprimee(ls_nocommande) = TRUE THEN
		gnv_app.inv_error.of_message("CIPQ0058")
		THIS.Undo()
		RETURN FAILURE
	END IF

	
	//Vérifier si la commande a été traitée
	IF gnv_app.of_verifiersicommandetraitee(ls_nocommande) = TRUE THEN
		gnv_app.inv_error.of_message("CIPQ0059")
		THIS.Undo()
		RETURN FAILURE
	END IF
	
END IF

RETURN ancestorreturnvalue
end event

event updateend;call super::updateend;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

string	ls_sql, ls_nocommande, ls_cie, ls_codeverrat, ls_famille
long		ll_noeleveur, ll_row, ll_cpt, ll_qte, ll_noproduit, ll_count
datetime	ldt_commande
date		ld_today

ll_row = THIS.GetRow()
IF ll_row > 0 THEN
	
	ls_nocommande = THIS.object.nocommande[ll_row]
	gnv_app.of_OrderUnLock(ls_nocommande)
	
	IF rowsinserted = 0 AND rowsupdated = 0 AND rowsdeleted = 0 THEN RETURN ancestorreturnvalue
	
	IF THIS.GetItemStatus(ll_row, 0, Primary!) = NotModified! THEN RETURN ancestorreturnvalue
	
	ll_noeleveur = THIS.object.no_eleveur[ll_row]
	
	ls_cie = THIS.object.cieno[ll_row]
	ldt_commande = THIS.object.datecommande[ll_row]
	
	IF rowsinserted > 0 THEN
		//Si ajout, générer dans 't_Commande_Validation'
		
		ld_today = Today()
		
		//Vérifier si ça existe deja
		SELECT 	count(1) INTO :ll_count FROM t_Commande_Validation
		WHERE		date(DateCommande) = :ld_today AND No_Eleveur = :ll_noeleveur USING SQLCA;
		
		IF IsNull(ll_count) OR ll_count = 0 THEN
			ls_sql = "INSERT INTO t_Commande_Validation ( DateCommande, No_Eleveur ) " + &
				"SELECT Now() AS DateCommande, " + string(ll_noeleveur) + " AS NoEleveur"
			
			gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_Commande_Validation", "Ajout", parent.title)
		END IF
	
	END IF
	
END IF

RETURN ancestorreturnvalue
end event

event pro_keypress;call super::pro_keypress;IF KeyDown(KeyControl!) THEN
	IF KeyDown(KeyS!) THEN
		uo_fin.event ue_buttonclicked("Enregistrer")
	END IF
	IF KeyDown(KeyQ!) THEN
		IF parent.event pfc_save() >= 0 THEN
			dw_commande_item.POST EVENT pfc_insertrow()
			dw_commande_item.SetFocus()
		END IF
	END IF
END IF
end event

event dropdown;call super::dropdown;datawindowchild 	ldwc_client
long					ll_rowdddw, ll_eleveur

IF THIS.GetRow() > 0 THEN
	
	CHOOSE CASE THIS.GetColumnName()
		CASE "no_eleveur"
			
			ll_eleveur = THIS.object.no_eleveur[THIS.GetRow()]

			IF GetChild( "no_eleveur", ldwc_client) = 1 THEN
				  //Sélectionner la rangée
				  ll_rowdddw = ldwc_client.Find("no_eleveur = " + string(ll_eleveur), 1, ldwc_client.RowCount())
				  IF ll_rowdddw > 0 THEN
					  ldwc_client.SetRow(ll_rowdddw)
					  ldwc_client.ScrollToRow(ll_rowdddw)
				END IF
			END IF
			
	END CHOOSE

END IF

end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_commande
event destroy ( )
string tag = "resize=frbsr"
integer x = 123
integer y = 2016
integer width = 4256
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long ll_trans
string ls_centre 

ls_centre = gnv_app.of_getcompagniedefaut( )

CHOOSE CASE as_button

	CASE "Ajouter un item"
		
		select isnull(t_centrecipq.transfert,0) into :ll_trans from t_centrecipq where cie = :ls_centre;
		if ll_trans = 1 then
			messagebox("Avertissement!","Un envoie d'un autre centre est en cours veuillez attendre 1 minute avant de procéder",Information!, OK!)
			return
		end if
		
		IF PARENT.event pfc_save() >= 0 THEN
			dw_commande_item.SetFocus()		
			dw_commande_item.event pfc_insertrow()
		END IF
		
	CASE "Supprimer cet item"
		dw_commande_item.event pfc_deleterow()

END CHOOSE

end event

type st_afficher from statictext within w_commande
integer x = 2560
integer y = 44
integer width = 745
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Afficher les commandes du:"
boolean focusrectangle = false
end type

type em_date from u_em within w_commande
integer x = 3333
integer y = 36
integer width = 439
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Tahoma"
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

event modified;call super::modified;long	ll_nbligne

IF parent.event pfc_save() >= 0 then
	id_date_retrieve = date(this.text)
	ll_nbligne = dw_commande.retrieve(id_date_retrieve, il_client_retrieve)
	dw_commande.gROUPcALC()
	st_affichees.text = "Affichées: " + string(ll_nbligne)
	IF ll_nbligne > 0 THEN
		//Rafraichir les infos
		
		dw_commande.event rowfocuschanged(1)
	END IF
end if
end event

type gb_1 from groupbox within w_commande
integer x = 73
integer y = 1264
integer width = 4370
integer height = 896
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Items"
end type

type rr_1 from roundrectangle within w_commande
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 148
integer width = 4549
integer height = 2048
integer cornerheight = 40
integer cornerwidth = 46
end type

type uo_toolbar_haut from u_cst_toolbarstrip within w_commande
event destroy ( )
string tag = "resize=frbsr"
integer x = 123
integer y = 1104
integer width = 4261
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;string ls_centre
long ll_trans
boolean lb_ImpJournal

CHOOSE CASE as_button

	CASE "Ajouter une commande"
		
		select isnull(t_centrecipq.transfert,0) into :ll_trans from t_centrecipq where cie = :ls_centre;
		if ll_trans = 1 then
			messagebox("Avertissement!","Un envoie d'un autre centre est en cours veuillez attendre 1 minute avant de procéder",Information!, OK!)
			return
		end if
		
		IF PARENT.event pfc_save() >= 0 THEN
			dw_commande.SetFocus()		
			ib_insertion_temp = TRUE
			dw_commande.event pfc_insertrow()
			ib_insertion_temp = FALSE
		END IF
		
	CASE "Supprimer cette commande"
		dw_commande.event pfc_deleterow()
		
		// Impression du journal
	 	lb_ImpJournal = (lower(trim(gnv_app.of_getValeurIni("DATABASE", "SaveToPrinter"))) = 'true')
	    if lb_ImpJournal then gnv_app.inv_journal.of_ImprimerJournal()

END CHOOSE
end event

type uo_fin from u_cst_toolbarstrip within w_commande
event destroy ( )
string tag = "resize=frbsr"
integer x = 27
integer y = 2228
integer width = 4544
integer taborder = 60
boolean bringtotop = true
end type

on uo_fin.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;boolean lb_ImpJournal
string ls_centre
long ll_trans

CHOOSE CASE as_button

	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Enregistrer"
		
		ls_centre = gnv_app.of_getcompagniedefaut()

		select isnull(t_centrecipq.transfert,0) into :ll_trans from t_centrecipq where cie = :ls_centre;
		if ll_trans = 1 then
			messagebox("Avertissement!","Un envoie d'un autre centre est en cours veuillez attendre 1 minute avant de procéder",Information!, OK!)
			return
		end if
		
		IF dw_commande_item.rowcount( ) = 0 THEN RETURN
		IF PARENT.event pfc_save() >= 0 THEN
		//	of_message()
			ib_insertion_temp = TRUE
			dw_commande.SetFocus()
			dw_commande.event pfc_insertrow()
			ib_insertion_temp = FALSE
		END IF
		
		// Impression du journal
	 	lb_ImpJournal = (lower(trim(gnv_app.of_getValeurIni("DATABASE", "SaveToPrinter"))) = 'true')
	    if lb_ImpJournal then gnv_app.inv_journal.of_ImprimerJournal()
	
	CASE "Enregistrer comme commande répétitive..."
		IF parent.event pfc_save() >= 0 THEN
			PARENT.post of_enregistrerrepetitive()
		end if
		
	CASE "Rechercher..."
		IF PARENT.event pfc_save() >= 0 THEN
			IF dw_commande.RowCount() > 0 THEN
				dw_commande.SetRow(1)
				dw_commande.ScrolltoRow(1)
				dw_commande.event pfc_finddlg()		
			END IF			
		END IF
		
		
END CHOOSE

end event

type dw_commande_item from u_dw within w_commande
integer x = 123
integer y = 1316
integer width = 4256
integer height = 684
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_commande_item"
boolean ib_insertion_a_la_fin = true
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_commande)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("cieno","cieno")
this.inv_linkage.of_Register("nocommande","nocommande")

SetRowFocusindicator(Hand!)

THIS.of_setpremierecolonneinsertion("qtecommande")

end event

event itemchanged;call super::itemchanged;string 				ls_desc, ls_null
long					ll_rowdddw, ll_qte
datawindowchild 	ldwc_verrat, ldwc_noproduit

SetNull(ls_null)

boolean	lb_rtn
string	ls_commande
//Avant d'accepter toute forme de modification, vérifier si la rangée est Locked
IF row > 0 AND ib_en_insertion = FALSE THEN
	ls_commande = THIS.object.nocommande[row]
	IF Not IsNull(ls_commande) AND ls_commande <> "" THEN
		lb_rtn = gnv_app.of_chkiflockandlock( ls_commande, TRUE)
		IF lb_rtn = TRUE THEN
			THIS.ib_suppression_message_itemerror = TRUE
			RETURN 1
		END IF
		
	END IF
END IF

CHOOSE CASE dwo.name
	
	CASE "qtecommande"
		ll_qte = long(data)
		THIS.object.qteinit[row] = ll_qte
		THIS.AcceptText()
		
	CASE "codeverrat"
		
		IF IsNull(data) or data = "" THEN 
			THIS.object.description[row] = ""
			RETURN 
		END IF
		
		THIS.GetChild('codeverrat', ldwc_verrat)
		ldwc_verrat.setTransObject(SQLCA)
		ll_rowdddw = ldwc_verrat.Find("upper(codeverrat) = '" + upper(data) + "'", 1, ldwc_verrat.RowCount())		
		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			//Mettre à jour la description
			ls_desc = ldwc_verrat.GetItemString(ll_rowdddw,"nom")
			THIS.object.description[row] = ls_desc
		ELSE
			gnv_app.inv_error.of_message("CIPQ0054")
			THIS.ib_suppression_message_itemerror = TRUE
			SetNull(data)
			RETURN 1
		END IF
		
		THIS.object.noproduit[row] = ls_null
		THIS.object.t_produit_nomproduit[row] = ""

	CASE "noproduit"

		//Vérifier s'il y a un raccourci sur la saisie de l'utilisateur
		string	ls_TempValue, ls_produit
		
		THIS.GetChild('noproduit', ldwc_noproduit)

		SELECT id_prod_ass INTO :ls_tempvalue FROM T_AssociationProd WHERE id_ass = trim(:data) ;
		
		If Not IsNull(ls_TempValue) AND ls_TempValue <> "" Then 
			ls_produit = ls_TempValue
			if ldwc_noproduit.Find("upper(noproduit) = '" + upper(ls_TempValue) + "-GS'", 1, ldwc_noproduit.RowCount()) > 0 then
				ls_produit += '-GS'
			end if
			
			THIS.object.noproduit[row] = ls_produit
		ELSE
			ls_produit = trim(data)
			if ls_produit <> data then
				THIS.object.noproduit[row] = ls_produit
			end if
		END IF
		
//		ldwc_noproduit.setTransObject(SQLCA)
//		//Nouveau retrieve parce que la dddw n'était pas toujours bien chargée
//		ldwc_noproduit.Retrieve()
		ll_rowdddw = ldwc_noproduit.Find("upper(noproduit) = '" + upper(ls_produit) + "'", 1, ldwc_noproduit.RowCount())
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			//Mettre à jour la description
			ls_desc = ldwc_noproduit.GetItemString(ll_rowdddw,"nomproduit")
			THIS.object.description[row] = ls_desc
			THIS.object.t_produit_nomproduit[row] = ls_desc
		ELSE
			//Vérifier si le focus est dans la zone
			//12-09-08 Ligne en dessous mis en commentaire car elle ne validait plus les numéros de produits
			//IF THIS.GetColumnName() <> "noproduit" THEN 
				gnv_app.inv_error.of_message("CIPQ0055")
				SetNull(data)
				THIS.object.noproduit[row] = ls_null
				THIS.ib_suppression_message_itemerror = TRUE
				THIS.object.t_produit_nomproduit[row] = ""
				RETURN 1				
			//END IF
		END IF

		If (Not IsNull(ls_TempValue) AND ls_TempValue <> "") or ls_produit <> data Then
			RETURN 2
		END IF
		
END CHOOSE
end event

event itemfocuschanged;call super::itemfocuschanged;datawindowchild 	ldwc_verrat, ldwc_noproduit
string 				ls_select_str, ls_column, ls_rtn, ls_codeverrat, ls_produit
n_cst_eleveur		lnv_eleveur
long					ll_row_parent, ll_eleveur
boolean				lb_gedis = FALSE

IF Row > 0 THEN
	
	ll_row_parent = dw_commande.GetRow()
	
	ll_eleveur = dw_commande.object.no_eleveur[ll_row_parent]
	
	lb_gedis = lnv_eleveur.of_formationgedis(ll_eleveur)	
	IF isnull(lb_gedis) THEN lb_gedis = FALSE

	CHOOSE CASE dwo.name 
		CASE "noproduit"
			
			ls_produit = THIS.object.noproduit[row]
			ls_codeverrat = THIS.object.codeverrat[row]
			
			If Not IsNull(ls_codeverrat) AND ls_codeverrat <> "" Then
				//Filtre par no de verrat
				ls_select_str = "SELECT DISTINCT t_Produit.NoProduit, t_Produit.NomProduit, t_Produit.NoClasse, t_Produit.PrixUnitaire " + &
					" FROM t_Produit INNER JOIN t_Verrat_Produit ON upper(t_Produit.NoProduit) = upper(t_Verrat_Produit.NoProduit) "

				If lb_gedis = TRUE Then
					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + "'))"
				Else
					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + &
						"') AND ((Right(upper(t_Produit.NoProduit),3)) <> '-GS'))"
				End If	
				
				ls_select_str = ls_select_str + " AND t_produit.noproduit NOT IN (SELECT nameheb FROM t_codehebdet WHERE no_eleveur = " + string(ll_eleveur) + ")"
					
			ELSE
				//Pas de verrat spécifié
				ls_select_str = gnv_app.of_findsqlproduit( ll_eleveur, FALSE, FALSE)
				
			END IF
			
			IF GetChild( "noproduit", ldwc_noproduit ) = 1 THEN
				ls_rtn = ldwc_noproduit.modify( "DataWindow.Table.Select=~"" + ls_select_str + "~"" )
				
				//Nouveau retrieve parce que la dddw n'était pas toujours bien chargée
				ldwc_noproduit.setTransObject(SQLCA)
				ldwc_noproduit.Retrieve()
			END IF
			
	END CHOOSE

END IF

end event

event updateend;call super::updateend;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

string	ls_sql, ls_nocommande, ls_cie, ls_codeverrat, ls_famille, ls_description, ls_noproduit, &
			ls_ItemCommande, ls_noproduitligne, ls_codeverratligne
long		ll_noeleveur, ll_row, ll_cpt, ll_qte, ll_rtn, ll_compteur, ll_cpt2, ll_qteinit, ll_row_parent, &
			ll_row_ligne, ll_quantite
datetime	ldt_commande
date		ld_commande
n_ds		lds_this

ll_row = dw_commande.GetRow()
IF ll_row > 0 THEN

	IF rowsinserted = 0 AND rowsupdated = 0 AND rowsdeleted = 0 THEN RETURN ancestorreturnvalue
	
	lds_this = CREATE n_ds
	lds_this.dataobject = "d_commande_item"
	lds_this.of_setTransobject(SQLCA)

	ll_noeleveur = dw_commande.object.no_eleveur[ll_row]
	ls_nocommande = dw_commande.object.nocommande[ll_row]
	ls_cie = dw_commande.object.cieno[ll_row]
	ldt_commande = dw_commande.object.datecommande[ll_row]

	gnv_app.of_OrderUnLock(ls_nocommande)
	
	IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "CommandeRecolte")) = "TRUE" THEN 
		FOR ll_cpt = 1 TO THIS.RowCount()
			ls_codeverrat = THIS.object.codeverrat[ll_cpt]
			ls_noproduit = THIS.object.noproduit[ll_cpt]
			ll_qte = THIS.object.qtecommande[ll_cpt]
			IF IsNull(ll_qte) THEN ll_qte = 0
			
			IF ls_codeverrat <> "" AND NOT IsNull(ls_codeverrat) THEN
				ls_SQL = "UPDATE t_Recolte_Commande " + &
					"SET t_Recolte_Commande.QteSoldeCommande = t_Recolte_Commande.QteSoldeCommande - " + string(ll_qte) + &
					" WHERE Date(t_Recolte_Commande.DateCommande)='" + string(ldt_commande, "yyyy-mm-dd") + &
					"' AND t_Recolte_Commande.Verrat=1 AND t_Recolte_Commande.Famille='" + ls_codeverrat + "' "
				gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_Recolte_Commande", "Mise à jour", parent.title)
				
			ELSE
				//Trouver la famille du produit
				SELECT 	famille INTO :ls_famille
				FROM 		t_produit
				WHERE		noproduit = :ls_noproduit USING SQLCA;
				
				IF IsNull(ls_famille) THEN ls_famille = ""
				
				ls_SQL = "UPDATE t_Recolte_Commande " + &
					"SET t_Recolte_Commande.QteSoldeCommande = t_Recolte_Commande.QteSoldeCommande - " + string(ll_qte) + &
					" WHERE Date(t_Recolte_Commande.DateCommande)='" + string(ldt_commande, "yyyy-mm-dd") + &
					"' AND t_Recolte_Commande.Verrat=0 AND t_Recolte_Commande.Famille='" + ls_famille + "' "
				gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_Recolte_Commande", "Mise à jour", parent.title)
				
			END IF
			
		END FOR
		
	END IF


	ll_row_parent = dw_commande.GetRow()
	ll_noeleveur = dw_commande.object.no_eleveur[ll_row_parent]
	ld_commande = date(ldt_commande)

	ll_row_ligne = THIS.GetRow()
	IF ll_row_ligne > 0 THEN
		ls_codeverratligne = THIS.object.codeverrat[ll_row_ligne]
		ls_noproduitligne = THIS.object.noproduit[ll_row_ligne]
		ll_quantite = THIS.object.qtecommande[ll_row_ligne]
		
		IF ll_quantite > 0 THEN
			If Isnull(ls_codeverratligne) OR ls_codeverratligne = "" THEN 
				ls_ItemCommande = string(ll_quantite) + "x " + ls_noproduitligne
			ELSE
				ls_ItemCommande = string(ll_quantite) + "x " + ls_noproduitligne + ", Verrat: " + ls_codeverratligne
			END IF
				
			IF rowsupdated > 0 THEN
				IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "SaveToPrinter")) = "TRUE" THEN 
					parent.of_SaveDetailToPrinterItem(ld_commande, string(ll_noeleveur), ls_nocommande, ls_ItemCommande, "Modifier")
					//parent.of_savedetailtoprinter( ls_cie, ls_nocommande, "Modifier")
				END IF
			END IF
		
			IF rowsinserted > 0 THEN
				IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "SaveToPrinter")) = "TRUE" THEN 
					parent.of_SaveDetailToPrinterItem(ld_commande, string(ll_noeleveur), ls_nocommande, ls_ItemCommande, "Ajouter")
					//parent.of_savedetailtoprinter( ls_cie, ls_nocommande, "Ajouter")
				END IF
			END IF	
		END IF
	
		//Mettre à jour les choix en conséquence
		IF THIS.RowCount() > 0 THEN
			lds_this.Retrieve(ls_cie, ls_nocommande)	
			gnv_app.of_updatechoix(lds_this)
		END IF
	
		//Conserver les commandes originales (ajout si inexistant - update si existant)
		//Rafraichir la partie du bas pour les champs "compteur" et "choix"
		ll_rtn = dw_commande_item.Retrieve(ls_cie, ls_nocommande)
		
		//Delete de la commande originale
		ls_sql = "DELETE FROM t_CommandeOriginale WHERE t_CommandeOriginale.CieNo='" + ls_cie + &
			"' AND t_CommandeOriginale.NoCommande='" + ls_nocommande + "' "
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeOriginale", "Suppression", parent.Title)
		
		FOR ll_cpt2 = 1 TO ll_rtn
			ll_compteur = THIS.object.compteur[ll_cpt2]
			ls_codeverrat = THIS.object.codeverrat[ll_cpt2]
			If Isnull(ls_codeverrat) THEN ls_codeverrat = ""
			ls_noproduit = THIS.object.noproduit[ll_cpt2]
			ll_qteinit = THIS.object.qteinit[ll_cpt2]	
			IF IsNull(ll_qteinit) THEN ll_qteinit = 0
			ls_description = THIS.object.description[ll_cpt2]		
			If Isnull(ls_description) THEN ls_description = ""
			ls_description = gnv_app.inv_string.of_globalreplace( ls_description, "'", "''")
			If IsNull(ll_qteinit) = FALSE AND ll_qteinit <> 0 THEN		
				//Insertion de la commande originale
				ls_sql = "INSERT INTO t_CommandeOriginale " + &
					"(cieno, nocommande, noligne, datecommande, no_eleveur, noproduit, codeverrat, description, qteinit) " + &
					"VALUES('" + ls_cie + "', '" + ls_nocommande + "', " + string(ll_compteur) + ", '" + &
					string(ldt_commande, "yyyy-mm-dd hh:mm:ss") + "', " + string(ll_noeleveur) + ", '" + string(ls_noproduit) + &
					"', '" + ls_codeverrat + "', '" + ls_description + "', " + string(ll_qteinit) + " )"
		
				gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeOriginale", "Insertion", parent.Title)
			END IF
			
		END FOR
	END IF
	
	IF IsValid(lds_this) THEN destroy(lds_this)
	
END IF

RETURN ancestorreturnvalue
end event

event pfc_predeleterow;call super::pfc_predeleterow;long		ll_quantite, ll_row, ll_qteinit, ll_compteur, ll_row_parent, ll_noeleveur
string 	ls_sql, ls_cie, ls_nocommande, ls_transferepar, ls_tranname, ls_ItemCommande, ls_codeverrat, ls_noproduit
date		ld_commande

IF AncestorReturnValue > 0 THEN
	
	ll_row = THIS.GetRow()
	IF ll_row > 0 THEN
		ls_cie = THIS.object.cieno[ll_row]
		ll_qteinit = THIS.object.qteinit[ll_row]
		ls_nocommande = THIS.object.nocommande[ll_row]
		ll_compteur = THIS.object.compteur[ll_row]
		ls_tranname = THIS.object.tranname[ll_row]
		ll_quantite = THIS.object.qtecommande[ll_row]
		ls_codeverrat = THIS.object.codeverrat[ll_row]
		ls_noproduit = THIS.object.noproduit[ll_row]
				
		ll_row_parent = dw_commande.GetRow()
		ls_transferepar = dw_commande.object.transferepar[ll_row_parent]
		ll_noeleveur = dw_commande.object.no_eleveur[ll_row_parent]
		ld_commande = date(dw_commande.object.datecommande[ll_row_parent])
		
		//Supprimer les commandes originales si ne viens pas d'un transfert, qtéinit<>0 et pas transféré
		If (IsNull(ls_transferepar) Or ls_transferepar = "") AND not IsNull(ll_compteur) Then
			If Not IsNull(ll_qteinit) And ll_qteinit <> 0 And (IsNull(ls_tranname) OR ls_tranname = "") Then
				ls_sql = "DELETE FROM t_CommandeOriginale " + " WHERE t_CommandeOriginale.CieNo = '" + ls_cie + &
					"' AND t_CommandeOriginale.NoCommande='" + ls_nocommande + &
					"' AND t_CommandeOriginale.NoLigne= " + string(ll_compteur)
				gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeOriginale", "Destruction", parent.Title)
			End If
		End If
		
		//Imprimer
		If ll_quantite <> 0 AND Not IsNull(ll_quantite) And Not IsNull(ls_noproduit) And ls_noproduit <> "" Then
			If Isnull(ls_codeverrat) OR ls_codeverrat = "" THEN 
				ls_ItemCommande = ls_noproduit
			ELSE
				ls_ItemCommande = ls_noproduit + ", Verrat: " + ls_codeverrat
			END IF
			
			IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "SaveToPrinter")) = "TRUE" THEN 
				of_SaveDetailToPrinterItem(ld_commande, string(ll_noeleveur), ls_nocommande, ls_ItemCommande, "Supprimer")
			END IF
		End If
	END IF
END IF


RETURN AncestorReturnValue


end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

long		ll_row, ll_count, ll_no, ll_rowparent
string	ls_codeverrat, ls_noproduit, ls_nocommande

ll_row = THIS.GetRow()

IF ll_row > 0 THEN

	//Vérifier si la commande a été imprimée
	ll_rowparent = dw_commande.GetRow()
	IF ll_rowparent > 0 THEN
		ls_nocommande = dw_commande.object.nocommande[ll_rowparent]
		IF gnv_app.of_verifiersicommandetraitee(ls_nocommande) = TRUE THEN
			gnv_app.inv_error.of_message("CIPQ0058")
			THIS.Undo()
			RETURN FAILURE
		END IF
	END IF

	ll_no = THIS.object.noligne[ll_row]
	If IsNull(ll_no) THEN
		ll_no = PARENT.of_recupererprochainnumeroitem()
		THIS.object.noligne[ll_row] = ll_no
	END IF

	ls_codeverrat = THIS.object.codeverrat[ll_row]
	ls_noproduit = THIS.object.noproduit[ll_row]
	
	//Si pas de produit
	IF IsNull(ls_noproduit) OR ls_noproduit = "" THEN
		gnv_app.inv_error.of_message("pfc_requiredmissing", {"Produit"})
		THIS.SetColumn("noproduit")
		RETURN FAILURE
	END IF
	
	//Si pas de verrat
	If IsNull(ls_codeverrat) OR ls_codeverrat = "" Then
		If Not IsNull(ls_noproduit) Then
			SELECT count(1) INTO :ll_count
			FROM t_Verrat_Produit WHERE upper(t_Verrat_Produit.NoProduit) = upper(:ls_noproduit) USING SQLCA;
			
			IF ll_count > 0 THEN
				gnv_app.inv_error.of_message("CIPQ0060",{ls_noproduit})
				SetColumn("codeverrat")
			
				RETURN FAILURE
			End If
		End If
	End If	
END IF

RETURN ancestorreturnvalue
end event

event pro_enter;
IF THIS.GetColumnName() = "codeverrat" THEN
	IF parent.event pfc_save() >= 0 THEN
		THIS.POST EVENT pfc_insertrow()
	END IF
ELSE
	CALL SUPER::pro_enter
END IF
end event

event pro_keypress;call super::pro_keypress;IF KeyDown(KeyControl!) THEN
	IF KeyDown(KeyE!) THEN
		do while yield()
		loop
		uo_fin.event ue_buttonclicked("Enregistrer")
	END IF
END IF
end event

event dropdown;call super::dropdown;datawindowchild 	ldwc_noproduit
string 				ls_produit
long					ll_rowdddw

IF THIS.GetRow() > 0 THEN
	
	CHOOSE CASE THIS.GetColumnName()
		CASE "noproduit"
			
			ls_produit = THIS.object.noproduit[THIS.GetRow()]
			IF IsNull(ls_produit) THEN
				AcceptText()
				ls_produit = THIS.object.noproduit[THIS.GetRow()]
			END IF

			IF GetChild( "noproduit", ldwc_noproduit ) = 1 THEN
				//Sélectionner la rangée
				ll_rowdddw = ldwc_noproduit.Find("upper(noproduit) = '" + upper(ls_produit) + "'", 1, ldwc_noproduit.RowCount())
				IF ll_rowdddw > 0 THEN
					ldwc_noproduit.SetRow(ll_rowdddw)
					ldwc_noproduit.ScrollToRow(ll_rowdddw)
				END IF
			END IF
			
	END CHOOSE

END IF

end event

event pfc_retrieve;call super::pfc_retrieve;// Pour filtrer la liste de verrats - Sébastien 2008-10-31

datawindowchild ldwc_verrat

if this.getChild("codeverrat", ldwc_verrat) = 1 then
	return this.event pfc_populatedddw("codeverrat", ldwc_verrat)
else
	return -1
end if
end event

event pfc_populatedddw;call super::pfc_populatedddw;if as_colname = 'codeverrat' then
	if dw_commande.getRow() > 0 then
		adwc_obj.setTransObject(SQLCA)
		adwc_obj.setSQLSelect(gnv_app.of_sqllisteverrats(dw_commande.object.no_eleveur[dw_commande.getRow()]))
		return adwc_obj.retrieve()
	else
		adwc_obj.reset()
		return 0
	end if
end if
end event

type st_affichees from statictext within w_commande
boolean visible = false
integer x = 3963
integer y = 1696
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "Affichées:"
boolean focusrectangle = false
end type

type rb_dujour from u_rb within w_commande
boolean visible = false
integer x = 3950
integer y = 1376
integer width = 416
integer height = 68
boolean bringtotop = true
long backcolor = 15793151
string text = "Du jour"
boolean checked = true
end type

event clicked;call super::clicked;long	ll_nbligne

IF parent.event pfc_save() >= 0 then
	id_date_retrieve = date(today())
	ll_nbligne = dw_commande.retrieve(id_date_retrieve, il_client_retrieve)
	st_affichees.text = "Affichées: " + string(ll_nbligne)
	IF ll_nbligne > 0 THEN
		//Rafraichir les infos
		
		dw_commande.event rowfocuschanged(1)
	END IF
end if
end event

type rb_tout from u_rb within w_commande
boolean visible = false
integer x = 3950
integer y = 1484
integer width = 416
integer height = 68
boolean bringtotop = true
long backcolor = 15793151
string text = "Tout"
end type

event clicked;call super::clicked;long	ll_nbligne
date	ld_null

SetNull(ld_null)
IF parent.event pfc_save() >= 0 then
	id_date_retrieve = date(ld_null)
	ll_nbligne = dw_commande.retrieve(ld_null, il_client_retrieve)
	st_affichees.text = "Affichées: " + string(ll_nbligne)
	IF ll_nbligne > 0 THEN
		//Rafraichir les infos
		
		dw_commande.event rowfocuschanged(1)
	END IF
end if

end event

type st_3 from statictext within w_commande
integer x = 3954
integer y = 44
integer width = 187
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Client:"
boolean focusrectangle = false
end type

type ddlb_client from u_ddlb within w_commande
integer x = 4142
integer y = 36
integer width = 389
integer height = 416
integer taborder = 30
boolean bringtotop = true
boolean allowedit = true
end type

event modified;call super::modified;long		ll_nbligne
string	ls_texte

IF parent.event pfc_save() >= 0 then
	
	ls_texte = this.text
	IF Upper(ls_texte) = "TOUS" THEN
		SetNull(il_client_retrieve)
	ELSE
		il_client_retrieve = long(ls_texte)
	END IF
	
	ll_nbligne = dw_commande.retrieve(id_date_retrieve, il_client_retrieve)
	dw_commande.GroupCalc()
	IF ll_nbligne > 0 THEN
		//Rafraichir les infos
		dw_commande.event rowfocuschanged(1)
	END IF
	st_affichees.text = "Affichées: " + string(ll_nbligne)
end if
end event

type pb_go from picturebutton within w_commande
integer x = 3776
integer y = 28
integer width = 101
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "C:\ii4net\CIPQ\images\rechercher.jpg"
alignment htextalign = left!
end type

event clicked;long ll_nbligne

ll_nbligne = dw_commande.retrieve(id_date_retrieve, il_client_retrieve)
IF ll_nbligne > 0 THEN
	dw_commande.event rowfocuschanged(1)
END IF
end event

type gb_2 from u_gb within w_commande
boolean visible = false
integer x = 3872
integer y = 1272
integer width = 576
integer height = 888
integer taborder = 11
long backcolor = 15793151
string text = "Commandes"
end type


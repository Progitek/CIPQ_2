$PBExportHeader$w_commande_repetitive.srw
forward
global type w_commande_repetitive from w_sheet_frame
end type
type uo_fin from u_cst_toolbarstrip within w_commande_repetitive
end type
type em_date from u_em within w_commande_repetitive
end type
type st_1 from statictext within w_commande_repetitive
end type
type st_2 from statictext within w_commande_repetitive
end type
type st_3 from statictext within w_commande_repetitive
end type
type dw_commande_repetitive from u_dw within w_commande_repetitive
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_commande_repetitive
end type
type dw_commande_repetitive_item from u_dw within w_commande_repetitive
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_commande_repetitive
end type
type gb_1 from groupbox within w_commande_repetitive
end type
type gb_2 from groupbox within w_commande_repetitive
end type
type rr_1 from roundrectangle within w_commande_repetitive
end type
type ddlb_client from u_ddlb within w_commande_repetitive
end type
type pb_go from picturebutton within w_commande_repetitive
end type
end forward

global type w_commande_repetitive from w_sheet_frame
string tag = "menu=m_commandesrepetitives"
uo_fin uo_fin
em_date em_date
st_1 st_1
st_2 st_2
st_3 st_3
dw_commande_repetitive dw_commande_repetitive
uo_toolbar_haut uo_toolbar_haut
dw_commande_repetitive_item dw_commande_repetitive_item
uo_toolbar_bas uo_toolbar_bas
gb_1 gb_1
gb_2 gb_2
rr_1 rr_1
ddlb_client ddlb_client
pb_go pb_go
end type
global w_commande_repetitive w_commande_repetitive

type variables
boolean	ib_insertion_temp = FALSE, ib_destruction_temp = FALSE

long		il_client_retrieve
date		id_date_retrieve
end variables

forward prototypes
public subroutine of_afficherclient (long al_client)
public subroutine of_setcodetransport (string as_code_transport)
public function integer of_changerclient (long al_no_client, long al_row)
public subroutine of_savedetailtoprinter (string as_cie, string as_nocommande, string as_mode)
public function long of_recupererprochainno (string as_cie)
public function long of_recupererprochainnumeroitem ()
public subroutine of_savedetailtoprinteritem (date ad_datecommande, string as_noeleveur, string as_nocommande, string as_itemcommande, string as_mode)
end prototypes

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
//	2007-12-13	Mathieu Gendron	Création
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

ll_row = dw_commande_repetitive.GetRow()

IF ll_nbrow > 0 THEN
	
	//Afficher le message d'avertissement
	ll_livr = lds_eleveur.object.livraisonspecial[ll_nbrow]
	IF ll_livr = 1 THEN
		ls_msg = trim(lds_eleveur.object.livraisonspecialmsg[ll_nbrow])
		
		IF IsNull(ls_msg) OR ls_msg = "" THEN
			gnv_app.inv_error.of_message("CIPQ0041")
		ELSE
			//Enlevé le message à leur demande 2008-10-17
			//gnv_app.inv_error.POST of_message("CIPQ0042", {ls_msg})
			dw_commande_repetitive.object.t_livraison.visible = TRUE
			ls_msg = gnv_app.inv_string.of_globalreplace( ls_msg, '"', "'")
			dw_commande_repetitive.object.t_livraison.text = "Message: " + ls_msg
			dw_commande_repetitive.object.t_exception.visible = TRUE
		END IF
	ELSE
		dw_commande_repetitive.object.t_livraison.visible = FALSE
		dw_commande_repetitive.object.t_exception.visible = FALSE
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
			
			
	dw_commande_repetitive.object.cc_client[ll_row] = ls_texte
	
	//Transporteur
	ll_transp = lds_eleveur.object.liv_notran[ll_nbrow]
	If IsNull(ll_transp) OR ll_transp = 0 THEN
		ll_transp = lds_eleveur.object.secteur_transporteur[ll_nbrow]
		IF IsNull(ll_transp) THEN ll_transp = 0
	END IF
	dw_commande_repetitive.object.cc_transporteur[ll_row] = ll_transp
	
	//Code de transport
	ls_codetransport_temp = trim(lds_eleveur.object.codetransport[ll_nbrow])
	//Si la valeur est vide, mettre le code d etransport par défaut
	ls_codetrans = dw_commande_repetitive.object.codetransport[ll_row]
	IF IsNull(ls_codetrans) OR ls_codetrans = "" THEN
		dw_commande_repetitive.object.codetransport[ll_row] = ls_codetransport_temp
		ls_codetrans = ls_codetransport_temp
	END IF
	
	//Formation gedis
	ll_gedis = lds_eleveur.object.formationgedis[ll_nbrow]
	IF ll_gedis = 1 THEN
		dw_commande_repetitive.object.cc_gedis[ll_row] = 1
	ELSE
		dw_commande_repetitive.object.cc_gedis[ll_row] = 0
	END IF
	
	THIS.of_setcodetransport(ls_codetrans)
	
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
	
	dw_commande_repetitive.object.t_rep.text = ls_nomrep
	
	//chkhorsque
	ll_hors = lds_eleveur.object.t_regionagri_hor_qu[ll_nbrow]
	IF ll_hors = 1 THEN
		dw_commande_repetitive.object.chkhorque[ll_row] = 1
	ELSE
		dw_commande_repetitive.object.chkhorque[ll_row] = 0
	END IF
	
ELSE
	//Mettre tout à null
	dw_commande_repetitive.object.t_livraison.visible = FALSE
	dw_commande_repetitive.object.t_livraison.text = ""
	dw_commande_repetitive.object.t_exception.visible = FALSE
	

	dw_commande_repetitive.object.t_codetransport.text = ""
	
	dw_commande_repetitive.object.cc_client[ll_row] = ""
	
	dw_commande_repetitive.object.cc_gedis[ll_row] = 0
	
	dw_commande_repetitive.object.cc_transporteur[ll_row] = ll_null
	dw_commande_repetitive.object.codetransport[ll_row] = ls_null

	dw_commande_repetitive.object.t_rep.text = ""
	dw_commande_repetitive.object.chkhorque[ll_row] = 0
	
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

dw_commande_repetitive.AcceptText()

ll_row = dw_commande_repetitive.GetRow()
dw_commande_repetitive.GetChild('codetransport', ldwc_codetransport)
ldwc_codetransport.setTransObject(SQLCA)

ll_row_dwc = ldwc_codetransport.Find("codetransport = '" + as_code_transport + "'", 1, ldwc_codetransport.RowCount())
IF ll_row_dwc > 0 THEN
	ls_trans = ldwc_codetransport.GetItemString(ll_row_dwc,"codetransport")
	ldec_prix = ldwc_codetransport.GetItemDecimal(ll_row_dwc,"prix")
	
	dw_commande_repetitive.object.t_codetransport.text = ls_trans
	
	IF ls_trans = "LC" OR ls_trans = "LSPE" OR ls_trans = "LP" OR ls_trans = "LV" THEN
		dw_commande_repetitive.object.livrampm[ll_row] = "AM"
	ELSE
		dw_commande_repetitive.object.livrampm[ll_row] = "PM"
	END IF
	
ELSE
	dw_commande_repetitive.object.t_codetransport.text = ""

END IF
end subroutine

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
//	2007-12-13	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

//Charger les informations de ce client
long		ll_noeleveur, ll_trouve
string	ls_cie

IF ib_insertion_temp THEN RETURN 0

ll_noeleveur = al_no_client

THIS.of_afficherclient( ll_noeleveur)
ls_cie = gnv_app.of_getcompagniedefaut()

IF dw_commande_repetitive.ib_en_insertion THEN

	SELECT 	count(no_eleveur) INTO :ll_trouve
	FROM		t_commanderepetitive
	WHERE		no_eleveur = :ll_noeleveur
	USING 	SQLCA;
	
	IF ll_trouve > 0 THEN
		//Il y a une autre commande répétitive pour cet éleveur
		gnv_app.inv_error.of_message("CIPQ0065") 
		
	END IF

	//ll_no = of_recupererprochainno(ls_cie)
	//dw_commande_repetitive.object.norepeat[al_row] = string(ll_no)	
	
END IF

dw_commande_repetitive.object.cieno[al_row] = ls_cie
//dw_commande_repetitive.object.t_no.text = ls_cie + " -"

dw_commande_repetitive.AcceptText()

//Charger les items - requery
dw_commande_repetitive_item.event pfc_retrieve()

//Lancer la sauvegarde
IF dw_commande_repetitive.ib_en_insertion THEN
	//THIS.event pfc_save()
END IF

RETURN 1
end function

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
ll_rowcount = dw_commande_repetitive_item.RowCount()
ll_rowparent = dw_commande_repetitive.GetRow()

FOR ll_cpt = 1 TO ll_rowcount
	ll_qte = dw_commande_repetitive_item.object.qtecommande[ll_cpt]
	
	IF Not IsNull(ll_qte) AND ll_qte <> 0 THEN
		
		ldt_commande = dw_commande_repetitive.object.datedernierrepeat[ll_rowparent]
		ll_noeleveur = dw_commande_repetitive.object.no_eleveur[ll_rowparent]
		ls_nocommande = string(dw_commande_repetitive.object.norepeat[ll_rowparent])
		
		ls_produit = dw_commande_repetitive_item.object.noproduit[ll_cpt]
		ls_verrat = dw_commande_repetitive_item.object.codeverrat[ll_cpt]
		
		ls_aString = string(ldt_commande,"yyyy-mm-dd") + "; " + as_Mode + ": " + string(now(), "hh:mm") + "; " + &
			string(ll_noeleveur) + "; REPTNoComm: " + as_NoCommande
		ls_aString = ls_aString + "; REPTCom:" + string(ll_qte) + " "
		
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

//Ancien
/*//////////////////////////////////////////////////////////////////////////////
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
//	2007-12-13	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

string	ls_aString = "", ls_sql, ls_nocommande, ls_verrat, ls_produit
long		ll_cpt, ll_rowcount, ll_qte, ll_rowparent, ll_noeleveur
datetime	ldt_commande

//Générer la ligne à imprimer
ll_rowcount = dw_commande_repetitive_item.RowCount()
ll_rowparent = dw_commande_repetitive.GetRow()

FOR ll_cpt = 1 TO ll_rowcount
	ll_qte = dw_commande_repetitive_item.object.qtecommande[ll_cpt]
	
	IF Not IsNull(ll_qte) AND ll_qte <> 0 THEN
		
		ldt_commande = dw_commande_repetitive.object.datedernierrepeat[ll_rowparent]
		ll_noeleveur = dw_commande_repetitive.object.no_eleveur[ll_rowparent]
		ls_nocommande = string(dw_commande_repetitive.object.norepeat[ll_rowparent])
		
		ls_produit = dw_commande_repetitive_item.object.noproduit[ll_cpt]
		ls_verrat = dw_commande_repetitive_item.object.codeverrat[ll_cpt]
		
		ls_aString = string(ldt_commande,"yyyy-mm-dd") + "; " + as_Mode + ": " + string(now(), "hh:mm") + "; " + &
			string(ll_noeleveur) + "; NoComm: " + as_NoCommande
			
		CHOOSE CASE "as_mode"
			CASE "Modifier"
				ls_aString = ls_aString + "; ReptCom:" + string(ll_qte) + " "
				
			CASE "Supprimer"
				ls_aString = ls_aString + ", ReptSup:" + string(ll_qte) + " "
				
		END CHOOSE
		
		
		If Not IsNull(ls_produit) Then
			 ls_aString = ls_aString + ls_produit
		End If
		
		If Not IsNull(ls_verrat) AND ls_verrat <> "" Then
			 ls_aString = ls_aString + ", Verrat:" + ls_verrat
		End If
		
		//Écrire dans 'Tmp_ImpressionCommande'
		ls_sql = "INSERT INTO Tmp_ImpressionCommande ( DescriptionCommande ) SELECT '" + ls_aString + "' AS Description"
		
		EXECUTE IMMEDIATE :ls_sql USING SQLCA;		
		
	END IF
	
END FOR



COMMIT USING SQLCA;*/
end subroutine

public function long of_recupererprochainno (string as_cie);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_recupererprochainno
//
//	Accès:  			Public
//
//	Argument:		String - Nom du centre
//
//	Retourne:  		Prochain no de commande
//
// Description:	Fonction pour le prochain no de commande
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-12-13	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long		ll_no, ll_retour
n_ds		lds_no_auto

lds_no_auto = CREATE n_ds
lds_no_auto.Dataobject = "ds_commande_repetitive_no_auto"
lds_no_auto.of_settransobject(SQLCA)

ll_retour = lds_no_auto.Retrieve(as_cie)
IF ll_retour > 0 THEN
	ll_no = lds_no_auto.object.cc_maximum[1]
	IF IsNull(ll_no) OR ll_no = 0 THEN ll_no = 1
ELSE
	ll_no = 1
END IF

IF IsValid(lds_no_auto) THEN Destroy(lds_no_auto)

RETURN ll_no
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
//	2008-11-12	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	max(noligne) + 1
INTO		:ll_no
FROM		t_commanderepetitivedetail
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

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
ls_aString = string(ad_DateCommande, "yyyy-mm-dd") + "; " + as_Mode + ": " + string(now(), "hh:mm") + "; " + as_NoEleveur + "; REPTNoComm: " + as_NoCommande + "; Item: " + as_ItemCommande

ls_aString = ls_aString + " Par: " + gnv_app.of_getuserid( )

//Écrire dans 'Tmp_ImpressionCommande'
ls_sql = "INSERT INTO Tmp_ImpressionCommande ( DescriptionCommande ) SELECT '" + ls_aString + "' AS Description"

EXECUTE IMMEDIATE :ls_sql USING SQLCA;

COMMIT USING SQLCA;
end subroutine

on w_commande_repetitive.create
int iCurrent
call super::create
this.uo_fin=create uo_fin
this.em_date=create em_date
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_commande_repetitive=create dw_commande_repetitive
this.uo_toolbar_haut=create uo_toolbar_haut
this.dw_commande_repetitive_item=create dw_commande_repetitive_item
this.uo_toolbar_bas=create uo_toolbar_bas
this.gb_1=create gb_1
this.gb_2=create gb_2
this.rr_1=create rr_1
this.ddlb_client=create ddlb_client
this.pb_go=create pb_go
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_fin
this.Control[iCurrent+2]=this.em_date
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.dw_commande_repetitive
this.Control[iCurrent+7]=this.uo_toolbar_haut
this.Control[iCurrent+8]=this.dw_commande_repetitive_item
this.Control[iCurrent+9]=this.uo_toolbar_bas
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.rr_1
this.Control[iCurrent+13]=this.ddlb_client
this.Control[iCurrent+14]=this.pb_go
end on

on w_commande_repetitive.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_fin)
destroy(this.em_date)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_commande_repetitive)
destroy(this.uo_toolbar_haut)
destroy(this.dw_commande_repetitive_item)
destroy(this.uo_toolbar_bas)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.rr_1)
destroy(this.ddlb_client)
destroy(this.pb_go)
end on

event open;call super::open;long		ll_nbligne, ll_norepeat, ll_no_eleveur
date		ld_date, ld_null
string	ls_cie

SetNull(ld_null)

//Vérifier si le lien provient de commande
ld_date = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien rep date"))
ll_norepeat = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien rep norepeat"))
ls_cie = gnv_app.inv_entrepotglobal.of_retournedonnee("lien rep cie")
ll_no_eleveur = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien rep no eleveur"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rep date", "")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rep norepeat", "")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rep cie", "")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rep no eleveur", "")

IF IsNull(ls_cie) OR ls_cie = "" THEN
	SetNull(il_client_retrieve)
	id_date_retrieve = date(today())
	ib_insertion_temp = TRUE
	ll_nbligne = dw_commande_repetitive.retrieve(id_date_retrieve, il_client_retrieve)
	em_date.text = string(today(),"yyyy-mm-dd")
	dw_commande_repetitive.SetFocus()
	dw_commande_repetitive.event pfc_insertrow()
	ib_insertion_temp = FALSE	
ELSE
	il_client_retrieve = ll_no_eleveur
	id_date_retrieve = ld_date
	ll_nbligne = dw_commande_repetitive.retrieve(id_date_retrieve, il_client_retrieve)
	IF ll_nbligne > 0 THEN
		dw_commande_repetitive.object.datedernierrepeat[1] = ld_null
		dw_commande_repetitive.SetFocus()
		dw_commande_repetitive.SetColumn("datedernierrepeat")
	END IF
	em_date.text = string(ld_date,"yyyy-mm-dd")
END IF

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un item", "AddWatch5!")
uo_toolbar_bas.of_AddItem("Supprimer cet item", "DeleteWatch5!")
uo_toolbar_bas.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter une commande répétitive", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_haut.of_AddItem("Supprimer cette commande répétitive", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_haut.of_displaytext(true)

uo_fin.of_settheme("classic")
uo_fin.of_DisplayBorder(true)
uo_fin.of_AddItem("Enregistrer", "Save!")
uo_fin.of_AddItem("Rechercher...", "Search!")
uo_fin.of_AddItem("Fermer", "Exit!")
uo_fin.of_displaytext(true)
end event

event pfc_postopen;call super::pfc_postopen;long	ll_nbrow, ll_cpt
n_ds 	lds_eleveur

lds_eleveur = CREATE n_ds
lds_eleveur.dataobject = "ds_commande_repetitive_eleveur"
lds_eleveur.SetTransobject(SQLCA)
ll_nbrow = lds_eleveur.retrieve()

ddlb_client.additem("Tous")

FOR ll_cpt = 1 TO ll_nbrow
	ddlb_client.additem(string(lds_eleveur.object.no_eleveur[ll_cpt]))
END FOR

ddlb_client.SelectItem(1)

IF IsValid(lds_eleveur) THEN DesTroy(lds_eleveur)
end event

type st_title from w_sheet_frame`st_title within w_commande_repetitive
integer x = 224
string text = "Commandes répétitives"
end type

type p_8 from w_sheet_frame`p_8 within w_commande_repetitive
integer x = 55
integer y = 32
integer width = 142
integer height = 112
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\commande_rep.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_commande_repetitive
integer y = 12
integer height = 156
end type

type uo_fin from u_cst_toolbarstrip within w_commande_repetitive
event destroy ( )
string tag = "resize=frbsr"
integer x = 27
integer y = 2228
integer width = 4544
integer taborder = 70
boolean bringtotop = true
end type

on uo_fin.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;boolean lb_ImpJournal 

CHOOSE CASE as_button

	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Enregistrer"
		em_date.SetFocus()
		IF PARENT.event pfc_save() >= 0 THEN
			ib_insertion_temp = TRUE
			dw_commande_repetitive.event pfc_insertrow()
			ib_insertion_temp = FALSE
		END IF
		
		// Impression du journal
	 	lb_ImpJournal = (lower(trim(gnv_app.of_getValeurIni("DATABASE", "SaveToPrinter"))) = 'true')
	    if lb_ImpJournal then gnv_app.inv_journal.of_ImprimerJournal()
		
	CASE "Rechercher..."
		IF PARENT.event pfc_save() >= 0 THEN
			IF dw_commande_repetitive.RowCount() > 0 THEN
				dw_commande_repetitive.SetRow(1)
				dw_commande_repetitive.ScrolltoRow(1)
				dw_commande_repetitive.event pfc_finddlg()	
			END IF
		END IF
END CHOOSE

end event

type em_date from u_em within w_commande_repetitive
integer x = 3392
integer y = 52
integer width = 411
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
	if this.getData(id_date_retrieve) < 1 then setNull(id_date_retrieve)
	
	ll_nbligne = dw_commande_repetitive.retrieve(id_date_retrieve, il_client_retrieve)
	dw_commande_repetitive.GroupCalc()
	IF ll_nbligne > 0 THEN
		//Rafraichir les infos
		dw_commande_repetitive.event rowfocuschanged(1)
	END IF
end if
end event

type st_1 from statictext within w_commande_repetitive
integer x = 2418
integer y = 60
integer width = 667
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
string text = "Afficher les commandes:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_commande_repetitive
integer x = 3214
integer y = 60
integer width = 178
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
string text = "Date:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_commande_repetitive
integer x = 3950
integer y = 60
integer width = 192
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

type dw_commande_repetitive from u_dw within w_commande_repetitive
integer x = 59
integer y = 204
integer width = 4466
integer height = 1052
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_commande_repetitive"
end type

event buttonclicked;call super::buttonclicked;long		ll_eleveur, ll_nbligne, ll_row
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
			ls_retour = gnv_app.inv_entrepotglobal.of_retournedonnee("donnee sommaire commande", TRUE)
		ELSE
			Messagebox("Attention", "Vous n'avez pas sélectionné d'éleveur.")
		END IF
		
	CASE "b_recherche"
		w_eleveur_rech	lw_wind_rech
		long	ll_no_eleveur

		//Vérifier s'il y a des items
		IF dw_commande_repetitive_item.RowCount() > 0 THEN
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
			dw_commande_repetitive.object.no_eleveur[row] = ll_no_eleveur
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

event itemchanged;call super::itemchanged;
Choose case dwo.name
	
	CASE "no_eleveur"
		
		long	ll_no_eleveur_old
		
		ll_no_eleveur_old = THIS.object.no_eleveur[row]
		
		//On peut changer le client sauf quand il y a des items de facturation
		IF dw_commande_repetitive_item.RowCount() > 0 THEN
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
			parent.of_changerclient(ll_noeleveur,row)
		END IF
		
		
	CASE "codetransport"
		THIS.AcceptText()
		of_setcodetransport(data)
		
END CHOOSE
end event

event rowfocuschanged;call super::rowfocuschanged;string	ls_cie, ls_repeat
long		ll_noeleveur

IF CurrentRow > 0 AND ib_destruction_temp = FALSE THEN
	
	ls_cie = THIS.object.cieno[currentrow]
	ls_repeat = THIS.object.norepeat[currentrow]
	
	IF ib_en_insertion = FALSE  THEN
		//Charger les informations de ce client
		ll_noeleveur = THIS.object.no_eleveur[currentrow]
		IF Not IsNull(ll_noeleveur) AND ll_noeleveur <> 0 THEN
			parent.of_changerclient(ll_noeleveur, currentrow)
		END IF
	
		dw_commande_repetitive_item.Retrieve(ls_cie, ls_repeat)
		
		dw_commande_repetitive.Setitemstatus( currentrow, 0, Primary!, NotModified!)
		
	ELSE
		SetNull(ll_noeleveur)
		parent.of_changerclient(ll_noeleveur, currentrow)
	END IF
	
END IF
end event

event updateend;call super::updateend;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

string	ls_sql, ls_norepeat, ls_cie, ls_codeverrat, ls_famille
long		ll_noeleveur, ll_row, ll_cpt, ll_qte, ll_noproduit
datetime	ldt_commande

ll_row = THIS.GetRow()
IF ll_row > 0 THEN
	
	IF rowsinserted = 0 AND rowsupdated = 0 AND rowsdeleted = 0 THEN RETURN ancestorreturnvalue
	
	IF THIS.GetItemStatus(ll_row, 0, Primary!) = NotModified! THEN RETURN ancestorreturnvalue
	
	ll_noeleveur = THIS.object.no_eleveur[ll_row]
	ls_norepeat = THIS.object.norepeat[ll_row]
	ls_cie = THIS.object.cieno[ll_row]
	ldt_commande = THIS.object.datedernierrepeat[ll_row]

	IF rowsinserted > 0 OR rowsupdated > 0 THEN
		IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "SaveToPrinter")) = "TRUE" THEN 
			//parent.of_savedetailtoprinter( ls_cie, ls_norepeat, "Modifier")
		END IF
	END IF

END IF

RETURN ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;
IF AncestorReturnValue > 0 THEN
	THIS.object.datedernierrepeat[AncestorReturnValue] = date(today())
END IF

RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

long		ll_row, ll_no
string	ls_norepeat, ls_cie

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	
	ls_norepeat = THIS.object.norepeat[ll_row]
	IF IsNull(ls_norepeat) THEN
		ls_cie = THIS.object.cieno[ll_row]
		ll_no = PARENT.of_recupererprochainno(ls_cie)
		THIS.object.norepeat[ll_row] = string(ll_no)	
//		update t_centrecipq set derniernocommande = :ll_no where cie = :ls_cie;
//		if sqlca.sqlcode = 0  then
//			commit using SQLCA;
//		else
//			rollback using SQLCA;
//		end if
	END IF
	
END IF

RETURN ancestorreturnvalue
end event

event pfc_predeleterow;call super::pfc_predeleterow;boolean	lb_askedbyclient = FALSE
string	ls_cie, ls_norepeat, ls_transfererpar, ls_sql
long		ll_row, ll_cpt, ll_compteur, ll_rtn

IF AncestorReturnValue > 0 THEN

	ib_destruction_temp = TRUE
	
	ll_row = THIS.GetRow()
	ls_norepeat = THIS.object.norepeat[ll_row]
	ls_cie = THIS.object.cieno[ll_row]
	
	IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "SaveToPrinter")) = "TRUE" THEN 
		parent.of_savedetailtoprinter( ls_cie, ls_norepeat, "Supprimer")
	END IF
	
END IF


RETURN AncestorReturnValue
end event

event pfc_deleterow;call super::pfc_deleterow;ib_destruction_temp = false

RETURN AncestorReturnValue
end event

event pro_keypress;call super::pro_keypress;IF KeyDown(KeyControl!) THEN
	IF KeyDown(KeyS!) THEN
		uo_fin.event ue_buttonclicked("Enregistrer")
	END IF
	IF KeyDown(KeyQ!) THEN
		IF parent.event pfc_save() >= 0 THEN
			dw_commande_repetitive_item.POST EVENT pfc_insertrow()
			dw_commande_repetitive_item.SetFocus()
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

type uo_toolbar_haut from u_cst_toolbarstrip within w_commande_repetitive
event destroy ( )
string tag = "resize=frbsr"
integer x = 123
integer y = 1120
integer width = 4265
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;string  ls_centre
long ll_trans
boolean lb_ImpJournal

CHOOSE CASE as_button

	CASE "Ajouter une commande répétitive"
		
		ls_centre = gnv_app.of_getcompagniedefaut()

		select isnull(t_centrecipq.transfert,0) into :ll_trans from t_centrecipq where cie = :ls_centre;
		if ll_trans = 1 then
			messagebox("Avertissement!","Un envoie d'un autre centre est en cours veuillez attendre 1 minute avant de procéder",Information!, OK!)
			return
		end if
		
		IF PARENT.event pfc_save() >= 0 THEN
			dw_commande_repetitive.SetFocus()		
			ib_insertion_temp = TRUE
			dw_commande_repetitive.event pfc_insertrow()
			ib_insertion_temp = FALSE
		END IF
		
	CASE "Supprimer cette commande répétitive"
		dw_commande_repetitive.event pfc_deleterow()
		
		// Impression du journal
	 	lb_ImpJournal = (lower(trim(gnv_app.of_getValeurIni("DATABASE", "SaveToPrinter"))) = 'true')
	    if lb_ImpJournal then gnv_app.inv_journal.of_ImprimerJournal()

END CHOOSE
end event

type dw_commande_repetitive_item from u_dw within w_commande_repetitive
integer x = 123
integer y = 1360
integer width = 4261
integer height = 652
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_commande_repetitive_item"
boolean ib_insertion_a_la_fin = true
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_commande_repetitive)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("cieno","cieno")
this.inv_linkage.of_Register("norepeat","norepeat")

SetRowFocusindicator(Hand!)


THIS.of_setpremierecolonneinsertion("qtecommande")

end event

event itemchanged;call super::itemchanged;string 				ls_desc, ls_null
long					ll_rowdddw
datawindowchild 	ldwc_verrat, ldwc_noproduit

SetNull(ls_null)

CHOOSE CASE dwo.name
		
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
			ls_produit = data
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
			//2009-04-24 Ligne en dessous mis en commentaire car elle ne validait plus les numéros de produits
			//IF THIS.GetColumnName() <> "noproduit" THEN 
				gnv_app.inv_error.of_message("CIPQ0055")
				SetNull(data)
				THIS.object.noproduit[row] = ls_null
				THIS.ib_suppression_message_itemerror = TRUE
				RETURN 1
			//END IF
		END IF

		If (Not IsNull(ls_TempValue) AND ls_TempValue <> "") or ls_produit <> data Then
			RETURN 2
		END IF		
END CHOOSE
end event

event itemfocuschanged;call super::itemfocuschanged;datawindowchild 	ldwc_verrat, ldwc_noproduit
string 				ls_select_str, ls_column, ls_rtn, ls_codeverrat
n_cst_eleveur		lnv_eleveur
long					ll_row_parent, ll_eleveur
boolean				lb_gedis = FALSE

IF Row > 0 THEN
	
	ll_row_parent = dw_commande_repetitive.GetRow()
	
	ll_eleveur = dw_commande_repetitive.object.no_eleveur[ll_row_parent]
	
	lb_gedis = lnv_eleveur.of_formationgedis(ll_eleveur)	
	IF isnull(lb_gedis) THEN lb_gedis = FALSE

	CHOOSE CASE dwo.name 
		CASE "noproduit"
			
			ls_codeverrat = THIS.object.codeverrat[row]
			
			If Not IsNull(ls_codeverrat) AND ls_codeverrat <> "" Then
				//Filtre par no de verrat
				ls_select_str = "SELECT DISTINCT t_Produit.NoProduit, t_Produit.NomProduit, t_Produit.NoClasse, t_Produit.PrixUnitaire " + &
					" FROM t_Produit INNER JOIN t_Verrat_Produit ON t_Produit.NoProduit = t_Verrat_Produit.NoProduit "
					
				If lb_gedis = TRUE Then
					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + "'))"
				Else
					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + &
						"') AND ((Right(upper(t_Produit.NoProduit),3))<>'-GS'))"
				End If				
						
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

string	ls_norepeat, ls_cie, ls_codeverratligne, ls_noproduitligne, ls_ItemCommande
long		ll_row, ll_rtn, ll_row_ligne, ll_quantite, ll_noeleveur
datetime	ldt_commande
date		ld_commande

n_ds		lds_this

ll_row = dw_commande_repetitive.GetRow()
IF ll_row > 0 THEN

	IF rowsinserted = 0 AND rowsupdated = 0 AND rowsdeleted = 0 THEN RETURN ancestorreturnvalue
	
	lds_this = CREATE n_ds
	lds_this.dataobject = "d_commande_repetitive_item"
	lds_this.of_setTransobject(SQLCA)
	
	ll_noeleveur = dw_commande_repetitive.object.no_eleveur[ll_row]
	ls_norepeat = dw_commande_repetitive.object.norepeat[ll_row]
	ls_cie = dw_commande_repetitive.object.cieno[ll_row]
	ldt_commande = dw_commande_repetitive.object.datedernierrepeat[ll_row]
	ld_commande = date(ldt_commande)
	
	ll_row_ligne = THIS.GetRow()
	if ll_row_ligne > 0 then
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
					parent.of_SaveDetailToPrinterItem(ld_commande, string(ll_noeleveur), ls_norepeat, ls_ItemCommande, "Modifier")
					//parent.of_savedetailtoprinter( ls_cie, ls_nocommande, "Modifier")
				END IF
			END IF
			
			IF rowsinserted > 0 THEN
				IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "SaveToPrinter")) = "TRUE" THEN 
					parent.of_SaveDetailToPrinterItem(ld_commande, string(ll_noeleveur), ls_norepeat, ls_ItemCommande, "Ajouter")
					//parent.of_savedetailtoprinter( ls_cie, ls_nocommande, "Ajouter")
				END IF
			END IF			
		END IF
	END IF
	
	//Mettre à jour les choix en conséquence
	IF THIS.RowCount() > 0 THEN
		lds_this.Retrieve(ls_cie, ls_norepeat)	
		gnv_app.of_updatechoix(lds_this)
	END IF
	IF IsValid(lds_this) THEN destroy(lds_this)
END IF

RETURN ancestorreturnvalue
end event

event pfc_preupdate;call super::pfc_preupdate;long 		ll_no, ll_row
string	ls_noproduit

IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	
	ls_noproduit = THIS.object.noproduit[ll_row]
	//Si pas de produit
	IF IsNull(ls_noproduit) OR ls_noproduit = "" THEN
		gnv_app.inv_error.of_message("pfc_requiredmissing", {"Produit"})
		RETURN FAILURE
	END IF

	ll_no = THIS.object.noligne[ll_row]
	IF IsNull(ll_no) THEN
		ll_no = PARENT.of_recupererprochainnumeroitem()
		THIS.object.noligne[ll_row] = ll_no
	END IF
END IF
RETURN ancestorreturnvalue
end event

event pro_keypress;call super::pro_keypress;IF KeyDown(KeyControl!) THEN
	IF KeyDown(KeyE!) THEN
		do while yield()
		loop
		uo_fin.event ue_buttonclicked("Enregistrer")
	END IF
END IF
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

event pfc_predeleterow;call super::pfc_predeleterow;long		ll_quantite, ll_row, ll_row_parent, ll_noeleveur
string 	ls_sql, ls_cie, ls_nocommande, ls_ItemCommande, ls_codeverrat, ls_noproduit
date		ld_commande

IF AncestorReturnValue > 0 THEN
	
	ll_row = THIS.GetRow()
	IF ll_row > 0 THEN
		ls_cie = THIS.object.cieno[ll_row]
		ls_nocommande = THIS.object.norepeat[ll_row]

		ll_quantite = THIS.object.qtecommande[ll_row]
		ls_codeverrat = THIS.object.codeverrat[ll_row]
		ls_noproduit = THIS.object.noproduit[ll_row]
				
		ll_row_parent = dw_commande_repetitive.GetRow()
		ll_noeleveur = dw_commande_repetitive.object.no_eleveur[ll_row_parent]
		ld_commande = date(dw_commande_repetitive.object.datedernierrepeat[ll_row_parent])
		
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

event pfc_retrieve;call super::pfc_retrieve;// Pour filtrer la liste de verrats - Sébastien 2008-10-31

datawindowchild ldwc_verrat

if this.getChild("codeverrat", ldwc_verrat) = 1 then
	return this.event pfc_populatedddw("codeverrat", ldwc_verrat)
else
	return -1
end if
end event

event pfc_populatedddw;call super::pfc_populatedddw;if as_colname = 'codeverrat' then
	if dw_commande_repetitive.getRow() > 0 then
		adwc_obj.setTransObject(SQLCA)
		adwc_obj.setSQLSelect(gnv_app.of_sqllisteverrats(dw_commande_repetitive.object.no_eleveur[dw_commande_repetitive.getRow()]))
		return adwc_obj.retrieve()
	else
		adwc_obj.reset()
		return 0
	end if
end if
end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_commande_repetitive
event destroy ( )
string tag = "resize=frbsr"
integer x = 123
integer y = 2016
integer width = 4261
integer taborder = 60
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un item"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_commande_repetitive_item.SetFocus()		
			dw_commande_repetitive_item.event pfc_insertrow()
		END IF
		
	CASE "Supprimer cet item"
		dw_commande_repetitive_item.event pfc_deleterow()

END CHOOSE
end event

type gb_1 from groupbox within w_commande_repetitive
integer x = 73
integer y = 1264
integer width = 4443
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

type gb_2 from groupbox within w_commande_repetitive
integer x = 2382
integer y = 16
integer width = 2162
integer height = 136
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
end type

type rr_1 from roundrectangle within w_commande_repetitive
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 188
integer width = 4549
integer height = 2012
integer cornerheight = 40
integer cornerwidth = 46
end type

type ddlb_client from u_ddlb within w_commande_repetitive
integer x = 4137
integer y = 52
integer width = 389
integer height = 416
integer taborder = 20
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
	
	ll_nbligne = dw_commande_repetitive.retrieve(id_date_retrieve, il_client_retrieve)
	dw_commande_repetitive.gROUPcALC()
	IF ll_nbligne > 0 THEN
		//Rafraichir les infos
		dw_commande_repetitive.event rowfocuschanged(1)
	END IF
end if
end event

type pb_go from picturebutton within w_commande_repetitive
integer x = 3813
integer y = 48
integer width = 101
integer height = 88
integer taborder = 10
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

ll_nbligne = dw_commande_repetitive.retrieve(id_date_retrieve, il_client_retrieve)
IF ll_nbligne > 0 THEN
	dw_commande_repetitive.event rowfocuschanged(1)
END IF
end event


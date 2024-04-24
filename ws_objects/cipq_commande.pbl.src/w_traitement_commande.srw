﻿$PBExportHeader$w_traitement_commande.srw
forward
global type w_traitement_commande from w_sheet_frame
end type
type gb_2 from u_gb within w_traitement_commande
end type
type uo_fin from u_cst_toolbarstrip within w_traitement_commande
end type
type rb_toutes from u_rb within w_traitement_commande
end type
type rb_completees from u_rb within w_traitement_commande
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_traitement_commande
end type
type st_1 from statictext within w_traitement_commande
end type
type em_date from u_em within w_traitement_commande
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_traitement_commande
end type
type cb_traiter from commandbutton within w_traitement_commande
end type
type rb_ext from u_rb within w_traitement_commande
end type
type rb_lespurs from u_rb within w_traitement_commande
end type
type rb_trans from u_rb within w_traitement_commande
end type
type st_toutes from statictext within w_traitement_commande
end type
type st_completees from statictext within w_traitement_commande
end type
type st_ext from statictext within w_traitement_commande
end type
type st_lespurs from statictext within w_traitement_commande
end type
type st_trans from statictext within w_traitement_commande
end type
type sle_reste from singlelineedit within w_traitement_commande
end type
type st_3 from statictext within w_traitement_commande
end type
type dw_traite_ext from u_dw within w_traitement_commande
end type
type pb_go from picturebutton within w_traitement_commande
end type
type gb_1 from groupbox within w_traitement_commande
end type
type rr_1 from roundrectangle within w_traitement_commande
end type
type dw_traite_commande_item from u_dw within w_traitement_commande
end type
type gb_3 from groupbox within w_traitement_commande
end type
type dw_traite_commande from u_dw within w_traitement_commande
end type
end forward

global type w_traitement_commande from w_sheet_frame
string tag = "menu=m_traitementdescommandes"
integer x = 214
integer y = 221
integer width = 5179
integer height = 2712
gb_2 gb_2
uo_fin uo_fin
rb_toutes rb_toutes
rb_completees rb_completees
uo_toolbar_haut uo_toolbar_haut
st_1 st_1
em_date em_date
uo_toolbar_bas uo_toolbar_bas
cb_traiter cb_traiter
rb_ext rb_ext
rb_lespurs rb_lespurs
rb_trans rb_trans
st_toutes st_toutes
st_completees st_completees
st_ext st_ext
st_lespurs st_lespurs
st_trans st_trans
sle_reste sle_reste
st_3 st_3
dw_traite_ext dw_traite_ext
pb_go pb_go
gb_1 gb_1
rr_1 rr_1
dw_traite_commande_item dw_traite_commande_item
gb_3 gb_3
dw_traite_commande dw_traite_commande
end type
global w_traitement_commande w_traitement_commande

type variables
boolean	ib_insertion_temp = FALSE, ib_check = FALSE, ib_en_edition = FALSE

date		id_date_retrieve

string	is_sql_original, is_sql_en_cours

string	is_filtre_semence = "", is_filtre_trans = ""
end variables

forward prototypes
public subroutine of_afficherclient (long al_client)
public subroutine of_setcodetransport (string as_code_transport)
public function integer of_changerclient (long al_no_client, long al_row)
public subroutine of_calculnbenregistrements ()
public subroutine of_suppr_trans ()
public subroutine of_majreste ()
public subroutine of_transfert ()
public function long of_recupererprochainnumeroitem ()
public subroutine of_updateqtecom (long al_row, long al_qtecur)
public subroutine of_setedition (boolean ab_switch)
public subroutine of_savedetailtoprinter (string as_cie, string as_nocommande, string as_mode)
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
//	2007-10-16	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

//Charger les informations de ce client
n_ds		lds_eleveur
long		ll_nbrow, ll_noeleveur, ll_livr, ll_transp, ll_row, ll_gedis, ll_hors, ll_null
string	ls_texte, ls_msg, ls_adresse, ls_ville, ls_code, ls_conte, ls_tel, ls_codetrans, ls_RepId, &
			ls_nomrep, ls_null, ls_codetransport_temp

ll_noeleveur = al_client

SetNull(ll_null)
SetNull(ls_null)

lds_eleveur = CREATE n_ds

lds_eleveur.dataobject = "ds_eleveur"
lds_eleveur.of_setTransobject(SQLCA)
ll_nbrow = lds_eleveur.Retrieve(ll_noeleveur)

ll_row = dw_traite_commande.GetRow()

IF ll_nbrow > 0 THEN
	
	//Afficher le message d'avertissement
	ll_livr = lds_eleveur.object.livraisonspecial[ll_nbrow]
	IF ll_livr = 1 THEN
		ls_msg = trim(lds_eleveur.object.livraisonspecialmsg[ll_nbrow])
		
		IF IsNull(ls_msg) OR ls_msg = "" THEN
			//gnv_app.inv_error.of_message("CIPQ0041")
		ELSE
			//gnv_app.inv_error.POST of_message("CIPQ0042", {ls_msg})
			dw_traite_commande.object.t_livraison.visible = TRUE
			ls_msg = gnv_app.inv_string.of_globalreplace( ls_msg, '"', "'")
			dw_traite_commande.object.t_livraison.text = "Message: " + ls_msg
			dw_traite_commande.object.t_exception.visible = TRUE
		END IF
	ELSE
		dw_traite_commande.object.t_livraison.visible = FALSE
		dw_traite_commande.object.t_exception.visible = FALSE
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
	
			
			
	dw_traite_commande.object.cc_client[ll_row] = ls_texte
	
	//Transporteur
	ll_transp = lds_eleveur.object.liv_notran[ll_nbrow]
	If IsNull(ll_transp) OR ll_transp = 0 THEN
		ll_transp = lds_eleveur.object.secteur_transporteur[ll_nbrow]
		IF IsNull(ll_transp) THEN ll_transp = 0
	END IF
	dw_traite_commande.object.cc_transporteur[ll_row] = ll_transp
	
	//Code de transport
	ls_codetrans = trim(lds_eleveur.object.codetransport[ll_nbrow])
	//Si la valeur est vide, mettre le code d etransport par défaut
	ls_codetransport_temp = dw_traite_commande.object.codetransport[ll_row]
	IF IsNull(ls_codetransport_temp) OR ls_codetransport_temp = "" THEN
		dw_traite_commande.object.codetransport[ll_row] = ls_codetrans
		ls_codetransport_temp = ls_codetrans
	END IF
	
	
	//Formation gedis
	ll_gedis = lds_eleveur.object.formationgedis[ll_nbrow]
	IF ll_gedis = 1 THEN
		dw_traite_commande.object.cc_gedis[ll_row] = 1
	ELSE
		dw_traite_commande.object.cc_gedis[ll_row] = 0
	END IF
	
	THIS.of_setcodetransport(ls_codetransport_temp)
	
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
	
	dw_traite_commande.object.t_rep.text = ls_nomrep
	
	//chkhorsque
	ll_hors = lds_eleveur.object.t_regionagri_hor_qu[ll_nbrow]
	IF ll_hors = 1 THEN
		dw_traite_commande.object.chkhorque[ll_row] = 1
	ELSE
		dw_traite_commande.object.chkhorque[ll_row] = 0
	END IF
	
ELSE
	//Mettre tout à null
	dw_traite_commande.object.t_livraison.visible = FALSE
	dw_traite_commande.object.t_livraison.text = ""
	dw_traite_commande.object.t_exception.visible = FALSE
	

	dw_traite_commande.object.t_prix.text = ""
	dw_traite_commande.object.t_codetransport.text = ""
	
	dw_traite_commande.object.cc_client[ll_row] = ""
	
	dw_traite_commande.object.cc_gedis[ll_row] = 0
	
	dw_traite_commande.object.cc_transporteur[ll_row] = ll_null
	dw_traite_commande.object.codetransport[ll_row] = ls_null

	dw_traite_commande.object.t_rep.text = ""
	dw_traite_commande.object.chkhorque[ll_row] = 0
	
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

dw_traite_commande.AcceptText()

ll_row = dw_traite_commande.GetRow()
dw_traite_commande.GetChild('codetransport', ldwc_codetransport)
ldwc_codetransport.setTransObject(SQLCA)

ll_row_dwc = ldwc_codetransport.Find("codetransport = '" + as_code_transport + "'", 1, ldwc_codetransport.RowCount())
IF ll_row_dwc > 0 THEN
	ls_trans = ldwc_codetransport.GetItemString(ll_row_dwc,"codetransport")
	ldec_prix = ldwc_codetransport.GetItemDecimal(ll_row_dwc,"prix")
	
	dw_traite_commande.object.t_prix.text = string(ldec_prix, "#,##0.00 $; (#,##0.00 $)")
	dw_traite_commande.object.t_codetransport.text = ls_trans
	
	IF ls_trans = "LC" OR ls_trans = "LSPE" OR ls_trans = "LP" OR ls_trans = "LV" THEN
		dw_traite_commande.object.livrampm[ll_row] = "AM"
	ELSE
		dw_traite_commande.object.livrampm[ll_row] = "PM"
	END IF
ELSE
	dw_traite_commande.object.t_prix.text = ""
	dw_traite_commande.object.t_codetransport.text = ""

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
//	2007-11-09	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

//Charger les informations de ce client
long		ll_noeleveur, ll_rtn

IF ib_insertion_temp THEN RETURN 0

ll_noeleveur = al_no_client

THIS.of_afficherclient(ll_noeleveur)

// ***** Sébastien - 2008-10-31 *****
dataWindowChild ldwc_verrat

ll_rtn = dw_traite_commande_item.GetChild('codeverrat', ldwc_verrat)
ldwc_verrat.setTransObject(SQLCA)
ldwc_verrat.setSQLSelect(gnv_app.of_SQLListeVerrats(ll_noeleveur))
ll_rtn = ldwc_verrat.retrieve()
// **********************************

//ls_cie = gnv_app.of_getcompagniedefaut()
//
//IF dw_traite_commande.ib_en_insertion THEN
//	
//	//Vérifier pour la duplication
//	ld_datecommande = date(dw_traite_commande.object.datecommande[al_row])
//	ld_hier = relativedate(ld_datecommande, -1)
//	ld_demain = relativedate(ld_datecommande, 1)
//	
//	SELECT 	count(no_eleveur) INTO :ll_trouve
//	FROM		t_commande
//	WHERE		no_eleveur = :ll_noeleveur AND datecommande > :ld_hier AND datecommande < :ld_demain
//	USING 	SQLCA;
//	
//	IF ll_trouve > 0 THEN
//		//Il y a eu une commande saisie aujourd'hui
//		IF gnv_app.inv_error.of_message("CIPQ0046") <> 1 THEN
//			
//			//Le gars ne veut plus saisir une commande, il veut plutôt aller rechercher l'ancienne 
//			//un retrieve et pointer sur la bonne ligne
//			
//			dw_traite_commande.DeleteRow(al_row)
//			dw_traite_commande.Update(TRUE, TRUE)
//			
//			ll_find = dw_commande.Find("no_eleveur = " + string(ll_noeleveur) + " AND string(datecommande, 'yyyy-mm-dd') > '" + string(ld_hier, "yyyy-mm-dd") + "' AND string(datecommande, 'yyyy-mm-dd') < '" + string(ld_demain, "yyyy-mm-dd") + "'" , 1, dw_commande.rowCount() )
//			
//			IF ll_find > 0 THEN
//				dw_traite_commande.ib_en_insertion = FALSE
//				dw_traite_commande.event rowfocuschanged(ll_find)
//			END IF
//			
//			RETURN 0
//			
//			lb_duplic = TRUE
//			
//		END IF
//	ELSE
//		
//		SELECT 	count(no_eleveur) INTO :ll_trouve
//		FROM		t_commande_validation
//		WHERE		no_eleveur = :ll_noeleveur AND datecommande > :ld_hier AND datecommande < :ld_demain
//		USING 	SQLCA;
//		
//		IF ll_trouve > 0 THEN
//			//Il y a eu une commande TRAITÉE aujourd'hui
//			gnv_app.inv_error.of_message("CIPQ0045")
//			
//		END IF
//	END IF
//	
//	IF lb_duplic = FALSE THEN
////		ll_no = of_recupererprochainno(ls_cie)
////		dw_commande.object.nocommande[al_row] = string(ll_no)
//	END IF	
//	
//END IF
//
//dw_traite_commande.object.cieno[al_row] = ls_cie
//dw_traite_commande.object.t_no.text = ls_cie + " -"
//
//dw_traite_commande.AcceptText()
//
////Charger les items - requery
//dw_traite_commande_item.event pfc_retrieve()
//
////Lancer la sauvegarde
//IF dw_traite_commande.ib_en_insertion THEN
//	//THIS.event pfc_save()
//END IF 

RETURN 1
end function

public subroutine of_calculnbenregistrements ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_calculnbenregistrements
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour calculer le nombre de commandes par catégorie
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-01-25	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

date 		ld_select
long		ll_toute, ll_complet, ll_ext, ll_pur, ll_trans, ll_row, ll_reste
string	ls_nocommande, ls_cieno

em_date.getData(ld_select)
IF IsNull(ld_select) THEN RETURN

//Toutes
SELECT 	count(1) INTO :ll_toute FROM t_commande
WHERE		(t_Commande.Imprimer = 0 OR t_Commande.Imprimer is null) 
AND		(t_commande.locked = 'T' OR :ld_select <> today())
AND 		date(t_Commande.DateCommande) = :ld_select USING SQLCA;

IF IsNull(ll_toute) THEN ll_toute = 0
st_toutes.text = string(ll_toute)

//NbComplet
SELECT 	count(1) INTO :ll_complet FROM t_commande
WHERE		(t_Commande.Imprimer = 0 OR t_Commande.Imprimer is null) 
AND		t_Commande.Reste = 0 AND (t_commande.locked = 'T' OR :ld_select <> today())
AND 		date(t_Commande.DateCommande) = :ld_select USING SQLCA;

IF IsNull(ll_complet) THEN ll_complet = 0
st_completees.text = string(ll_complet)

//Externe non complet
SELECT  count(1) INTO :ll_ext
FROM 		t_Commande LEFT JOIN t_eleveur 
ON 		t_Commande.No_Eleveur = t_eleveur.No_Eleveur
WHERE 	isnull(t_Commande.Imprimer, 0) = 0 AND t_Commande.Reste <> 0 AND (t_commande.locked = 'T' OR :ld_select <> today())
AND 		date(t_Commande.DateCommande) = :ld_select And isnull(t_commande.traiter, 0) = 0 AND
(select externe from t_transporteur Where IdTransporteur = t_ELEVEUR.Secteur_Transporteur) = 1 USING SQLCA;

IF IsNull(ll_ext) THEN ll_ext = 0
st_ext.text = string(ll_ext)

//NbPur
SELECT 	count(DISTINCT t_Commande.NoCommande) INTO :ll_pur 
FROM 		t_Commande INNER JOIN t_CommandeDetail ON t_Commande.CieNo = t_CommandeDetail.CieNo 
AND 		t_Commande.NoCommande = t_CommandeDetail.NoCommande
WHERE 	isNull(t_CommandeDetail.CodeVerrat, '') <> '' AND (t_commande.locked = 'T' OR :ld_select <> today())
AND 		date(t_Commande.DateCommande) = :ld_select USING SQLCA;

IF IsNull(ll_pur) THEN ll_pur = 0
st_lespurs.text = string(ll_pur)

//NbTransfert
SELECT 	count(1) INTO :ll_trans 
FROM		t_Commande
WHERE 	TransferePar is not null AND isNull(t_Commande.Imprimer, 0) = 0 
AND		(t_commande.locked = 'T' OR :ld_select <> today())
AND 		date(t_Commande.DateCommande) = :ld_select USING SQLCA;

IF IsNull(ll_trans) THEN ll_trans = 0
st_trans.text = string(ll_trans)

//Mis a jour du champ texte
ll_row = dw_traite_commande.GetRow()
IF ll_row > 0 THEN
	ls_nocommande = dw_traite_commande.object.nocommande[ll_row]
	ls_cieno = dw_traite_commande.object.cieno[ll_row]
	SELECT reste
	INTO 	:ll_reste
	FROM 	t_commande
	WHERE	nocommande = :ls_nocommande AND cieno = :ls_cieno;
	
	IF Isnull(ll_reste) THEN ll_reste = 0
	
	sle_reste.text = string(ll_reste)
	
ELSE
	sle_reste.text = "0"
END IF
end subroutine

public subroutine of_suppr_trans ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_suppr_trans
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour la suppression des éléments transférés
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-01-29	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////
string ls_sql

IF gnv_app.inv_error.of_message("CIPQ0076") = 1 THEN
	ls_sql = "DELETE FROM t_CommandeDetail " + &
		"WHERE t_CommandeDetail.QteCommande=0 AND t_CommandeDetail.QteExpedie=0 AND t_CommandeDetail.TranName Is Not Null"
	gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeDetail", "Destruction", this.Title)
	
	rb_toutes.checked = TRUE
END IF

end subroutine

public subroutine of_majreste ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_majreste
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour maj le reste pour la commande
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-01-29	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_rowcount

UPDATE t_commande  SET reste = 
(SELECT Sum (isnull(QteCommande,0) -  isnull(QteExpedie, 0)) as cc_sum 
FROM t_CommandeDetail 
WHERE	t_commande.cieno = t_CommandeDetail.CieNo AND t_Commande.NoCommande = t_CommandeDetail.NoCommande
GROUP BY t_CommandeDetail.CieNo, t_CommandeDetail.NoCommande 
 ); 
COMMIT USING SQLCA;

//ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)
//IF ll_rowcount > 0 THEN
//	dw_traite_commande.post event rowfocuschanged(1)
//END IF		

end subroutine

public subroutine of_transfert ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_transfert
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour transférer une commande
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-01-29	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

date	ld_commande

ld_commande = date(em_date.text)

If not isnull(ld_commande) THEN

	gnv_app.inv_transfert_inter_centre.of_transfert( ld_commande )	

ELSE
	em_date.SetFocus()
END IF
end subroutine

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

public subroutine of_updateqtecom (long al_row, long al_qtecur);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_updateqtecom
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour mettre à jour la qte commandee
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-01-28	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long		ll_null, ll_ligne, ll_ligne_header, ll_item, ll_qtecom, ll_qteinit, ll_qtetransfere
string	ls_nocommande, ls_sql

SetNull(ll_null)

ls_nocommande = dw_traite_commande_item.object.nocommande[al_row]
ll_ligne = dw_traite_commande_item.object.noligne[al_row]
ll_ligne_header = dw_traite_commande_item.object.noligneheader[al_row]
ll_item = dw_traite_commande_item.object.noitem[al_row]
				
SELECT 	qteinit, qtecommande
INTO		:ll_qteinit, :ll_qtecom
FROM 		t_CommandeDetail
WHERE		nocommande = :ls_nocommande AND noitem = :ll_item AND noligneheader = 0 ;

SELECT 	sum(QteTransfert)
INTO		:ll_qtetransfere
FROM 		t_CommandeDetail
WHERE		nocommande = :ls_nocommande AND noitem = :ll_item 
GROUP BY	nocommande, noitem ;

IF IsNull(ll_qtetransfere) THEN ll_qtetransfere = 0
IF IsNull(al_qtecur) THEN al_qtecur = 0
IF IsNull(ll_qteinit) THEN ll_qteinit = 0
IF IsNull(ll_qtecom) THEN ll_qtecom = 0	

ll_qtetransfere = al_qtecur - ll_qtetransfere 

IF ll_qteinit = 0 THEN
	//Si pas de qté initiale (transfert)
	ll_qtecom = ll_qtecom - al_qtecur
ELSE
	ll_qtecom = ll_qteinit - ll_qtetransfere
END IF

//MAJ de QteComm
IF ll_ligne_header = 0 OR IsNull(ll_ligne_header) THEN
	dw_traite_commande_item.object.qtecommande[al_row] = ll_qtecom
ELSE
	ls_sql = "UPDATE t_CommandeDetail SET t_CommandeDetail.QteCommande = " + string(ll_qtecom) + &
		" WHERE  t_CommandeDetail.NoCommande='" + ls_nocommande + &
		"' AND 	t_CommandeDetail.NoItem=" + string(ll_item) + " AND t_CommandeDetail.NoLigneHeader=0 "
	gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_commandedetail", "Mise-à-jour", THIS.title)
	
END IF

end subroutine

public subroutine of_setedition (boolean ab_switch);ib_en_edition = ab_switch

IF ib_en_edition = FALSE THEN
	//Barrer les dw
	dw_traite_commande.object.datawindow.readonly = "Yes"
	dw_traite_commande_item.object.datawindow.readonly = "Yes"
ELSE
	//Débarrer les dw
	dw_traite_commande.object.datawindow.readonly = "No"
	dw_traite_commande_item.object.datawindow.readonly = "No"
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
ll_rowcount = dw_traite_commande_item.RowCount()
ll_rowparent = dw_traite_commande.GetRow()

FOR ll_cpt = 1 TO ll_rowcount
	ll_qte = dw_traite_commande_item.object.qtecommande[ll_cpt]
	
	IF Not IsNull(ll_qte) AND ll_qte <> 0 THEN
		
		ldt_commande = dw_traite_commande.object.datecommande[ll_rowparent]
		ll_noeleveur = dw_traite_commande.object.no_eleveur[ll_rowparent]
		ls_nocommande = string(dw_traite_commande.object.nocommande[ll_rowparent])
		
		ls_produit = dw_traite_commande_item.object.noproduit[ll_cpt]
		ls_verrat = dw_traite_commande_item.object.codeverrat[ll_cpt]
		
		ls_aString = "Via Traitement " + string(ldt_commande,"yyyy-mm-dd") + "; " + as_Mode + ": " + string(now(), "hh:mm") + "; " + &
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
ls_aString = "Via traitement " + string(ad_DateCommande, "yyyy-mm-dd") + "; " + as_Mode + ": " + string(now(), "hh:mm") + "; " + as_NoEleveur + "; NoComm: " + as_NoCommande + "; Item: " + as_ItemCommande

ls_aString = ls_aString + " Par: " + gnv_app.of_getuserid( )

//Écrire dans 'Tmp_ImpressionCommande'
ls_sql = "INSERT INTO Tmp_ImpressionCommande ( DescriptionCommande ) SELECT '" + ls_aString + "' AS Description"

EXECUTE IMMEDIATE :ls_sql USING SQLCA;

COMMIT USING SQLCA;
end subroutine

on w_traitement_commande.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.uo_fin=create uo_fin
this.rb_toutes=create rb_toutes
this.rb_completees=create rb_completees
this.uo_toolbar_haut=create uo_toolbar_haut
this.st_1=create st_1
this.em_date=create em_date
this.uo_toolbar_bas=create uo_toolbar_bas
this.cb_traiter=create cb_traiter
this.rb_ext=create rb_ext
this.rb_lespurs=create rb_lespurs
this.rb_trans=create rb_trans
this.st_toutes=create st_toutes
this.st_completees=create st_completees
this.st_ext=create st_ext
this.st_lespurs=create st_lespurs
this.st_trans=create st_trans
this.sle_reste=create sle_reste
this.st_3=create st_3
this.dw_traite_ext=create dw_traite_ext
this.pb_go=create pb_go
this.gb_1=create gb_1
this.rr_1=create rr_1
this.dw_traite_commande_item=create dw_traite_commande_item
this.gb_3=create gb_3
this.dw_traite_commande=create dw_traite_commande
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.uo_fin
this.Control[iCurrent+3]=this.rb_toutes
this.Control[iCurrent+4]=this.rb_completees
this.Control[iCurrent+5]=this.uo_toolbar_haut
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.em_date
this.Control[iCurrent+8]=this.uo_toolbar_bas
this.Control[iCurrent+9]=this.cb_traiter
this.Control[iCurrent+10]=this.rb_ext
this.Control[iCurrent+11]=this.rb_lespurs
this.Control[iCurrent+12]=this.rb_trans
this.Control[iCurrent+13]=this.st_toutes
this.Control[iCurrent+14]=this.st_completees
this.Control[iCurrent+15]=this.st_ext
this.Control[iCurrent+16]=this.st_lespurs
this.Control[iCurrent+17]=this.st_trans
this.Control[iCurrent+18]=this.sle_reste
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.dw_traite_ext
this.Control[iCurrent+21]=this.pb_go
this.Control[iCurrent+22]=this.gb_1
this.Control[iCurrent+23]=this.rr_1
this.Control[iCurrent+24]=this.dw_traite_commande_item
this.Control[iCurrent+25]=this.gb_3
this.Control[iCurrent+26]=this.dw_traite_commande
end on

on w_traitement_commande.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.uo_fin)
destroy(this.rb_toutes)
destroy(this.rb_completees)
destroy(this.uo_toolbar_haut)
destroy(this.st_1)
destroy(this.em_date)
destroy(this.uo_toolbar_bas)
destroy(this.cb_traiter)
destroy(this.rb_ext)
destroy(this.rb_lespurs)
destroy(this.rb_trans)
destroy(this.st_toutes)
destroy(this.st_completees)
destroy(this.st_ext)
destroy(this.st_lespurs)
destroy(this.st_trans)
destroy(this.sle_reste)
destroy(this.st_3)
destroy(this.dw_traite_ext)
destroy(this.pb_go)
destroy(this.gb_1)
destroy(this.rr_1)
destroy(this.dw_traite_commande_item)
destroy(this.gb_3)
destroy(this.dw_traite_commande)
end on

event open;call super::open;long		ll_nbligne, ll_rtn
string	ls_cie

ls_cie = gnv_app.of_getcompagniedefaut( )

dw_traite_ext.InsertRow(0)

//Retrieve de la dddw
dataWindowChild ldwc_trans

ll_rtn = dw_traite_commande_item.GetChild('trans', ldwc_trans)
ldwc_trans.setTransObject(SQLCA)
ll_rtn = ldwc_trans.retrieve(ls_cie)

id_date_retrieve = date(today())
em_date.text = string(today(),"yyyy-mm-dd")
is_sql_original = dw_traite_commande.GetSqlSelect()
is_sql_en_cours = is_sql_original
ll_nbligne = dw_traite_commande.retrieve(id_date_retrieve)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un item", "AddWatch5!")
uo_toolbar_bas.of_AddItem("Supprimer cet item", "DeleteWatch5!")
uo_toolbar_bas.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Supprimer cette commande", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_haut.of_AddItem("Rafraîchir", "Update!")
uo_fin.of_AddItem("Transfert", "Continue!")
uo_toolbar_haut.of_displaytext(true)

uo_fin.of_settheme("classic")
uo_fin.of_DisplayBorder(true)
uo_fin.of_AddItem("Édition", "EditStops5!")
uo_fin.of_AddItem("Rechercher...", "Search!")

//uo_fin.of_AddItem("Supprimer les éléments transférés", "Custom080!")
uo_fin.of_AddItem("Enregistrer", "Save!")
uo_fin.of_AddItem("Fermer", "Exit!")
uo_fin.of_displaytext(true)

//Long ll_newrow
//DataWindowChild dddw_child
//
//dw_traite_commande_item.getchild( "trans", dddw_child)
//ll_newrow = dddw_child.insertrow(1)
//dddw_child.setitem( 1, "prefnom", "")

end event

event pfc_preopen;call super::pfc_preopen;dw_traite_commande.Of_SetLinkage(TRUE)
dw_traite_commande_item.Of_SetLinkage(TRUE)

dw_traite_commande_item.inv_linkage.of_SetMaster(dw_traite_commande)
dw_traite_commande_item.inv_linkage.of_Register("cieno","cieno")
dw_traite_commande_item.inv_linkage.of_Register("nocommande","nocommande")
dw_traite_commande_item.inv_Linkage.of_SetStyle(dw_traite_commande_item.inv_Linkage.RETRIEVE)
dw_traite_commande.inv_linkage.of_SetTransObject(SQLCA)

 gnv_app.of_TraitLock()

end event

event close;call super::close;gnv_app.of_traitunlock( )
end event

event pfc_save;call super::pfc_save;THIS.of_majreste()
THIS.of_calculnbenregistrements()

RETURN AncestorReturnValue
end event

type st_title from w_sheet_frame`st_title within w_traitement_commande
integer x = 206
integer y = 40
string text = "Traitement des commandes"
end type

type p_8 from w_sheet_frame`p_8 within w_traitement_commande
integer x = 55
integer y = 24
integer width = 142
integer height = 112
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\commande_trait.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_traitement_commande
integer y = 0
integer height = 160
end type

type gb_2 from u_gb within w_traitement_commande
integer x = 59
integer y = 2192
integer width = 4466
integer height = 128
integer taborder = 0
long backcolor = 15793151
string text = "Commandes"
end type

type uo_fin from u_cst_toolbarstrip within w_traitement_commande
event destroy ( )
string tag = "resize=frbsr"
integer x = 27
integer y = 2344
integer width = 4544
integer taborder = 90
boolean bringtotop = true
end type

on uo_fin.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Enregistrer"
		IF ib_en_edition = TRUE THEN
			IF PARENT.event pfc_save() >= 0 THEN
				parent.of_setedition(FALSE)
			END IF
		END IF
	
	CASE "Transfert"
		IF parent.event pfc_save() >= 0 THEN
			parent.of_transfert()
			//Doit-on rafraichir par la suite? OUI
			em_date.event modified()
		end if
		
	CASE "Supprimer les éléments transférés"
		parent.of_suppr_trans()
		
	CASE "Rechercher..."
		IF ib_en_edition = FALSE THEN
			IF PARENT.event pfc_save() >= 0 THEN
				IF dw_traite_commande.GetRow() > 0 THEN
					dw_traite_commande.SetRow(1)
					dw_traite_commande.ScrollTorow(1)
					dw_traite_commande.event pfc_finddlg()
				END IF
			END IF
		ELSE
			gnv_app.inv_error.of_message("PRO0017")
		END IF
		
	CASE "Édition"
		parent.of_setedition(TRUE)
		
END CHOOSE
end event

type rb_toutes from u_rb within w_traitement_commande
integer x = 96
integer y = 2240
integer width = 416
integer height = 68
boolean bringtotop = true
long backcolor = 15793151
string text = "Toutes"
boolean checked = true
end type

event clicked;call super::clicked;long 		ll_rowcount
string	ls_rtn

is_sql_en_cours = is_sql_original
ls_rtn = dw_traite_commande.modify("datawindow.table.select=~""+is_sql_en_cours+"~"")
dw_traite_commande.SetTransObject(SQLCA)
ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)

IF ll_rowcount > 0 THEN
	dw_traite_commande.post event rowfocuschanged(1)
END IF

end event

type rb_completees from u_rb within w_traitement_commande
integer x = 613
integer y = 2240
integer width = 416
integer height = 68
boolean bringtotop = true
long backcolor = 15793151
string text = "Complétées"
end type

event clicked;call super::clicked;long 		ll_rowcount
string	ls_sql, ls_rtn

ls_sql = is_sql_original + " AND Reste = 0 "
is_sql_en_cours = ls_sql
ls_rtn = dw_traite_commande.modify("datawindow.table.select=~""+is_sql_en_cours+"~"")
dw_traite_commande.SetTransObject(SQLCA)
ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)

IF ll_rowcount > 0 THEN
	dw_traite_commande.post event rowfocuschanged(1)
END IF

end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_traitement_commande
event destroy ( )
string tag = "resize=frbsr"
integer x = 123
integer y = 1124
integer width = 2501
integer taborder = 60
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long	ll_rowcount

CHOOSE CASE as_button
		
	CASE "Supprimer cette commande"
		IF ib_en_edition = TRUE THEN
			dw_traite_commande.event pfc_deleterow()
			parent.of_setedition(FALSE)
		ELSE
			gnv_app.inv_error.of_message("PRO0016")
		END IF

	CASE "Rafraîchir"
		ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)
		IF ll_rowcount > 0 THEN
			dw_traite_commande.post event rowfocuschanged(1)
		END IF
		
		
END CHOOSE
end event

type st_1 from statictext within w_traitement_commande
integer x = 3241
integer y = 52
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

type em_date from u_em within w_traitement_commande
integer x = 3995
integer y = 44
integer width = 411
integer height = 84
integer taborder = 40
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
	this.getData(id_date_retrieve)
	IF id_date_retrieve = 1900-01-01 THEN SetNull(id_date_retrieve)
	ll_nbligne = dw_traite_commande.retrieve(id_date_retrieve)
	IF ll_nbligne > 0 THEN
		//Rafraichir les infos
		
		dw_traite_commande.event rowfocuschanged(1)
	END IF
end if
end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_traitement_commande
event destroy ( )
string tag = "resize=frbsr"
integer x = 123
integer y = 2048
integer width = 4366
integer taborder = 80
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
		
	CASE "Ajouter un item"
		IF ib_en_edition = TRUE THEN
			IF PARENT.event pfc_save() >= 0 THEN
				dw_traite_commande_item.SetFocus()		
				dw_traite_commande_item.event pfc_insertrow()
			END IF
		ELSE
			gnv_app.inv_error.of_message("PRO0016")
		END IF
		
	CASE "Supprimer cet item"
		IF ib_en_edition = TRUE THEN
			dw_traite_commande_item.event pfc_deleterow()
			parent.of_setedition(FALSE)
		ELSE
			gnv_app.inv_error.of_message("PRO0016")
		END IF

	CASE "Rafraîchir"
		long	ll_rowcount
		ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)
		IF ll_rowcount > 0 THEN
			dw_traite_commande.post event rowfocuschanged(1)
		END IF		
		
END CHOOSE
end event

type cb_traiter from commandbutton within w_traitement_commande
integer x = 3214
integer y = 2224
integer width = 581
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

event clicked;

long	ll_reste, ll_row, ll_completer, ll_nbligne

ll_row = dw_traite_commande.GetRow()

IF ll_row > 0 THEN
	
	IF PARENT.event pfc_save() >= 0 THEN
	
		ll_reste = 	dw_traite_commande.object.reste[ll_row]
		ll_completer = dw_traite_commande.object.traiter[ll_row]
		
		IF THIS.text = "Non-traitée" AND rb_completees.Checked = FALSE THEN
			
			IF gnv_app.inv_error.of_message("CIPQ0074") <> 1 THEN
				RETURN
			END IF
		END IF
		
		IF ll_completer = 1 THEN
			dw_traite_commande.object.traiter[ll_row] = 0
			THIS.text = "Non-traitée"
		ELSE
			dw_traite_commande.object.traiter[ll_row] = 1
			THIS.text = "Traitée"
		END IF
		ib_check = TRUE
		//wei modify 223-03-28 --- pfc_save() est executé deux fois, donc j'ai enlevé ce.
		//parent.event pfc_save()
		ib_check = FALSE
		
		//Aller à la ligne suivante
		IF ll_row < dw_traite_commande.RowCount() THEN
			dw_traite_commande.SetRow(ll_row + 1)
			dw_traite_commande.ScrolltoRow(ll_row + 1)
			dw_traite_commande.Event rowfocuschanged(ll_row + 1)
		END IF
		
	END IF
END IF
end event

type rb_ext from u_rb within w_traitement_commande
boolean visible = false
integer x = 2551
integer y = 2240
integer width = 466
integer height = 68
boolean bringtotop = true
long backcolor = 15793151
string text = "Ext. non-complet"
end type

event clicked;call super::clicked;long 		ll_rowcount
string	ls_sql, ls_rtn

ls_sql = is_sql_original + " AND Reste <> 0 AND externe = 1 "
is_sql_en_cours = ls_sql
ls_rtn = dw_traite_commande.modify("datawindow.table.select=~""+is_sql_en_cours+"~"")
dw_traite_commande.SetTransObject(SQLCA)
ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)

IF ll_rowcount > 0 THEN
	dw_traite_commande.post event rowfocuschanged(1)
END IF

end event

type rb_lespurs from u_rb within w_traitement_commande
integer x = 1262
integer y = 2240
integer width = 466
integer height = 68
boolean bringtotop = true
long backcolor = 15793151
string text = "Les Purs"
end type

event clicked;call super::clicked;long 		ll_rowcount
string	ls_sql, ls_rtn

is_sql_en_cours = is_sql_original + &
	" AND (SELECT count(1) FROM t_CommandeDetail  " + &
	" WHERE t_CommandeDetail.cieno = t_Commande.cieno AND " + &
	"t_CommandeDetail.nocommande = t_Commande.nocommande AND (t_CommandeDetail.CodeVerrat is not null OR t_CommandeDetail.CodeVerrat <> '')) > 0 " + &
	" AND (SELECT count(1) FROM t_CommandeDetail  " + &
	" WHERE t_CommandeDetail.cieno = t_Commande.cieno AND " + &
	" t_CommandeDetail.nocommande = t_Commande.nocommande) > 0 "
ls_rtn = dw_traite_commande.modify("datawindow.table.select=~"" + is_sql_en_cours + "~"")
dw_traite_commande.SetTransObject(SQLCA)
ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)

IF ll_rowcount > 0 THEN
	dw_traite_commande.post event rowfocuschanged(1)
END IF
end event

type rb_trans from u_rb within w_traitement_commande
integer x = 1833
integer y = 2240
integer width = 466
integer height = 68
boolean bringtotop = true
long backcolor = 15793151
string text = "Transférées par"
end type

event clicked;call super::clicked;long 		ll_rowcount
string	ls_rtn

is_sql_en_cours = is_sql_original + " AND (Not (TransferePar is null))  "
ls_rtn = dw_traite_commande.modify("datawindow.table.select=~""+is_sql_en_cours+"~"")
dw_traite_commande.SetTransObject(SQLCA)
ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)

IF ll_rowcount > 0 THEN
	dw_traite_commande.post event rowfocuschanged(1)
END IF

end event

type st_toutes from statictext within w_traitement_commande
integer x = 334
integer y = 2244
integer width = 146
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_completees from statictext within w_traitement_commande
integer x = 951
integer y = 2244
integer width = 146
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_ext from statictext within w_traitement_commande
boolean visible = false
integer x = 2994
integer y = 2244
integer width = 146
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_lespurs from statictext within w_traitement_commande
integer x = 1531
integer y = 2244
integer width = 146
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_trans from statictext within w_traitement_commande
integer x = 2254
integer y = 2244
integer width = 146
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_reste from singlelineedit within w_traitement_commande
integer x = 4119
integer y = 2228
integer width = 302
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
boolean border = false
end type

type st_3 from statictext within w_traitement_commande
integer x = 3927
integer y = 2228
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Reste:"
boolean focusrectangle = false
end type

type dw_traite_ext from u_dw within w_traitement_commande
integer x = 2711
integer y = 1120
integer width = 1705
integer height = 128
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_traite_ext"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;long		ll_rowcount, ll_rtn
string 	ls_sql

Choose case dwo.name
	
	CASE "cc_trans"
		//Effectuer le filtre sur le transfert
		is_filtre_trans = data
		If IsNull(data) THEN
			is_sql_en_cours = is_sql_original
			//THIS.SetSqlSelect(is_sql_original)
			dw_traite_commande.modify("datawindow.table.select=~""+is_sql_en_cours+"~"")
			dw_traite_commande.SetTransObject(SQLCA)
			ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)
			IF ll_rowcount > 0 THEN
				dw_traite_commande.post event rowfocuschanged(1)
			END IF

		ELSE
			is_filtre_semence = ""
			THIS.object.cc_semence[row] = ""
			
			//Changer le SQL pour mettre celui des transferts
			ls_sql = "SELECT t_commande.cieno,t_commande.nocommande,t_commande.no_eleveur, t_commande.nobonexpe, " + &
				"t_commande.boncommandeclient, t_commande.datecommande, t_commande.novendeur, t_commande.codetransport, " + &
         	"t_commande.livrampm, t_commande.traiter, t_commande.imprimer, t_commande.facture, t_commande.datefacturation, " + &  
         	"t_commande.nofacture, t_commande.tauxtaxefederale, t_commande.tauxtaxeprovinciale, t_commande.repeat, " + &  
         	"t_commande.reste, t_commande.message_commande, t_commande.repartition, t_commande.locked,  " + &
				"t_commande.duplication, t_commande.transferepar, t_commande.norepeat, 0 as cc_gedis, " + &  
         	"0 as cc_transporteur, 0 as chkHorQue, '' as cc_client, '' as cc_trans, '' as cc_semence, " + &
         	"t_ELEVEUR.CIE_NO as cc_t_eleveur_cie_no , t_ELEVEUR.DroitAllianceMaternelle, " + &
	 			"IFNULL ( t_ELEVEUR.liv_notran, t_ELEVEUR.Secteur_Transporteur , t_ELEVEUR.liv_notran) as cc_SecteurTransporteur " + &
    			"FROM t_commande  INNER JOIN t_CommandeDetail " + &
				"ON (t_Commande.NoCommande = t_CommandeDetail.NoCommande) AND (t_Commande.CieNo = t_CommandeDetail.CieNo) " + &
    			"LEFT JOIN t_ELEVEUR   ON t_Commande.No_Eleveur = t_ELEVEUR.No_Eleveur " + &
   			"WHERE (date(t_commande.datecommande) = :ad_date OR :ad_date is null) AND  " + &
         	"isnull(t_commande.traiter, 0) = 0 and isnull(t_commande.Imprimer, 0) = 0 " + &
				"AND t_CommandeDetail.Trans='" + data + "' " 
			is_sql_en_cours = ls_sql
			//ll_rtn = THIS.SetSqlSelect(is_sql_en_cours)
			dw_traite_commande.modify("datawindow.table.select=~""+is_sql_en_cours+"~"")
			dw_traite_commande.SetTransObject(SQLCA)
			ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)

			IF ll_rowcount = 0 THEN
				gnv_app.inv_error.of_message("CIPQ0075", {data})
			ELSE
				dw_traite_commande.post event rowfocuschanged(1)
			END IF
			
		END IF
		
	CASE "cc_semence"
		//Effectuer le filtre sur le produit
		is_filtre_semence = data
		If IsNull(data) THEN
			is_sql_en_cours = is_sql_original
			dw_traite_commande.modify("datawindow.table.select=~""+is_sql_en_cours+"~"")
			dw_traite_commande.SetTransObject(SQLCA)
			ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)

			IF ll_rowcount > 0 THEN
				dw_traite_commande.post event rowfocuschanged(1)
			END IF
			
		ELSE
			is_filtre_trans = ""
			THIS.object.cc_trans[row] = ""
			
			//Changer le SQL pour mettre celui des semences
			ls_sql = "SELECT t_commande.cieno,t_commande.nocommande,t_commande.no_eleveur, t_commande.nobonexpe, " + &
				"t_commande.boncommandeclient, t_commande.datecommande, t_commande.novendeur, t_commande.codetransport, " + &
         	"t_commande.livrampm, t_commande.traiter, t_commande.imprimer, t_commande.facture, t_commande.datefacturation, " + &  
         	"t_commande.nofacture, t_commande.tauxtaxefederale, t_commande.tauxtaxeprovinciale, t_commande.repeat, " + &  
         	"t_commande.reste, t_commande.message_commande, t_commande.repartition, t_commande.locked,  " + &
				"t_commande.duplication, t_commande.transferepar, t_commande.norepeat, 0 as cc_gedis, " + &  
         	"0 as cc_transporteur, 0 as chkHorQue, '' as cc_client, '' as cc_trans, '' as cc_semence, " + &
         	"t_ELEVEUR.CIE_NO as cc_t_eleveur_cie_no , t_ELEVEUR.DroitAllianceMaternelle, " + &
	 			"IFNULL ( t_ELEVEUR.liv_notran, t_ELEVEUR.Secteur_Transporteur , t_ELEVEUR.liv_notran) as cc_SecteurTransporteur " + &
    			"FROM t_commande  INNER JOIN t_CommandeDetail " + &
				"ON t_Commande.NoCommande = t_CommandeDetail.NoCommande AND t_Commande.CieNo = t_CommandeDetail.CieNo " + &
    			"LEFT JOIN t_ELEVEUR ON t_Commande.No_Eleveur = t_ELEVEUR.No_Eleveur " + &
   			"WHERE (date(t_commande.datecommande) = :ad_date OR :ad_date is null) AND  " + &
         	"isnull(t_commande.traiter, 0) = 0 and isnull(t_commande.Imprimer, 0) = 0 " + &
				"AND upper(t_CommandeDetail.NoProduit) = '" + upper(data) + "' " 
				
			is_sql_en_cours = ls_sql
			dw_traite_commande.modify("datawindow.table.select=~""+is_sql_en_cours+"~"")
			//ll_rtn = THIS.SetSqlSelect(is_sql_en_cours)
			dw_traite_commande.SetTransObject(SQLCA)
			ll_rowcount = dw_traite_commande.Retrieve(id_date_retrieve)
			
			IF ll_rowcount = 0 THEN
				gnv_app.inv_error.of_message("CIPQ0075", {data})
			ELSE
				dw_traite_commande.post event rowfocuschanged(1)
			END IF
		END IF

		
END CHOOSE
end event

type pb_go from picturebutton within w_traitement_commande
integer x = 4411
integer y = 44
integer width = 101
integer height = 84
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

type gb_1 from groupbox within w_traitement_commande
integer x = 59
integer y = 1284
integer width = 4466
integer height = 896
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 15793151
string text = "Items"
end type

type rr_1 from roundrectangle within w_traitement_commande
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 168
integer width = 4549
integer height = 2168
integer cornerheight = 40
integer cornerwidth = 46
end type

type dw_traite_commande_item from u_dw within w_traitement_commande
integer x = 123
integer y = 1336
integer width = 4366
integer height = 696
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_traite_commande_item"
boolean hscrollbar = true
boolean livescroll = false
boolean ib_insertion_a_la_fin = true
end type

event constructor;call super::constructor;SetRowFocusindicator(Hand!)


THIS.of_setpremierecolonneinsertion("qtecommande")



end event

event itemchanged;call super::itemchanged;string 				ls_desc, ls_null, ls_transferepar, ls_nocommande, ls_sql, ls_trans
long					ll_rowdddw, ll_qtetransfere = 0, ll_qteinit = 0, ll_qtecom = 0, ll_item, ll_ligne_header, ll_ligne, &
						ll_qtecur = 0, ll_null
datawindowchild 	ldwc_verrat, ldwc_noproduit

SetNull(ls_null)
SetNull(ll_null)

CHOOSE CASE dwo.name
	
	CASE "qtetransfert"
		ls_transferepar = THIS.object.tranname[row]
		ll_qtecur = long(data)
		IF not(IsNull(ls_transferepar) OR ls_transferepar = "") AND (not isnull(data)) AND data <> "" THEN
			gnv_app.inv_error.of_message("CIPQ0079" )
			THIS.ib_suppression_message_itemerror = TRUE
			return 1
		ELSE
			ls_trans = THIS.object.trans[row]
			IF IsNull(ls_trans) OR ls_trans = "" AND (not isnull(data)) AND data <> "" THEN
				gnv_app.inv_error.of_message("CIPQ0081" )
				THIS.SetColumn("trans")
				SetNull(data)
				THIS.object.qtetransfert[row] = ll_null
				THIS.ib_suppression_message_itemerror = TRUE
				return 2
			ELSE
				THIS.AcceptText()
				PARENT.of_updateqtecom(row, ll_qtecur)
			END IF
		END IF

	CASE "qteexpedie"
		ll_qtecur = THIS.object.qtecommande[row]
		If long(data) > ll_qtecur Then
			gnv_app.inv_error.of_message("CIPQ0080")
			//RETURN 2
		END IF
		
	CASE "trans"
		ls_transferepar = THIS.object.tranname[row]
		IF not(IsNull(ls_transferepar) OR ls_transferepar = "") THEN
			gnv_app.inv_error.of_message("CIPQ0079" )
			return 2
		ELSE
			//Corriger la qté commandée
			
			ll_qtecur = THIS.object.qtetransfert[row]
			IF (IsNull(data) OR data = "") AND NOT (ll_qtecur = 0 OR IsNull(ll_qtecur)) THEN
				THIS.AcceptText()
				PARENT.of_updateqtecom(row, ll_qtecur)
				THIS.object.qtetransfert[row] = ll_null
				THIS.AcceptText()				
			END IF
		END IF
		
	CASE "codeverrat"
		
		IF IsNull(data) or data = "" THEN 
			THIS.object.description[row] = ""
			RETURN 
		END IF
		
		THIS.GetChild('codeverrat', ldwc_verrat)
//		ldwc_verrat.setTransObject(SQLCA)
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
		SetColumn("noproduit")

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
			gnv_app.inv_error.of_message("CIPQ0055")
			SetNull(data)
			THIS.object.noproduit[row] = ls_null
			THIS.ib_suppression_message_itemerror = TRUE
			RETURN 1
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
	
	ll_row_parent = dw_traite_commande.GetRow()
	
	ll_eleveur = dw_traite_commande.object.no_eleveur[ll_row_parent]
	
	lb_gedis = lnv_eleveur.of_formationgedis(ll_eleveur)	
	IF isnull(lb_gedis) THEN lb_gedis = FALSE

	CHOOSE CASE dwo.name 
		CASE "noproduit"
			
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
date		ld_commande

ll_row = dw_traite_commande.GetRow()
IF ll_row > 0 THEN

	IF rowsinserted = 0 AND rowsupdated = 0 AND rowsdeleted = 0 THEN RETURN ancestorreturnvalue
	
	ll_noeleveur = dw_traite_commande.object.no_eleveur[ll_row]
	ls_nocommande = dw_traite_commande.object.nocommande[ll_row]
	ls_cie = dw_traite_commande.object.cieno[ll_row]
	ld_commande = date(dw_traite_commande.object.datecommande[ll_row])

	ll_row_parent = dw_traite_commande.GetRow()
	ll_noeleveur = dw_traite_commande.object.no_eleveur[ll_row_parent]

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
	END IF
	
END IF

RETURN ancestorreturnvalue
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF


long		ll_rowparent, ll_imprimer, ll_row, ll_count, ll_no
string	ls_nocommande, ls_codeverrat, ls_noproduit

//Vérifier si la commande a été imprimée
ll_rowparent = dw_traite_commande.GetRow()
IF ll_rowparent > 0 AND ib_check = FALSE THEN
	ls_nocommande = dw_traite_commande.object.nocommande[ll_rowparent]
	IF gnv_app.of_verifiersicommandetraitee(ls_nocommande) = TRUE THEN
		gnv_app.inv_error.of_message("CIPQ0058")
		THIS.Undo()
		RETURN FAILURE
	END IF
END IF


ll_row = THIS.GetRow()

IF ll_row > 0 THEN


	ll_no = THIS.object.noligne[ll_row]
	If IsNull(ll_no) THEN
		ll_no = PARENT.of_recupererprochainnumeroitem()
		THIS.object.noligne[ll_row] = ll_no
	END IF

	ls_codeverrat = THIS.object.codeverrat[ll_row]
	ls_noproduit = THIS.object.noproduit[ll_row]
	
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

event pfc_predeleterow;call super::pfc_predeleterow;long		ll_row, ll_compteur, ll_row_parent, ll_quantite, ll_noeleveur
string 	ls_sql, ls_cie, ls_nocommande, ls_transferepar, ls_tranname, ls_ItemCommande, ls_codeverrat, ls_noproduit
date		ld_commande

IF AncestorReturnValue > 0 THEN
	
	ll_row = THIS.GetRow()
	IF ll_row > 0 THEN
		ls_cie = THIS.object.cieno[ll_row]
		ls_nocommande = THIS.object.nocommande[ll_row]
		ll_compteur = THIS.object.compteur[ll_row]
		ll_quantite = THIS.object.qtecommande[ll_row]
		ls_codeverrat = THIS.object.codeverrat[ll_row]
		ls_noproduit = THIS.object.noproduit[ll_row]
				
		ll_row_parent = dw_traite_commande.GetRow()
		ls_transferepar = dw_traite_commande.object.transferepar[ll_row_parent]
		ll_noeleveur = dw_traite_commande.object.no_eleveur[ll_row_parent]
		ld_commande = date(dw_traite_commande.object.datecommande[ll_row_parent])
		
		//Supprimer les commandes originales 
		If (IsNull(ls_transferepar) Or ls_transferepar = "") AND not IsNull(ll_compteur) Then
			ls_sql = "DELETE FROM t_CommandeOriginale " + " WHERE t_CommandeOriginale.CieNo = '" + ls_cie + &
				"' AND t_CommandeOriginale.NoCommande='" + ls_nocommande + &
				"' AND t_CommandeOriginale.NoLigne= " + string(ll_compteur)
			gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeOriginale", "Destruction", parent.Title)
		End If
		
		//Imprimer
		If ll_quantite <> 0 AND Not IsNull(ll_quantite) Then
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

event pfc_retrieve;string	ls_cie
long		ll_rtn, ll_newrow

ls_cie = gnv_app.of_getcompagniedefaut( )

//Retrieve de la dddw
dataWindowChild ldwc_trans

ll_rtn = THIS.GetChild('trans', ldwc_trans)
ldwc_trans.setTransObject(SQLCA)
ll_rtn = ldwc_trans.retrieve(ls_cie)

// Pour filtrer la liste de verrats - Sébastien 2010-02-24
datawindowchild ldwc_verrat

if this.getChild("codeverrat", ldwc_verrat) = 1 then
	return this.event pfc_populatedddw("codeverrat", ldwc_verrat)
else
	return -1
end if

//ll_newrow = ldwc_trans.insertrow(1)
//ldwc_trans.setitem( 1, "prefnom", "")

CALL SUPER::pfc_retrieve
RETURN ANCESTORReTURNVALUE 

end event

event buttonclicked;call super::buttonclicked;//Bouton voir commande
string	ls_produit
long		ll_temp

IF row > 0 THEN
	
	ls_produit = THIS.object.noproduit[row]
	IF ls_produit <> "" AND Not IsNull(ls_produit) THEN
		w_traite_commande_recolte lw_wind
		
		// Si famille de produit est temporaire
		Select 	CodeTemporaire INTO :ll_temp
		FROM		t_produit
		WHERE		upper(noproduit) = upper(:ls_produit) USING SQLCA;
		
		If ll_temp = 0 Then Return
		
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("produit recolte traite", ls_produit)
		
		Open(lw_wind)
		
	END IF
END IF
end event

event pfc_update;call super::pfc_update;parent.of_majreste()

RETURN AncestorReturnValue
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

event pfc_populatedddw;call super::pfc_populatedddw;if as_colname = 'codeverrat' then
	if dw_traite_commande.getRow() > 0 then
		adwc_obj.setTransObject(SQLCA)
		adwc_obj.setSQLSelect(gnv_app.of_sqllisteverrats(dw_traite_commande.object.no_eleveur[dw_traite_commande.getRow()]))
		return adwc_obj.retrieve()
	else
		adwc_obj.reset()
		return 0
	end if
end if
end event

type gb_3 from groupbox within w_traitement_commande
integer x = 2688
integer y = 1076
integer width = 1737
integer height = 180
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Filtre"
end type

type dw_traite_commande from u_dw within w_traitement_commande
integer x = 59
integer y = 184
integer width = 4466
integer height = 1100
integer taborder = 10
string dataobject = "d_traite_commande"
end type

event constructor;call super::constructor;THIS.of_setfind( true)

parent.of_majreste()


end event

event rowfocuschanged;call super::rowfocuschanged;string	ls_cie, ls_commande
long		ll_noeleveur, ll_traiter, ll_rtn, ll_nbligne, ll_reste, ll_newrow
n_ds		lds_this

IF CurrentRow > 0 THEN
	
	IF THIS.RowCount() > 0 THEN
		ls_cie = THIS.object.cieno[currentrow]
		ls_commande = THIS.object.nocommande[currentrow]
	
		THIS.object.cc_trans[currentrow] = is_filtre_trans
		THIS.object.cc_semence[currentrow] = is_filtre_semence
		
		//Charger les informations de ce client
		ll_noeleveur = THIS.object.no_eleveur[currentrow]
		IF Not IsNull(ll_noeleveur) AND ll_noeleveur <> 0 THEN
			parent.of_changerclient(ll_noeleveur, currentrow)
		END IF
		
		ls_cie = gnv_app.of_getcompagniedefaut( )
		
		//Retrieve de la dddw
		dataWindowChild ldwc_trans
		
		ll_rtn = dw_traite_commande_item.GetChild('trans', ldwc_trans)
		ldwc_trans.setTransObject(SQLCA)
		ll_rtn = ldwc_trans.retrieve(ls_cie)
		ll_newrow = ldwc_trans.insertrow(1)
		ldwc_trans.setitem( 1, "prefnom", "")
		
		ll_nbligne = dw_traite_commande_item.Retrieve(ls_cie, ls_commande)
		
		//Faire le updatechoix
		IF ll_nbligne > 0 THEN
			lds_this = CREATE n_ds
			lds_this.dataobject = "d_traite_commande_item"
			lds_this.of_setTransobject(SQLCA)
			
			gnv_app.of_updatechoix(lds_this)
			
			IF IsValid(lds_this) THEN destroy(lds_this)
			
		END IF
		
		dw_traite_commande.Setitemstatus( currentrow, 0, Primary!, NotModified!)
		
		//Vérifier le statut de la commande
		ll_traiter = THIS.object.traiter[currentrow]
		IF ll_traiter = 1 THEN
			cb_traiter.text = "Traitée"
		ELSE
			cb_traiter.text = "Non-traitée"
		END IF
		
		parent.of_calculnbenregistrements()
	
		ll_reste = THIS.object.reste[currentrow]
		sle_reste.text = string(ll_reste)
		
		parent.of_setedition(FALSE)
		
		gb_1.Text = "Items pour la commande - " + String(ls_commande)
	END IF
END IF
end event

event pfc_predeleterow;call super::pfc_predeleterow;boolean	lb_askedbyclient = FALSE
string	ls_cie, ls_nocommande, ls_transfererpar, ls_sql
long		ll_row, ll_cpt, ll_compteur, ll_rtn, ll_no_client

IF AncestorReturnValue > 0 THEN
	
	ll_row = THIS.GetRow()
	ll_no_client = THIS.object.no_eleveur[ll_row]
	
	IF NOT IsNull(ll_no_client) THEN
		IF dw_traite_commande_item.rowcount() > 0 THEN
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
		ll_rtn = dw_traite_commande_item.Retrieve(ls_cie, ls_nocommande)
		
		//Supprimer les commandes originales non transférée, si pas d'un transfert, et si commande cancellé par le client
		FOR ll_cpt = 1 TO ll_rtn
			ll_compteur = dw_traite_commande_item.object.compteur[ll_cpt]
			
			//Delete de la commande originale
			ls_sql = "DELETE FROM t_CommandeOriginale WHERE t_CommandeOriginale.CieNo='" + ls_cie + &
				"' AND t_CommandeOriginale.NoCommande='" + ls_nocommande + &
				"' AND t_CommandeOriginale.NoLigne=" + string(ll_compteur)
			
			gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeOriginale", "Suppression", parent.Title)
			
		END FOR
	
	END IF
	
	
END IF


RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;//N'exécutera pas le script du descendant 
IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF


long	ll_row, ll_imprimer

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	ll_imprimer = THIS.object.imprimer[ll_row]
	
	IF ll_imprimer = 1 THEN
		gnv_app.inv_error.of_message("CIPQ0077")
		RETURN FAILURE
	END IF
	
	parent.of_majreste()
END IF


RETURN ancestorreturnvalue
end event

event pro_postconstructor;call super::pro_postconstructor;PARENT.of_setedition(FALSE)
end event

event pro_postscrollvertical;call super::pro_postscrollvertical;If this.RowCount() <= 0 Then Return

Long ll_ligne

ll_ligne = Long( This.Describe( "datawindow.firstrowonpage" ) )

This.SetRow(ll_ligne)

end event

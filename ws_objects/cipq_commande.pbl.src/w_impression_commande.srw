$PBExportHeader$w_impression_commande.srw
forward
global type w_impression_commande from w_sheet
end type
type dw_commande_invalide from u_dw within w_impression_commande
end type
type dw_bon_sans_detail from u_dw within w_impression_commande
end type
type dw_commande_sans_detail from u_dw within w_impression_commande
end type
type dw_impression_commande from u_dw within w_impression_commande
end type
type uo_toolbar from u_cst_toolbarstrip within w_impression_commande
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_impression_commande
end type
type st_1 from statictext within w_impression_commande
end type
type p_ra from picture within w_impression_commande
end type
type gb_1 from u_gb within w_impression_commande
end type
type gb_2 from u_gb within w_impression_commande
end type
type gb_3 from u_gb within w_impression_commande
end type
type rr_2 from roundrectangle within w_impression_commande
end type
type rr_1 from roundrectangle within w_impression_commande
end type
end forward

global type w_impression_commande from w_sheet
string tag = "menu=m_impression"
integer width = 3845
integer height = 1840
string title = "Impression du bon de livraison"
dw_commande_invalide dw_commande_invalide
dw_bon_sans_detail dw_bon_sans_detail
dw_commande_sans_detail dw_commande_sans_detail
dw_impression_commande dw_impression_commande
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
rr_2 rr_2
rr_1 rr_1
end type
global w_impression_commande w_impression_commande

forward prototypes
public subroutine of_posterbonlivraison ()
public subroutine of_recount ()
public subroutine of_genererbonlivraison ()
public subroutine of_imprimerbonlivraison ()
public function long of_reservenextlivno (string as_cie)
public subroutine of_purgecommafterprintliv (string as_strlivno)
end prototypes

public subroutine of_posterbonlivraison ();//of_posterbonlivraison

string	ls_cie, ls_sql

ls_cie = string(dw_impression_commande.object.no_centre[1])

//Commande originale
//qryCommandeOriginaleMAJ
UPDATE t_Commande 
INNER JOIN (t_CommandeOriginale 
INNER JOIN t_CommandeDetail ON 
(t_CommandeDetail.Compteur = t_CommandeOriginale.NoLigne) AND (t_CommandeOriginale.NoCommande = t_CommandeDetail.NoCommande) AND (t_CommandeOriginale.CieNo = t_CommandeDetail.CieNo)) 
ON (t_Commande.NoCommande = t_CommandeDetail.NoCommande) AND (t_Commande.CieNo = t_CommandeDetail.CieNo) 
SET t_CommandeOriginale.DateCommande = t_Commande.DateCommande, 
t_CommandeOriginale.NoBonExpe = t_Commande.NoBonExpe, 
t_CommandeOriginale.NoProduit = upper(t_CommandeDetail.NoProduit), 
t_CommandeOriginale.CodeVerrat = upper(t_CommandeDetail.CodeVerrat), 
t_CommandeOriginale.Description = t_CommandeDetail.Description, 
t_CommandeOriginale.QteInit = t_CommandeDetail.QteInit ;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"qryCommandeOriginaleMAJ", SQLCA.SQLeRRText})
END IF
COMMIT USING SQLCA;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"qryCommandeOriginaleMAJ", SQLCA.SQLeRRText})
END IF

//qryCommandeOriginaleAjout
INSERT INTO t_commandeoriginale (CieNo, NoCommande, NoLigne, DateCommande, NoBonExpe, No_eleveur, NoProduit, CodeVerrat, Description, QteInit)
SELECT	t_commande.cieno, t_commande.nocommande, t_commandedetail.compteur, t_commande.datecommande, t_commande.NoBonExpe, t_commande.no_eleveur, t_commandedetail.noproduit,
	t_commandedetail.codeverrat, t_commandedetail.description, t_commandedetail.qteinit
FROM t_commande LEFT JOIN t_commandedetail ON (t_commande.cieno = t_commandedetail.cieno AND t_commande.nocommande = t_commandedetail.nocommande)
WHERE date(t_commande.DateCommande) <= today() AND QteInit <> 0 AND QteInit is not null AND t_commande.TransferePar is null AND
NOT EXISTS (
	SELECT 	1
	FROM 	t_commandeoriginale
	WHERE	t_commandeoriginale.cieno = t_commandedetail.cieno AND t_commandeoriginale.nocommande = t_commandedetail.nocommande AND t_commandeoriginale.noligne = t_commandedetail.compteur 
	) ;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"qryCommandeOriginaleAjout", SQLCA.SQLeRRText})
END IF
COMMIT USING SQLCA;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"qryCommandeOriginaleAjout", SQLCA.SQLeRRText})
END IF


//Bon Livraison

//CipqQryMAJLivraisonStat
UPDATE t_StatFacture 
INNER JOIN t_commande ON (t_Commande.NoBonExpe = t_StatFacture.LIV_NO) AND (t_Commande.CieNo = t_StatFacture.CIE_NO)
INNER JOIN t_eleveur ON (t_ELEVEUR.No_Eleveur = t_Commande.No_Eleveur) 
SET t_StatFacture.REG_AGR = t_ELEVEUR.REG_AGR, 
t_StatFacture.No_Eleveur = t_Commande.No_Eleveur, 
t_StatFacture.VEND_NO = t_Commande.NoVendeur, 
t_StatFacture.LIV_DATE = t_Commande.DateCommande, 
t_StatFacture.AMPM = t_Commande.LivrAMPM, 
t_StatFacture.Message_Liv = t_Commande.Message_commande, 
t_StatFacture.BonCommandeClient = t_Commande.BonCommandeClient, 
t_StatFacture.CREDIT = 1, 
t_StatFacture.TAXEP = 0, 
t_StatFacture.TAXEF = 0, 
t_StatFacture.Dicom = If t_Commande.CodeTransport='LV' THEN 1 ELSE 0 ENDIF, 
t_StatFacture.IDTransporteur = If (liv_notran is null) THEN Secteur_transporteur ELSE liv_notran ENDIF
WHERE t_StatFacture.CIE_NO = :ls_cie AND t_Commande.NoBonExpe Is Not Null AND t_Commande.Imprimer = 1 ;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"CipqQryMAJLivraisonStat", SQLCA.SQLeRRText})
END IF
COMMIT USING SQLCA;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"CipqQryMAJLivraisonStat", SQLCA.SQLeRRText})
END IF

//CipqQryMAJLivraisonTransportStatDet
INSERT 	INTO t_StatFactureDetail ( CIE_NO, LIV_NO, LIGNE_NO, PROD_NO, QTE_EXP, Description )
SELECT 	t_Commande.CieNo, t_Commande.NoBonExpe, 0 , t_Commande.CodeTransport, 1 , t_Transport.NOM
FROM 	t_ELEVEUR 
INNER JOIN (t_StatFacture 
INNER JOIN (t_Commande 
INNER JOIN t_Transport ON t_Commande.CodeTransport = t_Transport.CodeTransport) ON (t_StatFacture.LIV_NO = t_Commande.NoBonExpe) AND 
(t_StatFacture.CIE_NO = t_Commande.CieNo)) ON t_ELEVEUR.No_Eleveur = t_Commande.No_Eleveur
WHERE t_Commande.CieNo = :ls_cie AND t_Commande.NoBonExpe Is Not Null AND t_Commande.Imprimer = 1 ;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"CipqQryMAJLivraisonTransportStatDet", SQLCA.SQLeRRText})
END IF
COMMIT USING SQLCA;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"CipqQryMAJLivraisonTransportStatDet", SQLCA.SQLeRRText})
END IF

//CipqQryMAJLivraisonStatDetail
INSERT INTO t_StatFactureDetail 
( CIE_NO, LIV_NO, LIGNE_NO, PROD_NO, VERRAT_NO, QteInit, QTE_COMM, QTE_EXP, Description, Melange, NoLigneHeader, Choix, NoItem )
SELECT t_CommandeDetail.CieNo, 
t_Commande.NoBonExpe, 
t_CommandeDetail.NoLigne, 
t_CommandeDetail.NoProduit, 
t_CommandeDetail.CodeVerrat, 
t_CommandeDetail.QteInit, 
isnull(QteCommande , 0) AS QteComm, 
isnull(QteExpedie , 0) AS QteExp, 
t_CommandeDetail.Description, 
t_CommandeDetail.Melange, 
t_CommandeDetail.NoLigneHeader, 
t_CommandeDetail.Choix, 
t_CommandeDetail.NoItem
FROM (t_StatFacture 
INNER JOIN t_Commande ON (t_StatFacture.LIV_NO = t_Commande.NoBonExpe) AND (t_StatFacture.CIE_NO = t_Commande.CieNo)) 
INNER JOIN t_CommandeDetail ON (t_Commande.NoCommande = t_CommandeDetail.NoCommande) AND (t_Commande.CieNo = t_CommandeDetail.CieNo)
WHERE t_CommandeDetail.CieNo = :ls_cie AND t_Commande.NoBonExpe Is Not Null AND t_Commande.Imprimer= 1 ;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"CipqQryMAJLivraisonStatDetail", SQLCA.SQLeRRText})
END IF
COMMIT USING SQLCA;
IF SQLCA.SQLCode < 0 then
	gnv_app.inv_error.of_message("CIPQ0152",{"CipqQryMAJLivraisonStatDetail", SQLCA.SQLeRRText})
END IF


//CipqQryDelLivraisonStatDetail
//Pas besoin à cause du delete cascade

//CipqQryDelLivraisonStat - //Mis en audit le 2008-10-27
//ICI
//En commentaire le 2008-10-29, commandes perdues??? // REMIS foutait le trouble 2008-10-31
ls_sql = "DELETE FROM t_Commande " + &
			"WHERE EXISTS (SELECT 1 FROM T_StatFacture " + &
			"WHERE (T_StatFacture.LIV_NO = t_Commande.NoBonExpe) " + &
			"AND (T_StatFacture.CIE_NO = t_Commande.CieNo) )"

gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_commande", "Destruction", THIS.Title + " of_posterbonlivraison")

//Supprimer les commandes transférées au complet et non facturable
//CipqQryDelCommandeDetailTrans
//Pas besoin à cause du delete cascade

//CipqQryDelCommandeTrans
// Enlevé, p-ê un bug? 2008-10-26
//DELETE FROM t_Commande
//WHERE t_Commande.NoBonExpe Is Null AND t_Commande.Traiter = 1 AND t_Commande.Imprimer = 1 ;
//COMMIT USING SQLCA;
end subroutine

public subroutine of_recount ();//of_recount

SetPointer(HourGlass!)

long		ll_reimp = 0, ll_NextLivNo, ll_null, ll_count
string	ls_cie, ls_livno_fin, ls_livno_debut
date		ld_cur

SetNull(ll_null)

ll_reimp = dw_impression_commande.object.impression[1]
ls_cie = string(dw_impression_commande.object.no_centre[1])
ld_cur = date(dw_impression_commande.object.date_imp[1])

dw_commande_sans_detail.Retrieve(ld_cur)
dw_bon_sans_detail.Retrieve(ld_cur)
dw_commande_invalide.retrieve(ld_cur)

dw_impression_commande.object.bons_a_imprimer[1] = 0
dw_impression_commande.object.no_bon_debut[1] = ll_null
dw_impression_commande.object.no_bon_fin[1] = ll_null

IF ll_reimp = 0 THEN //Première impression
	
	SELECT  	cast(nobonexpe as integer)
	INTO		:ll_NextLivNo
	FROM		t_centreCIPQ
	WHERE		cie = :ls_cie ;
	
	//On exclu les commandes qui ont des produits utilisés comme 'CodeTemporaire', ou que des qtés livrés=0
	SELECT 	count( DISTINCT t_Commande.CieNo + ' ' + t_Commande.NoCommande )
	INTO		:ll_count
	FROM 		t_commande 
	WHERE 	t_Commande.Traiter = 1 AND t_Commande.Imprimer = 0 
				AND (t_Commande.Locked ='P' OR :ld_cur <> date(today())) AND
				date(t_Commande.DateCommande) = :ld_cur AND t_Commande.CieNo = :ls_cie AND
				NOT EXISTS(
				
					SELECT 		1
					FROM 			t_CommandeDetail 
					LEFT JOIN 	t_Produit ON (upper(t_CommandeDetail.NoProduit) = upper(t_Produit.NoProduit)) 
					WHERE	 		t_CommandeDetail.QteCommande <> 0 AND 
									( t_Produit.CodeTemporaire = 1 OR t_CommandeDetail.QteExpedie = 0 OR t_CommandeDetail.QteExpedie is null ) AND
									t_Commande.NoCommande = t_CommandeDetail.NoCommande 
									AND t_Commande.CieNo = t_CommandeDetail.CieNo
					
				) ;
	//OR t_CommandeDetail.qtetransfert = 0 OR t_CommandeDetail.qtetransfert is null			
	//Changé parce que ça chiait - voir aussi ds_generer_bon
//	SELECT 	count( DISTINCT t_Commande.CieNo + ' ' + t_Commande.NoCommande )
//	INTO		:ll_count
//	FROM 		t_commande 
//	WHERE 	t_Commande.Traiter = 1 AND t_Commande.Imprimer = 0 
//				AND (t_Commande.Locked ='P' OR :ld_cur <> date(today())) AND
//				date(t_Commande.DateCommande) = :ld_cur AND t_Commande.CieNo = :ls_cie ;

////données de test (2008-01-07)
//	SELECT 	count( DISTINCT t_Commande.CieNo + ' ' + t_Commande.NoCommande )
//	INTO		:ll_count
//	FROM 		t_commande 
//	WHERE 	
//				t_Commande.DateCommande = :ld_cur AND t_Commande.CieNo = :ls_cie AND
//				NOT EXISTS(
//				
//					SELECT 		1
//					FROM 			t_CommandeDetail 
//					LEFT JOIN 	t_Produit ON (t_CommandeDetail.NoProduit = t_Produit.NoProduit) 
//					WHERE	 		t_CommandeDetail.QteCommande <> 0 AND ( t_Produit.CodeTemporaire = 1 OR t_CommandeDetail.QteExpedie = 0) AND
//									t_Commande.NoCommande = t_CommandeDetail.NoCommande AND t_Commande.CieNo = t_CommandeDetail.CieNo
//					
//				) ;
	
	IF ll_count = 0 THEN
		dw_impression_commande.object.no_bon_debut[1] = ll_null
		dw_impression_commande.object.no_bon_fin[1] = ll_null
	ELSE
		dw_impression_commande.object.no_bon_debut[1] = ll_NextLivNo
		dw_impression_commande.object.no_bon_fin[1] = (ll_NextLivNo + ll_count) - 1
	END IF
	dw_impression_commande.object.bons_a_imprimer[1] = ll_count
	 
ELSE  //Réimpression
	
	SELECT FIRST t_StatFacture.LIV_NO
	INTO			:ls_livno_debut
	FROM 			t_StatFacture 
	WHERE 		t_StatFacture.CIE_NO = :ls_cie AND date(t_StatFacture.LIV_DATE) = :ld_cur 
	ORDER BY 	t_StatFacture.LIV_NO;
	
	SELECT FIRST t_StatFacture.LIV_NO
	INTO			:ls_livno_fin
	FROM 			t_StatFacture 
	WHERE 		t_StatFacture.CIE_NO = :ls_cie AND date(t_StatFacture.LIV_DATE) = :ld_cur 
	ORDER BY 	t_StatFacture.LIV_NO DESC;
	
	SELECT count( t_StatFacture.LIV_NO )
	INTO			:ll_count
	FROM 			t_StatFacture 
	WHERE 		t_StatFacture.CIE_NO = :ls_cie AND date(t_StatFacture.LIV_DATE) = :ld_cur ;	
	
	IF ll_count = 0 THEN
		dw_impression_commande.object.no_bon_debut[1] = ll_null
		dw_impression_commande.object.no_bon_fin[1] = ll_null
	ELSE
		dw_impression_commande.object.no_bon_debut[1] = long(ls_livno_debut)
		dw_impression_commande.object.no_bon_fin[1] = long(ls_livno_fin)
	END IF
	dw_impression_commande.object.bons_a_imprimer[1] = ll_count
	 
END IF
end subroutine

public subroutine of_genererbonlivraison ();//of_genererbonlivraison

string	ls_cie
long		ll_nbrow, ll_cpt, ll_nobonlivraison, ll_nofin
date		ld_cur
n_ds		lds_commande_generer_bon

ls_cie = string(dw_impression_commande.object.no_centre[1])
ld_cur = date(dw_impression_commande.object.date_imp[1])
ll_nofin = dw_impression_commande.object.no_bon_fin[1]

lds_commande_generer_bon = CREATE n_ds
lds_commande_generer_bon.dataobject = "ds_commande_generer_bon"
lds_commande_generer_bon.of_setTransobject(SQLCA)

ll_nbrow = lds_commande_generer_bon.Retrieve(ld_cur, ls_cie)
FOR ll_cpt = 1 TO ll_nbrow
	ll_nobonlivraison = THIS.of_reservenextlivno(ls_cie)
	
	lds_commande_generer_bon.object.nobonexpe[ll_cpt] = string(ll_nobonlivraison)
	lds_commande_generer_bon.object.imprimer[ll_cpt] = 1
	
	lds_commande_generer_bon.update(true,true)
	COMMIT USING SQLCA;
	
	IF ll_nofin = ll_nobonlivraison THEN EXIT
END FOR

IF IsValid(lds_commande_generer_bon) THEN destroy(lds_commande_generer_bon)
end subroutine

public subroutine of_imprimerbonlivraison ();// of_imprimerbonlivraison

string	ls_cie, ls_NoLivToPrint, ls_message, ls_Type_Emballage, ls_printer
date		ld_cur
long		ll_etiquette_suppl, ll_nb_row, ll_cpt, ll_debut, ll_fin, ll_nb_ligne, ll_cpt_emballage, ll_nb_emballage, &
			ll_Qte_Emballage, ll_NbrEtiquette, ll_cpt_nbr_etiquette
n_ds		lds_bon, lds_imprimer, lds_type_emballage, lds_imprimer_etiquette

//Fonction pour lancer l'impression des bons
ls_cie = string(dw_impression_commande.object.no_centre[1])

// Récupérer l'imprimante pour les bons de livraison du INI
ls_printer = gnv_app.of_getValeurIni("IMPRIMANTE", "BonLivraison")
if ls_printer = "Choix" then
	if printsetup() = -1 then return
	ls_printer = PrintGetPrinter ( )
end if

SetPointer(HourGlass!)

ld_cur = date(dw_impression_commande.object.date_imp[1])
ll_etiquette_suppl = dw_impression_commande.object.etiquette_suppl[1]
ll_debut = dw_impression_commande.object.no_bon_debut[1]
ll_fin = dw_impression_commande.object.no_bon_fin[1]
ls_message = dw_impression_commande.object.message[1]

lds_bon = CREATE n_ds
lds_bon.dataobject = "ds_imprimer_liste_bon"
lds_bon.of_setTransobject(SQLCA)

lds_imprimer_etiquette = CREATE n_ds
lds_imprimer_etiquette.dataobject = "d_r_bon_stat_etiquette" + ls_cie
lds_imprimer_etiquette.of_setTransobject(SQLCA)
lds_imprimer_etiquette.object.datawindow.print.printername = ls_printer

lds_imprimer = CREATE n_ds
lds_imprimer.dataobject = "d_r_bon_stat_" + ls_cie
lds_imprimer.of_setTransobject(SQLCA)
lds_imprimer.object.datawindow.print.printername = ls_printer

lds_type_emballage = CREATE n_ds
lds_type_emballage.dataobject = "ds_type_emballage"
lds_type_emballage.of_setTransobject(SQLCA)

ll_nb_emballage = lds_type_emballage.Retrieve()

ll_nb_row = lds_bon.retrieve(ls_cie, ld_cur, ll_debut, ll_fin)
dw_impression_commande.object.t_impression.visible = 1
dw_impression_commande.object.t_chiffre.visible = 1

IF ll_nb_row > 0 THEN
	FOR ll_cpt = 1 TO ll_nb_row
		SetPointer(HourGlass!)
		
		ls_NoLivToPrint = lds_bon.object.t_statfacture_liv_no[ll_cpt]
		dw_impression_commande.object.t_chiffre.text = ls_NoLivToPrint
		
		//Imprimer le bon
		ll_nb_ligne = lds_imprimer.Retrieve(ls_cie, ls_NoLivToPrint)
		IF ll_nb_ligne > 0 THEN
			lds_imprimer.object.cc_message[1] = ls_message
			lds_imprimer.print(false,false)
					
			IF ll_etiquette_suppl = 1 THEN
				//On vérifie le nombre d'impression d'étiquettes supplémentaire pour chaque type d'emballage
				
				FOR ll_cpt_emballage = 1 TO ll_nb_emballage
					
					ls_Type_Emballage = lds_type_emballage.object.type_emballage[ll_cpt_emballage]
					ll_Qte_Emballage = lds_type_emballage.object.Qte_Emballage[ll_cpt_emballage]
					IF IsNull(ll_Qte_Emballage) THEN ll_Qte_Emballage = 0
					
					ll_NbrEtiquette = gnv_app.of_checknbrbilltoprint( ls_cie, long(ls_NoLivToPrint), ls_Type_Emballage, ll_Qte_Emballage, TRUE)
					FOR ll_cpt_nbr_etiquette = 1 TO ll_NbrEtiquette
						lds_imprimer_etiquette.Retrieve(ls_cie, ls_NoLivToPrint)
						lds_imprimer_etiquette.print(false,false)
					END FOR
					
				END FOR
			END IF

			//PurgeCommAfterPrintLiv
			SetPointer(HourGlass!)
			THIS.of_PurgeCommAfterPrintLiv(ls_NoLivToPrint)

		END IF
		
	END FOR
ELSE
	Messagebox("Attention", "Il n'y a aucun bon à imprimer. Vérifier vos numéros de bon, la date et le centre.")
END IF

IF IsValid(lds_imprimer) THEN destroy(lds_imprimer)
IF IsValid(lds_bon) THEN destroy(lds_bon)
IF IsValid(lds_type_emballage) THEN destroy(lds_type_emballage)
IF IsValid(lds_imprimer_etiquette) THEN destroy(lds_imprimer_etiquette)
dw_impression_commande.object.t_impression.visible = 0
dw_impression_commande.object.t_chiffre.visible = 0
end subroutine

public function long of_reservenextlivno (string as_cie);//of_ReserveNextLivNo

long 		ll_retour = -1
string	ls_no

ll_retour = gnv_app.of_getnextlivno(as_cie)

//Si la réservation est réussie
IF ll_retour <> -1 THEN
	ls_no = string(ll_retour)
	
	INSERT INTO T_StatFacture ( CIE_NO, LIV_NO ) VALUES (:as_cie , :ls_no) ;

	IF SQLCA.SQLCode < 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_ReserveNextLivNo", SQLCA.SQLeRRText})
	END IF
	COMMIT USING SQLCA;
	IF SQLCA.SQLCode < 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"of_ReserveNextLivNo", SQLCA.SQLeRRText})
	END IF

	
END IF

RETURN ll_retour
end function

public subroutine of_purgecommafterprintliv (string as_strlivno);// of_purgecommafterprintliv

string 	ls_cie, ls_sql
long		ll_TmpStrLivNo

//Detruit la commande précédente
ll_TmpStrLivNo = long(as_strlivno) - 1

dw_impression_commande.object.t_chiffre.text = string(ll_TmpStrLivNo)

SetPointer(HourGlass!)

//Delete - 2008-10-27 en audit
ls_sql = "DELETE FROM t_Commande " + &
			"WHERE t_Commande.CieNo = '" + ls_cie + "' AND t_Commande.NoBonExpe = '" + as_strlivno + "'"

gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_commande", "Destruction", THIS.Title + " of_purgecommafterprintliv " + as_strlivno)


RETURN
end subroutine

on w_impression_commande.create
int iCurrent
call super::create
this.dw_commande_invalide=create dw_commande_invalide
this.dw_bon_sans_detail=create dw_bon_sans_detail
this.dw_commande_sans_detail=create dw_commande_sans_detail
this.dw_impression_commande=create dw_impression_commande
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.rr_2=create rr_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_commande_invalide
this.Control[iCurrent+2]=this.dw_bon_sans_detail
this.Control[iCurrent+3]=this.dw_commande_sans_detail
this.Control[iCurrent+4]=this.dw_impression_commande
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.uo_toolbar_gauche
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.p_ra
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.rr_2
this.Control[iCurrent+13]=this.rr_1
end on

on w_impression_commande.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_commande_invalide)
destroy(this.dw_bon_sans_detail)
destroy(this.dw_commande_sans_detail)
destroy(this.dw_impression_commande)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_gauche)
destroy(this.st_1)
destroy(this.p_ra)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.rr_2)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

uo_toolbar_gauche.of_settheme("classic")
uo_toolbar_gauche.of_DisplayBorder(true)
uo_toolbar_gauche.of_AddItem("Imprimer...", "Print!")
uo_toolbar_gauche.POST of_displaytext(true)

dw_impression_commande.InsertRow(0)

dw_impression_commande.object.no_centre[1] = long(gnv_app.of_getcompagniedefaut( ))
dw_impression_commande.object.date_imp[1] = date(today())

THIS.POST of_recount()
end event

event pfc_preopen;call super::pfc_preopen;gnv_app.of_PrintLock()
end event

event close;call super::close;gnv_app.of_PrintUnLock()
end event

type dw_commande_invalide from u_dw within w_impression_commande
integer x = 2345
integer y = 876
integer width = 1422
integer height = 268
integer taborder = 21
string dataobject = "d_commande_invalide"
boolean ib_itemchanged_encours = true
end type

type dw_bon_sans_detail from u_dw within w_impression_commande
integer x = 2345
integer y = 1260
integer width = 1422
integer height = 332
integer taborder = 31
string dataobject = "d_bon_sans_detail"
end type

type dw_commande_sans_detail from u_dw within w_impression_commande
integer x = 2345
integer y = 256
integer width = 1422
integer height = 508
integer taborder = 20
string dataobject = "d_commande_sans_detail"
end type

event buttonclicked;call super::buttonclicked;string	ls_cie, ls_nocommande, ls_sql

IF row > 0 THEN
	ls_cie = gnv_app.of_getcompagniedefaut( )
	ls_nocommande = THIS.object.t_commande_nocommande[row]
	
	ls_sql = "DELETE FROM t_commande where nocommande = '" + ls_nocommande + "' AND cieno = '" + ls_cie + "' "
	gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_Commande", "Destruction", parent.Title)
	
	THIS.Retrieve(date(dw_impression_commande.object.date_imp[1]))
END IF
end event

type dw_impression_commande from u_dw within w_impression_commande
integer x = 69
integer y = 256
integer width = 2135
integer height = 1144
integer taborder = 10
string dataobject = "d_impression_commande"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	
	CASE "impression"
		
		IF data = "1" THEN
			//Coché: Réimpression
			THIS.object.impression_t.text = "Réimpression"
			THIS.object.etiquette_suppl[row] = 0
		ELSE
			THIS.object.impression_t.text = "Générer Bons, Poster et Imprimer"
			THIS.object.etiquette_suppl[row] = 1
		END IF
			
END CHOOSE

IF dwo.name <> "no_bon_debut" AND dwo.name <> "message" AND dwo.name <> "no_bon_fin" THEN
	PARENT.POST of_recount()
END IF
end event

event editchanged;call super::editchanged;IF dwo.name <> "no_bon_debut" AND dwo.name <> "message" AND dwo.name <> "no_bon_fin" THEN
	THIS.AcceptText()
END IF
end event

type uo_toolbar from u_cst_toolbarstrip within w_impression_commande
event destroy ( )
integer x = 1737
integer y = 1528
integer width = 507
integer taborder = 20
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;do while yield()
loop


Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_impression_commande
event destroy ( )
integer x = 23
integer y = 1528
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;date		ld_cur
long		ll_deb, ll_fin, ll_reimp

SetPointer(HourGlass!)

dw_impression_commande.AcceptText()
ld_cur = dw_impression_commande.object.date_imp[1]
ll_deb = dw_impression_commande.object.no_bon_debut[1]
ll_fin = dw_impression_commande.object.no_bon_fin[1]
ll_reimp = dw_impression_commande.object.impression[1]

IF IsNull(ld_cur) OR ld_cur = 1900-01-01 THEN
	gnv_app.inv_error.of_message("pfc_requiredmissing",{"Date"})
	dw_impression_commande.SetColumn("date_imp")
	RETURN
END IF

IF IsNull(ll_deb)  THEN
	gnv_app.inv_error.of_message("pfc_requiredmissing",{"Numéro de livraison: début"})
	dw_impression_commande.SetColumn("no_bon_debut")
	RETURN
END IF

IF IsNull(ll_fin)  THEN
	gnv_app.inv_error.of_message("pfc_requiredmissing",{"Numéro de livraison: fin"})
	dw_impression_commande.SetColumn("no_bon_fin")
	RETURN
END IF

IF ll_fin < ll_deb THEN
	gnv_app.inv_error.of_message("CIPQ0102")
	dw_impression_commande.SetColumn("no_bon_fin")
	RETURN
END IF

uo_toolbar.visible = FALSE

IF ll_reimp = 1 THEN
	//Réimpression
	SetPointer(HourGlass!)
	parent.of_ImprimerBonLivraison()
	
ELSE
	IF gnv_app.inv_error.of_message("CIPQ0103") = 1 THEN
		//Générer les no bons livraisons
		SetPointer(HourGlass!)
		parent.of_genererbonlivraison()
		do while yield()
		loop
		
		//Les poster
		SetPointer(HourGlass!)
		parent.of_posterbonlivraison()
		do while yield()
		loop
		
		//Les imprimer
		SetPointer(HourGlass!)
		parent.of_ImprimerBonLivraison()
		do while yield()
		loop
	END IF
END IF

SetPointer(HourGlass!)
Parent.of_recount( )
uo_toolbar.visible = TRUE
end event

type st_1 from statictext within w_impression_commande
integer x = 274
integer y = 60
integer width = 1157
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Impression du bon de livraison"
boolean focusrectangle = false
end type

type p_ra from picture within w_impression_commande
integer x = 55
integer y = 32
integer width = 165
integer height = 140
string picturename = "C:\ii4net\CIPQ\images\imprimer.bmp"
boolean focusrectangle = false
end type

type gb_1 from u_gb within w_impression_commande
string tag = " "
integer x = 2295
integer y = 808
integer width = 1499
integer height = 376
integer taborder = 11
long backcolor = 12639424
string text = "Liste des commandes en erreur"
end type

type gb_2 from u_gb within w_impression_commande
integer x = 2295
integer y = 192
integer width = 1499
integer height = 608
integer taborder = 10
long backcolor = 12639424
string text = "Liste des commandes sans item"
end type

type gb_3 from u_gb within w_impression_commande
string tag = " "
integer x = 2295
integer y = 1196
integer width = 1499
integer height = 436
integer taborder = 21
long backcolor = 12639424
string text = "Liste des bons sans item"
end type

type rr_2 from roundrectangle within w_impression_commande
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 3771
integer height = 172
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_1 from roundrectangle within w_impression_commande
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 212
integer width = 2226
integer height = 1272
integer cornerheight = 40
integer cornerwidth = 46
end type


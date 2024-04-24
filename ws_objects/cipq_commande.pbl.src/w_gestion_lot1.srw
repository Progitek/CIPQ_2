$PBExportHeader$w_gestion_lot1.srw
forward
global type w_gestion_lot1 from w_sheet_frame
end type
type uo_fin from u_cst_toolbarstrip within w_gestion_lot1
end type
type st_1 from statictext within w_gestion_lot1
end type
type em_date from u_em within w_gestion_lot1
end type
type pb_go from picturebutton within w_gestion_lot1
end type
type rb_melange from u_rb within w_gestion_lot1
end type
type rb_pure from u_rb within w_gestion_lot1
end type
type st_2 from statictext within w_gestion_lot1
end type
type em_expiration from u_em within w_gestion_lot1
end type
type st_3 from statictext within w_gestion_lot1
end type
type st_4 from statictext within w_gestion_lot1
end type
type dw_gestion_lot_famille from u_dw within w_gestion_lot1
end type
type dw_gestion_lot_lot from u_dw within w_gestion_lot1
end type
type cb_calcul from commandbutton within w_gestion_lot1
end type
type cb_rec_dispo from commandbutton within w_gestion_lot1
end type
type dw_gestion_lot_lot_detail from u_dw within w_gestion_lot1
end type
type uo_gauche from u_cst_toolbarstrip within w_gestion_lot1
end type
type uo_bas from u_cst_toolbarstrip within w_gestion_lot1
end type
type uo_mid from u_cst_toolbarstrip within w_gestion_lot1
end type
type uo_droite from u_cst_toolbarstrip within w_gestion_lot1
end type
type gb_1 from groupbox within w_gestion_lot1
end type
type gb_3 from groupbox within w_gestion_lot1
end type
type gb_4 from groupbox within w_gestion_lot1
end type
type rr_1 from roundrectangle within w_gestion_lot1
end type
type ddlb_extension from u_ddlb within w_gestion_lot1
end type
type ole_com from olecustomcontrol within w_gestion_lot1
end type
type dw_gestion_lot_produit from u_dw within w_gestion_lot1
end type
type gb_2 from groupbox within w_gestion_lot1
end type
type dw_gestion_lot_produit_verrat from u_dw within w_gestion_lot1
end type
end forward

global type w_gestion_lot1 from w_sheet_frame
string tag = "menu=m_gestiondeslotsdesrecoltes"
uo_fin uo_fin
st_1 st_1
em_date em_date
pb_go pb_go
rb_melange rb_melange
rb_pure rb_pure
st_2 st_2
em_expiration em_expiration
st_3 st_3
st_4 st_4
dw_gestion_lot_famille dw_gestion_lot_famille
dw_gestion_lot_lot dw_gestion_lot_lot
cb_calcul cb_calcul
cb_rec_dispo cb_rec_dispo
dw_gestion_lot_lot_detail dw_gestion_lot_lot_detail
uo_gauche uo_gauche
uo_bas uo_bas
uo_mid uo_mid
uo_droite uo_droite
gb_1 gb_1
gb_3 gb_3
gb_4 gb_4
rr_1 rr_1
ddlb_extension ddlb_extension
ole_com ole_com
dw_gestion_lot_produit dw_gestion_lot_produit
gb_2 gb_2
dw_gestion_lot_produit_verrat dw_gestion_lot_produit_verrat
end type
global w_gestion_lot1 w_gestion_lot1

type variables
datetime	idt_cur
long	il_type = 1
string	is_sql_original, is_sql_en_cours
end variables

forward prototypes
public subroutine of_rafraichir ()
public subroutine of_affichage ()
public function long of_comptecommandeverrat (string as_noverrat)
public function long of_comptedosedisponible (string as_codeverrat, date ad_date)
public function long of_comptedoserecolte (string as_codeverrat)
public function long of_comptecommandeproduit (string as_noproduit)
public function long of_comptecommandeproduitpur (string as_noproduit, string as_noverrat)
public function long of_compteproduitlot (string as_noproduit)
public function long of_compteproduitlotpur (string as_noproduit, string as_noverrat)
public subroutine of_calculpure ()
public subroutine of_calculmelange ()
public subroutine of_spsverrat (long al_row)
public subroutine of_spsproduit (long al_row)
public subroutine of_t_produit (long al_row)
public subroutine of_t_verrat (long al_row)
end prototypes

public subroutine of_rafraichir ();boolean lb_premiererangee

lb_premiererangee = (dw_gestion_lot_famille.getRow() = 1)
dw_gestion_lot_famille.Retrieve(idt_cur, il_type)

// Si on n'a pas changé de rangée, forcer le raffraîchissement
if lb_premiererangee then dw_gestion_lot_famille.event rowfocuschanged(1)

RETURN
end subroutine

public subroutine of_affichage ();
IF il_type = 1 THEN //Mélange

	dw_gestion_lot_produit_verrat.visible = FALSE
	dw_gestion_lot_produit.visible = TRUE
	
	dw_gestion_lot_produit.object.qtedosemelange.visible = true
	dw_gestion_lot_produit.object.qtedosemelange_t.visible = true
	dw_gestion_lot_produit.object.imprime.visible = true
	dw_gestion_lot_produit.object.imprime_t.visible = true
	dw_gestion_lot_produit.object.b_sps.visible = TRUE
	
	cb_calcul.text = "Calcul des produits (mélanges)"
	
	dw_gestion_lot_famille.object.famillemelange.visible = TRUE
	dw_gestion_lot_famille.SetColumn("famillemelange")
	dw_gestion_lot_famille.object.famillepure.visible = FALSE
	
	dw_gestion_lot_lot_detail.object.codeverratmelange.visible = TRUE
	dw_gestion_lot_lot_detail.SetColumn("codeverratmelange")
	dw_gestion_lot_lot_detail.object.codeverratpure.visible = FALSE

	dw_gestion_lot_lot_detail.object.qtedosemelange.visible = TRUE
	dw_gestion_lot_lot_detail.object.qtedosemelange_t.visible = TRUE
	dw_gestion_lot_lot_detail.object.qtedosepure.visible = FALSE
	dw_gestion_lot_lot_detail.object.qtedosepure_t.visible = FALSE
	
	dw_gestion_lot_lot_detail.object.encommande_t.visible = FALSE
	dw_gestion_lot_lot_detail.object.encommande.visible = FALSE
	//dw_gestion_lot_lot_detail.object.distributiontermine_t.visible = TRUE
	//dw_gestion_lot_lot_detail.object.distributiontermine.visible = TRUE

	dw_gestion_lot_lot_detail.object.typeabregemelange.visible = TRUE
	dw_gestion_lot_lot_detail.object.typeabregepure.visible = TRUE


ELSE //Pure
	
	dw_gestion_lot_produit_verrat.visible = TRUE
	dw_gestion_lot_produit.visible = FALSE
	
	dw_gestion_lot_produit.object.qtedosemelange.visible = FALSE
	dw_gestion_lot_produit.object.qtedosemelange_t.visible = FALSE
	dw_gestion_lot_produit.object.imprime.visible = FALSE
	dw_gestion_lot_produit.object.imprime_t.visible = FALSE
	dw_gestion_lot_produit.object.b_sps.visible = FALSE
	
	cb_calcul.text = "Calcul des produits (pures)"
	
	dw_gestion_lot_famille.object.famillemelange.visible = FALSE
	dw_gestion_lot_famille.SetColumn("famillemelange")
	dw_gestion_lot_famille.object.famillepure.visible = TRUE
	
	dw_gestion_lot_lot_detail.object.codeverratmelange.visible = FALSE
	dw_gestion_lot_lot_detail.SetColumn("codeverratmelange")
	dw_gestion_lot_lot_detail.object.codeverratpure.visible = TRUE

	dw_gestion_lot_lot_detail.object.qtedosemelange.visible = FALSE
	dw_gestion_lot_lot_detail.object.qtedosemelange_t.visible = FALSE
	dw_gestion_lot_lot_detail.object.qtedosepure.visible = TRUE
	dw_gestion_lot_lot_detail.object.qtedosepure_t.visible = TRUE
	
	dw_gestion_lot_lot_detail.object.encommande_t.visible = TRUE
	dw_gestion_lot_lot_detail.object.encommande.visible = TRUE
	//dw_gestion_lot_lot_detail.object.distributiontermine_t.visible = FALSE
	//dw_gestion_lot_lot_detail.object.distributiontermine.visible = FALSE

	dw_gestion_lot_lot_detail.object.typeabregemelange.visible = FALSE
	dw_gestion_lot_lot_detail.object.typeabregepure.visible = FALSE
	
END IF

THIS.of_rafraichir()
end subroutine

public function long of_comptecommandeverrat (string as_noverrat);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_comptecommandeverrat
//
//	Accès:  			Public
//
//	Argument:		as_noverrat
//
//	Retourne:  		Le compte
//
// Description:	Fonction pour retourner une somme
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-25	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

date		ld_datecommande
long		ll_sum1, ll_sum2

em_date.getData(ld_datecommande)

SELECT 	Sum(t_CommandeDetail.QteCommande) AS SumCommande 
INTO		:ll_sum1
FROM 		t_Commande 
INNER JOIN t_CommandeDetail ON (t_Commande.NoCommande = t_CommandeDetail.NoCommande) AND (t_Commande.CieNo = t_CommandeDetail.CieNo) 
WHERE 	upper(t_CommandeDetail.CodeVerrat) = upper(:as_noverrat) AND 
			date(t_Commande.DateCommande) = :ld_datecommande ; 

If IsNull(ll_sum1) THEN ll_sum1 = 0

SELECT 	Sum(t_StatFactureDetail.QTE_EXP) AS SumQTE_EXP 
INTO		:ll_sum2
FROM 		t_StatFacture INNER JOIN t_StatFactureDetail ON 
(t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO) 
WHERE 	upper(t_StatFactureDetail.VERRAT_NO) = upper(:as_noverrat) AND Date(t_StatFacture.LIV_DATE) = :ld_datecommande ;

If IsNull(ll_sum2) THEN ll_sum2 = 0

RETURN ll_sum1 + ll_sum2
end function

public function long of_comptedosedisponible (string as_codeverrat, date ad_date);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_comptedosedisponible
//
//	Accès:  			Public
//
//	Argument:		as_codeverrat , ad_date
//
//	Retourne:  		Rien
//
// Description:	Fonction pour compter le nombre de doses disponibles
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-25	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long 	ll_compte, ll_pure, ll_melange
dec	ldec_pure, ldec_melange

SELECT 	sum(qtedosepure)
INTO		:ldec_pure
FROM		T_Recolte_GestionLot_Detail
WHERE		date(daterecolte) = :ad_date AND upper(CodeVerrat) = upper(:as_codeverrat) ;

If IsNull(ldec_pure) THEN ldec_pure = 0

SELECT	sum(qtedosemelange)
INTO		:ldec_melange
FROM		T_Recolte_GestionLot_Detail
WHERE		date(daterecolte) = :ad_date AND upper(CodeVerrat) = upper(:as_codeverrat) ;

If IsNull(ldec_melange) THEN ldec_melange = 0

ll_compte = round(ldec_pure,0) + round(ldec_melange,0)

RETURN ll_compte
end function

public function long of_comptedoserecolte (string as_codeverrat);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_comptedoserecolte
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		le compte
//
// Description:	Fonction pour compter les doses de récolte
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-25	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

date		ld_datecommande
long		ll_compte
dec		ldec_compte

em_date.getData(ld_datecommande)

SELECT 	sum(AMPO_TOTAL)
INTO		:ldec_compte
FROM		t_RECOLTE
WHERE		upper(CodeVerrat) = upper(:as_codeverrat) AND DATE(date_recolte) = :ld_datecommande ;

ll_compte = ROUND(ldec_compte,0)

RETURN ll_compte
end function

public function long of_comptecommandeproduit (string as_noproduit);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_comptecommandeproduit
//
//	Accès:  			Public
//
//	Argument:		as_noproduit
//
//	Retourne:  		Le compte
//
// Description:	Fonction pour retourner une somme
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-27	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

date		ld_datecommande
long		ll_sum1, ll_sum2

em_date.getData(ld_datecommande)

SELECT 	Sum(t_CommandeDetail.QteCommande) AS SumCommande 
INTO		:ll_sum1
FROM 		t_Commande 
INNER JOIN t_CommandeDetail ON (t_Commande.NoCommande = t_CommandeDetail.NoCommande) AND (t_Commande.CieNo = t_CommandeDetail.CieNo) 
WHERE 	upper(t_CommandeDetail.NoProduit) = upper(:as_noproduit) AND 
date(t_Commande.DateCommande) = :ld_datecommande ; 

If IsNull(ll_sum1) THEN ll_sum1 = 0

SELECT 	Sum(t_StatFactureDetail.QTE_EXP) AS SumQTE_EXP 
INTO		:ll_sum2
FROM 		t_StatFacture INNER JOIN t_StatFactureDetail ON 
(t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO) 
WHERE 	upper(t_StatFactureDetail.PROD_NO) = upper(:as_noproduit) AND date(t_StatFacture.LIV_DATE) = :ld_datecommande ;

If IsNull(ll_sum2) THEN ll_sum2 = 0

RETURN ll_sum1 + ll_sum2
end function

public function long of_comptecommandeproduitpur (string as_noproduit, string as_noverrat);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_comptecommandeproduitpur
//
//	Accès:  			Public
//
//	Argument:		as_noproduit, as_noverrat
//
//	Retourne:  		Le compte
//
// Description:	Fonction pour retourner une somme
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-27	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

date		ld_datecommande
long		ll_sum1, ll_sum2

em_date.getData(ld_datecommande)

SELECT 	Sum(t_CommandeDetail.QteCommande) AS SumCommande 
INTO		:ll_sum1
FROM 		t_Commande 
INNER JOIN t_CommandeDetail ON (t_Commande.NoCommande = t_CommandeDetail.NoCommande) AND (t_Commande.CieNo = t_CommandeDetail.CieNo) 
WHERE 	upper(t_CommandeDetail.NoProduit) = upper(:as_noproduit) 
AND 		upper(t_CommandeDetail.CodeVerrat) = upper(:as_noverrat) 
AND 		date(t_Commande.DateCommande) = :ld_datecommande ; 

If IsNull(ll_sum1) THEN ll_sum1 = 0

SELECT 	Sum(t_StatFactureDetail.QTE_EXP) AS SumQTE_EXP 
INTO		:ll_sum2
FROM 		t_StatFacture INNER JOIN t_StatFactureDetail ON 
(t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO) 
WHERE 	upper(t_StatFactureDetail.PROD_NO) = upper(:as_noproduit ) 
AND 		upper(T_StatFactureDetail.Verrat_NO) = upper(:as_noverrat)
AND 		date(t_StatFacture.LIV_DATE) = :ld_datecommande ;

If IsNull(ll_sum2) THEN ll_sum2 = 0

RETURN ll_sum1 + ll_sum2
end function

public function long of_compteproduitlot (string as_noproduit);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_compteproduitlot
//
//	Accès:  			Public
//
//	Argument:		as_noproduit
//
//	Retourne:  		Rien
//
// Description:	Fonction pour compter
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-26	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long		ll_compte
date		ld_cur

SetPointer(Hourglass!)

em_date.getData(ld_cur)

SELECT 	sum(QteDoseMelange)
INTO		:ll_compte
FROM		T_Recolte_GestionLot_Produit
WHERE		date(daterecolte) = :ld_cur AND upper(noproduit) = upper(:as_noproduit) ;

IF IsNull(ll_compte) THEN ll_compte = 0

RETURN ll_compte
end function

public function long of_compteproduitlotpur (string as_noproduit, string as_noverrat);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_compteproduitlot
//
//	Accès:  			Public
//
//	Argument:		as_noproduit, as_noverrat
//
//	Retourne:  		Rien
//
// Description:	Fonction pour compter
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-26	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long		ll_compte
date		ld_cur

em_date.getData(ld_cur)

SELECT 	sum(QteDoseMelange)
INTO		:ll_compte
FROM		T_Recolte_GestionLot_Produit
WHERE		date(daterecolte) = :ld_cur AND upper(noproduit) = upper(:as_noproduit) AND upper(codeverrat) = upper(:as_noverrat) ;

IF IsNull(ll_compte) THEN ll_compte = 0

RETURN ll_compte
end function

public subroutine of_calculpure ();long		ll_cpt, ll_rowcount, ll_encommande, ll_enlot, ll_manque
string	ls_noproduit, ls_noverrat

dw_gestion_lot_produit_verrat.Accepttext()

IF THIS.EVENT pfc_save() >= 0 THEN
	ll_rowcount = dw_gestion_lot_produit_verrat.RowCount()
	
	FOR ll_cpt = 1 TO ll_rowcount
		ls_noproduit = dw_gestion_lot_produit_verrat.object.noproduit[ll_cpt]
		ls_noverrat = dw_gestion_lot_produit_verrat.object.codeverrat[ll_cpt]
		
		IF IsNull(ls_noproduit) THEN
			ll_encommande = 0
			ll_enlot = 0
		ELSE
			IF IsNull(ls_noverrat) THEN
				ll_encommande = 0
				ll_enlot = 0
			ELSE
				ll_encommande = THIS.of_CompteCommandeProduitPur(ls_noproduit, ls_noverrat)
				ll_enlot = THIS.of_CompteProduitLotPur(ls_noproduit, ls_noverrat)
			END IF
		END IF
		
		ll_manque = ll_encommande - ll_enlot
		
		dw_gestion_lot_produit_verrat.object.encommande[ll_cpt] = ll_encommande
		dw_gestion_lot_produit_verrat.object.enlot[ll_cpt] = ll_enlot
		dw_gestion_lot_produit_verrat.object.manque[ll_cpt] = ll_manque
		
	END FOR
	
	THIS.EVENT pfc_save()
	
END IF
end subroutine

public subroutine of_calculmelange ();//of_calculmelange

long		ll_rowcount, ll_cpt, ll_enlot, ll_encommande, ll_manque
string	ls_produit

IF THIS.event pfc_save() >= 0 THEN
	SetPointer(Hourglass!)
	ll_rowcount = dw_gestion_lot_produit.Rowcount()
	FOR ll_cpt = 1 TO ll_rowcount
		ls_produit = dw_gestion_lot_produit.object.noproduit[ll_cpt]
		IF IsNull(ls_produit) THEN
			ll_enlot = 0
		ELSE
			ll_enlot = THIS.of_compteproduitlot(ls_produit)
		END IF
		
		dw_gestion_lot_produit.object.enlot[ll_cpt] = ll_enlot
		
		IF gnv_app.of_getcompagniedefaut( ) <> "114" THEN
			IF IsNull(ls_produit) THEN
				ll_encommande = 0
				ll_manque = 0
			ELSE
				ll_encommande = THIS.of_CompteCommandeProduit(ls_produit)
				ll_manque = ll_encommande - ll_enlot
			END IF
			
			dw_gestion_lot_produit.object.encommande[ll_cpt] = ll_encommande
			dw_gestion_lot_produit.object.manque[ll_cpt] = ll_manque
		END IF
		
	END FOR
	
	THIS.event pfc_save()
	
END IF

end subroutine

public subroutine of_spsverrat (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_spsverrat
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour le piton sps
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-26	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

string	ls_codeverrat, ls_produit, ls_boardid, ls_NewLetter, ls_newid, ls_batchid, &
			ls_LabelFormat, ls_RegNumber, ls_ExtenderUsed, ls_No_Lot, ls_RaisonSocial, &
			ls_codeheb, ls_TempValue, ls_regname, ls_StringToSend, ls_InString, ls_code, &
			ls_code_output, ls_date, ls_month_name
long		ll_Afficher_Desc, ll_NewNo, ll_SPS_NoRecherche, ll_TubeToPackage, &
			ll_TubeCalculated, ll_qtemelange = 0
datetime	ldt_spsdate
date		ld_exp
n_cst_datetime lnv_date

IF THIS.event pfc_save() >= 0 THEN
	IF gnv_app.inv_error.of_message("CIPQ0097") = 1 THEN
		
		SetPointer(HourGlass!)
		
		ls_codeverrat = dw_gestion_lot_produit_verrat.object.codeverrat[al_row]
		
		//Validation pour envoi de pur à la sps-21
		SELECT	VRAIRACE
		INTO		:ls_produit
		FROM		t_verrat
		WHERE 	upper(CodeVerrat) = upper(:ls_codeverrat) ;
		
		//Si verrat d'Hébergement, afficher tatouage si permis
		IF upper(ls_produit) = "LO" THEN
			SELECT	Af_Desc
			INTO		:ll_Afficher_Desc
			FROM		t_verrat
			WHERE 	upper(CodeVerrat) = upper(:ls_codeverrat) ;
			
			IF ll_Afficher_Desc = 1 THEN
				SELECT	tatouage
				INTO		:ls_boardid
				FROM		t_verrat
				WHERE 	upper(CodeVerrat) = upper(:ls_codeverrat) ;
				
			END IF
		ELSE
			SELECT	tatouage
			INTO		:ls_boardid
			FROM		t_verrat
			WHERE 	upper(CodeVerrat) = upper(:ls_codeverrat) ;			
		END IF
		
		IF IsNull(ls_boardid) THEN 
			ls_boardid = "ND"
		END IF
		
		SELECT	SPS_Date
		INTO		:ldt_spsdate
		FROM		t_Parametre ;
		

		IF date(ldt_spsdate) <> date(today()) THEN
			
			SELECT 	CAST (MAX(RIGHT(NoBatchID,2)) AS INTEGER)
			INTO		:ll_newno
			FROM		t_batch ;
			
			IF IsNull(ll_newno) THEN 
				ll_newno = 0
			END IF
			ll_newno++
			
			ls_newletter = "X"
			ls_newID = ls_newletter + string(ll_newno, "00")
			
		ELSE
			
			SELECT 	SPS_NoRecherche, SPS_LettreRecherche
			INTO		:ll_newno, :ls_newletter
			FROM		t_parametre ;
			
			IF IsNull(ll_newno) THEN 
				ll_newno = 0
			END IF
			ll_newno++
			
			IF ll_newno > 99 THEN //On recommence au bas (à 1)
				SELECT 	CAST (MAX(RIGHT(NoBatchID,2)) AS INTEGER)
				INTO		:ll_newno
				FROM		t_batch ;
				
				IF IsNull(ll_newno) THEN 
					ll_newno = 0
				END IF
				ll_newno++
				
				IF ls_newletter = "X" THEN
					ls_newletter = "Y"
				ELSEIF ls_newletter = "Y" THEN
					ls_newletter = "Z"
				ELSE
					ls_newletter = "X"
				END IF
			END IF
			ls_newID = ls_newletter + string(ll_newno, "00")
		END IF
		
		ls_batchid = ls_newID
		
		//MAJ de t_Parametre
		UPDATE 	t_Parametre 
    	SET 		t_Parametre.SPS_Date = today(), 
		 			t_Parametre.SPS_NoRecherche = :ll_newno, 
					t_Parametre.SPS_LettreRecherche = :ls_newletter ;
					
		COMMIT USING SQLCA;
		
		em_expiration.getData(ld_exp)
				
		IF IsNull(ld_exp) OR ld_exp = 1900-01-01 OR string(ld_exp) = "0000-00-00" THEN
			MEssagebox("Attention", "Une date d'expiration est obligatoire.")
			gnv_app.inv_error.of_message("CIPQ0098")
			RETURN
		END IF
		
		ll_qtemelange = dw_gestion_lot_produit_verrat.object.qtedosemelange[al_row]
		
		ll_TubeToPackage = ll_qtemelange
		ll_TubeCalculated = ll_qtemelange
		ls_LabelFormat = "1"
	
		//Autres
		ls_RegNumber = ""
		
		//Extension
		ls_ExtenderUsed = ddlb_extension.text
		If IsNull(ls_ExtenderUsed) THEN ls_ExtenderUsed = ""
		
		ls_no_lot = ls_codeverrat
		
		ls_codeheb = LEFT(ls_codeverrat,1)
		
		//Raison social
		SELECT 	RaisonSocial
		INTO		:ls_TempValue
		FROM		t_CodeHebergeur
		WHERE		CodeHebergeur = :ls_codeheb ;
		
		//Si pas hébergeur, trouver la classe du verrat, la famille de produit, la raison social de cette famille de produit
		If IsNull(ls_TempValue) OR ls_TempValue = "" THEN
			SELECT 	Classe 
			INTO		:ls_TempValue
			FROM		t_verrat
			WHERE 	upper(CodeVerrat) = upper(:ls_codeverrat) ;
			
			IF NOT IsNull(ls_TempValue) and ls_tempvalue <> "" THEN
				SELECT 	Famille 
				INTO		:ls_TempValue
				FROM		t_verrat_classe
				WHERE		classeverrat = :ls_TempValue ;				
				
				IF NOT IsNull(ls_TempValue) and ls_tempvalue <> "" THEN
					SELECT	RaisonSocial
					INTO		:ls_tempvalue
					FROM		t_Produit_Famille
					WHERE		upper(Famille) = upper(:ls_tempvalue) ;
				ELSE
					ls_TempValue = "C.I.P.Q."
				END IF
			ELSE
				ls_TempValue = "C.I.P.Q."
				
			END IF
			
		END IF
		
		ls_regname = ls_TempValue
		ls_regname = LEFT(ls_regname,14)

		ls_month_name = lnv_date.of_shortmonthname( month(ld_exp) )
		ls_date = string(ld_exp, "dd") + ls_month_name + string(ld_exp, "yy")

		//Ligne à envoyer
		ls_StringToSend = ls_boardid + space (16 - len(ls_boardid)) + space(10) + ls_batchid + Space(10 - Len(ls_BatchID)) + &
							space(2) + ls_produit + space(6 - len(ls_produit)) + space(8) + ls_regnumber + &
							space(12 - len(ls_regnumber)) + space(4) + ls_date + &
							Space(8 - Len(ls_date)) + space(4) + string(ll_tubetopackage) + &
							space(3 - len(string(ll_tubetopackage))) + space(1) + string(ll_TubeCalculated) + &
							space(3 - len(string(ll_TubeCalculated))) + space(1) + ls_LabelFormat + &
							space(1 - len(ls_LabelFormat)) + space(1) + ls_regname + space(14 - len(ls_regname)) + &
							space(2) + ls_ExtenderUsed + Space(10 - len(ls_ExtenderUsed)) + space(2) + &
							ls_no_lot + space(15 - len(ls_no_lot)) + "~r~n"
							
		//Ouverture du port
		ole_com.object.Settings = "2400,N,8,1"
		ole_com.object.InputLen = 0
		ole_com.object.CommPort = 1
		ole_com.object.PortOpen = TRUE
		
		//Demande d'info
		ls_code = Char(18)
		ole_com.object.Output = ls_code
		
		ls_code_output = char(20)
		
		Do
			//Check for data.
			If ole_com.object.InBufferCount Then
				ls_InString = ole_com.object.InPut	
			End If
			  
		Loop Until Pos(ls_InString, ls_code_output) > 0 //Attendre la réponse de la SPS-21
		
		ole_com.object.output = ls_StringToSend
		ole_com.object.PortOpen = FALSE
		
		dw_gestion_lot_produit_verrat.object.imprime[al_row] = ls_batchid
		
		THIS.event pfc_save()
		
		gnv_app.inv_error.of_message( "CIPQ0098")
	END IF	

END IF
end subroutine

public subroutine of_spsproduit (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_spsproduit
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour le piton sps
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-26	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

string	ls_codeverrat, ls_produit, ls_boardid, ls_NewLetter, ls_newid, ls_batchid, &
			ls_LabelFormat, ls_RegNumber, ls_ExtenderUsed, ls_No_Lot, ls_RaisonSocial, &
			ls_codeheb, ls_TempValue, ls_regname, ls_StringToSend, ls_InString, &
			ls_produit_ab, ls_code, ls_code_sortie, ls_date, ls_month_name
long		ll_Afficher_Desc, ll_NewNo, ll_SPS_NoRecherche, ll_TubeToPackage, &
			ll_TubeCalculated, ll_qtemelange = 0
datetime	ldt_spsdate
date		ld_exp
n_cst_datetime lnv_date

IF THIS.event pfc_save() >= 0 THEN
	IF gnv_app.inv_error.of_message("CIPQ0097") = 1 THEN
		
		SetPointer(HourGlass!)
		
		ls_produit = dw_gestion_lot_produit.object.noproduit[al_row]
		
		//Validation pour envoi de mélange
		SELECT	boarid
		INTO		:ls_boardid
		FROM		t_produit
		WHERE 	upper(noproduit) = upper(:ls_produit) ;				
		
		IF IsNull(ls_boardid) OR ls_boardid = "" THEN 
			SELECT	nomproduit
			INTO		:ls_boardid
			FROM		t_produit
			WHERE 	upper(noproduit) = upper(:ls_produit) ;	
			
			IF IsNull(ls_boardid) THEN 
				ls_boardid = ""
			ELSE
				ls_boardid = LEFT(ls_boardid,16)
			END IF
		END IF
		
		
		SELECT	SPS_Date
		INTO		:ldt_spsdate
		FROM		t_Parametre ;
		

		IF date(ldt_spsdate) <> date(today()) THEN
			
			SELECT 	CAST (MAX(RIGHT(NoBatchID,2)) AS INTEGER)
			INTO		:ll_newno
			FROM		t_batch ;
			
			IF IsNull(ll_newno) THEN 
				ll_newno = 0
			END IF
			ll_newno++
			
			ls_newletter = "X"
			ls_newID = ls_newletter + string(ll_newno, "00")
			
		ELSE
			
			SELECT 	SPS_NoRecherche, SPS_LettreRecherche
			INTO		:ll_newno, :ls_newletter
			FROM		t_parametre ;
			
			IF IsNull(ll_newno) THEN 
				ll_newno = 0
			END IF
			ll_newno++
			
			IF ll_newno > 99 THEN //On recommence au bas (à 1)
				SELECT 	CAST (MAX(RIGHT(NoBatchID,2)) AS INTEGER)
				INTO		:ll_newno
				FROM		t_batch ;
				
				IF IsNull(ll_newno) THEN 
					ll_newno = 0
				END IF
				ll_newno++
				
				IF ls_newletter = "X" THEN
					ls_newletter = "Y"
				ELSEIF ls_newletter = "Y" THEN
					ls_newletter = "Z"
				ELSE
					ls_newletter = "X"
				END IF
			END IF
			ls_newID = ls_newletter + string(ll_newno, "00")
		END IF
		
		ls_batchid = ls_newID
		
		//MAJ de t_Parametre
		UPDATE 	t_Parametre 
    	SET 		t_Parametre.SPS_Date = today(), 
		 			t_Parametre.SPS_NoRecherche = :ll_newno, 
					t_Parametre.SPS_LettreRecherche = :ls_newletter ;
					
		COMMIT USING SQLCA;
		
		em_expiration.getData(ld_exp)
		
		//No produit abrégé
		SELECT	noproduitshort
		INTO		:ls_produit_ab
		FROM		t_produit
		WHERE		upper(noproduit) = upper(:ls_produit) ;
		
		IF IsNull(ls_produit_ab) THEN
			ls_produit_ab = ls_produit
		END IF
				
		IF IsNull(ld_exp) OR ld_exp = 1900-01-01 OR string(ld_exp) = "0000-00-00" THEN
			MEssagebox("Attention", "Une date d'expiration est obligatoire.")
			gnv_app.inv_error.of_message("CIPQ0098")
			RETURN
		END IF
		
		ll_qtemelange = dw_gestion_lot_produit.object.qtedosemelange[al_row]
		
		ll_TubeToPackage = ll_qtemelange
		ll_TubeCalculated = ll_qtemelange
		ls_LabelFormat = "1"
	
		//Autres
		ls_RegNumber = ""
		
		//Extension
		ls_ExtenderUsed = ddlb_extension.text
		If IsNull(ls_ExtenderUsed) THEN ls_ExtenderUsed = ""
		
		ls_no_lot = dw_gestion_lot_produit.object.nolot[al_row]
		
		ls_codeheb = LEFT(ls_codeverrat,1)
		
		//Raison social
		SELECT 	CodeHebergeur
		INTO		:ls_TempValue
		FROM		t_produit
		WHERE		upper(NoProduit) = upper(:ls_produit) ;
		
		If NOT IsNull(ls_TempValue) AND ls_TempValue <> "" THEN
			SELECT 	RaisonSocial
			INTO		:ls_TempValue
			FROM		t_CodeHebergeur
			WHERE		CodeHebergeur = :ls_TempValue ;			
		END IF
		
		//Si pas hébergeur, trouver la la famille de produit, la raison social de cette famille de produit
		If IsNull(ls_TempValue) OR ls_TempValue = "" THEN
			SELECT 	Famille 
			INTO		:ls_TempValue
			FROM		t_produit
			WHERE		upper(NoProduit) = upper(:ls_produit) ;				
			
			IF NOT IsNull(ls_TempValue) and ls_tempvalue <> "" THEN
				SELECT	RaisonSocial
				INTO		:ls_tempvalue
				FROM		t_Produit_Famille
				WHERE		upper(Famille) = upper(:ls_tempvalue) ;
			END IF
		
		END IF
		
		If IsNull(ls_TempValue) OR ls_TempValue = "" THEN
			ls_TempValue = "C.I.P.Q."
		END IF
	
		ls_regname = ls_TempValue
		ls_regname = LEFT(ls_regname,14)
		
		ls_month_name = lnv_date.of_shortmonthname( month(ld_exp) )
		ls_date = string(ld_exp, "dd") + ls_month_name + string(ld_exp, "yy")
		
		//Ligne à envoyer
		ls_StringToSend = ls_boardid + space (16 - len(ls_boardid)) + space(10) + ls_batchid + Space(10 - Len(ls_BatchID)) + &
							space(2) + ls_produit_ab + space(6 - len(ls_produit_ab)) + space(8) + ls_regnumber + &
							space(12 - len(ls_regnumber)) + space(4) + ls_date + &
							Space(8 - Len(ls_date)) + space(4) + string(ll_tubetopackage) + &
							space(3 - len(string(ll_tubetopackage))) + space(1) + string(ll_TubeCalculated) + &
							space(3 - len(string(ll_TubeCalculated))) + space(1) + ls_LabelFormat + &
							space(1 - len(ls_LabelFormat)) + space(1) + ls_regname + space(14 - len(ls_regname)) + &
							space(2) + ls_ExtenderUsed + Space(10 - len(ls_ExtenderUsed)) + space(2) + &
							ls_no_lot + space(15 - len(ls_no_lot)) + "~r~n"
		
//		RETURN
		
		//Ouverture du port
		ole_com.object.Settings = "2400,N,8,1"
		ole_com.object.InputLen = 0
		ole_com.object.CommPort = 1
		ole_com.object.PortOpen = TRUE
		
		//Demande d'info
		ls_code = Char(18)
		ole_com.object.Output = ls_code
		
		ls_code_sortie = char(20)
		
		Do
			//Check for data.
			If ole_com.object.InBufferCount Then
				ls_InString = ole_com.object.InPut	
			End If
			  
		Loop Until Pos(ls_InString, ls_code_sortie) > 0 //Attendre la réponse de la SPS-21
		
		ole_com.object.output = ls_StringToSend
		ole_com.object.PortOpen = FALSE
		
		dw_gestion_lot_produit.object.imprime[al_row] = ls_batchid
		
		THIS.event pfc_save()
		
		gnv_app.inv_error.of_message( "CIPQ0098")
	END IF	

END IF
end subroutine

public subroutine of_t_produit (long al_row);//of_t_produit

string	ls_nolot, ls_produit, ls_imprime, ls_famille, ls_sql, ls_imprimante
date		ld_DateRecolte
long		ll_qtedistribue, ll_nb_row

ls_nolot = dw_gestion_lot_produit.object.nolot[al_row]
ls_produit = dw_gestion_lot_produit.object.noproduit[al_row]
ls_imprime = dw_gestion_lot_produit.object.imprime[al_row]
IF IsNull(ls_imprime) THEN ls_imprime = ""
ls_famille = dw_gestion_lot_produit.object.famille[al_row]
ld_DateRecolte = date(dw_gestion_lot_produit.object.daterecolte[al_row])
ll_qtedistribue = dw_gestion_lot_produit.object.qtedosemelange[al_row]

//Vider les tables TMP
select count(1) into :ll_nb_row from #TMP_Lab_InfoLot;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #TMP_Lab_InfoLot (no_lot varchar(12) null,~r~n" + &
														 "daterecolte datetime null,~r~n" + &
														 "produit varchar(30) null,~r~n" + &
														 "codeverrat varchar(12) null,~r~n" + &
														 "qtedistribue integer null,~r~n" + &
														 "imprime varchar(10) null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #TMP_Lab_InfoLot;
	commit using sqlca;
end if

select count(1) into :ll_nb_row from #TMP_Lab_InfoLot_Detail;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #TMP_Lab_InfoLot_Detail (no_lot varchar(12) null,~r~n" + &
																  "codeverrat varchar(12) null,~r~n" + &
																  "typeabrege varchar(1) null,~r~n" + &
																  "qtedose integer null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #TMP_Lab_InfoLot_Detail;
	commit using sqlca;
end if

//Insérer data dans #TMP_Lab_InfoLot
INSERT INTO #TMP_Lab_InfoLot ( No_Lot, DateRecolte, Produit, QteDistribue, Imprime )
VALUES (:ls_nolot , :ld_DateRecolte , :ls_produit , :ll_qtedistribue , :ls_imprime ) ;

COMMIT USING SQLCA;

//Insérer détail
INSERT INTO #TMP_Lab_InfoLot_Detail ( No_Lot, CodeVerrat, TypeAbrege, QteDose ) 
SELECT	T_Recolte_GestionLot_Detail.nolot, T_Recolte_GestionLot_Detail.CodeVerrat, 
			t_RecolteCote.typeabrege, T_Recolte_GestionLot_Detail.QteDoseMelange
FROM		T_Recolte_GestionLot_Detail LEFT JOIN t_recolte ON 
			(T_Recolte_GestionLot_Detail.CodeVerrat = t_RECOLTE.CodeVerrat) AND 
			(T_Recolte_GestionLot_Detail.DateRecolte = t_RECOLTE.DATE_recolte) 
LEFT JOIN t_RecolteCote ON t_RECOLTE.MOTILITE_P = t_RecolteCote.Cote
WHERE date(t_Recolte_GestionLot_Detail.DateRecolte) = :ld_daterecolte AND 
		t_Recolte_GestionLot_Detail.Famille = :ls_famille AND t_Recolte_GestionLot_Detail.NoLot = :ls_nolot ;
COMMIT USING SQLCA;

//Ne plus ouvrir la fenêtre de reçu mais plutôt lancer l'impression directe
//w_r_labo_infolot	lw_wind
//OpenSheet(lw_wind, gnv_app.of_GetFrame(), 6, layered!)

n_ds		lds_bon

lds_bon = CREATE n_ds
lds_bon.dataobject = "d_r_labo_infolot"
lds_bon.of_setTransobject(SQLCA)
ll_nb_row = lds_bon.Retrieve()

// Récupérer l'imprimante pour les étiquettes produit et verrat du INI
ls_imprimante = gnv_app.of_getValeurIni("IMPRIMANTE", "Etiquette")

if ls_imprimante = "Choix" then
	if printsetup() = -1 then return
	ls_imprimante = PrintGetPrinter ( )
end if

lds_bon.object.datawindow.print.printername = ls_imprimante

lds_bon.print(false,false)

IF IsValid(lds_bon) THEN Destroy(lds_bon)

RETURN
end subroutine

public subroutine of_t_verrat (long al_row);//of_t_verrat

string	ls_nolot, ls_produit, ls_imprime, ls_famille, ls_codeverrat, ls_sql, ls_imprimante
date		ld_DateRecolte
long		ll_qtedistribue, ll_nb_row

ls_nolot = dw_gestion_lot_produit_verrat.object.nolot[al_row]
ls_produit = dw_gestion_lot_produit_verrat.object.noproduit[al_row]
ls_imprime = dw_gestion_lot_produit_verrat.object.imprime[al_row]
IF IsNull(ls_imprime) THEN ls_imprime = ""
ls_famille = dw_gestion_lot_produit_verrat.object.famille[al_row]
ld_DateRecolte = date(dw_gestion_lot_produit_verrat.object.daterecolte[al_row])
ll_qtedistribue = dw_gestion_lot_produit_verrat.object.qtedosemelange[al_row]
ls_codeverrat = dw_gestion_lot_produit_verrat.object.codeverrat[al_row]

//Vider les tables TMP
select count(1) into :ll_nb_row from #TMP_Lab_InfoLot;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #TMP_Lab_InfoLot (no_lot varchar(12) null,~r~n" + &
														 "daterecolte datetime null,~r~n" + &
														 "produit varchar(30) null,~r~n" + &
														 "codeverrat varchar(12) null,~r~n" + &
														 "qtedistribue integer null,~r~n" + &
														 "imprime varchar(10) null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #TMP_Lab_InfoLot;
	commit using sqlca;
end if

select count(1) into :ll_nb_row from #TMP_Lab_InfoLot_Detail;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #TMP_Lab_InfoLot_Detail (no_lot varchar(12) null,~r~n" + &
																  "codeverrat varchar(12) null,~r~n" + &
																  "typeabrege varchar(1) null,~r~n" + &
																  "qtedose integer null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #TMP_Lab_InfoLot_Detail;
	commit using sqlca;
end if

//Insérer data dans #TMP_Lab_InfoLot
INSERT INTO #TMP_Lab_InfoLot ( No_Lot, DateRecolte, Produit, CodeVerrat, QteDistribue, Imprime )
VALUES (:ls_nolot , :ld_DateRecolte , :ls_produit , :ls_codeverrat, :ll_qtedistribue , :ls_imprime ) ;

//Insérer détail
INSERT INTO #TMP_Lab_InfoLot_Detail ( No_Lot, CodeVerrat, TypeAbrege, QteDose ) 
SELECT	T_Recolte_GestionLot_Detail.nolot, T_Recolte_GestionLot_Detail.CodeVerrat, 
			t_RecolteCote.typeabrege, T_Recolte_GestionLot_Detail.QteDoseMelange
FROM		T_Recolte_GestionLot_Detail LEFT JOIN t_recolte ON 
			(T_Recolte_GestionLot_Detail.CodeVerrat = t_RECOLTE.CodeVerrat) AND 
			(T_Recolte_GestionLot_Detail.DateRecolte = t_RECOLTE.DATE_recolte)
LEFT JOIN t_RecolteCote ON t_RECOLTE.MOTILITE_P = t_RecolteCote.Cote
WHERE date(t_Recolte_GestionLot_Detail.DateRecolte) = :ld_daterecolte AND 
		t_Recolte_GestionLot_Detail.Famille = :ls_famille AND t_Recolte_GestionLot_Detail.NoLot = :ls_nolot ;

COMMIT USING SQLCA;
//Ne plus ouvrir la fenêtre de reçu mais plutôt lancer l'impression directe
//w_r_labo_infolot	lw_wind
//OpenSheet(lw_wind, gnv_app.of_GetFrame(), 6, layered!)

n_ds		lds_bon

lds_bon = CREATE n_ds
lds_bon.dataobject = "d_r_labo_infolot"
lds_bon.of_setTransobject(SQLCA)
ll_nb_row = lds_bon.Retrieve()

// Récupérer l'imprimante pour les étiquettes produit et verrat du INI
ls_imprimante = gnv_app.of_getValeurIni("IMPRIMANTE", "Etiquette")

if ls_imprimante = "Choix" then
	if printsetup() = -1 then return
	ls_imprimante = PrintGetPrinter ( )
end if

lds_bon.object.datawindow.print.printername = ls_imprimante

lds_bon.print(false,false)

IF IsValid(lds_bon) THEN Destroy(lds_bon)

RETURN
end subroutine

on w_gestion_lot1.create
int iCurrent
call super::create
this.uo_fin=create uo_fin
this.st_1=create st_1
this.em_date=create em_date
this.pb_go=create pb_go
this.rb_melange=create rb_melange
this.rb_pure=create rb_pure
this.st_2=create st_2
this.em_expiration=create em_expiration
this.st_3=create st_3
this.st_4=create st_4
this.dw_gestion_lot_famille=create dw_gestion_lot_famille
this.dw_gestion_lot_lot=create dw_gestion_lot_lot
this.cb_calcul=create cb_calcul
this.cb_rec_dispo=create cb_rec_dispo
this.dw_gestion_lot_lot_detail=create dw_gestion_lot_lot_detail
this.uo_gauche=create uo_gauche
this.uo_bas=create uo_bas
this.uo_mid=create uo_mid
this.uo_droite=create uo_droite
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_4=create gb_4
this.rr_1=create rr_1
this.ddlb_extension=create ddlb_extension
this.ole_com=create ole_com
this.dw_gestion_lot_produit=create dw_gestion_lot_produit
this.gb_2=create gb_2
this.dw_gestion_lot_produit_verrat=create dw_gestion_lot_produit_verrat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_fin
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_date
this.Control[iCurrent+4]=this.pb_go
this.Control[iCurrent+5]=this.rb_melange
this.Control[iCurrent+6]=this.rb_pure
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.em_expiration
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.dw_gestion_lot_famille
this.Control[iCurrent+12]=this.dw_gestion_lot_lot
this.Control[iCurrent+13]=this.cb_calcul
this.Control[iCurrent+14]=this.cb_rec_dispo
this.Control[iCurrent+15]=this.dw_gestion_lot_lot_detail
this.Control[iCurrent+16]=this.uo_gauche
this.Control[iCurrent+17]=this.uo_bas
this.Control[iCurrent+18]=this.uo_mid
this.Control[iCurrent+19]=this.uo_droite
this.Control[iCurrent+20]=this.gb_1
this.Control[iCurrent+21]=this.gb_3
this.Control[iCurrent+22]=this.gb_4
this.Control[iCurrent+23]=this.rr_1
this.Control[iCurrent+24]=this.ddlb_extension
this.Control[iCurrent+25]=this.ole_com
this.Control[iCurrent+26]=this.dw_gestion_lot_produit
this.Control[iCurrent+27]=this.gb_2
this.Control[iCurrent+28]=this.dw_gestion_lot_produit_verrat
end on

on w_gestion_lot1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_fin)
destroy(this.st_1)
destroy(this.em_date)
destroy(this.pb_go)
destroy(this.rb_melange)
destroy(this.rb_pure)
destroy(this.st_2)
destroy(this.em_expiration)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_gestion_lot_famille)
destroy(this.dw_gestion_lot_lot)
destroy(this.cb_calcul)
destroy(this.cb_rec_dispo)
destroy(this.dw_gestion_lot_lot_detail)
destroy(this.uo_gauche)
destroy(this.uo_bas)
destroy(this.uo_mid)
destroy(this.uo_droite)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.rr_1)
destroy(this.ddlb_extension)
destroy(this.ole_com)
destroy(this.dw_gestion_lot_produit)
destroy(this.gb_2)
destroy(this.dw_gestion_lot_produit_verrat)
end on

event open;call super::open;idt_cur = datetime(today())
em_date.text = string(idt_cur, "yyyy-mm-dd")

is_sql_original = dw_gestion_lot_famille.getsqlselect()
is_sql_en_cours = is_sql_original

uo_fin.of_settheme("classic")
uo_fin.of_DisplayBorder(true)
uo_fin.of_AddItem("Liste des verrats disponibles", "ExecuteSQL5!")
uo_fin.of_AddItem("Rafraîchir l'écran", "StepOver!")
uo_fin.of_AddItem("Enregistrer", "Save!")
uo_fin.of_AddItem("Fermer", "Exit!")
uo_fin.of_displaytext(true)

uo_gauche.of_settheme("classic")
uo_gauche.of_DisplayBorder(true)
uo_gauche.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_gauche.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_gauche.of_displaytext(true)

uo_mid.of_settheme("classic")
uo_mid.of_DisplayBorder(true)
uo_mid.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_mid.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_mid.of_displaytext(true)

uo_droite.of_settheme("classic")
uo_droite.of_DisplayBorder(true)
uo_droite.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_droite.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_droite.of_displaytext(true)

uo_bas.of_settheme("classic")
uo_bas.of_DisplayBorder(true)
uo_bas.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_bas.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_bas.of_displaytext(true)

//Mettre une date d'expiration par défaut (4 jours)
date	ld_today
ld_today = relativedate(date(today()), 4)
em_expiration.text = string(ld_today, "yyyy-mm-dd")
end event

event pfc_postopen;call super::pfc_postopen;pb_go.Event Clicked()


end event

event pfc_preopen;call super::pfc_preopen;date				ldt_2mois, ldt_1jour
n_cst_datetime lnv_dt

IF gnv_app.of_getcompagniedefaut( ) = "110" THEN
	
	ldt_2mois = lnv_dt.of_relativemonth( today(), -2 )
	
   //On conserve 2 mois de data  et seulement ceux qui ont été produit
   //Suppression des Codes Temporaires pour les jours antérieurs
		
	DELETE FROM T_Recolte_GestionLot_Famille 
   	WHERE date(T_Recolte_GestionLot_Famille.DateRecolte) < :ldt_2mois USING SQLCA;
	COMMIT USING SQLCA;
	
	ldt_1jour = RelativeDate(today(), -1)
	//On supprime les No produits qui n'ont pas été fabriqués il y a 2 jours
	DELETE FROM t_Recolte_GestionLot_Produit 
     	WHERE t_Recolte_GestionLot_Produit.QteDoseMelange = 0 AND t_Recolte_GestionLot_Produit.DateRecolte < :ldt_1jour USING SQLCA;
	COMMIT USING SQLCA;
END IF

THIS.of_affichage()


end event

type st_title from w_sheet_frame`st_title within w_gestion_lot1
integer x = 229
string text = "Gestion des lots de récoltes"
end type

type p_8 from w_sheet_frame`p_8 within w_gestion_lot1
integer x = 41
integer y = 20
integer width = 160
integer height = 132
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\modele.gif"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_gestion_lot1
integer x = 9
integer y = 16
integer width = 4562
integer height = 140
end type

type uo_fin from u_cst_toolbarstrip within w_gestion_lot1
event destroy ( )
string tag = "resize=frbsr"
integer x = 27
integer y = 2228
integer width = 4544
integer taborder = 10
boolean bringtotop = true
end type

on uo_fin.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Fermer", "Close"	
		IF PARENT.event pfc_save() >= 0 THEN
			Close(parent)
		END IF
		
	CASE "Rafraîchir l'écran"
		parent.of_rafraichir()

	CASE "Liste des verrats disponibles"
		date ld_cur
		
		em_date.getData(ld_cur)
		//Ouvrir la liste des verrats non-attribués
		w_gestion_lot_verratnonattribue	lw_wind
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date nd", string(ld_cur, "yyyy-mm-dd"))
		Open(lw_wind)
		
	CASE "Enregistrer"
		PARENT.event pfc_save()

		
END CHOOSE
end event

type st_1 from statictext within w_gestion_lot1
integer x = 82
integer y = 248
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "Date de la récolte:"
boolean focusrectangle = false
end type

type em_date from u_em within w_gestion_lot1
integer x = 608
integer y = 240
integer width = 448
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

event modified;call super::modified;date ld_cur

this.getData(ld_cur)
idt_cur = datetime(ld_cur)
end event

type pb_go from picturebutton within w_gestion_lot1
integer x = 1070
integer y = 240
integer width = 101
integer height = 88
integer taborder = 30
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

event clicked;parent.of_affichage()
end event

type rb_melange from u_rb within w_gestion_lot1
integer x = 1198
integer y = 252
integer width = 338
integer height = 68
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
long backcolor = 15793151
string text = "Mélange"
boolean checked = true
end type

event clicked;call super::clicked;IF PARENT.event pfc_save() >= 0 THEN
	IF THIS.Checked = TRUE THEN
		il_type = 1
	ELSE
		il_type = 2
	END IF
	
	parent.of_affichage()
END IF
end event

type rb_pure from u_rb within w_gestion_lot1
integer x = 1550
integer y = 252
integer width = 238
integer height = 68
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
long backcolor = 15793151
string text = "Pure"
end type

event clicked;call super::clicked;IF PARENT.event pfc_save() >= 0 THEN
	IF THIS.Checked = TRUE THEN
		il_type = 2
	ELSE
		il_type = 1
	END IF
	
	parent.of_affichage()
END IF
end event

type st_2 from statictext within w_gestion_lot1
boolean visible = false
integer x = 3639
integer y = 52
integer width = 878
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "Informations pour la SPS-21"
boolean focusrectangle = false
end type

type em_expiration from u_em within w_gestion_lot1
integer x = 3241
integer y = 240
integer width = 448
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

type st_3 from statictext within w_gestion_lot1
integer x = 2720
integer y = 248
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 15793151
string text = "Date d~'expiration:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_gestion_lot1
integer x = 3803
integer y = 248
integer width = 302
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15793151
string text = "Extension:"
boolean focusrectangle = false
end type

type dw_gestion_lot_famille from u_dw within w_gestion_lot1
integer x = 128
integer y = 416
integer width = 777
integer height = 1548
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_gestion_lot_famille"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)

SetRowFocusIndicator(Hand!)
end event

event itemchanged;call super::itemchanged;
IF row > 0 THEN
	
	CHOOSE CASE dwo.name
			
		CASE "famillemelange"
			
			Datawindowchild	ldwc_famille
			long	ll_rowdddw
			
			THIS.GetChild('famillemelange', ldwc_famille)
			ldwc_famille.setTransObject(SQLCA)
			ll_rowdddw = ldwc_famille.Find("famille = '" + data + "'", 1, ldwc_famille.RowCount())		
			
			//Vérifier s'il fait partie de la liste
			IF ll_rowdddw = 0 THEN		
				gnv_app.inv_error.of_message("PRO0011")
				THIS.ib_suppression_message_itemerror = TRUE
				THIS.SetColumn("famillemelange")
				SetText("")
				RETURN 1
			END IF
			
	END CHOOSE
		
	THIS.object.famille[row] = data
	THIS.AcceptText()
	THIS.Update(TRUE,TRUE)
	
	
END IF
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	THIS.object.type[AncestorReturnValue] = il_type
	THIS.object.daterecolte[AncestorReturnValue] = date(today())
END IF

RETURN AncestorReturnValue
end event

event pfc_predeleterow;call super::pfc_predeleterow;IF AncestorReturnValue = CONTINUE_ACTION THEN
	IF dw_gestion_lot_lot.RowCount() > 0 THEN
		gnv_app.inv_error.of_message("CIPQ0091")
		RETURN PREVENT_ACTION
	END IF
	
END IF

RETURN AncestorReturnValue
end event

event pro_enter;IF THIS.GetColumnName() = "famillemelange" THEN
	IF parent.event pfc_save() >= 0 THEN
		THIS.POST EVENT pfc_insertrow()
	END IF
ELSE
	CALL SUPER::pro_enter
END IF
end event

type dw_gestion_lot_lot from u_dw within w_gestion_lot1
integer x = 1010
integer y = 420
integer width = 827
integer height = 748
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_gestion_lot_lot"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_gestion_lot_famille)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("daterecolte","daterecolte")
this.inv_linkage.of_Register("famille","famille")

SetRowFocusIndicator(Hand!)
end event

event buttonclicked;call super::buttonclicked;string	ls_nolot
datetime	ldt_cur
date		ld_cur
long		ll_row_parent
string	ls_famille

IF row > 0 THEN
	//On vérifie si on a un lot pour la date du jour
	
	SELECT NoLOT
	INTO :ls_nolot
	FROM	t_NoLot
	WHERE date(DateRepartition) = date(today()) ;
	
	
	//si oui, on cherche le premier qui est vide
	If Not IsNull(ls_nolot) AND ls_nolot <> "" Then
		ls_nolot = gnv_app.of_nextnolot( )
	Else
		 //si non, on met 'DateRépartition' à null
		 UPDATE t_NoLot SET DateRepartition = Null USING SQLCA;
		 commit using sqlca;
		 //on cherche le premier qui est vide
		 ls_nolot = gnv_app.of_nextnolot( )
	End If
	
	THIS.object.nolot[row] = ls_nolot
	
	//NoLot_AfterUpdate
	dw_gestion_lot_lot.SetColumn("nolot")
	
	//Ajout automatique
	em_date.getData(ld_cur)
	ldt_cur = datetime(ld_cur)
	ll_row_parent = dw_gestion_lot_famille.GetRow()
	ls_famille = dw_gestion_lot_famille.object.famille[ll_row_parent]
	
	INSERT INTO t_Recolte_GestionLot_Produit ( DateRecolte, Famille, NoLot, NoProduit )
	SELECT :ldt_cur AS DateR, 
	:ls_famille AS Fam, 
	:ls_nolot AS Lot, 
	t_Produit.noproduit
	FROM t_Produit
	WHERE 
	upper(t_Produit.Famille) = upper(:ls_famille) AND t_Produit.actif = 1 AND t_Produit.Special = 1 ;
	
	dw_gestion_lot_produit.retrieve(ldt_cur, ls_famille, ls_nolot)
	
	parent.event pfc_save()
END IF
end event

event pfc_predeleterow;call super::pfc_predeleterow;IF AncestorReturnValue = CONTINUE_ACTION THEN
	IF (dw_gestion_lot_produit.RowCount() > 0 AND dw_gestion_lot_produit.visible = TRUE) OR &
		(dw_gestion_lot_produit_verrat.RowCount() > 0 AND dw_gestion_lot_produit_verrat.visible = TRUE) THEN
		
		gnv_app.inv_error.of_message("CIPQ0092")
		RETURN PREVENT_ACTION
	END IF
	
END IF

RETURN AncestorReturnValue
end event

event itemchanged;call super::itemchanged;datetime	ldt_cur
date		ld_cur
string	ls_famille, ls_ancien_lot
long		ll_row_parent, ll_cpt, ll_qte
boolean	lb_peutpas = FALSE

CHOOSE CASE dwo.name
		
	CASE "nolot"
		
		If Not IsNull(data) THEN
			//ib_en_insertion = TRUE AND
			IF rb_melange.checked = TRUE AND dw_gestion_lot_produit.visible = TRUE THEN
				
				em_date.getData(ld_cur)
				ldt_cur = datetime(ld_cur)
				ll_row_parent = dw_gestion_lot_famille.GetRow()
				ls_famille = dw_gestion_lot_famille.object.famille[ll_row_parent]
				ls_ancien_lot = dw_gestion_lot_lot.object.nolot[row]
				
				IF dw_gestion_lot_produit.RowCount() <> 0 THEN
					DELETE FROM t_Recolte_GestionLot_Produit
					WHERE 
					date(t_Recolte_GestionLot_Produit.DateRecolte) = :ld_cur AND
					upper(t_Recolte_GestionLot_Produit.Famille) = upper(:ls_famille)
					AND t_Recolte_GestionLot_Produit.NoLot = :ls_ancien_lot;
					commit using sqlca;
				END IF
				
				INSERT INTO t_Recolte_GestionLot_Produit ( DateRecolte, Famille, NoLot, NoProduit )
				SELECT :ldt_cur AS DateR, 
				:ls_famille AS Fam, 
				:data AS Lot, 
				t_Produit.noproduit
				FROM t_Produit
				WHERE 
				upper(t_Produit.Famille) = upper(:ls_famille) AND t_Produit.actif = 1 AND t_Produit.Special = 1 ;
				
				commit using sqlca;
				
				dw_gestion_lot_produit.retrieve(ldt_cur, ls_famille, data)
				
				parent.event pfc_save()
			END IF
			
			IF ib_en_insertion = FALSE THEN
				//Vérifier si un des produits a commencé à être distribué
				FOR ll_cpt = 1 TO dw_gestion_lot_produit_verrat.RowCount()
					ll_qte = dw_gestion_lot_produit_verrat.object.qtedistribue_qtedistribue[ll_cpt]
					IF Not IsNull(ll_qte) AND ll_qte > 0 THEN
						lb_peutpas = TRUE
						EXIT
					END IF
					
				END FOR
				
			END IF
			
			IF lb_peutpas = TRUE THEN
				gnv_app.inv_error.of_message("CIPQ0093")
				RETURN 2
			END IF
			
			
		END IF
		
END CHOOSE
end event

type cb_calcul from commandbutton within w_gestion_lot1
integer x = 3328
integer y = 1160
integer width = 1134
integer height = 112
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Calcul des produits (pures)"
end type

event clicked;SetPointer(Hourglass!)
IF THIS.TExT = "Calcul des produits (pures)" THEN
	parent.of_calculpure()
ELSE
	parent.of_calculmelange()
END IF
end event

type cb_rec_dispo from commandbutton within w_gestion_lot1
integer x = 3328
integer y = 1968
integer width = 1134
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Calcul des doses récoltées et disponibles"
end type

event clicked;long		ll_rowcount, ll_cpt, ll_qterecolte, ll_qtedisponible, ll_rowlot
string	ls_codeverrat, ls_nolot, ls_famille
date		ld_date_recolte
dec		ldec_total, ldec_temp

IF PARENT.EVENT pfc_save() >= 0 THEN
	ll_rowcount = dw_gestion_lot_lot_detail.RowCount()

	FOR ll_cpt = 1 TO ll_rowcount
		
		ls_codeverrat = dw_gestion_lot_lot_detail.object.codeverrat[ll_cpt]
		ld_date_recolte = date(dw_gestion_lot_lot_detail.object.daterecolte[ll_cpt])
		ls_nolot = dw_gestion_lot_lot_detail.object.nolot[ll_cpt]
		ls_famille = dw_gestion_lot_lot_detail.object.famille[ll_cpt]
		
		IF IsNull(ls_codeverrat) THEN
			ll_qterecolte = 0
			ll_qtedisponible = 0
			IF dw_gestion_lot_lot_detail.object.encommande.visible = TRUE THEN
				dw_gestion_lot_lot_detail.object.encommande[ll_cpt] = 0
			END IF
		ELSE
			ll_qterecolte = PARENT.of_CompteDoseRecolte(ls_codeverrat)
			ll_qtedisponible = ll_qterecolte - (PARENT.of_CompteDoseDisponible(ls_codeverrat , ld_date_recolte)  )
			IF dw_gestion_lot_lot_detail.object.encommande.visible = "1" THEN
				dw_gestion_lot_lot_detail.object.encommande[ll_cpt] = PARENT.of_comptecommandeverrat( ls_codeverrat)
			END IF
		END IF
		
		dw_gestion_lot_lot_detail.object.qtedoserecolte[ll_cpt] = ll_qterecolte
		dw_gestion_lot_lot_detail.object.qtedosedisponible[ll_cpt] = ll_qtedisponible
		
		//MAj de 'QteDoseTotal'
		IF il_type = 1 THEN
			ldec_temp = dw_gestion_lot_lot_detail.object.qtedosemelange[ll_cpt]
//			SELECT 	QteDoseMelange
//			INTO		:ldec_temp
//			FROM		T_Recolte_GestionLot_Detail
//			WHERE		date(daterecolte) = :ld_date_recolte AND famille = :ls_famille AND nolot = :ls_nolot ;
		ELSE
			ldec_temp = dw_gestion_lot_lot_detail.object.qtedosepure[ll_cpt]
//			SELECT 	QteDosePure
//			INTO		:ldec_temp
//			FROM		T_Recolte_GestionLot_Detail
//			WHERE		date(daterecolte) = :ld_date_recolte AND famille = :ls_famille AND nolot = :ls_nolot ;			
		END IF
		
		ldec_total += ldec_temp
		
	END FOR
	
	ll_rowlot = dw_gestion_lot_lot.GetRow()
	
	IF IsNull(ldec_total) THEN ldec_total = 0
	
	dw_gestion_lot_lot.object.qtedosetotal[ll_rowlot] = round(ldec_total, 0)


	PARENT.EVENT pfc_save()
	
END IF
end event

type dw_gestion_lot_lot_detail from u_dw within w_gestion_lot1
integer x = 1019
integer y = 1376
integer width = 3442
integer height = 592
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_gestion_lot_lot_detail"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_gestion_lot_lot)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("daterecolte","daterecolte")
this.inv_linkage.of_Register("famille","famille")
this.inv_linkage.of_Register("nolot","nolot")

SetRowFocusIndicator(Hand!)

datawindowchild 	ldwc_verrat_melange, ldwc_verrat_pure
long		ll_rtn
date		ld_null
string	ls_null

SetNull(ls_null)
SetNull(ld_null)

ll_rtn = THIS.GetChild('codeverratmelange', ldwc_verrat_melange)
ldwc_verrat_melange.setTransObject(SQLCA)
ll_rtn = ldwc_verrat_melange.retrieve(ld_null, ls_null)

ll_rtn = THIS.GetChild('codeverratpure', ldwc_verrat_pure)
ldwc_verrat_pure.setTransObject(SQLCA)
ll_rtn = ldwc_verrat_pure.retrieve(ld_null, ls_null)
end event

event itemchanged;call super::itemchanged;datawindowchild	ldwc_verrat

long		ll_rowdddw, ll_rowparent, ll_qte, ll_qteold, ll_qtedisponible, ll_indiquer, ll_cpt
string	ls_famillemelange, ls_NoLot_IndiceClasse, ls_nolot, ls_classe, ls_classe_expr, ls_famille, ls_codeverrat, ls_classeind
date		ld_cur

CHOOSE CASE dwo.name
		
	CASE "codeverratpure"
		THIS.object.codeverrat[row] = data
		
		THIS.GetChild('codeverratpure', ldwc_verrat)
		ldwc_verrat.setTransObject(SQLCA)
		ll_rowdddw = ldwc_verrat.Find("upper(codeverrat) = '" + upper(data) + "'", 1, ldwc_verrat.RowCount())
		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			//Mettre à jour les champs
			THIS.object.typeabrege[row] = ldwc_verrat.GetItemString(ll_rowdddw,"typeabrege")
			THIS.object.typeabregepure[row] = ldwc_verrat.GetItemString(ll_rowdddw,"typeabrege")
			THIS.object.concentration[row] = ldwc_verrat.GetItemDecimal(ll_rowdddw,"concentration")
			THIS.object.gedis[row] = ldwc_verrat.GetItemNumber(ll_rowdddw,"gedis")
			THIS.object.exclusif[row] = ldwc_verrat.GetItemNumber(ll_rowdddw,"exclusif")
		ELSE
//			gnv_app.inv_error.of_message("PRO0011")
//			THIS.ib_suppression_message_itemerror = TRUE
//			THIS.SetColumn("codeverratpure")
//			SetText("")
//			RETURN 1
		END IF
		
		
	CASE "codeverratmelange"	
				
		// Vérifier si la famille est une super femelle
		ll_rowparent = dw_gestion_lot_famille.GetRow()
		ls_famillemelange = dw_gestion_lot_famille.object.famillemelange[ll_rowparent]
		ls_famille = dw_gestion_lot_famille.object.famille[ll_rowparent]

		THIS.GetChild('codeverratmelange', ldwc_verrat)
		ldwc_verrat.setTransObject(SQLCA)
		ll_rowdddw = ldwc_verrat.Find("upper(codeverrat) = '" + upper(data) + "'", 1, ldwc_verrat.RowCount())
		
		IF ll_rowdddw > 0 THEN
			//Vérifier s'il fait partie de la liste
			
			//Extraire l'indice de la classe inscrite dans le NoLot (l'avant dernier caractère)
			ls_nolot = THIS.object.nolot[row]
			ls_NoLot_IndiceClasse = MID( ls_nolot, LEN(ls_nolot) - 1, 1)
			
			//Extraire le dernier caractère de la classe du verrat
			ls_classe = ldwc_verrat.GetItemString(ll_rowdddw,"exprclasse")			
			
			IF ls_famillemelange = "SFL" OR ls_famillemelange = "SFY" THEN
		
				IF ls_classe <> "" THEN
					ls_classe_expr = RIGHT(ls_classe, 1)
				ELSE //Pas dans la liste
					//Chercher la classe du verrat
					
					em_date.getData(ld_cur)
					
					SELECT 	t_RECOLTE.Classe
					INTO		:ls_classe_expr
					FROM 		t_RECOLTE INNER JOIN t_Verrat_Classe ON t_RECOLTE.Classe = t_Verrat_Classe.ClasseVerrat
					WHERE 	upper(t_Verrat_Classe.Famille) = upper(:ls_famille) AND 
								date(t_RECOLTE.DATE_recolte) = :ld_cur AND 
								t_RECOLTE.AMPO_TOTAL > 0 AND
								t_recolte.codeverrat = :data
					USING SQLCA;

					ls_classe_expr = RIGHT(ls_classe, 1)
				END IF
				
				//si différent, canceller
				If ls_NoLot_IndiceClasse <> ls_classe_expr Then
					gnv_app.inv_error.of_message("CIPQ0094",{ls_NoLot_IndiceClasse})
					RETURN 2
				END IF
			ELSE
				IF IsNull(ls_classe) THEN ls_classe = ""
				
				FOR ll_cpt = 1 TO THIS.RowCount()
					IF ll_cpt <> THIS.GetRow() THEN  //Pas besoin de valider la ligne en cours
						ls_codeverrat = THIS.object.codeverratmelange[row]
						
						SELECT 	if isnull(indiquer, 0) = 1 then t_recolte.classe else '' endif
						INTO		:ls_classeind
						FROM 		t_RECOLTE INNER JOIN t_Verrat_Classe ON t_RECOLTE.Classe = t_Verrat_Classe.ClasseVerrat
						WHERE 	upper(t_Verrat_Classe.Famille) = upper(:ls_famille) AND 
									date(t_RECOLTE.DATE_recolte) = :ld_cur AND 
									t_RECOLTE.AMPO_TOTAL > 0 AND
									t_recolte.codeverrat = :ls_codeverrat
						USING SQLCA;						
						
						IF ls_classe <> ls_classeind THEN
							IF ls_classeind <> "" THEN
								// Vous devez sélectionner des verrats dont la classe est
								gnv_app.inv_error.of_message("CIPQ0135",{ls_classeind})
							ELSE
								//Vous devez sélectionner des verrats dont la classe n'est pas marquée (indiquée) dans les classes des verrats !
								gnv_app.inv_error.of_message("CIPQ0136")
							END IF
							THIS.SetText("")
							RETURN 2
						END IF
					END IF
					
				END FOR
				
			END IF
			
			THIS.object.codeverrat[row] = data
		
		
			//Mettre à jour les champs
			THIS.object.typeabrege[row] = ldwc_verrat.GetItemString(ll_rowdddw,"typeabrege")
			THIS.object.typeabregepure[row] = ldwc_verrat.GetItemString(ll_rowdddw,"typeabrege")
			THIS.object.concentration[row] = ldwc_verrat.GetItemDecimal(ll_rowdddw,"concentration")
			THIS.object.gedis[row] = ldwc_verrat.GetItemNumber(ll_rowdddw,"gedis")
			THIS.object.exclusif[row] = ldwc_verrat.GetItemNumber(ll_rowdddw,"exclusif")

		ELSE
			//2008-10-20
//			gnv_app.inv_error.of_message("PRO0011")
//			THIS.ib_suppression_message_itemerror = TRUE
//			THIS.SetColumn("codeverratmelange")
//			SetText("")
//			RETURN 1
			THIS.object.codeverrat[row] = data
		END IF	
		
	CASE "distributiontermine"
		parent.event pfc_save()
		
		
	CASE "qtedosemelange"
		ll_qte = long(data)
		IF IsNull(ll_qte) THEN ll_qte = 0
		
		ll_qteold = dw_gestion_lot_lot_detail.object.qtedosemelange[row] //Ancienne valeur
		IF IsNull(ll_qteold) THEN ll_qteold = 0
		
		ll_qte = ll_qte - ll_qteold
		
		ll_qtedisponible = THIS.object.qtedosedisponible[row]
		IF IsNull(ll_qtedisponible) THEN ll_qtedisponible = 0
		
		IF ll_qte > ll_qtedisponible THEN
			gnv_app.inv_error.of_message("CIPQ0096")
			RETURN 2
		END IF
		
		
	CASE "qtedosepure"	
		ll_qte = long(data)
		IF IsNull(ll_qte) THEN ll_qte = 0
		
		ll_qteold = dw_gestion_lot_lot_detail.object.qtedosepure[row]
		IF IsNull(ll_qteold) THEN ll_qteold = 0
		
		ll_qte = ll_qte - ll_qteold
		
		ll_qtedisponible = THIS.object.qtedosedisponible[row]
		IF IsNull(ll_qtedisponible) THEN ll_qtedisponible = 0
		
		IF ll_qte > ll_qtedisponible THEN
			gnv_app.inv_error.of_message("CIPQ0096")
			RETURN 2
		END IF	
		
	CASE "typeabregemelange", "typeabregepure"
		THIS.object.typeabrege[row] = data
		
END CHOOSE
end event

event rowfocuschanged;call super::rowfocuschanged;datawindowchild 	ldwc_verrat_melange, ldwc_verrat_pure
long		ll_rtn, ll_rowparent
date		ld_daterecolte
string	ls_famille

SetNull(ls_famille)
SetNull(ld_daterecolte)

IF CurrentRow > 0 THEN
	
	ll_rowparent = dw_gestion_lot_lot.GetRow()
	IF ll_rowparent > 0 THEN
		ld_daterecolte = date(dw_gestion_lot_lot.object.daterecolte[ll_rowparent])
		ls_famille = dw_gestion_lot_lot.object.famille[ll_rowparent]
		
		ll_rtn = THIS.GetChild('codeverratmelange', ldwc_verrat_melange)
		ldwc_verrat_melange.setTransObject(SQLCA)
		ll_rtn = ldwc_verrat_melange.retrieve(ld_daterecolte, ls_famille)
		
		ll_rtn = THIS.GetChild('codeverratpure', ldwc_verrat_pure)
		ldwc_verrat_pure.setTransObject(SQLCA)
		ll_rtn = ldwc_verrat_pure.retrieve(ld_daterecolte, ls_famille)
	END IF
END IF
end event

event pfc_deleterow;call super::pfc_deleterow;
IF AncestorReturnValue = SUCCESS THEN
	IF gnv_app.inv_error.of_message("CIPQ0095") = 1 THEN
		cb_rec_dispo.post event clicked()
	END IF
	
END IF

RETURN AncestorReturnValue
end event

type uo_gauche from u_cst_toolbarstrip within w_gestion_lot1
event destroy ( )
string tag = "resize=frbsr"
integer x = 119
integer y = 1980
integer width = 754
integer taborder = 20
boolean bringtotop = true
end type

on uo_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter"	
		IF PARENT.event pfc_save() >= 0 THEN
			dw_gestion_lot_famille.SetFocus()		
			dw_gestion_lot_famille.event pfc_insertrow()
		END IF
		
	CASE "Supprimer"
		dw_gestion_lot_famille.event pfc_deleterow()
	
		
END CHOOSE
end event

type uo_bas from u_cst_toolbarstrip within w_gestion_lot1
event destroy ( )
string tag = "resize=frbsr"
integer x = 1001
integer y = 1980
integer width = 2295
integer taborder = 30
boolean bringtotop = true
end type

on uo_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter"	
		IF PARENT.event pfc_save() >= 0 THEN
			dw_gestion_lot_lot_detail.SetFocus()		
			dw_gestion_lot_lot_detail.event pfc_insertrow()
		END IF
		
	CASE "Supprimer"
		dw_gestion_lot_lot_detail.event pfc_deleterow()
	
		
END CHOOSE
end event

type uo_mid from u_cst_toolbarstrip within w_gestion_lot1
event destroy ( )
string tag = "resize=frbsr"
integer x = 1010
integer y = 1168
integer width = 818
integer taborder = 30
boolean bringtotop = true
end type

on uo_mid.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long 		ll_rowcount, ll_row
string	ls_nolot
CHOOSE CASE as_button

	CASE "Ajouter"	
		IF PARENT.event pfc_save() >= 0 THEN
			dw_gestion_lot_lot.SetFocus()		
			dw_gestion_lot_lot.event pfc_insertrow()
			dw_gestion_lot_lot.SetFocus()	
			dw_gestion_lot_lot.SetColumn("nolot")
		END IF
		
	CASE "Supprimer"
		ll_row = dw_gestion_lot_lot.GetRow()
		
		IF ll_row > 0 THEN
			ls_nolot = dw_gestion_lot_lot.object.nolot[ll_row]
			
			IF Not IsNull(ls_nolot) AND ls_nolot <> "" THEN
				IF PARENT.event pfc_save() < 0 THEN
					RETURN
				END IF
			END IF
	
			IF dw_gestion_lot_lot_detail.RowCount() > 0 OR &
				(dw_gestion_lot_produit_verrat.RowCount() > 0 AND dw_gestion_lot_produit_verrat.visible = TRUE) OR &
				(dw_gestion_lot_produit.RowCount() > 0 AND dw_gestion_lot_produit.visible = TRUE) THEN
				
				gnv_app.inv_error.of_message("CIPQ0119")
			ELSE
				dw_gestion_lot_lot.event pfc_deleterow()
			END IF
		END IF
		
END CHOOSE
end event

type uo_droite from u_cst_toolbarstrip within w_gestion_lot1
event destroy ( )
string tag = "resize=frbsr"
integer x = 1966
integer y = 1168
integer width = 1330
integer taborder = 40
boolean bringtotop = true
end type

on uo_droite.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;

CHOOSE CASE as_button

	CASE "Ajouter"	
		IF cb_calcul.text = "Calcul des produits (pures)" THEN
			IF PARENT.event pfc_save() >= 0 THEN
				dw_gestion_lot_produit_verrat.SetFocus()		
				dw_gestion_lot_produit_verrat.event pfc_insertrow()
			END IF			
		ELSE
			IF PARENT.event pfc_save() >= 0 THEN
				dw_gestion_lot_produit.SetFocus()		
				dw_gestion_lot_produit.event pfc_insertrow()
			END IF				
		END IF 
		
	CASE "Supprimer"
		IF cb_calcul.text = "Calcul des produits (pures)" THEN
			dw_gestion_lot_produit_verrat.SetFocus()
			dw_gestion_lot_produit_verrat.event pfc_deleterow()
		ELSE
			dw_gestion_lot_produit.SetFocus()
			dw_gestion_lot_produit.event pfc_deleterow()
		END IF 
	
		
END CHOOSE
end event

type gb_1 from groupbox within w_gestion_lot1
integer x = 82
integer y = 348
integer width = 837
integer height = 1772
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Famille"
end type

type gb_3 from groupbox within w_gestion_lot1
integer x = 969
integer y = 348
integer width = 905
integer height = 952
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Lot"
end type

type gb_4 from groupbox within w_gestion_lot1
integer x = 969
integer y = 1316
integer width = 3534
integer height = 804
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Détail"
end type

type rr_1 from roundrectangle within w_gestion_lot1
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 9
integer y = 188
integer width = 4562
integer height = 1988
integer cornerheight = 100
integer cornerwidth = 100
end type

type ddlb_extension from u_ddlb within w_gestion_lot1
integer x = 4101
integer y = 240
integer width = 398
integer height = 204
integer taborder = 11
boolean bringtotop = true
boolean vscrollbar = false
string item[] = {"Allongé",""}
end type

type ole_com from olecustomcontrol within w_gestion_lot1
event oncomm ( )
boolean visible = false
integer x = 2409
integer y = 208
integer width = 174
integer height = 152
integer taborder = 50
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_gestion_lot1.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type dw_gestion_lot_produit from u_dw within w_gestion_lot1
integer x = 1975
integer y = 408
integer width = 2510
integer height = 740
integer taborder = 21
string dataobject = "d_gestion_lot_produit"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_gestion_lot_lot)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("daterecolte","daterecolte")
this.inv_linkage.of_Register("famille","famille")
this.inv_linkage.of_Register("nolot","nolot")

SetRowFocusIndicator(Hand!)

THIS.of_setpremierecolonneinsertion( "noproduit")

datawindowchild 	ldwc_produit
long		ll_rtn
string	ls_null

SetNull(ls_null)

ll_rtn = THIS.GetChild('noproduit', ldwc_produit)
ldwc_produit.setTransObject(SQLCA)
ll_rtn = ldwc_produit.retrieve(ls_null)
end event

event buttonclicked;call super::buttonclicked;
CHOOSE CASE dwo.name 
		
	CASE "b_sps"
		IF PARENT.event pfc_save() >= 0 THEN
			parent.of_spsproduit(row)
		END IF
			
	CASE "b_t"
		IF PARENT.event pfc_save() >= 0 THEN
			parent.of_t_produit(row)
		END IF
		
END CHOOSE
end event

event rowfocuschanged;call super::rowfocuschanged;datawindowchild 	ldwc_produit
long		ll_rtn, ll_rowparent
string	ls_famille

SetNull(ls_famille)

IF CurrentRow > 0 THEN
	
	ll_rowparent = dw_gestion_lot_lot.GetRow()
	IF ll_rowparent > 0 THEN
		ls_famille = dw_gestion_lot_lot.object.famille[ll_rowparent]
		
		ll_rtn = THIS.GetChild('noproduit', ldwc_produit)
		ldwc_produit.setTransObject(SQLCA)
		ll_rtn = ldwc_produit.retrieve(ls_famille)
		
	END IF
END IF
end event

event pfc_predeleterow;call super::pfc_predeleterow;IF AncestorReturnValue = CONTINUE_ACTION THEN
	
	long 	ll_qtedistribue, ll_qtedosemelange, ll_row
	
	ll_row = THIS.GetRow()
	ll_qtedistribue = THIS.object.qtedistribue_qtedistribue[ll_row]
	ll_qtedosemelange = THIS.object.qtedosemelange[ll_row]
	
	IF ll_qtedistribue > 0 THEN
		gnv_app.inv_error.of_message("CIPQ0099")
		RETURN PREVENT_ACTION
	END IF
	
	IF ll_qtedosemelange > 0 THEN
		gnv_app.inv_error.of_message("CIPQ0100")
		RETURN PREVENT_ACTION		
	END IF
	
END IF

RETURN AncestorReturnValue
end event

event itemchanged;call super::itemchanged;long		ll_total = 0, ll_total_orig, ll_row_parent, ll_old, ll_cpt, ll_temp, ll_qtedistribue
date		ld_cur
string	ls_famille, ls_nolot

CHOOSE CASE dwo.name
		
	CASE "noproduit"
		Datawindowchild	ldwc_produit
		long	ll_rowdddw
		
		THIS.GetChild('noproduit', ldwc_produit)
		ldwc_produit.setTransObject(SQLCA)
		ll_rowdddw = ldwc_produit.Find("upper(noproduit) = '" + upper(data) + "'", 1, ldwc_produit.RowCount())		
		
		//2008-4-18
//		//Vérifier s'il fait partie de la liste
//		IF ll_rowdddw = 0 THEN		
//			gnv_app.inv_error.of_message("PRO0011")
//			THIS.ib_suppression_message_itemerror = TRUE
//			THIS.SetColumn("noproduit")
//			SetText("")
//			RETURN 1
//		END IF
		
		
	CASE "qtedosemelange"
		
		ll_row_parent = dw_gestion_lot_lot.GetRow()
		IF ll_row_parent > 0 THEN
			
			ll_qtedistribue = THIS.object.qtedistribue_qtedistribue[row]
			IF ll_qtedistribue > 0 THEN
				IF gnv_app.of_getcompagniedefaut( ) = "112" THEN
					Messagebox("Attention","Les quantités ont commencé à être distribuées.")
				END IF
			END IF

			//Vérifier si le total des qté dépasse le grand total
			ll_total_orig = dw_gestion_lot_lot.object.qtedosetotal[ll_row_parent]
			IF IsNull(ll_total_orig) THEN ll_total_orig = 0
			
			THIS.AcceptText()
			
			FOR ll_cpt = 1 TO THIS.RowCount()
				ll_temp = THIS.object.qtedosemelange[ll_cpt]
				If IsNull(ll_temp) THEN ll_temp = 0
				ll_total += ll_temp
			END FOR
			
			IF IsNull(ll_total) THEN ll_total = 0
			
			IF ll_total > ll_total_orig THEN
				gnv_app.inv_error.of_message("CIPQ0101")
				ll_old = THIS.object.qtedosemelange[row]
				THIS.ib_suppression_message_itemerror = TRUE
				data = string(ll_old)
				THIS.object.qtedosemelange[row] = 0
				RETURN 1
			END IF
			
		END IF
END CHOOSE
end event

type gb_2 from groupbox within w_gestion_lot1
integer x = 1929
integer y = 348
integer width = 2574
integer height = 952
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Produit / Verrat"
end type

type dw_gestion_lot_produit_verrat from u_dw within w_gestion_lot1
integer x = 1975
integer y = 408
integer width = 2510
integer height = 740
integer taborder = 11
string dataobject = "d_gestion_lot_produit_verrat"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_gestion_lot_lot)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("daterecolte","daterecolte")
this.inv_linkage.of_Register("famille","famille")
this.inv_linkage.of_Register("nolot","nolot")

SetRowFocusIndicator(Hand!)

THIS.of_setpremierecolonneinsertion( "noproduit")

datawindowchild 	ldwc_produit, ldwc_verrat
long		ll_rtn
date		ld_null
string	ls_null

SetNull(ls_null)
SetNull(ld_null)

ll_rtn = THIS.GetChild('noproduit', ldwc_produit)
ldwc_produit.setTransObject(SQLCA)
ll_rtn = ldwc_produit.retrieve(ls_null, ls_null)

ll_rtn = THIS.GetChild('codeverrat', ldwc_verrat)
ldwc_verrat.setTransObject(SQLCA)
ll_rtn = ldwc_verrat.retrieve(ld_null, ls_null, ls_null)
end event

event buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name 
		
	CASE "b_sps"
		IF PARENT.event pfc_save() >= 0 THEN
			parent.of_spsverrat(row)
		END IF
		
			
	CASE "b_t"
		IF PARENT.event pfc_save() >= 0 THEN
			parent.of_t_verrat(row)
		END IF
		
END CHOOSE
end event

event rowfocuschanged;call super::rowfocuschanged;datawindowchild 	ldwc_produit, ldwc_verrat
long		ll_rtn, ll_rowparent
date		ld_daterecolte
string	ls_famille, ls_nolot, ls_null

SetNull(ls_famille)
SetNull(ld_daterecolte)
SetNull(ls_null)

IF CurrentRow > 0 THEN
	
	ll_rowparent = dw_gestion_lot_lot.GetRow()
	IF ll_rowparent > 0 THEN
		ld_daterecolte = date(dw_gestion_lot_lot.object.daterecolte[ll_rowparent])
		ls_famille = dw_gestion_lot_lot.object.famille[ll_rowparent]
		ls_nolot = dw_gestion_lot_lot.object.nolot[ll_rowparent]
		
		//ll_rtn = THIS.GetChild('noproduit', ldwc_produit)
		//ldwc_produit.setTransObject(SQLCA)
		//ll_rtn = ldwc_produit.retrieve(ls_famille, ls_null)
		
		ll_rtn = THIS.GetChild('codeverrat', ldwc_verrat)
		ldwc_verrat.setTransObject(SQLCA)
		ll_rtn = ldwc_verrat.retrieve(ld_daterecolte, ls_famille, ls_nolot)
	END IF
END IF
end event

event itemchanged;call super::itemchanged;date		ld_cur
long		ll_rowdddw, ll_rtn, ll_row_parent, ll_total = 0, ll_total_orig, ll_old, ll_temp, ll_cpt, ll_qtedistribue
string	ls_select_str, ls_rtn, ls_famille, ls_nolot
Datawindowchild	ldwc_verrat, ldwc_produit

CHOOSE CASE dwo.name
	
	CASE "codeverrat"
		
		THIS.GetChild('codeverrat', ldwc_verrat)
		ldwc_verrat.setTransObject(SQLCA)
		ll_rowdddw = ldwc_verrat.Find("upper(codeverrat) = '" + upper(data) + "'", 1, ldwc_verrat.RowCount())		
		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw = 0 THEN		
			gnv_app.inv_error.of_message("PRO0011")
			THIS.ib_suppression_message_itemerror = TRUE
			THIS.SetColumn("codeverrat")
			SetText("")
			RETURN 1
		END IF
		
		//Changer la dddw de produit
		If Not IsNull(data) THEN
			ls_select_str = "SELECT t_Produit.NoProduit FROM t_Produit " + &
				"INNER JOIN t_Verrat_Produit ON upper(t_Produit.NoProduit) = upper(t_Verrat_Produit.NoProduit) " + &
				"WHERE upper(t_Verrat_Produit.CodeVerrat) = upper(:as_code) AND upper(t_Produit.Famille = :as_famille) "
			IF GetChild( "noproduit", ldwc_produit ) = 1 THEN
				  ls_rtn = ldwc_produit.modify( "DataWindow.Table.Select=~"" + ls_select_str + "~"" )
				  ls_famille = THIS.object.famille[row]
				  ll_rtn = ldwc_produit.retrieve(ls_famille, data)
			END IF
			
		END IF
	
	CASE "noproduit"
		
		THIS.GetChild('noproduit', ldwc_produit)
		ldwc_produit.setTransObject(SQLCA)
		ll_rowdddw = ldwc_produit.Find("upper(noproduit) = '" + upper(data) + "'", 1, ldwc_produit.RowCount())		
		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw = 0 THEN		
			gnv_app.inv_error.of_message("PRO0011")
			THIS.ib_suppression_message_itemerror = TRUE
			THIS.SetColumn("noproduit")
			SetText("")
			RETURN 1
		END IF
		
	CASE "qtedosemelange"
		
		ll_row_parent = dw_gestion_lot_lot.GetRow()
		IF ll_row_parent > 0 THEN
			
			ll_qtedistribue = THIS.object.qtedistribue_qtedistribue[row]
			IF ll_qtedistribue > 0 THEN
				IF gnv_app.of_getcompagniedefaut( ) = "112" THEN
					Messagebox("Attention","Les quantités ont commencé à être distribuées.")
				END IF
			END IF

			ll_total_orig = dw_gestion_lot_lot.object.qtedosetotal[ll_row_parent]
			IF IsNull(ll_total_orig) THEN ll_total_orig = 0
			
			THIS.AcceptText()
			
			FOR ll_cpt = 1 TO THIS.RowCount()
				ll_temp = THIS.object.qtedosemelange[ll_cpt]
				If IsNull(ll_temp) THEN ll_temp = 0
				ll_total += ll_temp
			END FOR
			
			IF IsNull(ll_total) THEN ll_total = 0
			
			IF ll_total > ll_total_orig THEN
				gnv_app.inv_error.of_message("CIPQ0101")
				ll_old = THIS.object.qtedosemelange[row]
				THIS.ib_suppression_message_itemerror = TRUE
				data = string(ll_old)
				THIS.object.qtedosemelange[row] = 0
				RETURN 1
			END IF
			
		END IF
		
END CHOOSE
end event

event pfc_predeleterow;call super::pfc_predeleterow;IF AncestorReturnValue = CONTINUE_ACTION THEN
	
	long 	ll_qtedistribue, ll_qtedosemelange, ll_row
	
	ll_row = THIS.GetRow()
	ll_qtedistribue = THIS.object.qtedistribue_qtedistribue[ll_row]
	ll_qtedosemelange = THIS.object.qtedosemelange[ll_row]
	
	IF ll_qtedistribue > 0 THEN
		gnv_app.inv_error.of_message("CIPQ0099")
		RETURN PREVENT_ACTION
	END IF
	
	IF ll_qtedosemelange > 0 THEN
		gnv_app.inv_error.of_message("CIPQ0100")
		RETURN PREVENT_ACTION		
	END IF
	
END IF

RETURN AncestorReturnValue
end event

event itemfocuschanged;call super::itemfocuschanged;datawindowchild 	ldwc_noproduit
string	ls_codeverrat, ls_select_str, ls_rtn, ls_null

IF row > 0 THEN
	
	CHOOSE CASE dwo.name 
		CASE "noproduit"
			ls_codeverrat = THIS.object.codeverrat[row]
			SetNull(ls_null)
			
			If Not IsNull(ls_codeverrat) AND ls_codeverrat <> "" Then
				//Filtre par no de verrat
				ls_select_str =  "SELECT DISTINCT t_Produit.NoProduit " + &
					"FROM t_Produit INNER JOIN t_Verrat_Produit ON upper(t_Produit.NoProduit) = upper(t_Verrat_Produit.NoProduit) " + &
					"WHERE upper(t_Verrat_Produit.CodeVerrat) = upper(:as_codeverrat) "
					
				IF GetChild( "noproduit", ldwc_noproduit ) = 1 THEN
					ls_rtn = ldwc_noproduit.modify( "DataWindow.Table.Select=~"" + ls_select_str + "~"" )
					ldwc_noproduit.Retrieve(ls_null, ls_codeverrat)
				END IF			
			
			END IF


	END CHOOSE
	
END IF
end event

event pfc_preupdate;call super::pfc_preupdate;long ll_ligne1, ll_ligne2, ll_nbrangees
string ls_produit1, ls_produit2, ls_verrat1, ls_verrat2

ll_nbrangees = this.rowCount()

for ll_ligne1 = 1 to ll_nbrangees - 1
	ls_produit1 = this.object.noproduit[ll_ligne1]
	ls_verrat1 = this.object.codeverrat[ll_ligne1]
	
	for ll_ligne2 = ll_ligne1 + 1 to ll_nbrangees
		ls_produit2 = this.object.noproduit[ll_ligne2]
		ls_verrat2 = this.object.codeverrat[ll_ligne2]
		
		if ls_produit1 = ls_produit2 and ls_verrat1 = ls_verrat2 then
			if gnv_app.inv_error.of_message("CIPQ0160") = 2 then
				return -1
			else
				return 1
			end if
		end if
	next
next

return 1
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
05w_gestion_lot1.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15w_gestion_lot1.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point

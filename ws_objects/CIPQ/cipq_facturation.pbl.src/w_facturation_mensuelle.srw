$PBExportHeader$w_facturation_mensuelle.srw
forward
global type w_facturation_mensuelle from w_sheet_frame
end type
type uo_toolbar from u_cst_toolbarstrip within w_facturation_mensuelle
end type
type rb_ecran from u_rb within w_facturation_mensuelle
end type
type rb_imprimante from u_rb within w_facturation_mensuelle
end type
type rb_no_facture from u_rb within w_facturation_mensuelle
end type
type rb_ordre from u_rb within w_facturation_mensuelle
end type
type rb_ppa from u_rb within w_facturation_mensuelle
end type
type rb_sans_groupe from u_rb within w_facturation_mensuelle
end type
type rb_groupe_client from u_rb within w_facturation_mensuelle
end type
type rb_sous_groupe from u_rb within w_facturation_mensuelle
end type
type rb_groupe_payeur from u_rb within w_facturation_mensuelle
end type
type em_date from editmask within w_facturation_mensuelle
end type
type st_1 from statictext within w_facturation_mensuelle
end type
type st_2 from statictext within w_facturation_mensuelle
end type
type st_3 from statictext within w_facturation_mensuelle
end type
type sle_de from singlelineedit within w_facturation_mensuelle
end type
type sle_a from singlelineedit within w_facturation_mensuelle
end type
type cb_mode from commandbutton within w_facturation_mensuelle
end type
type st_fact from statictext within w_facturation_mensuelle
end type
type cb_verification from commandbutton within w_facturation_mensuelle
end type
type st_4 from statictext within w_facturation_mensuelle
end type
type st_facture from statictext within w_facturation_mensuelle
end type
type cb_mise from commandbutton within w_facturation_mensuelle
end type
type cb_generer from commandbutton within w_facturation_mensuelle
end type
type cb_imprimer from commandbutton within w_facturation_mensuelle
end type
type cb_exportation from commandbutton within w_facturation_mensuelle
end type
type cb_ver from commandbutton within w_facturation_mensuelle
end type
type st_5 from statictext within w_facturation_mensuelle
end type
type sle_message from singlelineedit within w_facturation_mensuelle
end type
type cbx_impression from u_cbx within w_facturation_mensuelle
end type
type dw_facturation_mensuelle_groupe from u_dw within w_facturation_mensuelle
end type
type st_impression from statictext within w_facturation_mensuelle
end type
type st_suite from statictext within w_facturation_mensuelle
end type
type st_ligne2 from statictext within w_facturation_mensuelle
end type
type rb_internet from u_rb within w_facturation_mensuelle
end type
type cb_etape1 from commandbutton within w_facturation_mensuelle
end type
type lb_pdf from listbox within w_facturation_mensuelle
end type
type cb_1 from commandbutton within w_facturation_mensuelle
end type
type em_debutfact from editmask within w_facturation_mensuelle
end type
type em_finfact from editmask within w_facturation_mensuelle
end type
type gb_1 from groupbox within w_facturation_mensuelle
end type
type gb_2 from groupbox within w_facturation_mensuelle
end type
type gb_ordre from groupbox within w_facturation_mensuelle
end type
type gb_4 from groupbox within w_facturation_mensuelle
end type
type gb_5 from groupbox within w_facturation_mensuelle
end type
type rr_1 from roundrectangle within w_facturation_mensuelle
end type
type rr_2 from roundrectangle within w_facturation_mensuelle
end type
end forward

global type w_facturation_mensuelle from w_sheet_frame
string tag = "menu=m_facturationmensuelle"
integer width = 4681
string title = "Facturation mensuelle"
uo_toolbar uo_toolbar
rb_ecran rb_ecran
rb_imprimante rb_imprimante
rb_no_facture rb_no_facture
rb_ordre rb_ordre
rb_ppa rb_ppa
rb_sans_groupe rb_sans_groupe
rb_groupe_client rb_groupe_client
rb_sous_groupe rb_sous_groupe
rb_groupe_payeur rb_groupe_payeur
em_date em_date
st_1 st_1
st_2 st_2
st_3 st_3
sle_de sle_de
sle_a sle_a
cb_mode cb_mode
st_fact st_fact
cb_verification cb_verification
st_4 st_4
st_facture st_facture
cb_mise cb_mise
cb_generer cb_generer
cb_imprimer cb_imprimer
cb_exportation cb_exportation
cb_ver cb_ver
st_5 st_5
sle_message sle_message
cbx_impression cbx_impression
dw_facturation_mensuelle_groupe dw_facturation_mensuelle_groupe
st_impression st_impression
st_suite st_suite
st_ligne2 st_ligne2
rb_internet rb_internet
cb_etape1 cb_etape1
lb_pdf lb_pdf
cb_1 cb_1
em_debutfact em_debutfact
em_finfact em_finfact
gb_1 gb_1
gb_2 gb_2
gb_ordre gb_ordre
gb_4 gb_4
gb_5 gb_5
rr_1 rr_1
rr_2 rr_2
end type
global w_facturation_mensuelle w_facturation_mensuelle

type variables
string	is_centre
string is_pathfact
end variables

forward prototypes
public subroutine of_recount ()
public subroutine of_updateallnofacturefast ()
public subroutine of_updateprixfacdet ()
public function boolean of_get_transportfree (long al_no_eleveur, string as_code_transport)
public subroutine of_piecejointe (long al_debut, long al_fin, string as_message)
end prototypes

public subroutine of_recount ();//of_recount
long		ll_compteur = 0, ll_reimp, ll_nb_ligne, ll_de, ll_a
dec		ldec_prix
date		ld_cur
string	ls_cie, ls_null, ls_nofacture
n_ds		lds_facturation_count

lds_facturation_count = CREATE n_ds

SetPointer(Hourglass!)

SetNull(ls_null)
ld_cur = date(em_date.text)
ls_cie = gnv_app.of_getcompagniedefaut( )

SetPointer(HourGlass!)

IF cbx_impression.checked THEN
	ll_reimp = 1
	//Réimpression
	lds_facturation_count.dataobject = "ds_facturation_mensuelle_reimp"
ELSE
	ll_reimp = 0
	//Pas une réimpression
	lds_facturation_count.dataobject = "ds_facturation_mensuelle_normal_count"
END IF

lds_facturation_count.SetTransObject(SQLCA)

ll_nb_ligne = lds_facturation_count.Retrieve(ld_cur)
st_facture.text = string(ll_nb_ligne)


IF ll_nb_ligne = 0 THEN
	em_date.SetFocus()

	cb_generer.Enabled = FALSe
	cb_mise.Enabled = FALSE
	
	//sle_de.text = ls_null
	//sle_a.text = ls_null	
ELSE
	//Calcul des numéros de factures
	IF ll_reimp = 0 THEN
		SELECT 	nofacture
		INTO		:ls_nofacture
		FROM 		t_centreCIPQ
		WHERE		cie = :ls_cie;
		
		If isNull(ls_nofacture) THEN ls_nofacture = "0"
		
		ll_de = long(ls_nofacture) + 1
		ll_a	= long(ls_nofacture) + ll_nb_ligne
	ELSE
		ll_de = long(lds_facturation_count.object.fact_no[1])
		ll_a = long(lds_facturation_count.object.fact_no[ll_nb_ligne])
	END IF
	
	sle_de.text = string(ll_de)
	sle_a.text = string(ll_a)
	
END IF

//Possibilité d'ajuster le prix ou non
IF ll_reimp = 0 THEN
	IF ll_nb_ligne > 0 THEN
		ldec_prix = lds_facturation_count.object.prix[1]
		IF isnull(ldec_prix) = FALSE THEN
			cb_mise.enabled = FALSE
		ELSE
			cb_mise.enabled = TRUE
		END IF
	END IF
ELSE
	cb_mise.enabled = FALSE
	cb_generer.enabled = FALSE
END IF

IF st_fact.text = "Facturation" THEN
	IF ll_nb_ligne = 0 THEN
		cb_generer.enabled = FALSE
	ELSE
		cb_generer.enabled = TRUE
	END IF
ELSE
	cb_generer.enabled = FALSE
END IF

em_date.SetFocus()


IF IsValid(lds_facturation_count) THEN Destroy(lds_facturation_count)
end subroutine

public subroutine of_updateallnofacturefast ();//of_UpdateAllNoFactureFast
date 		ld_cur
datetime	ldt_cur
long		ll_count, ll_cpt, ll_nb_ligne, ll_nofacture, ll_Tr_Client, ll_Tr_Client_old, ll_groupe, ll_groupesec, ll_cntfact
n_ds		lds_facturation_count
string	ls_cie, ls_nofacture, ls_cycle

ld_cur = date(em_date.text)
ldt_cur = datetime(ld_cur)
lds_facturation_count = CREATE n_ds

ls_cie = gnv_app.of_getcompagniedefaut( )
SetPointer(HourGlass!)

IF cbx_impression.checked THEN
	RETURN
END IF

//Pas une réimpression
lds_facturation_count.dataobject = "ds_facturation_mensuelle_normal"
lds_facturation_count.SetTransObject(SQLCA)

ll_nb_ligne = lds_facturation_count.Retrieve(ld_cur)
IF ll_nb_ligne = 0 THEN
	gnv_app.inv_error.of_message("CIPQ00118")
	RETURN
END IF

//Récupérer le prochain no de facture
SELECT 	nofacture
INTO		:ls_nofacture
FROM 		t_centreCIPQ
WHERE		cie = :ls_cie;

If isNull(ls_nofacture) THEN ls_nofacture = "0"
ll_nofacture = long(ls_nofacture)

IF ll_nb_ligne > 0 THEN
	ll_Tr_Client_old = lds_facturation_count.object.no_eleveur[1]
END IF

ll_cpt = 1

DO WHILE ll_cpt <= ll_nb_ligne
	ll_Tr_Client = lds_facturation_count.object.no_eleveur[ll_cpt]
	ls_cycle = lds_facturation_count.object.billing_cycle_code[ll_cpt]
	ll_groupe = lds_facturation_count.object.groupe[ll_cpt]
	ll_groupesec = lds_facturation_count.object.groupesecondaire[ll_cpt]
	ll_nofacture++
	DO WHILE ll_Tr_Client_old = ll_Tr_Client AND ll_cpt <= ll_nb_ligne
		st_impression.text = "Génération de la facture #" + string(ll_nofacture)
		ls_nofacture= string(ll_nofacture)
		
		//Mettre à jour la date et le numéro
		//2008-12-02 Mathieu Gendron Updatait même les livraisons de l'autre mois "AND liv_date <= :ldt_cur"
		//2008-12-22 Mathieu Gendron On sauvegarde maintenant l'historique des groupes, sous-groupes et cycles
		//2009-06-03 Sébastien Tremblay Remis "AND liv_date <= :ldt_cur" parce que le problème est corrigé ailleurs
		UPDATE 	t_statfacture
		SET 		fact_no = :ls_nofacture,
					fact_date = :ldt_cur,
					billing_cycle_code = :ls_cycle,
					groupe = :ll_groupe,
					groupesecondaire = :ll_groupesec
		WHERE		no_eleveur = :ll_Tr_Client AND FACT_NO is null
		AND		date(t_statfacture.liv_date) <= :ldt_cur
		USING 	SQLCA;
		
		COMMIT USING SQLCA;
		
		ll_cpt ++
		
		IF ll_cpt <= ll_nb_ligne THEN
			ll_Tr_Client = lds_facturation_count.object.no_eleveur[ll_cpt]
		ELSE
			ll_Tr_Client = 0
		END IF
	LOOP
	
	ll_Tr_Client_old = ll_Tr_Client
LOOP

// ON verifie si tous les factures du moins courant on un numero sinon on reverse
// Début

select count(1) into :ll_cntfact
from t_statfacture
where date(t_statfacture.liv_date) <= :ldt_cur and fact_no is null;

if ll_cntfact > 0 then
	
	messagebox("Avertissement!", "Il y a des bons de commande qui sont toujours non facturés voici la liste")
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien bonfact date",ldt_cur)
	opensheet(w_bonnonfact, gnv_app.of_getFrame(),6, layered!)
	
end if


// Fin

ls_nofacture = string(ll_nofacture)

UPDATE	t_centreCIPQ SET nofacture = :ls_nofacture
WHERE		cie = :ls_cie;
COMMIT USING SQLCA;

IF IsValid(lds_facturation_count) THEN Destroy(lds_facturation_count)
end subroutine

public subroutine of_updateprixfacdet ();//of_UpdatePrixFacDet
long		ll_cpt_matable, ll_nb_ligne_matable, ll_no_eleveur, ll_cpt_matable_correction, ll_nb_ligne_matable_correction, &
			ll_livgratuiteannee, ll_livgratuiteanneetot, ll_LivGratuitemois, ll_LivGratuitemoisTot, ll_cpt_detail, &
			ll_nb_ligne_detail, ll_PLivrGratuit, ll_PLivrGratuitTot, ll_count_transport, ll_count_produit, ll_economie, &
			ll_count_sonde, ll_eleveur_temp, ll_tmpLivGratuiteAnnee, ll_tmpLivGratuiteMois, ll_no_classe, &
			ll_count_classe, ll_groupe, ll_semence, ll_nb_ligne_facturecalcultaxe, ll_cpt_facturecalcultaxe, ll_rtn, &
			ll_row_trouve, ll_nb_ligne_ldec_totprod_groupe, ll_nb_ligne_sumexped_groupe
date		ld_date_liv, ld_cur, ld_saisie
string	ls_prod_no, ls_code_produit, ls_liv_no, ls_cie, ls_livv
boolean	lb_Priv = FALSE, lb_skip = FALSE
dec		ldec_prix, ldec_qte_exp, ldec_borne, ldec_SommeDeQTE_EXP, ldec_prixsp, ldec_PrixUnitaire, ldec_TotProd, &
			ldec_evprix, ldec_SumExped, ldec_sumTotProd, ldec_PrixVenteStat, ldec_TaxF, ldec_TaxP, ldec_aTPS, &
			ldec_aTVQ, ldec_Vent, ldec_TotProd_sans_groupe, ldec_ptrixlmai

SetPointer(Hourglass!)

select isnull(prixlmai,0) into :ldec_ptrixlmai from t_centrecipq where cie  = '110';

st_impression.text = "MISE À JOUR DES PRIX"
st_suite.text = "Vérification/correction des livraisons"
st_impression.Visible = TRUE
st_suite.visible = TRUE

em_date.getdata(ld_saisie)

//Vérification/correction des livraisons
n_ds	lds_matable, lds_MaTableCorrection, lds_ldec_totprod_groupe, lds_sumexped_groupe

lds_matable = CREATE n_ds
lds_matable.Dataobject = "ds_verification_correction"
lds_matable.SetTransObject(SQLCA)
ll_nb_ligne_matable = lds_matable.retrieve()


lds_MaTableCorrection = CREATE n_ds
lds_MaTableCorrection.Dataobject = "ds_correction_livraison"
lds_MaTableCorrection.SetTransObject(SQLCA)

SetPointer(Hourglass!)

//On ne peut pas charger 2 livraisons identiques/jour au client, même si livraisons proviennent de centres différents
FOR ll_cpt_matable = 1 TO ll_nb_ligne_matable
	st_ligne2.text = ''
	ll_no_eleveur = lds_matable.object.no_eleveur[ll_cpt_matable]
	ld_date_liv = lds_matable.object.liv_date[ll_cpt_matable]
	ls_prod_no = lds_matable.object.prod_no[ll_cpt_matable]
	
	st_suite.text = "Vérification/correction des livraisons. Client: " + string(ll_no_eleveur) + "~r~n" + &
		string(ll_cpt_matable) + " de " + string(ll_nb_ligne_matable)
	
	ll_nb_ligne_matable_correction = lds_MaTableCorrection.Retrieve(ll_no_eleveur, ld_date_liv, ls_prod_no)
	
	FOR ll_cpt_matable_correction = 1 TO ll_nb_ligne_matable_correction
		//On ne modifie pas la première livraison
		If ll_cpt_matable_correction > 1 THEN
			st_ligne2.text = string(ll_cpt_matable_correction)
			//Pour tous les autres, on modifie le code pour une livraison gratuite
			lds_MaTableCorrection.object.t_statfacturedetail_prod_no[ll_cpt_matable_correction] = 'LG'
			ll_rtn = lds_MaTableCorrection.update(TRUE,TRUE)
			COMMIT USING SQLCA;
		END IF
	END FOR
	
END FOR
st_ligne2.visible = FALSE


do while yield()
loop


st_suite.text = "Calcul des livraisons gratuites"

setPointer(HourGlass!)

SELECT 	TOP 1 livgratuiteannee, livgratuiteanneetot, LivGratuitemois, LivGratuitemoisTot
INTO		:ll_livgratuiteannee, :ll_livgratuiteanneetot, :ll_LivGratuitemois, :ll_LivGratuitemoisTot
FROM 		t_parametre USING SQLCA;

//MAJ du Nombre de livraison gratuite par année pour les éleveurs ayant le privilège 'PLivrGratuit' à la date de renouvellement
UPDATE t_ELEVEUR SET LivGratuiteAnnee = :ll_livgratuiteannee
WHERE t_ELEVEUR.PLivrGratuit = 1 AND Month(DateRenouvellement) = Month(DateAdd(month,1,LivGratuiteDate)) USING SQLCA;
COMMIT USING SQLCA;

//MAJ du Nombre de livraison gratuite par année pour les éleveurs ayant le privilège 'PLivrGratuitTot' à la date de renouvellement
UPDATE t_ELEVEUR SET LivGratuiteAnnee = :ll_livgratuiteanneetot
WHERE t_ELEVEUR.PLivrGratuitTot = 1 AND Month(DateRenouvellement) = Month(DateAdd(month,1,LivGratuiteDate)) USING SQLCA;
COMMIT USING SQLCA;

//Réinitialise le nombre de livraison gratuite par mois pour les éleveurs ayant le privilège 'PLivrGratuit'
//MAJ de la date LivGratuiteDate
ld_cur = relativedate(today(), - day(today()) )

UPDATE t_ELEVEUR SET LivGratuiteMois = :ll_LivGratuitemois , LivGratuiteDate = :ld_cur
WHERE t_ELEVEUR.PLivrGratuit = 1 USING SQLCA;
COMMIT USING SQLCA;

//Réinitialise le nombre de livraison gratuite par mois pour les éleveurs ayant le privilège 'PLivrGratuitTot'
//MAJ de la date LivGratuiteDate
UPDATE t_ELEVEUR SET LivGratuiteMois = :ll_LivGratuitemoisTot , LivGratuiteDate = :ld_cur
WHERE t_ELEVEUR.PLivrGratuitTot = 1 USING SQLCA;
COMMIT USING SQLCA;

setPointer(HourGlass!)

st_suite.text = "Hébergements (dont la classe=19) par éleveur qui ont un groupe de facturation"

lds_ldec_totprod_groupe = CREATE n_ds
lds_ldec_totprod_groupe.Dataobject = "ds_ldec_totprod_groupe"
lds_ldec_totprod_groupe.SetTransObject(SQLCA)
ll_nb_ligne_ldec_totprod_groupe = lds_ldec_totprod_groupe.retrieve(ld_saisie)

st_suite.text = "Somme des expéditions pour les semences avec groupe"
lds_sumexped_groupe = CREATE n_ds
lds_sumexped_groupe.Dataobject = "ds_sumexped_groupe"
lds_sumexped_groupe.SetTransObject(SQLCA)
ll_nb_ligne_sumexped_groupe = lds_sumexped_groupe.retrieve(ld_saisie)

setPointer(HourGlass!)


//Sélection des factures à traiter
n_ds	lds_matabledetail
lds_matabledetail = CREATE n_ds
lds_matabledetail.Dataobject = "ds_selection_facture"
lds_matabledetail.SetTransObject(SQLCA)
ll_nb_ligne_detail = lds_matabledetail.Retrieve(ld_saisie)

st_suite.text = "Sélection des détails"

FOR ll_cpt_detail = 1 TO ll_nb_ligne_detail
	
	do while yield()
	loop
	
	lb_skip = FALSE
	
	ll_economie = 0
	ldec_prix = 0
	ll_no_classe = 0 
	ldec_PrixUnitaire = 0
	SetNull(ll_groupe)
	
	st_suite.text = "Mise à jour des détails " + string(ll_cpt_detail) + " de " + string(ll_nb_ligne_detail)
	lb_Priv = FALSE
	ll_no_eleveur = lds_matabledetail.object.t_statfacture_no_eleveur[ll_cpt_detail]
	ls_code_produit = lds_matabledetail.object.t_statfacturedetail_codeproduit[ll_cpt_detail]
	ldec_qte_exp = lds_matabledetail.object.t_statfacturedetail_qte_exp[ll_cpt_detail]
	ls_livv = string(lds_matabledetail.object.t_statfacture_liv_no[ll_cpt_detail])
	
	IF NOT isnull(ldec_qte_exp) THEN 
	
		Select TOP 1 PLivrGratuit, PLivrGratuitTot
		INTO			:ll_PLivrGratuit, :ll_PLivrGratuitTot
		FROM			t_eleveur
		WHERE			no_eleveur = :ll_no_eleveur USING SQLCA;
		
		//Établir si privilège
		IF ll_PLivrGratuit = 1 OR ll_PLivrGratuitTot = 1 THEN
			lb_Priv = TRUE
		END IF
		
		//Voir si le produit = code de Transport
		Select 		count(1)
		INTO			:ll_count_transport
		FROM			t_transport
		WHERE			(CodeTransport) = (:ls_code_produit) USING SQLCA;
		
		//Si pas trouvé, voir si produit
		IF ll_count_transport = 0 THEN
			
			//Pointer sur le produit, dans la table T_Produit
			SELECT	count(1)
			INTO		:ll_count_produit
			FROM		t_produit
			WHERE		(NoProduit) = (:ls_code_produit) USING SQLCA;
			
			IF ll_count_produit > 0 THEN //Si le produit existe
	
				//Établir le prix du produit
				
				SELECT	noeconomievolume, isNull(PrixUnitaireSP, 0), NoClasse, isNull(PrixUnitaire, 0)
				INTO		:ll_economie, :ldec_prix, :ll_no_classe, :ldec_PrixUnitaire
				FROM		t_produit
				WHERE		(NoProduit) = (:ls_code_produit) USING SQLCA;			
			
				IF IsNull(ll_economie) THEN ll_economie = 0
				
				CHOOSE CASE (ls_code_produit)
					CASE "FCSE", "FGOLD", "FGOLD100", "FMAT", "0080", "0081", "0100", &
						  "501", "502", "503", "504", "505", "506", "507", "508", "509", "518", &
						  "RAB-YY", "RAB-LL", "RAB-LIV", "HEB-RABC", "HEB-RABG", "HEB-RABK", "HEB-RABP", "HEB-RABR" //Tiges et sondes
						lb_skip = TRUE
						If lb_Priv = TRUE Then
							// 2009-07-21 Sébastien Tremblay - Demande de Léonard : Prix privilège et non 0 pour les éleveurs privilèges
							lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_PrixUnitaire
							ll_rtn = lds_matabledetail.update(true, true)
							COMMIT USING SQLCA;
							
						ELSE 
							// 2009-07-21 Sébastien Tremblay - Demande de Léonard : pas d'économie de volume pour les sondes
//							IF ll_economie = 0 OR IsNull(ll_economie) OR SQLCA.SQLCode = 100 THEN //Si le produit n'a pas d'Économie de volume
								lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
								ll_rtn = lds_matabledetail.update(true, true)					
								COMMIT USING SQLCA;						
//							ELSE
//								//Établir la borne inférieure par éleveur
//								ldec_borne = ldec_qte_exp
//								If IsNull(ldec_borne) THEN ldec_borne = 0
//								CHOOSE CASE (ls_code_produit)
//									CASE "FCSE", "FGOLD", "FGOLD100", "0080", "0081", "0100"
//										//Nombre caisse de sondes 'FCSE' et 'FGOLD*' et "0080" et "0081" et "0100" expédiées par éleveur
//										SELECT 	t_StatFacture.No_Eleveur, 
//													Sum(t_StatFactureDetail.QTE_EXP) AS SommeDeQTE_EXP 
//										INTO		:ll_eleveur_temp, :ldec_SommeDeQTE_EXP
//										FROM 		t_StatFacture INNER JOIN t_StatFactureDetail 
//													ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
//													AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)
//										WHERE 	((t_StatFactureDetail.PROD_NO) ='FCSE' Or 
//													(t_StatFactureDetail.PROD_NO) Like 'FGOLD%' Or 
//													t_StatFactureDetail.PROD_NO='0100' Or 
//													t_StatFactureDetail.PROD_NO='0080' Or 
//													t_StatFactureDetail.PROD_NO='0081')
//													AND t_StatFacture.FACT_NO Is Null AND LIV_DATE is not null
//													AND date(LIV_DATE) <= :ld_saisie AND t_StatFacture.No_Eleveur = :ll_no_eleveur
//										GROUP BY t_StatFacture.No_Eleveur USING SQLCA;			
//										
//										If Not ISNull(ldec_SommeDeQTE_EXP) THEN
//											ldec_borne = ldec_SommeDeQTE_EXP
//										END IF
//										
//								END CHOOSE
//								
//								//Si économie de volume
//								//Table 'EconomieVolumeDetail'
//								SELECT 	FIRST t_EconomieVolumeDetail.PrixSP
//								INTO		:ldec_prixsp
//								FROM 		t_EconomieVolumeDetail
//								WHERE		NoEconomieVolume = :ll_economie AND BorneInferieure <= :ldec_borne
//								ORDER BY t_EconomieVolumeDetail.NoEconomieVolume, t_EconomieVolumeDetail.BorneInferieure DESC
//								USING SQLCA;
//								
//								IF Not(IsNull(ldec_prixsp)) AND ldec_prixsp <> 0 AND SQLCA.SQLCode <> 100 AND ll_economie <> 0 THEN
//									lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prixsp
//								ELSE //Si erreur et on ne trouve pas économie de volume
//									lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
//								END IF
//								ll_rtn = lds_matabledetail.update(true, true)					
//								COMMIT USING SQLCA;		
//								
//							END IF
							
						END IF
						
					Case "CR-LMAI"  //Crédit de livraison
						
						lb_skip = TRUE
						
						If lb_Priv = TRUE Then
							//lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = 0
							lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_PrixUnitaire
							ll_rtn = lds_matabledetail.update(true, true)					
							COMMIT USING SQLCA;		
							
							SELECT	LivGratuiteAnnee, LivGratuiteMois
							INTO		:ll_tmpLivGratuiteAnnee, :ll_tmpLivGratuiteMois
							FROM		t_eleveur
							WHERE		no_eleveur = :ll_no_eleveur ;
							
							ll_tmpLivGratuiteAnnee = ll_tmpLivGratuiteAnnee + long(round(ldec_qte_exp,0))
							ll_tmpLivGratuiteMois = ll_tmpLivGratuiteMois + long(round(ldec_qte_exp,0))
							
							UPDATE 	t_eleveur
							SET		LivGratuiteAnnee = :ll_tmpLivGratuiteAnnee , LivGratuiteMois = :ll_tmpLivGratuiteMois
							WHERE		no_eleveur = :ll_no_eleveur USING SQLCA;
							
							COMMIT USING SQLCA;
						ELSE
							lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
							ll_rtn = lds_matabledetail.update(true, true)					
							COMMIT USING SQLCA;								
						END IF
												
				END CHOOSE
				
				IF lb_skip = FALSE THEN
					//Si pas trouvé, voir si classe
					SELECT	Count(1)
					INTO		:ll_count_classe
					FROM		t_classe
					WHERE		noclasse = :ll_no_classe ;
					
					IF	ll_count_classe > 0 THEN
						//Hébergement
						IF ll_no_classe = 19 THEN
							//Établir la borne
							ldec_borne = ldec_qte_exp
							IF IsNull(ldec_borne) THEN ldec_borne = 0
							
							//Si l'éleveur appartient à un groupe de facturation
							SELECT	Groupe
							INTO		:ll_groupe
							FROM		t_eleveur
							WHERE		no_eleveur = :ll_no_eleveur ;
							
							If Not IsNull(ll_groupe) THEN
								//Si l'éleveur appartient à un groupe de facturation

								ll_row_trouve = lds_ldec_totprod_groupe.FIND( "groupe=" + string(ll_groupe) + " and noeconomievolume=" + string(ll_economie), 1, lds_ldec_totprod_groupe.RowCount())
								IF ll_row_trouve > 0 THEN
									ldec_TotProd = lds_ldec_totprod_groupe.object.totprod[ll_row_trouve]
								ELSE
									ldec_TotProd = 0
								END IF
								ldec_borne = ldec_TotProd
							ELSE
								//l'éleveur n'a pas de groupe de facturation
								
								SELECT 		Count(t_StatFactureDetail.QTE_EXP) AS TotProd 
								INTO			:ldec_TotProd_sans_groupe
								FROM 			(t_StatFacture INNER JOIN t_ELEVEUR ON t_StatFacture.No_Eleveur = t_ELEVEUR.No_Eleveur) 
								INNER JOIN 	((t_Classe INNER JOIN t_Produit ON t_Classe.NoClasse = t_Produit.NoClasse) 
								INNER JOIN 	t_StatFactureDetail ON (t_Produit.NoProduit) = (t_StatFactureDetail.PROD_NO)) 
												ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
												AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO) 
								WHERE 		t_ELEVEUR.no_eleveur = :ll_no_eleveur AND
												(t_ELEVEUR.Groupe Is Null OR t_ELEVEUR.Groupe = 0) And t_Classe.NoClasse = 19
												And t_Produit.NoEconomieVolume = :ll_economie AND t_StatFacture.FACT_NO Is Null
												AND LIV_DATE is not null AND date(LIV_DATE) <= :ld_saisie
								USING SQLCA;
								
								IF Not IsNull(ldec_TotProd_sans_groupe) AND ldec_TotProd_sans_groupe <> 0 THEN
									ldec_borne = ldec_TotProd_sans_groupe
								ELSE
									ldec_borne = 0
								END IF		
							END IF
							
							
							//Table 'EconomieVolumeDetail'
							SELECT 	FIRST t_EconomieVolumeDetail.PrixSP, t_EconomieVolumeDetail.Prix
							INTO		:ldec_prixsp, :ldec_evprix
							FROM 		t_EconomieVolumeDetail
							WHERE		NoEconomieVolume = :ll_economie AND BorneInferieure <= :ldec_borne
							ORDER BY t_EconomieVolumeDetail.NoEconomieVolume, t_EconomieVolumeDetail.BorneInferieure DESC
							USING SQLCA;	
							
							IF (Not(IsNull(ldec_prixsp)) AND ldec_prixsp <> 0) AND (Not(IsNull(ldec_evprix)) AND ldec_evprix <> 0) AND SQLCA.SQLCode <> 100 AND ll_economie <> 0  THEN 
								//Si privilège
								IF lb_priv = TRUE THEN
									lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_evprix
								ELSE
									lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prixsp
								END IF
							ELSE //Si sans privilège,on applique le prix *SP
								IF lb_priv = TRUE THEN
									lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_PrixUnitaire
								ELSE
									lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
								END IF			
							END IF
							
							ll_rtn = lds_matabledetail.update(true, true)					
							COMMIT USING SQLCA;		
							
							
						ELSE //Semence
							
							SELECT	semence
							INTO		:ll_semence
							FROM		t_classe
							WHERE		noclasse = :ll_no_classe ;
							
							IF ll_semence = 1 THEN
								//Si économie de volume sur le produit
								IF not(ll_economie = 0 OR IsNull(ll_economie)) THEN 
									//Établir la borne
									ldec_borne = ldec_qte_exp
									IF IsNull(ldec_borne) THEN ldec_borne = 0
									
									//Si l'éleveur appartient à un groupe de facturation
									SELECT	Groupe
									INTO		:ll_groupe
									FROM		t_eleveur
									WHERE		no_eleveur = :ll_no_eleveur ;
									
									If Not IsNull(ll_groupe) THEN
										//Si l'éleveur appartient à un groupe de facturation
										
										ll_row_trouve = lds_sumexped_groupe.FIND( "groupe=" + string(ll_groupe), 1, lds_sumexped_groupe.rOWcOUNT())
										IF ll_row_trouve > 0 THEN
											ldec_SumExped = lds_sumexped_groupe.object.sumexped[ll_row_trouve]
										ELSE
											ldec_SumExped = 0
										END IF		
										ldec_borne = ldec_SumExped
									ELSE
										//l'éleveur n'a pas de groupe de facturation
										SELECT 	Sum(t_StatFactureDetail.QTE_EXP) AS SumExped 
										INTO		:ldec_SumExped
										FROM 		(t_ELEVEUR INNER JOIN t_StatFacture 
													ON t_ELEVEUR.No_Eleveur = t_StatFacture.No_Eleveur) 
													INNER JOIN (t_StatFactureDetail 
													INNER JOIN (t_Classe INNER JOIN t_Produit 
													ON t_Classe.NoClasse = t_Produit.NoClasse) 
													ON (t_StatFactureDetail.PROD_NO) = (t_Produit.NoProduit)) 
													ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
													AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO) 
										WHERE 	t_ELEVEUR.no_eleveur = :ll_no_eleveur And t_Classe.Semence = 1
													AND t_StatFacture.FACT_NO Is Null AND LIV_DATE is not null AND date(LIV_DATE) <= :ld_saisie ;
										
										IF Not IsNull(ldec_SumExped) AND ldec_SumExped <> 0 THEN
											ldec_borne = ldec_SumExped
										ELSE
											ldec_borne = 0
										END IF		
									END IF
		
									
									//Table 'EconomieVolumeDetail'
									SELECT 	FIRST t_EconomieVolumeDetail.PrixSP, t_EconomieVolumeDetail.Prix
									INTO		:ldec_prixsp, :ldec_evprix
									FROM 		t_EconomieVolumeDetail
									WHERE		NoEconomieVolume = :ll_economie AND BorneInferieure <= :ldec_borne
									ORDER BY t_EconomieVolumeDetail.NoEconomieVolume, t_EconomieVolumeDetail.BorneInferieure DESC
									USING SQLCA;	
									
									IF (((Not(IsNull(ldec_prixsp)) AND ldec_prixsp <> 0) OR (Not(IsNull(ldec_evprix))) AND ldec_evprix <> 0)) AND SQLCA.SQLCode <> 100 AND ll_economie <> 0  THEN 
										//Si privilège
										IF lb_priv = TRUE THEN
											lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_evprix
										ELSE
											lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prixsp
										END IF
									ELSE //Si sans privilège,on applique le prix *SP
										IF lb_priv = TRUE THEN
											lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_PrixUnitaire
										ELSE
											lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
										END IF			
									END IF
									
									ll_rtn = lds_matabledetail.update(true, true)					
									COMMIT USING SQLCA;		
		
									
								ELSE //Pas d'économie de volume
									IF lb_priv = TRUE THEN
										lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_PrixUnitaire
									ELSE
										lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
									END IF	
									ll_rtn = lds_matabledetail.update(true, true)					
									COMMIT USING SQLCA;							
																		
								END IF

							ELSE
								//Les non semence <>19 (hébergement)
								IF not(ll_economie = 0 OR IsNull(ll_economie)) THEN //Si le produit a une d'Économie de volume
									//La borne est calculée sur chaque produit et pour chaque éleveur
									//SommeTotal des produits (dont la classe.Semence=0) par Éleveur
									//et dont les produits sont <> de "FCSE","FGOLD", "FGOLD100", "FMAT", "0080", "0081", "0100",
									//"501", "502", "503", "504", "505", "506", "507", "508", "509", "518"
									//et dont la classe est <> hébergement(19)
																
									SELECT 	Sum(t_StatFactureDetail.QTE_EXP) AS TotProd 
									INTO		:ldec_sumTotProd
									FROM 		t_StatFacture INNER JOIN (t_StatFactureDetail
												INNER JOIN (t_Classe INNER JOIN t_Produit
												ON t_Classe.NoClasse = t_Produit.NoClasse)
												ON (t_StatFactureDetail.PROD_NO) = (t_Produit.NoProduit))
												ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO)
												AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)
									WHERE 	t_Produit.NoEconomieVolume <> 0 AND (t_Produit.NoProduit) <> 'FCSE'
												And (t_Produit.NoProduit) Not Like 'FGOLD%' And (t_Produit.NoProduit) <> 'FMAT'
												And t_Produit.NoProduit <> '0100' And t_Produit.NoProduit <> '0080'
												And t_Produit.NoProduit <> '0081' And t_Produit.NoProduit <> '501'
												And t_Produit.NoProduit <> '502' And t_Produit.NoProduit <> '503'
												And t_Produit.NoProduit <> '504' And t_Produit.NoProduit <> '505'
												And t_Produit.NoProduit <> '506' And t_Produit.NoProduit <> '507'
												And t_Produit.NoProduit <> '508' And t_Produit.NoProduit <> '509'
												And t_Produit.NoProduit <> '518' AND t_Classe.NoClasse <> 19
												AND t_Classe.Semence = 0 AND t_StatFacture.no_eleveur = :ll_no_eleveur
												AND (t_StatFactureDetail.prod_no) = (:ls_code_produit)
												AND t_StatFacture.FACT_NO Is Null AND LIV_DATE is not null
												AND date(LIV_DATE) <= :ld_saisie
									USING SQLCA;
									
									IF ldec_sumTotProd <> 0 AND Not Isnull(ldec_sumTotProd) THEN
										
										IF Not IsNull(ldec_SumExped) AND ldec_SumExped <> 0 THEN
											//ldec_borne = ldec_SumExped
											ldec_borne = ldec_sumTotProd
											
										ELSE
											ldec_borne = 0
										END IF	
										
										//Table 'EconomieVolumeDetail'
										SELECT 	FIRST t_EconomieVolumeDetail.PrixSP, t_EconomieVolumeDetail.Prix
										INTO		:ldec_prixsp, :ldec_evprix
										FROM 		t_EconomieVolumeDetail
										WHERE		NoEconomieVolume = :ll_economie AND BorneInferieure <= :ldec_borne
										ORDER BY t_EconomieVolumeDetail.NoEconomieVolume, t_EconomieVolumeDetail.BorneInferieure DESC
										USING SQLCA;	
										
										IF ((Not(IsNull(ldec_prixsp)) AND ldec_prixsp <> 0) OR (Not(IsNull(ldec_evprix)) AND ldec_evprix <> 0)) AND SQLCA.SQLCode <> 100 AND ll_economie <> 0  THEN 
											//Si privilège
											IF lb_priv = TRUE THEN
												lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_evprix
											ELSE
												lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prixsp
											END IF
										ELSE //Si sans privilège,on applique le prix *SP
											IF lb_priv = TRUE THEN
												lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_PrixUnitaire
											ELSE
												lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
											END IF			
										END IF
										
										ll_rtn = lds_matabledetail.update(true, true)					
										COMMIT USING SQLCA;		
										
									ELSE
										IF lb_priv = TRUE THEN
											lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_PrixUnitaire
										ELSE
											lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
										END IF									
										ll_rtn = lds_matabledetail.update(true, true)					
										COMMIT USING SQLCA;									
									END IF
									
								ELSE
									IF lb_priv = TRUE THEN
										lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_PrixUnitaire
									ELSE
										lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
									END IF			
									ll_rtn = lds_matabledetail.update(true, true)					
									COMMIT USING SQLCA;								
								END IF					
								
								
							END IF
							
							
						END IF
						
					ELSE
						//Si le produit n'appartient pas à une classe de produit
						IF lb_priv = TRUE THEN
							lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_PrixUnitaire
						ELSE
							lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
						END IF
						ll_rtn = lds_matabledetail.update(true, true)					
						COMMIT USING SQLCA;			
					END IF
				END IF
			END IF
			
		ELSE //Si transport
			IF lb_priv = TRUE THEN
				IF THIS.of_get_transportfree(ll_no_eleveur, ls_code_produit) = TRUE THEN
					ldec_prix = 0
					IF ls_code_produit = 'LMAI' THEN ldec_prix = ldec_ptrixlmai
				ELSE
					//Trouver un prix
					Select 		TOP 1 prix
					INTO			:ldec_prix
					FROM			t_transport
					WHERE			CodeTransport = :ls_code_produit USING SQLCA;
				END IF
				
			ELSE
				Select 		TOP 1 prix
				INTO			:ldec_prix
				FROM			t_transport
				WHERE			CodeTransport = :ls_code_produit USING SQLCA;
			END IF
			
			lds_matabledetail.object.t_statfacturedetail_uprix[ll_cpt_detail] = ldec_prix
			ll_rtn = lds_matabledetail.update(true, true)
			COMMIT USING SQLCA;
		END IF
		
	END IF

END FOR

st_suite.text = "Sélection des entêtes "

//Table StatFacture des éléments facturées et tblCodesTaxes pour calculer les taxes
n_ds	lds_matable_facturecalcultaxe

lds_matable_facturecalcultaxe = CREATE n_ds
lds_matable_facturecalcultaxe.Dataobject = "ds_facturecalcultaxe"
lds_matable_facturecalcultaxe.SetTransObject(SQLCA)
ll_nb_ligne_facturecalcultaxe = lds_matable_facturecalcultaxe.retrieve(ld_saisie)

FOR ll_cpt_facturecalcultaxe = 1 TO ll_nb_ligne_facturecalcultaxe
	st_suite.text = "Mise a jour des entêtes " + string(ll_cpt_facturecalcultaxe) + " de " + string(ll_nb_ligne_facturecalcultaxe)
	
	ls_cie = lds_matable_facturecalcultaxe.object.cie_no[ll_cpt_facturecalcultaxe]
	ls_liv_no = lds_matable_facturecalcultaxe.object.liv_no[ll_cpt_facturecalcultaxe]
	
// Changement : les no_fact sont pu nul, on vient de les mettre
	SELECT 	Sum(QTE_EXP * UPRIX ) AS Vent
	INTO		:ldec_Vent
	FROM 		t_StatFactureDetail INNER JOIN t_StatFacture
				ON (t_StatFactureDetail.CIE_NO = t_StatFacture.CIE_NO)
				AND (t_StatFactureDetail.LIV_NO = t_StatFacture.LIV_NO)
	WHERE 	t_StatFacture.CIE_NO = :ls_cie
				AND t_StatFacture.LIV_NO = :ls_liv_no AND LIV_DATE is not null
				AND date(LIV_DATE) <= :ld_saisie
				USING SQLCA;
	
	If IsNull(ldec_Vent) THEN ldec_Vent = 0
	ldec_PrixVenteStat = Round(ldec_Vent,2)
	ldec_TaxF = lds_matable_facturecalcultaxe.object.taxe_fede[ll_cpt_facturecalcultaxe]
	ldec_TaxP = lds_matable_facturecalcultaxe.object.taxe_prov[ll_cpt_facturecalcultaxe]
	ldec_aTPS = ROUND(ldec_PrixVenteStat * (ldec_TaxF / 100), 2)
	ldec_aTVQ = ROUND(ldec_PrixVenteStat * (ldec_TaxP / 100), 2)
	
	lds_matable_facturecalcultaxe.object.Pourc_Fed[ll_cpt_facturecalcultaxe] = ldec_TaxF
	lds_matable_facturecalcultaxe.object.Pourc_Prov[ll_cpt_facturecalcultaxe] = ldec_TaxP
	lds_matable_facturecalcultaxe.object.VENTE[ll_cpt_facturecalcultaxe] = ldec_PrixVenteStat
	lds_matable_facturecalcultaxe.object.TAXEF[ll_cpt_facturecalcultaxe] = round(ldec_aTPS,2)
	lds_matable_facturecalcultaxe.object.TAXEP[ll_cpt_facturecalcultaxe] = round(ldec_aTVQ,2)
	
	ll_rtn = lds_matable_facturecalcultaxe.update(true,true)
	COMMIT USING SQLCA;
	
	//TEST//
	
	UPDATE t_statfacturedetail 
	INNER JOIN t_statfacture ON (t_statfacture.LIV_NO = t_statfactureDetail.LIV_NO) AND (t_statfacture.CIE_NO = t_statfactureDetail.CIE_NO)
	SET tps = ((qte_exp * uprix) * pourc_fed)/100, tvq = ((qte_exp * uprix) * pourc_prov)/100
	WHERE	t_StatFacture.CIE_NO = :ls_cie
		AND t_StatFacture.LIV_NO = :ls_liv_no AND LIV_DATE is not null
		AND date(LIV_DATE) <= :ld_saisie
	USING SQLCA;
	
END FOR

IF IsValid(lds_matable_facturecalcultaxe) THEN Destroy (lds_matable_facturecalcultaxe)
IF IsValid(lds_matabledetail) THEN Destroy (lds_matabledetail)
IF IsValid(lds_MaTableCorrection) THEN Destroy (lds_MaTableCorrection)
IF IsValid(lds_matable) THEN Destroy (lds_matable)
IF IsValid(lds_ldec_totprod_groupe) THEN Destroy (lds_ldec_totprod_groupe)
IF IsValid(lds_sumexped_groupe) THEN Destroy (lds_sumexped_groupe)

st_impression.Visible = FALSE
st_suite.visible = FALSE
end subroutine

public function boolean of_get_transportfree (long al_no_eleveur, string as_code_transport); //of_Get_TransportFree

long	ll_PLivrGratuitTot, ll_LivGratuiteMois, ll_LivGratuiteAnnee

as_code_transport = UPPER(as_code_transport)

//Les exceptions
If as_code_transport = "LO" Or as_code_transport = "LG" Or as_code_transport = "LMAT" Or as_code_transport = "LSPE" Or as_code_transport = "LCOOP" Then
	RETURN FALSE
End If

SELECT 	TOP 1 PLivrGratuitTot, LivGratuiteMois, LivGratuiteAnnee
INTO		:ll_PLivrGratuitTot, :ll_LivGratuiteMois, :ll_LivGratuiteAnnee
FROM 		t_eleveur
WHERE		no_eleveur = :al_no_eleveur ;

If IsNull(ll_PLivrGratuitTot) AND IsNull(ll_LivGratuiteMois) AND IsNull(ll_LivGratuiteAnnee) THEN RETURN FALSE

//Si privilège total, gratuité illimitée mais assujettie aux exceptions
IF ll_PLivrGratuitTot = 1 THEN
	RETURN TRUE
END IF

IF ll_LivGratuiteMois <= 1 OR IsNull(ll_LivGratuiteMois) THEN
	RETURN FALSE
END IF

IF ll_LivGratuiteAnnee <= 1 OR IsNull(ll_LivGratuiteAnnee) THEN
	RETURN FALSE
END IF

ll_LivGratuiteAnnee --
ll_LivGratuiteMois --

//On débite la livraison à l'éleveur
UPDATE 	t_eleveur SET LivGratuiteMois = :ll_LivGratuiteMois, LivGratuiteAnnee = :ll_LivGratuiteAnnee
WHERE		no_eleveur = :al_no_eleveur USING SQLCA;
COMMIT 	USING SQLCA;

RETURN TRUE
end function

public subroutine of_piecejointe (long al_debut, long al_fin, string as_message);string ls_destinataire,ls_pathfile,ls_filename, ls_cellulaire
string ls_courriel, ls_sujet, ls_body,ls_erreur=""
long i,ll_count,ll_envoyer, ll_retrieve, ll_debut,ll_noeleveur

select isnull(email,''), isnull(factsubject,''),isnull(factbody,'') 
  into :ls_courriel, :ls_sujet, :ls_body 
  from t_centrecipq 
 where cie = :is_centre;

if ls_courriel = '' then 
	messagebox("Avertissement","Courriel du destinataire absent!")
	return
end if
if ls_sujet = '' then 
	messagebox("Avertissement","Veuillez entrer un sujet !")
	return
end if

ll_count = long(st_facture.text)
if ll_count > 0 and al_debut > 0 and al_fin > 0 then 
	
	//st_impression.text = "Envoi par courriel en cours..."
	st_impression.visible = true 
	
	ll_debut = al_debut

	// Parcourir NoFact
	For i = ll_debut To al_fin
		n_ds ds_facturation
		ds_facturation = Create n_ds
		ds_facturation.dataobject = 'd_r_facturation_template'
		ds_facturation.SetTransObject(SQLCA)
		ll_retrieve = ds_facturation.retrieve(ll_debut,ll_debut)
	   ds_facturation.object.st_message_footer.text = as_message
		
		st_impression.text = "Génération de la facture #" + string(ll_debut)
		
		if ll_retrieve > 0 then
			setnull(ls_filename)
			setnull(ls_destinataire)
			setnull(ll_noeleveur)
			setnull(ls_erreur)
			setnull(ls_cellulaire)
			
			ls_destinataire = ds_facturation.getItemString(1,'af_courriel')
			ll_noeleveur     = ds_facturation.getItemNumber(1,'no_eleveur')
			ls_cellulaire     = ds_facturation.getItemString(1,'cellulaire')
			
			if ls_destinataire = "" or isnull(ls_destinataire) then 
				ls_erreur = "Le courriel du destinataire absent !"
			end if
			
			if not match(ls_destinataire,'^[a-zA-Z0-9][a-zA-Z\0-9\-_\.]*[^.]\@[^.][a-zA-Z\0-9\-_\.]+\.[a-zA-Z\0-9\-_\.]*[a-zA-Z\0-9]+$') then
				ls_erreur = "Courriel du destinataire invalide !"
			end if

			ls_filename = is_pathfact+"\"+string(ll_debut) +"-"+string(now(),"dd-mm-yyyy-hh-mm-ss") + ".pdf"
			if ds_facturation.saveas(ls_filename,PDF!,false) <> 1 then
				ls_erreur = "Impossible de créer la pièce jointe !"
			end if
			
			//if not isnull(ls_erreur) then
			//	ll_envoyer = -1
			//end if
			
			ll_envoyer = 2
			
			// courriel
			insert into t_message(dateenvoye, priorite, message_de, message_a, sujet, message_texte, fichier_attache, source, statut,statut_lu, statut_affiche, typemessagerie, couleur, email, envoyer, sms, nomemail, id_user, nomordinateur, nomreel,failmsg,no_eleveur)
			values(now(), 0, :ls_courriel, :ls_destinataire, :ls_sujet, :ls_body, :ls_filename, 'e', 'a', 'o','o', 'U', 15780518, 1, :ll_envoyer, 0,'',0,'','',:ls_erreur,:ll_noeleveur);
			if SQLCA.SQLCode = 0 then
				commit using SQLCA;
			else
				rollback using SQLCA;
			end if
			//sms 
			/*
			if ls_cellulaire = "" or isnull(ls_cellulaire) then 
				insert into t_message(dateenvoye, priorite, message_de, message_a, sujet, message_texte, fichier_attache, source, statut,statut_lu, statut_affiche, typemessagerie, couleur, email, envoyer, sms, nomemail, id_user, nomordinateur, nomreel,failmsg,no_eleveur)
				values(now(), 0, :ls_courriel, :ls_destinataire, :ls_sujet, :ls_body, :ls_filename, 'e', 'a', 'o','o', 'U', 15780518, 1, :ll_envoyer, 1,'',0,'','',:ls_erreur,:ll_noeleveur);
				if SQLCA.SQLCode = 0 then
					commit using SQLCA;
				else
					rollback using SQLCA;
				end if
			end if
			*/
		end if
		
		destroy (ds_facturation)
		
		ll_debut = ll_debut + 1
	Next

	st_impression.visible = false
	st_impression.text = "Impression en cours ..."
	
end if
end subroutine

on w_facturation_mensuelle.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.rb_ecran=create rb_ecran
this.rb_imprimante=create rb_imprimante
this.rb_no_facture=create rb_no_facture
this.rb_ordre=create rb_ordre
this.rb_ppa=create rb_ppa
this.rb_sans_groupe=create rb_sans_groupe
this.rb_groupe_client=create rb_groupe_client
this.rb_sous_groupe=create rb_sous_groupe
this.rb_groupe_payeur=create rb_groupe_payeur
this.em_date=create em_date
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.sle_de=create sle_de
this.sle_a=create sle_a
this.cb_mode=create cb_mode
this.st_fact=create st_fact
this.cb_verification=create cb_verification
this.st_4=create st_4
this.st_facture=create st_facture
this.cb_mise=create cb_mise
this.cb_generer=create cb_generer
this.cb_imprimer=create cb_imprimer
this.cb_exportation=create cb_exportation
this.cb_ver=create cb_ver
this.st_5=create st_5
this.sle_message=create sle_message
this.cbx_impression=create cbx_impression
this.dw_facturation_mensuelle_groupe=create dw_facturation_mensuelle_groupe
this.st_impression=create st_impression
this.st_suite=create st_suite
this.st_ligne2=create st_ligne2
this.rb_internet=create rb_internet
this.cb_etape1=create cb_etape1
this.lb_pdf=create lb_pdf
this.cb_1=create cb_1
this.em_debutfact=create em_debutfact
this.em_finfact=create em_finfact
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_ordre=create gb_ordre
this.gb_4=create gb_4
this.gb_5=create gb_5
this.rr_1=create rr_1
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.rb_ecran
this.Control[iCurrent+3]=this.rb_imprimante
this.Control[iCurrent+4]=this.rb_no_facture
this.Control[iCurrent+5]=this.rb_ordre
this.Control[iCurrent+6]=this.rb_ppa
this.Control[iCurrent+7]=this.rb_sans_groupe
this.Control[iCurrent+8]=this.rb_groupe_client
this.Control[iCurrent+9]=this.rb_sous_groupe
this.Control[iCurrent+10]=this.rb_groupe_payeur
this.Control[iCurrent+11]=this.em_date
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.sle_de
this.Control[iCurrent+16]=this.sle_a
this.Control[iCurrent+17]=this.cb_mode
this.Control[iCurrent+18]=this.st_fact
this.Control[iCurrent+19]=this.cb_verification
this.Control[iCurrent+20]=this.st_4
this.Control[iCurrent+21]=this.st_facture
this.Control[iCurrent+22]=this.cb_mise
this.Control[iCurrent+23]=this.cb_generer
this.Control[iCurrent+24]=this.cb_imprimer
this.Control[iCurrent+25]=this.cb_exportation
this.Control[iCurrent+26]=this.cb_ver
this.Control[iCurrent+27]=this.st_5
this.Control[iCurrent+28]=this.sle_message
this.Control[iCurrent+29]=this.cbx_impression
this.Control[iCurrent+30]=this.dw_facturation_mensuelle_groupe
this.Control[iCurrent+31]=this.st_impression
this.Control[iCurrent+32]=this.st_suite
this.Control[iCurrent+33]=this.st_ligne2
this.Control[iCurrent+34]=this.rb_internet
this.Control[iCurrent+35]=this.cb_etape1
this.Control[iCurrent+36]=this.lb_pdf
this.Control[iCurrent+37]=this.cb_1
this.Control[iCurrent+38]=this.em_debutfact
this.Control[iCurrent+39]=this.em_finfact
this.Control[iCurrent+40]=this.gb_1
this.Control[iCurrent+41]=this.gb_2
this.Control[iCurrent+42]=this.gb_ordre
this.Control[iCurrent+43]=this.gb_4
this.Control[iCurrent+44]=this.gb_5
this.Control[iCurrent+45]=this.rr_1
this.Control[iCurrent+46]=this.rr_2
end on

on w_facturation_mensuelle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.rb_ecran)
destroy(this.rb_imprimante)
destroy(this.rb_no_facture)
destroy(this.rb_ordre)
destroy(this.rb_ppa)
destroy(this.rb_sans_groupe)
destroy(this.rb_groupe_client)
destroy(this.rb_sous_groupe)
destroy(this.rb_groupe_payeur)
destroy(this.em_date)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_de)
destroy(this.sle_a)
destroy(this.cb_mode)
destroy(this.st_fact)
destroy(this.cb_verification)
destroy(this.st_4)
destroy(this.st_facture)
destroy(this.cb_mise)
destroy(this.cb_generer)
destroy(this.cb_imprimer)
destroy(this.cb_exportation)
destroy(this.cb_ver)
destroy(this.st_5)
destroy(this.sle_message)
destroy(this.cbx_impression)
destroy(this.dw_facturation_mensuelle_groupe)
destroy(this.st_impression)
destroy(this.st_suite)
destroy(this.st_ligne2)
destroy(this.rb_internet)
destroy(this.cb_etape1)
destroy(this.lb_pdf)
destroy(this.cb_1)
destroy(this.em_debutfact)
destroy(this.em_finfact)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_ordre)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

dw_facturation_mensuelle_groupe.insertRow(0)

date	ld_cur, ld_temp

ld_cur = RelativeDate(date(Today()),  - day(date(today())))
em_date.text = string(ld_cur)

em_finfact.text = string(ld_cur)
ld_temp = date(year(ld_cur), month(ld_cur), 1)
em_debutfact.text = string(ld_temp)

UPDATE	T_Parametre SET DateFacture = :ld_cur ;
COMMIT USING SQLCA;

is_centre = gnv_app.of_getcompagniedefaut( )

THIS.of_recount()

// INTERNET
date ldt_date
string ls_pathfile
n_cst_datetime luo_time

lb_pdf.reset()
ls_pathfile = gnv_app.of_getValeurIni("FACTURATION", "Path")	
if ls_pathfile = "" then
	messagebox("Avertissement","Impossible de créer PDF pour la facturation. Chemin introuvable.")
end if

ldt_date = date(now())
ldt_date = luo_time.of_relativemonth( ldt_date,-1) 

is_pathfact = ls_pathfile + "\" + string(ldt_date,"yyyymm")
if not directoryExists(is_pathfact) then createDirectory(is_pathfact)

lb_pdf.DirList(is_pathfact+'\*.pdf', 0)








end event

type st_title from w_sheet_frame`st_title within w_facturation_mensuelle
integer x = 311
integer y = 84
string pointer = "Arrow!"
string text = "Facturation mensuelle"
end type

type p_8 from w_sheet_frame`p_8 within w_facturation_mensuelle
integer x = 91
integer y = 68
integer width = 146
integer height = 128
string picturename = "C:\ii4net\CIPQ\images\dol.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_facturation_mensuelle
integer height = 196
end type

type uo_toolbar from u_cst_toolbarstrip within w_facturation_mensuelle
event destroy ( )
integer x = 4064
integer y = 2028
integer width = 507
integer taborder = 140
boolean bringtotop = true
string pointer = "Arrow!"
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type rb_ecran from u_rb within w_facturation_mensuelle
boolean visible = false
integer x = 4727
integer y = 776
integer width = 416
integer height = 68
boolean bringtotop = true
long backcolor = 15793151
string text = "Écran"
end type

type rb_imprimante from u_rb within w_facturation_mensuelle
boolean visible = false
integer x = 4727
integer y = 872
integer width = 416
integer height = 68
boolean bringtotop = true
long backcolor = 15793151
string text = "Imprimante"
boolean checked = true
end type

type rb_no_facture from u_rb within w_facturation_mensuelle
integer x = 3346
integer y = 656
integer width = 416
integer height = 68
boolean bringtotop = true
fontcharset fontcharset = ansi!
string pointer = "Arrow!"
long backcolor = 15793151
string text = "No facture"
boolean checked = true
end type

event clicked;call super::clicked;gb_ordre.visible = FALSE
rb_ppa.visible = FALSE
rb_sans_groupe.visible = FALSE
rb_groupe_client.visible = FALSE
rb_sous_groupe.visible = FALSE
rb_groupe_payeur.visible = FALSE
rb_internet.visible = FALSE

cb_etape1.visible = false
end event

type rb_ordre from u_rb within w_facturation_mensuelle
integer x = 3346
integer y = 808
integer width = 594
integer height = 68
boolean bringtotop = true
string pointer = "Arrow!"
long backcolor = 15793151
string text = "Ordre d~'envoi postal"
end type

event clicked;call super::clicked;gb_ordre.visible = TRUE
rb_ppa.visible = TRUE
rb_sans_groupe.visible = TRUE
rb_groupe_client.visible = TRUE
rb_sous_groupe.visible = TRUE
rb_groupe_payeur.visible = TRUE
rb_internet.visible = TRUE
end event

type rb_ppa from u_rb within w_facturation_mensuelle
boolean visible = false
integer x = 3346
integer y = 1100
integer width = 416
integer height = 68
boolean bringtotop = true
string pointer = "Arrow!"
long textcolor = 16711680
long backcolor = 15793151
string text = "PPA"
boolean checked = true
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = FALSE

cb_etape1.visible = false
lb_pdf.visible = false
end event

type rb_sans_groupe from u_rb within w_facturation_mensuelle
boolean visible = false
integer x = 3346
integer y = 1184
integer width = 416
integer height = 68
boolean bringtotop = true
string pointer = "Arrow!"
long backcolor = 15793151
string text = "Sans groupe"
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = FALSE

cb_etape1.visible = false
lb_pdf.visible = false
end event

type rb_groupe_client from u_rb within w_facturation_mensuelle
boolean visible = false
integer x = 3346
integer y = 1268
integer width = 594
integer height = 68
boolean bringtotop = true
string pointer = "Arrow!"
long backcolor = 15793151
string text = "Groupe client payeur"
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = FALSE

cb_etape1.visible = false
lb_pdf.visible = false
end event

type rb_sous_groupe from u_rb within w_facturation_mensuelle
boolean visible = false
integer x = 3346
integer y = 1352
integer width = 517
integer height = 68
boolean bringtotop = true
string pointer = "Arrow!"
long backcolor = 15793151
string text = "Sous groupe payeur"
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = TRUE

//Lancer le retrieve de la section du bas
datawindowchild 	ldwc_groupe_payeur
long		ll_rtn, ll_null
date		ld_cur

SetNull(ll_null)

ld_cur = date(em_date.text)
ll_rtn = dw_facturation_mensuelle_groupe.GetChild('idgroup', ldwc_groupe_payeur)
ldwc_groupe_payeur.setTransObject(SQLCA)
ll_rtn = ldwc_groupe_payeur.retrieve(2, ld_cur)

dw_facturation_mensuelle_groupe.object.idgroup[1] = ll_null
dw_facturation_mensuelle_groupe.object.idgroupsecondaire[1] = ll_null

cb_etape1.visible = false
lb_pdf.visible = false
end event

type rb_groupe_payeur from u_rb within w_facturation_mensuelle
boolean visible = false
integer x = 3346
integer y = 1436
integer width = 517
integer height = 68
boolean bringtotop = true
string pointer = "Arrow!"
long backcolor = 15793151
string text = "Groupe payeur"
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = TRUE

//Lancer le retrieve de la section du bas
datawindowchild 	ldwc_groupe_payeur
long		ll_rtn, ll_null
date		ld_cur

SetNull(ll_null)

ld_cur = date(em_date.text)
ll_rtn = dw_facturation_mensuelle_groupe.GetChild('idgroup', ldwc_groupe_payeur)
ldwc_groupe_payeur.setTransObject(SQLCA)
ll_rtn = ldwc_groupe_payeur.retrieve(1, ld_cur)
dw_facturation_mensuelle_groupe.object.idgroup[1] = ll_null
dw_facturation_mensuelle_groupe.object.idgroupsecondaire[1] = ll_null

cb_etape1.visible = false
lb_pdf.visible = false
end event

type em_date from editmask within w_facturation_mensuelle
integer x = 393
integer y = 640
integer width = 389
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

event modified;
IF THIS.text <> "" THEN
	date		ld_cur, ld_cur2
	string	ls_mois
	n_cst_datetime	lnv_date
	
	ld_cur = date(THIS.text)
	ld_cur = lnv_date.of_relativemonth( ld_cur, 1)
	ld_cur = RelativeDate(ld_cur, - day(ld_cur))
	ld_cur2 = lnv_date.of_lastdayofmonth( ld_cur)
	
	IF ld_cur2 <> date(em_date.text) THEN
		ls_mois = lnv_date.of_monthname( date(em_date.text))
		gnv_app.inv_error.of_message("CIPQ0115", { ls_mois, string(ld_cur2)})
		em_date.text = string(ld_cur2)
	ELSE 
		of_recount()
	END IF
	
END IF
end event

type st_1 from statictext within w_facturation_mensuelle
integer x = 192
integer y = 648
integer width = 174
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long backcolor = 12639424
string text = "Date:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_facturation_mensuelle
integer x = 261
integer y = 892
integer width = 123
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long backcolor = 12639424
string text = "De:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_facturation_mensuelle
integer x = 261
integer y = 1020
integer width = 123
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long backcolor = 12639424
string text = "À:"
boolean focusrectangle = false
end type

type sle_de from singlelineedit within w_facturation_mensuelle
integer x = 393
integer y = 880
integer width = 357
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_a from singlelineedit within w_facturation_mensuelle
integer x = 393
integer y = 1000
integer width = 357
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;
IF this.text < sle_de.text AND this.text <> "" THEN
	gnv_app.inv_error.of_message("CIPQ0114")
	st_facture.text = "0"
	THIS.text = ""
	THIS.POST SetFocus()
END IF
end event

type cb_mode from commandbutton within w_facturation_mensuelle
integer x = 96
integer y = 324
integer width = 635
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
string text = "Mode"
end type

event clicked;IF st_fact.text = "Facturation" Then
	st_fact.text = "Impression"
   cbx_impression.checked = True
Else
	st_fact.text = "Facturation"
	cbx_impression.checked = False
End If

parent.of_Recount()
end event

type st_fact from statictext within w_facturation_mensuelle
integer x = 96
integer y = 452
integer width = 635
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long textcolor = 16711680
long backcolor = 15793151
string text = "Facturation"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_verification from commandbutton within w_facturation_mensuelle
integer x = 96
integer y = 1740
integer width = 1029
integer height = 136
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
string text = "Vérification de l~'integrité des données"
boolean flatstyle = true
end type

event clicked;string	ls_cie, ls_liv_no, ls_sql
long		ll_nb_row, ll_cpt, ll_count
n_ds		lds_destruction

SetPointer(HourGlass!)

//Supprimer les bons de livraison qui n'ont pas de détail et qui n'ont pas été facturé
lds_destruction = CREATE n_ds
lds_destruction.dataobject = "ds_facturation_bon_pas_detail"
lds_destruction.of_setTransobject(SQLCA)
ll_nb_row = lds_destruction.Retrieve()

FOR ll_cpt = 1 TO ll_nb_row
	ls_cie = lds_destruction.object.t_statfacture_cie_no[ll_cpt]
	ls_liv_no = lds_destruction.object.t_statfacture_liv_no[ll_cpt]
	
	DELETE FROM T_StatFacture 
	WHERE (((T_StatFacture.CIE_NO)=:ls_cie) AND ((T_StatFacture.LIV_NO)=:ls_liv_no))	USING SQLCA;
	
	COMMIT USING SQLCA;
END FOR

select count(1) into :ll_count from #tmp_problem_fact;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #tmp_problem_fact (DescProblem varchar(50) null,~r~n" + &
														  "numero_de_bon_de_commande varchar(50) null,~r~n" + &
														  "problem varchar(50) null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #tmp_problem_fact;
	commit using sqlca;
end if

INSERT INTO #tmp_problem_fact ( Problem, DescProblem, Numero_de_bon_de_commande )
SELECT t_StatFacture.No_Eleveur, 'Numéro de client non existant' AS Expr2, t_StatFacture.LIV_NO
FROM t_StatFacture LEFT JOIN t_ELEVEUR ON t_StatFacture.No_Eleveur = t_ELEVEUR.No_Eleveur
WHERE (((t_ELEVEUR.No_Eleveur) Is Null) AND ((t_StatFacture.FACT_DATE) Is Null) AND ((t_StatFacture.FACT_NO) Is Null)) USING SQLCA;
COMMIT USING SQLCA;

INSERT INTO #tmp_problem_fact ( Problem, DescProblem, Numero_de_bon_de_commande )
SELECT t_StatFactureDetail.PROD_NO, 
If LIGNE_NO = 0 THEN 'Numéro de Transport non existant' ELSE 'Numéro de Produit non existant' ENDIF AS Expr1, 
t_StatFacture.LIV_NO
FROM t_StatFacture INNER JOIN ((t_StatFactureDetail 
LEFT JOIN t_Produit ON (t_StatFactureDetail.PROD_NO) = (t_Produit.NoProduit)) 
LEFT JOIN t_Transport ON (t_StatFactureDetail.PROD_NO) = (t_Transport.CodeTransport)) 
ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)
WHERE (((t_StatFacture.FACT_NO) Is Null) AND ((t_StatFacture.FACT_DATE) Is Null) AND ((t_Produit.NoProduit) Is Null) 
AND ((t_Transport.CodeTransport) Is Null)) USING SQLCA;
COMMIT USING SQLCA;

INSERT INTO #tmp_problem_fact ( Problem, DescProblem, Numero_de_bon_de_commande )
SELECT t_StatFactureDetail.VERRAT_NO, 'Numéro de Verrat non existant' AS Expr1, t_StatFacture.LIV_NO
FROM t_StatFacture INNER JOIN (t_StatFactureDetail 
LEFT JOIN t_Verrat ON (t_StatFactureDetail.VERRAT_NO) = (t_Verrat.CodeVerrat)) ON 
(t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)
WHERE (((t_StatFactureDetail.VERRAT_NO) Is Not Null) AND ((t_StatFacture.FACT_NO) Is Null) AND 
((t_StatFacture.FACT_DATE) Is Null) AND ((t_Verrat.CodeVerrat) Is Null)) USING SQLCA;
COMMIT USING SQLCA;

SELECT count(1) INTO :ll_count FROM #tmp_problem_fact USING SQLCA;

IF ll_count = 0 OR IsNull(ll_count) THEN
	gnv_app.inv_error.of_message("CIPQ0116")
ELSE
	cb_mise.Enabled = FALSE
	cb_generer.Enabled = FALSE
	//Ouvrir le rapport des problèmes
	w_r_problem_fact lw_fen
	SetPointer(HourGlass!)
	OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
END IF
end event

type st_4 from statictext within w_facturation_mensuelle
integer x = 2153
integer y = 348
integer width = 1093
integer height = 124
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long textcolor = 32768
long backcolor = 15793151
string text = "Nombre de factures:"
boolean focusrectangle = false
end type

type st_facture from statictext within w_facturation_mensuelle
integer x = 3264
integer y = 344
integer width = 402
integer height = 132
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15793151
boolean focusrectangle = false
end type

type cb_mise from commandbutton within w_facturation_mensuelle
integer x = 2203
integer y = 656
integer width = 846
integer height = 136
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
string text = "Mise à jour des prix"
end type

event clicked;PARENT.of_UpdatePrixFacDet()
st_suite.visible = FALSE
PARENT.of_recount()
end event

type cb_generer from commandbutton within w_facturation_mensuelle
integer x = 2203
integer y = 848
integer width = 846
integer height = 136
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
string text = "Générer les factures"
end type

event clicked;IF cbx_impression.checked = FALSE THEN
	SetPointer(HourGlass!)
	st_impression.text = "Un instant S.V.P."
	st_impression.visible = TRUE
	parent.of_UpdateAllNoFactureFast()
	st_impression.visible = FALSE
END IF

parent.of_recount()
end event

type cb_imprimer from commandbutton within w_facturation_mensuelle
integer x = 2203
integer y = 1040
integer width = 846
integer height = 136
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
string text = "Imprimer les factures"
end type

event clicked;string	ls_tri, ls_critere, ls_message, ls_critere2
long		ll_debut, ll_fin, ll_groupe, ll_sous_groupe, ll_cntfact
date 		ld_cur
datetime	ldt_cur

ld_cur = date(em_date.text)
ldt_cur = datetime(ld_cur)

ll_debut = long(sle_de.text)
ll_fin = long(sle_a.text)

select count(1) into :ll_cntfact
from t_statfacture
where date(t_statfacture.liv_date) <= :ldt_cur and fact_no is null;

if ll_cntfact > 0 then
	
	if messagebox("Avertissement","Il y a des bons de livraison qui n'ont pas de numéro de factures d'attribuer desirez-vous tout de même imprimer?",Question!, YesNo!,2)  <>1 then
		return
	end if
	
end if


ls_message = sle_message.text

st_impression.text  = "Impression en cours..."

gnv_app.inv_entrepotglobal.of_ajoutedonnee("debut rapport facturation", ll_debut)
gnv_app.inv_entrepotglobal.of_ajoutedonnee("fin rapport facturation", ll_fin)
gnv_app.inv_entrepotglobal.of_ajoutedonnee("message rapport facturation", ls_message)

IF rb_internet.checked = TRUE AND rb_no_facture.checked = FALSE THEN
	//of_piecejointe(ll_debut,ll_fin,ls_message)
	//update t_message set envoyer = 0 where envoyer = 2;
	commit using SQLCA;
ELSE
	If rb_no_facture.checked = TRUE THEN
		ls_tri = "1"
	ELSE
		ls_tri = "2"

		IF rb_ppa.checked = TRUE THEN //Client 'PPA'
			ls_Critere = " (t_ELEVEUR.Billing_cycle_code='PPA') "
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("client PPA facturation", "PPA")
			
		ELSEIF rb_sans_groupe.checked = TRUE THEN //Client indépendant
			ls_Critere = " ((t_ELEVEUR.Billing_cycle_code <> 'PPA') And (t_ELEVEUR.Groupe Is Null))"
			
		ELSEIF rb_groupe_client.checked = TRUE THEN //Client indépendant avec groupe
			ls_Critere = "(((t_ELEVEUR.Billing_cycle_code <> 'PPA') And (TypePayeur =0)) Or ((t_ELEVEUR.Billing_cycle_code <> 'PPA') " + &
				"And (TypePayeur = 2) And ( NonPayeur = 1))) "
			
		ELSEIF rb_sous_groupe.checked = TRUE THEN //Sous groupe payeur
			ls_Critere = "((t_ELEVEUR.Billing_cycle_code <>'PPA') And (Not (t_ELEVEUR.Groupe) Is Null) And (TypePayeur=2) " + &
				"And (NonPayeur=0) "
			
			ll_groupe = dw_facturation_mensuelle_groupe.object.idgroup[1]
			ll_sous_groupe = dw_facturation_mensuelle_groupe.object.idgroupsecondaire[1]
			
			IF Not IsNull(ll_groupe) THEN
				ls_critere = ls_critere + " AND ( t_ELEVEUR.Groupe = " + string(ll_groupe) + " ) "
			END IF
			
			IF Not IsNull(ll_sous_groupe) THEN
				ls_critere = ls_critere + " AND ( t_ELEVEUR.GroupeSecondaire = " + string(ll_sous_groupe) + " ) "
			END IF
			
			ls_critere += ")"
			
		ELSEIF rb_groupe_payeur.checked = TRUE THEN //Groupe payeur
			
			ls_Critere = "((t_ELEVEUR.Billing_cycle_code <> 'PPA') And (Not (t_ELEVEUR.Groupe) Is Null) And (TypePayeur=1) "
			
			ll_groupe = dw_facturation_mensuelle_groupe.object.idgroup[1]
			IF Not IsNull(ll_groupe) THEN
				ls_critere = ls_critere + " AND ( t_ELEVEUR.Groupe = " + string(ll_groupe) + " ) "
			END IF		
			
			ls_critere += ")"
		END IF
		
		// Demander si on veut afficher les facturations par internet ( vérifie si il y a une adresse courriel dans eleveur)
		if Messagebox("Information","Voulez-vous afficher les facturations par internet ?", Exclamation!, YesNo!, 2) = 1 then
			//ls_Critere
		else
			ls_Critere = ls_Critere + " AND ( isnull(t_ELEVEUR.AF_COURRIEL,'') = '') "
		end if

		gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere rapport facturation", ls_critere)
		
	END IF
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("tri rapport facturation", ls_tri)
	
	//Ouvrir l'interface
	w_r_facturation	lw_fen
	SetPointer(HourGlass!)
	OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)	
END IF
end event

type cb_exportation from commandbutton within w_facturation_mensuelle
integer x = 2203
integer y = 1468
integer width = 846
integer height = 136
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
string text = "Exportation des factures"
end type

event clicked;date 		ld_cur
datetime	ldt_cur
long ll_cntfact

w_exportation_facture lw_fen
SetPointer(HourGlass!)
ld_cur = date(em_date.text)
ldt_cur = datetime(ld_cur)

select count(1) into :ll_cntfact
from t_statfacture
where date(t_statfacture.liv_date) <= :ldt_cur and fact_no is null;

if ll_cntfact > 0 then
	
	if messagebox("Avertissement","Il y a des bons de livraison qui n'ont pas de numéro de factures d'attribuer desirez-vous tout de même exporter?",Question!, YesNo!,2)  <>1 then
		return
	end if
	
end if

gnv_app.inv_entrepotglobal.of_ajoutedonnee("date exportation fact", string(em_date.text))
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
end event

type cb_ver from commandbutton within w_facturation_mensuelle
integer x = 1166
integer y = 1740
integer width = 1029
integer height = 136
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
string text = "Vérification de l~'integrité des factures"
boolean flatstyle = true
end type

event clicked;w_r_integrite_fact lw_fen
SetPointer(HourGlass!)

date	ld_cur
ld_cur = date(em_date.text)
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien integrite date", string(ld_cur))
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
end event

type st_5 from statictext within w_facturation_mensuelle
integer x = 187
integer y = 1532
integer width = 247
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long backcolor = 12639424
string text = "Message:"
boolean focusrectangle = false
end type

type sle_message from singlelineedit within w_facturation_mensuelle
integer x = 471
integer y = 1516
integer width = 1646
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_impression from u_cbx within w_facturation_mensuelle
boolean visible = false
integer x = 251
integer y = 1296
integer width = 526
integer height = 68
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string pointer = "Arrow!"
long backcolor = 12639424
string text = "Réimpression"
end type

event clicked;call super::clicked;parent.of_recount()
end event

type dw_facturation_mensuelle_groupe from u_dw within w_facturation_mensuelle
boolean visible = false
integer x = 3259
integer y = 1680
integer width = 1253
integer height = 228
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_facturation_mensuelle_groupe"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;datawindowchild 	ldwc_groupe_payeur, ldwc_sous_groupe_payeur
date		ld_null
long		ll_null, ll_rtn

SetNull(ll_null)
SetNull(ld_null)

ll_rtn = THIS.GetChild('idgroup', ldwc_groupe_payeur)
ldwc_groupe_payeur.setTransObject(SQLCA)
ll_rtn = ldwc_groupe_payeur.retrieve(ll_null, ld_null)

ll_rtn = THIS.GetChild('idgroupsecondaire', ldwc_sous_groupe_payeur)
ldwc_sous_groupe_payeur.setTransObject(SQLCA)
ll_rtn = ldwc_sous_groupe_payeur.retrieve(ll_null, ld_null)
end event

event itemchanged;call super::itemchanged;
IF dwo.name = "idgroup" THEN

	datawindowchild 	ldwc_sous_groupe_payeur
	date		ld_cur
	long		ll_rtn, ll_group
	
	ld_cur = date(em_date.text)
	ll_group = long(data)
	ll_rtn = THIS.GetChild('idgroupsecondaire', ldwc_sous_groupe_payeur)
	ldwc_sous_groupe_payeur.setTransObject(SQLCA)
	SetPointer(HourGlass!)
	ll_rtn = ldwc_sous_groupe_payeur.retrieve(ll_group, ld_cur)
END IF
end event

type st_impression from statictext within w_facturation_mensuelle
boolean visible = false
integer x = 919
integer y = 656
integer width = 1216
integer height = 504
boolean bringtotop = true
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long textcolor = 255
long backcolor = 12639424
string text = "Impression en cours..."
alignment alignment = center!
boolean border = true
long bordercolor = 255
boolean focusrectangle = false
end type

type st_suite from statictext within w_facturation_mensuelle
boolean visible = false
integer x = 873
integer y = 1200
integer width = 2281
integer height = 252
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12639424
alignment alignment = center!
boolean focusrectangle = false
end type

type st_ligne2 from statictext within w_facturation_mensuelle
integer x = 3040
integer y = 1292
integer width = 119
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
boolean focusrectangle = false
end type

type rb_internet from u_rb within w_facturation_mensuelle
boolean visible = false
integer x = 3346
integer y = 1520
integer width = 517
integer height = 68
boolean bringtotop = true
string pointer = "Arrow!"
long backcolor = 15793151
string text = "Internet"
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = FALSE

cb_etape1.visible = true
lb_pdf.visible = true
end event

type cb_etape1 from commandbutton within w_facturation_mensuelle
boolean visible = false
integer x = 3653
integer y = 1520
integer width = 343
integer height = 92
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Générer"
end type

event clicked;string ls_fichier
long ll_debut 
long ll_fin
string ls_message
long ll_nb
long i
long ll_year
long ll_month
date ldt_date
n_cst_dirattrib lo_dirList[]

if messagebox("Avertissement","Voulez-vous continuer ?",Question!,YesNo!,2) = 1 then

	ll_nb = gnv_app.inv_filesrv.of_dirList(is_pathfact + "\*.pdf", 0, lo_dirList)		
	For i = 1 To ll_nb
		if left(lo_dirList[i].is_FileName,1) <> '.' then	
			ls_fichier = is_pathfact + "\" + lo_dirList[i].is_FileName
			FileDelete(ls_fichier)
		end if
	Next

	ll_year    =  long(string(now(),"yyyy"))
	ll_month =  long(string(now(),"mm"))
	delete from t_message where year(dateenvoye) = :ll_year and month(dateenvoye) = :ll_month;
	commit using sqlca;
end if

ll_debut        = long(sle_de.text)
ll_fin             = long(sle_a.text)
ls_message = sle_message.text

of_piecejointe(ll_debut,ll_fin,ls_message)

lb_pdf.reset()
lb_pdf.DirList(is_pathfact+'\*.pdf', 0)


end event

type lb_pdf from listbox within w_facturation_mensuelle
boolean visible = false
integer x = 3264
integer y = 1660
integer width = 1216
integer height = 280
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean border = false
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;n_cst_syncproc luo_sync
luo_sync = CREATE n_cst_syncproc
			
luo_sync.of_setwindow('normal')
luo_sync.of_RunAndWait('"' + is_pathfact + '\' + lb_pdf.selecteditem() + '"')
			
IF IsValid(luo_sync) THEN destroy luo_sync
end event

type cb_1 from commandbutton within w_facturation_mensuelle
integer x = 2235
integer y = 1740
integer width = 1033
integer height = 136
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
string text = "Vérification Facture / bon de livraison"
boolean flatstyle = true
end type

event clicked;datastore ds_imp
date ldt_debut,  ldt_fin
string ls_path, ls_file
int li_rc

li_rc = GetFileSaveName ( "Select File",  ls_path, ls_file, "XLS", "All Files (*.*),*.*" , "C:\ii4net",  32770)
 
em_debutfact.getData(ldt_debut) 
em_finfact.getData(ldt_fin)

ds_imp = create datastore
ds_imp.dataobject = "d_rappveriffact"
ds_imp.setTransObject(SQLCA)
ds_imp.retrieve(ldt_debut,  ldt_fin)
ds_imp.saveas(ls_path, Excel8!, true)

destroy ds_imp
end event

type em_debutfact from editmask within w_facturation_mensuelle
integer x = 3319
integer y = 1748
integer width = 457
integer height = 112
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type em_finfact from editmask within w_facturation_mensuelle
integer x = 3808
integer y = 1748
integer width = 430
integer height = 112
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type gb_1 from groupbox within w_facturation_mensuelle
boolean visible = false
integer x = 4635
integer y = 672
integer width = 1230
integer height = 320
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Impression"
end type

type gb_2 from groupbox within w_facturation_mensuelle
integer x = 3255
integer y = 528
integer width = 1230
integer height = 452
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Trié par"
end type

type gb_ordre from groupbox within w_facturation_mensuelle
boolean visible = false
integer x = 3255
integer y = 1024
integer width = 1230
integer height = 624
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Ordre d~'envoi postal"
end type

type gb_4 from groupbox within w_facturation_mensuelle
integer x = 192
integer y = 784
integer width = 654
integer height = 380
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long backcolor = 12639424
string text = "Numéro de facture"
end type

type gb_5 from groupbox within w_facturation_mensuelle
boolean visible = false
integer x = 187
integer y = 1212
integer width = 654
integer height = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long backcolor = 12639424
string text = "Option"
end type

type rr_1 from roundrectangle within w_facturation_mensuelle
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 256
integer width = 4549
integer height = 1712
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_facturation_mensuelle
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 12639424
integer x = 96
integer y = 556
integer width = 3081
integer height = 1104
integer cornerheight = 40
integer cornerwidth = 46
end type


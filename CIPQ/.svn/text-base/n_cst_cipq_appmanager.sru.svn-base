HA$PBExportHeader$n_cst_cipq_appmanager.sru
forward
global type n_cst_cipq_appmanager from n_cst_appmanager
end type
end forward

global type n_cst_cipq_appmanager from n_cst_appmanager
end type
global n_cst_cipq_appmanager n_cst_cipq_appmanager

type variables
n_cst_filesrvwin32				inv_filesrv
n_cst_string            		inv_String
n_cst_platformwin32        	inv_API
n_cst_dernier_acces				inv_dernieracces
n_cst_messagefrancais   		inv_MessageFrancais
n_cst_Journal						inv_Journal
n_cst_transfert_internet		inv_transfert_internet
n_cst_transfert_inter_centre	inv_transfert_inter_centre
n_cst_transfert_centre_adm		inv_transfert_centre_adm

string is_Password, is_reptemporaire = "Z:\cipq"

long	il_id_user

n_cst_audit		inv_audit

boolean	ib_administrateur = FALSE

long	il_version = 48
end variables

forward prototypes
public function integer of_setentrepotglobal (boolean ab_switch)
public subroutine of_setpassword (string as_password)
public function integer of_setmessagefrancais (boolean ab_switch)
public function string of_getcompagniedefaut ()
public function decimal of_getprixhebergement (string as_centre)
public function string of_getvaleurini (string as_section, string as_key)
public function string of_findsqlproduit (long al_noeleveur, boolean ab_incluretransport, boolean ab_inclureheb)
public function boolean of_verifiersicommandeimprimee (string as_nocommande)
public function boolean of_verifiersicommandetraitee (string as_nocommande)
public function long of_findnbverratfamille (string as_famille)
public function long of_getnbdosesmoyenne ()
public subroutine of_updatechoix (n_ds ads_donnees)
public function string of_nextnolot ()
public function long of_checknbrbilltoprint (string as_cie, long al_nocomm, string as_typeemballage, long al_qteemballage, boolean ab_statyes)
public function string of_finddescprod (string as_noproduit, string as_noverrat)
public function boolean of_chkifaffdesc (string as_noverrat)
public subroutine of_unlockall ()
public function boolean of_checkifprintopen ()
public subroutine of_printunlock ()
public subroutine of_printlock ()
public function boolean of_checkiftraiteopen ()
public function boolean of_checkifrepartopen ()
public subroutine of_traitunlock ()
public subroutine of_repartunlock ()
public subroutine of_traitlock ()
public subroutine of_repartlock ()
public function boolean of_chkiflockandlock (string as_orderno, boolean ab_tolock)
public subroutine of_orderlock (string as_orderno)
public subroutine of_orderunlock (string as_orderno)
public function long of_getnextlivno (string as_cie)
public function string of_get_tps (string as_cie)
public function string of_get_tvq (string as_cie)
public function string of_getgroupefacturationaccpac (long al_no_eleveur, string as_cyclecode, string as_adesc, long al_typepayeur, string as_anomgroupsec, long al_nonpayeur, long al_pouraccpac)
public subroutine of_appdroits (menu am_menu)
public function integer of_setjournal (boolean ab_switch)
public subroutine of_dolistemale (date ad_debut)
public function integer of_getdelai (string as_codeverrat, date ad_cur)
public subroutine of_valider_qte_malerecolte (string as_cie, string as_famille, date ad_cur)
public subroutine of_doepurerlistemale (date ad_cur)
public function integer of_getdelaitocome (string as_codeverrat, date ad_cur, date ad_de)
public function string of_finddescriptionproduct (string as_produit, string as_verrat, string as_code_hebergeur)
public function string of_tofindproduct (string as_produit, string as_verrat, string as_code_hebergeur)
public subroutine of_domoyenneexptransporteur (date ad_debut)
public subroutine of_domoyennecommande_orig_mel (date ad_debut)
public subroutine of_domoyennecommorig_pur (date ad_de)
public subroutine of_docommandesoriginales (date ad_debut, date ad_fin, boolean ab_parfamille)
public subroutine of_docompilationrecoltesg (date ad_de, date ad_au)
public subroutine of_docompilationrecolte (date ad_de, date ad_au)
public subroutine of_docompilationdetailrecolte (date ad_de, date ad_au)
public subroutine of_doregistrerecolte (date ad_de, date ad_au)
public subroutine of_doregistreanalyserecolte (date ad_de, date ad_au)
public function long of_cntheb (string as_centre, boolean ab_all, boolean ab_cumul, date ad_de, date ad_au)
public function string of_getvaleurftp (string as_section, string as_key)
public function long of_recupererprochainno (string as_cie)
public function long of_dynamic_count (string as_string)
public subroutine of_updatetable ()
public function string of_sqllisteverrats (long al_noclient)
public function boolean of_checkifpunaiseopen ()
public subroutine of_verrat_famille_frequence_recolte_vali (date ad_de, date ad_a)
public function integer of_cree_tablefact_temp (string as_table_name)
public subroutine of_dotmpemplacementvide (date adt_de)
public subroutine of_dotmpemplacementvide ()
end prototypes

public function integer of_setentrepotglobal (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_setEntrepotGlobal
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument: 		ab_switch		
//						True - active (create) le service,
//						False - d$$HEX1$$e900$$ENDHEX$$sactive (destroy) le service
//
//	Retourne:  		Integer
//						 1 - r$$HEX1$$e900$$ENDHEX$$ussi
//						 0 - aucune action ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$e
//						-1 - Une erreur s'est produite
//
//	Description:	Active ou d$$HEX1$$e900$$ENDHEX$$sactive le service d'entreposage global
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur		Description
//
//////////////////////////////////////////////////////////////////////////////

//V$$HEX1$$e900$$ENDHEX$$rifier l'argument
If IsNull(ab_switch) Then
	Return -1
End if

IF ab_Switch THEN
	IF IsNull(inv_EntrepotGlobal) Or Not IsValid (inv_EntrepotGlobal) THEN
		inv_EntrepotGlobal = CREATE n_cst_entrepotglobal
		Return 1
	END IF
ELSE
	IF IsValid (inv_EntrepotGlobal) THEN
		DESTROY inv_EntrepotGlobal
		Return 1
	END IF	
END IF

Return 0
end function

public subroutine of_setpassword (string as_password);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_SetPassword
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		as_Password	- Repr$$HEX1$$e900$$ENDHEX$$sente le password utilis$$HEX1$$e900$$ENDHEX$$
//						
//	Retourne:  		rien
//
//	Description:	Permet de setter la variable priv$$HEX1$$e900$$ENDHEX$$e is_password
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

is_Password = as_Password
end subroutine

public function integer of_setmessagefrancais (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_SetMessageFrancais
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		ab_switch		
//						True - active (create) le service,
//						False - d$$HEX1$$e900$$ENDHEX$$sactive (destroy) le service
//
// Retourne:  		Integer
//						 1 - r$$HEX1$$e900$$ENDHEX$$ussi
//						 0 - aucune action ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$e
//						-1 - Une erreur s'est produite
//
//
//	Description:	Active ou d$$HEX1$$e900$$ENDHEX$$sactive le service de traduction des messages Sybase
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

//V$$HEX1$$e900$$ENDHEX$$rifier l'argument
If IsNull(ab_switch) Then
	Return -1
End if

IF ab_Switch THEN
	IF IsNull(inv_messagefrancais) Or Not IsValid (inv_messagefrancais) THEN
		inv_messagefrancais = CREATE n_cst_MessageFrancais
		Return 1
	END IF
ELSE
	IF IsValid (inv_messagefrancais) THEN
		DESTROY inv_messagefrancais
		Return 1
	END IF	
END IF

Return 0
end function

public function string of_getcompagniedefaut ();string	ls_ciedefaut


SELECT centre INTO :ls_ciedefaut FROM t_parametre;

//Pour les tests
//RETURN "111"
return ls_ciedefaut
end function

public function decimal of_getprixhebergement (string as_centre);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_getprixhebergement
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		String - Nom du centre
//
//	Retourne:  		Prix
//
// Description:	Fonction pour trouver la valeur de l'h$$HEX1$$e900$$ENDHEX$$bergement par d$$HEX1$$e900$$ENDHEX$$faut
//						pour le centre voulu
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-09-12	Mathieu Gendron	Cr$$HEX1$$e900$$ENDHEX$$ation
//
//////////////////////////////////////////////////////////////////////////////


decimal	ldec_heb


SELECT t_CentreCIPQ.DefHEBPrix INTO :ldec_heb FROM t_CentreCIPQ WHERE t_CentreCIPQ.CIE=:as_centre ;

IF IsNull(ldec_heb) THEN ldec_heb = 0

RETURN ldec_heb
end function

public function string of_getvaleurini (string as_section, string as_key);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_getvaleurini
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		as_section	- section du .ini
//						as_key		- cl$$HEX1$$e900$$ENDHEX$$
//
//	Retourne:  		La valeur
//
// Description:	Fonction pour retourner les valeurs du fichier .ini de 
//						l'application
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-09-19	Mathieu Gendron	Cr$$HEX1$$e900$$ENDHEX$$ation
//
//////////////////////////////////////////////////////////////////////////////


RETURN ProfileString (this.of_GetAppIniFile(), as_section, as_key, "")
end function

public function string of_findsqlproduit (long al_noeleveur, boolean ab_incluretransport, boolean ab_inclureheb);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_findsqlproduit
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		al_noeleveur 			- no de l'$$HEX1$$e900$$ENDHEX$$leveur
//						ab_inclureheb 			- inclure l'h$$HEX1$$e900$$ENDHEX$$bergement?
//						ab_incluretransport 	- inclure le transport?
//						
//	Retourne:  		Le sql $$HEX2$$e0002000$$ENDHEX$$pousser
//
// Description:	Fonction pour 
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-11-23	Mathieu Gendron	Cr$$HEX1$$e900$$ENDHEX$$ation
//
//////////////////////////////////////////////////////////////////////////////

boolean	lb_gedis = FALSE 
string	ls_nom_table, ls_delete, ls_execute, ls_sql, ls_code, ls_rtn
long		ll_nbrow, ll_cpt, ll_count

n_cst_eleveur		lnv_eleveur
n_ds					lds_eleveur


ls_nom_table = "#tmp_liste_produit_" + THIS.of_getuserid( )

//D$$HEX1$$e900$$ENDHEX$$truire l'ancien contenu de la table pour cette personne - 
//ne pas v$$HEX1$$e900$$ENDHEX$$rifier le code de retour, ca se peut que la table n'existe pas
ls_delete = "DELETE FROM " + ls_nom_table 
EXECUTE IMMEDIATE :ls_delete USING SQLCA;

//Cr$$HEX1$$e900$$ENDHEX$$er la table
ls_sql = "CREATE TABLE " + ls_nom_table + "( NoProduit varchar(16), NomProduit varchar(100)) "
EXECUTE IMMEDIATE :ls_sql USING SQLCA;


//V$$HEX1$$e900$$ENDHEX$$rifier le g$$HEX1$$e900$$ENDHEX$$dis
lb_gedis = lnv_eleveur.of_formationgedis(al_noeleveur)	
IF isnull(lb_gedis) THEN lb_gedis = FALSE

If ab_InclureTransport = True Then
    //On ajoute les code de transport
    ls_sql = "INSERT INTO " + ls_nom_table + "( NoProduit, NomProduit ) " + &
        "SELECT t_Transport.CodeTransport, t_Transport.NOM FROM t_Transport"
    EXECUTE IMMEDIATE :ls_sql USING SQLCA;
End If

If ab_InclureHEB = True Then
    //On ajoute les classe de produit d'HEB (19) actif
    ls_sql = "INSERT INTO " + ls_nom_table + " ( NoProduit, NomProduit ) " + &
        "SELECT t_Produit.NoProduit, t_Produit.NomProduit FROM t_Produit " +&
        "WHERE t_Produit.NoClasse = 19 AND t_Produit.actif = 1"
    EXECUTE IMMEDIATE :ls_sql USING SQLCA;
End If

//On ajoute les produits CIPQ
If lb_gedis = TRUE Then //Tous les produits
    ls_sql = "INSERT INTO " + ls_nom_table + " ( NoProduit, NomProduit ) " + &
        "SELECT t_Produit.NoProduit, t_Produit.NomProduit FROM t_Produit " + &
        "WHERE t_Produit.CodeHebergeur Is Null AND t_Produit.NoClasse <> 19 AND t_Produit.actif = 1"
    EXECUTE IMMEDIATE :ls_sql USING SQLCA;
Else
//	//Ajouter le produit "SM-G" (exception avec le crit$$HEX1$$e800$$ENDHEX$$re "-GS" pour d$$HEX1$$e900$$ENDHEX$$tecter les produits g$$HEX1$$e900$$ENDHEX$$dis)
//   ls_sql = "INSERT INTO " + ls_nom_table + " ( NoProduit, NomProduit ) SELECT t_Produit.NoProduit, t_Produit.NomProduit " + &
//        "FROM t_Produit WHERE t_Produit.NoProduit='SM-G'"
//   EXECUTE IMMEDIATE :ls_sql USING SQLCA;
   //Ne pas ajouter les produits G$$HEX1$$e900$$ENDHEX$$dis
   ls_sql = "INSERT INTO " + ls_nom_table + " ( NoProduit, NomProduit ) " + &
        "SELECT t_Produit.NoProduit, t_Produit.NomProduit FROM t_Produit " + &
        "WHERE Right(NoProduit,3) <> '-GS' AND t_Produit.CodeHebergeur Is Null " + &
		  "AND t_Produit.NoClasse <> 19 AND t_Produit.actif = 1"
   EXECUTE IMMEDIATE :ls_sql USING SQLCA;
END IF

lds_eleveur = CREATE n_ds

lds_eleveur.dataobject = "ds_eleveur_code_hebergeur"
lds_eleveur.of_setTransobject(SQLCA)
ll_nbrow = lds_eleveur.Retrieve(al_noeleveur)

FOR ll_cpt = 1 TO ll_nbrow
	
	ls_code = lds_eleveur.object.codehebergeur[ll_cpt]
	
	//V$$HEX1$$e900$$ENDHEX$$rifier si droit aux produits
	IF lds_eleveur.object.DroitProduit[ll_cpt] = 1 THEN
		

		//Tous les produits actifs de l'h$$HEX1$$e900$$ENDHEX$$bergeur sont s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$s
		ls_sql = "INSERT INTO " + ls_nom_table + " ( NoProduit, NomProduit ) " + &
					"SELECT t_Produit.NoProduit, t_Produit.NomProduit FROM t_Produit "

		IF lb_gedis = TRUE THEN
			ls_sql = ls_sql + "WHERE t_Produit.CodeHebergeur ='" + ls_code + &
				"' And t_Produit.actif = 1 and isNull(t_Produit.Multiplication, 0) = 0"
		Else
			ls_sql = ls_sql + "WHERE t_Produit.CodeHebergeur ='" + ls_code + &
				"' And t_Produit.actif = 1 And Right(NoProduit,3) <> '-GS'" + &
				" and isNull(t_Produit.Multiplication, 0) = 0"
		End If
		EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	End If

   //V$$HEX1$$e900$$ENDHEX$$rifier si droit aux produits de multiplication
	IF lds_eleveur.object.DroitMultiplication[ll_cpt] = 1 THEN
		 //Tous les produits de multiplication actifs de l'h$$HEX1$$e900$$ENDHEX$$bergeur sont s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$s
		 ls_sql = "INSERT INTO " + ls_nom_table + " ( NoProduit, NomProduit ) " + &
					"SELECT t_Produit.NoProduit, t_Produit.NomProduit FROM t_Produit "
		 
		 IF lb_gedis = TRUE THEN
			  ls_sql = ls_sql + "WHERE t_Produit.CodeHebergeur ='" + ls_code + &
			  "' And t_Produit.actif = 1 And t_Produit.Multiplication = 1 "
		 Else
			  ls_sql = ls_sql + "WHERE t_Produit.CodeHebergeur ='" + ls_code + &
			  "' And t_Produit.actif = 1 And t_Produit.Multiplication = 1 AND Right(NoProduit,3) <> '-GS'"
		 
		 End If
		 EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	END IF
	
END FOR

IF IsValid(lds_eleveur) THEN DESTROY(lds_eleveur)

COMMIT USING SQLCA;

ls_rtn = "SELECT DISTINCT NoProduit, NomProduit, null as no_classe, null as PrixUnitaire FROM " + ls_nom_table + " ORDER BY NoProduit"

RETURN ls_rtn
end function

public function boolean of_verifiersicommandeimprimee (string as_nocommande);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_verifiersicommandeimprimee
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		String - No de commande
//
//	Retourne:  		boolean 
//
// Description:	Fonction v$$HEX1$$e900$$ENDHEX$$rifier si une commande a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$imprim$$HEX1$$e900$$ENDHEX$$e
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-12-04	Mathieu Gendron	Cr$$HEX1$$e900$$ENDHEX$$ation
//
//////////////////////////////////////////////////////////////////////////////

long		ll_imprimer = 0

SELECT 	t_Commande.Imprimer INTO :ll_imprimer
FROM 		t_Commande
WHERE 	t_Commande.NoCommande=:as_nocommande USING SQLCA;

IF ll_imprimer = 1 THEN
	RETURN TRUE	
ELSE
	RETURN FALSE	
END IF

end function

public function boolean of_verifiersicommandetraitee (string as_nocommande);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_verifiersicommandetraitee
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		String - No de commande
//
//	Retourne:  		boolean 
//
// Description:	Fonction v$$HEX1$$e900$$ENDHEX$$rifier si une commande a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$e
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-12-04	Mathieu Gendron	Cr$$HEX1$$e900$$ENDHEX$$ation
//
//////////////////////////////////////////////////////////////////////////////

long		ll_traiter = 0

SELECT 	t_Commande.Traiter INTO :ll_traiter
FROM 		t_Commande
WHERE 	t_Commande.NoCommande=:as_nocommande USING SQLCA;

IF ll_traiter = 1 THEN
	RETURN TRUE	
ELSE
	RETURN FALSE	
END IF

end function

public function long of_findnbverratfamille (string as_famille);long	ll_nbverrat

If Len(as_famille) = 0 Then RETURN 0

SELECT 	Count(T_Verrat.CodeVerrat) AS NbVerrat  
INTO		:ll_nbverrat
FROM 		t_verrat, t_Verrat_Classe
WHERE 	t_Verrat_Classe.ClasseVerrat = T_Verrat.Classe AND
			(t_Verrat_Classe.Famille) = (:as_famille) AND t_Verrat.ELIMIN Is Null 
USING SQLCA;

RETURN ll_nbverrat
end function

public function long of_getnbdosesmoyenne ();long	ll_nbdoses


SELECT nbdosemoyenne INTO :ll_nbdoses FROM t_parametre;

return ll_nbdoses
end function

public subroutine of_updatechoix (n_ds ads_donnees);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_updatechoix
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		n_ds	- ads_donnees
//
//	Retourne:  		Rien
//
// Description:	Fonction pour changer les choix de l'ordre de saisie et
//						des z$$HEX1$$e900$$ENDHEX$$ros (les quantit$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ros indiquent les choix alternatifs)
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-12-5	Mathieu Gendron	Cr$$HEX1$$e900$$ENDHEX$$ation
//
//////////////////////////////////////////////////////////////////////////////

long	ll_cpt = 1, ll_mynoitem = 0, ll_mychoice, ll_myline, ll_rowcount, ll_qteinit, ll_qtecommande

//ll_cpt track les rang$$HEX1$$e900$$ENDHEX$$es
//ll_mychoice est incr$$HEX1$$e900$$ENDHEX$$ment$$HEX2$$e9002000$$ENDHEX$$seulement lors des changements de choix principaux

ll_rowcount = ads_donnees.RowCount()


//Faire le tour de tout ceux qui ne sont pas $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro
FOR ll_cpt = 1 TO ll_rowcount
	ll_mynoitem ++
	ll_mychoice = 1
	ll_qtecommande = ads_donnees.object.qtecommande[ll_cpt]
	
	IF ll_qtecommande <> 0 AND ISNull(ll_qtecommande) = FALSE THEN
		//Choix principal - Faire l'action
		ads_donnees.object.noligneheader[ll_cpt] = 0
		ads_donnees.object.choix[ll_cpt] = ll_mychoice
		ads_donnees.object.noitem[ll_cpt] = ll_mynoitem
	END IF
	
END FOR

ll_mynoitem = 0

IF ads_donnees.dataobject <> "d_commande_repetitive_item" THEN
	//Faire le tour des seconds ou troisi$$HEX1$$e800$$ENDHEX$$me choix etc.
	FOR ll_cpt = 1 TO ll_rowcount
		ll_qtecommande = ads_donnees.object.qtecommande[ll_cpt]
		IF ( ll_qtecommande = 0 OR ISNull(ll_qtecommande) ) AND ll_cpt <> 1 THEN
			//Choix secondaire et pas la premi$$HEX1$$e800$$ENDHEX$$re ligne - Faire l'action
			
			//R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le mychoice de la ligne pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente
			ll_mychoice = ads_donnees.object.choix[ll_cpt - 1]
			ll_mychoice ++
			ads_donnees.object.choix[ll_cpt] = ll_mychoice
			
			ll_mynoitem = ads_donnees.object.noitem[ll_cpt - 1]
			ads_donnees.object.noitem[ll_cpt] = ll_mynoitem
			
			ll_myline = ads_donnees.object.noligne[ll_cpt - 1]
			ads_donnees.object.noligneheader[ll_cpt] = ll_myline
			
		END IF
	END FOR
END IF

ads_donnees.Update(true, true)
commit using SQLCA;
end subroutine

public function string of_nextnolot ();
//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_nextnolot
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Le prochain no de lot
//
// Description:	Fonction pour setter le nouveau no de lot
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-21	Mathieu Gendron	Cr$$HEX1$$e900$$ENDHEX$$ation
//
//////////////////////////////////////////////////////////////////////////////
string		ls_nolot
datetime		ldt_today

ldt_today = datetime(Today())

SELECT 	FIRST nolot 
INTO		:ls_nolot
FROM 		t_NoLot 
WHERE 	daterepartition is null 
ORDER BY t_NoLot.Compteur ;

IF NOT IsNull(ls_nolot) THEN
	UPDATE 	t_nolot SET daterepartition = :ldt_today
	WHERE 	nolot = :ls_nolot;
END IF

RETURN ls_nolot

end function

public function long of_checknbrbilltoprint (string as_cie, long al_nocomm, string as_typeemballage, long al_qteemballage, boolean ab_statyes);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_CheckNbrBillToPrint
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		plein d'arguments ;)
//
//	Retourne:  		Nombre d'$$HEX1$$e900$$ENDHEX$$tiquettes
//
// Description:	Fonction pour calculer le nombre d'$$HEX1$$e900$$ENDHEX$$tiquettes $$HEX2$$e0002000$$ENDHEX$$imprimer
//						selon le type d'emballage
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-03-07	Mathieu Gendron	Cr$$HEX1$$e900$$ENDHEX$$ation
//
//////////////////////////////////////////////////////////////////////////////

long		ll_retour = 0, ll_QteTotal
dec		ldec_n
string	ls_nocomm

ls_nocomm = string(al_nocomm)
//qt$$HEX2$$e9002000$$ENDHEX$$total $$HEX2$$e0002000$$ENDHEX$$livrer
IF ab_StatYes = TRUE THEN
	SELECT 	Sum(T_StatFactureDetail.QTE_EXP) AS Quantite 
	INTO		:ll_QteTotal
	FROM 		T_StatFactureDetail INNER JOIN t_Produit ON T_StatFactureDetail.PROD_NO = t_Produit.NoProduit 
				WHERE T_StatFactureDetail.CIE_NO = :as_cie And t_StatFactureDetail.LIV_NO = :ls_nocomm And 
				t_Produit.Special = 1 And t_Produit.Type_Emballage = :as_typeemballage
				GROUP BY t_StatFactureDetail.CIE_NO, t_StatFactureDetail.LIV_NO	;
	
ELSE
	SELECT 	Sum(t_CommandeDetail.QteExpedie) AS Quantite 
	INTO		:ll_QteTotal
   FROM 		(t_CommandeDetail INNER JOIN t_Produit ON t_CommandeDetail.NoProduit = t_Produit.NoProduit) 
   INNER JOIN t_Commande ON (t_CommandeDetail.NoCommande = t_Commande.NoCommande) AND (t_CommandeDetail.CieNo = t_Commande.CieNo) 
   WHERE 	t_Produit.Special = 1 And t_Produit.Type_Emballage = :as_typeemballage
   GROUP BY t_Commande.NoBonExpe HAVING t_Commande.NoBonExpe = :ls_nocomm ;
	
END IF

IF Not IsNull(ll_QteTotal) AND ll_QteTotal > 0 THEN
	//Calcul du nombre d'$$HEX1$$e900$$ENDHEX$$tiquette selon le nombre de paquet n$$HEX1$$e900$$ENDHEX$$cessaire pour empaquetter les produits
	
	ldec_n = ll_QteTotal / al_qteemballage //Nombre de paquet n$$HEX1$$e900$$ENDHEX$$cessaire
	
	IF mod(ll_QteTotal, al_qteemballage) > 0 THEN
		//S'il reste des produits, on a besoin d'un paquet de plus
		ldec_n += 1		
	END IF
	
	//On a besoin d'un $$HEX1$$e900$$ENDHEX$$tiquette de moins (celui de l'impression du bon de livraison)
	ldec_n = INT(ldec_n) - 1
END IF

RETURN ldec_n
end function

public function string of_finddescprod (string as_noproduit, string as_noverrat);//of_FindDescProd

string	ls_retour, ls_null

SetNull(ls_null)

IF as_noproduit = "" THEN as_noproduit = ls_null
IF as_noverrat = "" THEN as_noverrat = ls_null

If IsNull(as_noproduit) AND IsNull(as_noverrat) THEN
	RETURN ""
END IF

IF NOT IsNull(as_noproduit) THEN
	SELECT FIRST t_Transport.NOM INTO :ls_retour 
	FROM t_Transport WHERE (t_Transport.CodeTransport) = (:as_noproduit) USING SQLCA;
	
	IF ls_retour = "" THEN SetNull(ls_retour)
	
	IF Not IsNull(ls_retour) THEN 
		RETURN ls_retour
	ELSE
		SELECT t_Produit.NomProduit INTO :ls_retour
		FROM t_Produit WHERE (t_Produit.NoProduit) = (:as_noproduit) USING SQLCA;

		RETURN ls_retour
	END IF
	
ELSE
	RETURN ""
END IF


RETURN TRIM(ls_retour)
end function

public function boolean of_chkifaffdesc (string as_noverrat);//of_ChkIfAffDesc

boolean	lb_retour = TRUE
string	ls_desc, ls_null
long		ll_count, ll_rtn

SetNull(ls_null)

If IsNull(as_noverrat) OR as_noverrat = "" THEN
	RETURN TRUE
END IF


SELECT 	count(1)
INTO		:ll_count
FROM 		T_Verrat
WHERE		(t_Verrat.CodeVerrat) = (:as_noverrat) ;

IF ll_count = 0 THEN RETURN TRUE

SELECT 	T_Verrat.Af_Desc 
INTO		:ll_rtn
FROM 		T_Verrat 
WHERE 	(t_Verrat.CodeVerrat) = (:as_noverrat) ;

IF ll_rtn = 1 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

public subroutine of_unlockall ();//of_unlockall
//Pour d$$HEX1$$e900$$ENDHEX$$barrer toute les commandes

IF gnv_app.inv_error.of_message("CIPQ0108") = 1 THEN
	
	//Faire le unlock
	UPDATE t_Commande SET Locked = 'C' ;
	COMMIT USING SQLCA;
	
	UPDATE	t_centrecipq 
	SET		punaise_open = 0;
	COMMIT USING SQLCA;
	
	gnv_app.inv_error.of_message("CIPQ0109")
END IF
end subroutine

public function boolean of_checkifprintopen ();//of_CheckIfPrintOpen

long 		ll_count, ll_nontransfere
string	ls_lockedby

//V$$HEX1$$e900$$ENDHEX$$rifier s'il y a des transferts pending
SELECT 	Count(t_CommandeDetail.NoProduit) AS CompteNoProduit 
INTO		:ll_nontransfere
FROM 		t_Commande 
INNER JOIN t_CommandeDetail 
			ON (t_Commande.NoCommande = t_CommandeDetail.NoCommande) 
			AND (t_Commande.CieNo = t_CommandeDetail.CieNo) 
WHERE 	date(t_Commande.DateCommande)= Date(today()) 
			AND t_CommandeDetail.TranName Is Null 
			AND t_CommandeDetail.Trans Is Not Null;

IF ll_nontransfere > 0 AND isnull(ll_nontransfere) = FALSE THEN
	Messagebox("Attention", "Vous devez tranf$$HEX1$$e900$$ENDHEX$$rer " + string(ll_nontransfere) + " ligne(s) de commande avant d'imprimer les bons de livraison.")
	RETURN TRUE
END IF


SELECT 	count(1)
INTO		:ll_count
FROM 		t_Commande 
WHERE 	t_Commande.Locked = 'P' ;

IF ll_count > 0 THEN
	//Est-ce qu'on peut savoir c'est qui
	SELECT 	FIRST lockedby
	INTO		:ls_lockedby
	FROM 		t_Commande
	WHERE 	t_Commande.Locked = 'P' ;
	
	IF IsNull(ls_lockedby) OR ls_lockedby = "" THEN
		Messagebox("Attention", "Un utilisateur utilise d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$l'impression.")
	ELSE
		Messagebox("Attention", "L'utilisateur suivant utilise d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$l'impression: " + ls_lockedby)
	END IF
	
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

public subroutine of_printunlock ();//of_printunlock

UPDATE t_Commande SET Locked = 'C' 
WHERE Locked = 'P' ;

COMMIT USING SQLCA;
end subroutine

public subroutine of_printlock ();//of_printlock

string	ls_user
ls_user = THIS.of_getuserid( )

UPDATE t_Commande SET Locked = 'P', lockedby = :ls_user 
WHERE Traiter = 1 AND Locked = 'C' AND date(datecommande) = date(today());

COMMIT USING SQLCA;


end subroutine

public function boolean of_checkiftraiteopen ();//of_CheckIfTraiteOpen

long		ll_count
string	ls_lockedby

SELECT 	count(1)
INTO		:ll_count
FROM 		t_Commande
WHERE 	t_Commande.Locked = 'T' ;

IF ll_count = 0 THEN
	RETURN FALSE
ELSE
	//Il y a d$$HEX1$$e900$$ENDHEX$$ja un utilisateur dans le Traitement des Commandes
	//Est-ce qu'on peut savoir c'est qui
	SELECT 	FIRST lockedby
	INTO		:ls_lockedby
	FROM 		t_Commande
	WHERE 	t_Commande.Locked = 'T' ;
	
	IF IsNull(ls_lockedby) OR ls_lockedby = "" THEN
		gnv_app.inv_error.of_message("CIPQ0111")
	ELSE
		Messagebox("Attention", "L'utilisateur suivant utilise d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$le traitement des commandes: " + ls_lockedby)
	END IF
	
	RETURN TRUE
END IF
end function

public function boolean of_checkifrepartopen ();//of_checkifrepartopen

long		ll_count
string	ls_lockedby

SELECT 	count(1)
INTO		:ll_count
FROM 		t_Commande
WHERE 	t_Commande.Locked = 'R' ;

IF ll_count = 0 THEN
	RETURN FALSE
ELSE
	//
	//Est-ce qu'on peut savoir c'est qui
	SELECT 	FIRST lockedby
	INTO		:ls_lockedby
	FROM 		t_Commande
	WHERE 	t_Commande.Locked = 'R' ;
	
	IF IsNull(ls_lockedby) OR ls_lockedby = "" THEN
		gnv_app.inv_error.of_message("CIPQ0111")
	ELSE
		Messagebox("Attention", "L'utilisateur suivant utilise d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$la r$$HEX1$$e900$$ENDHEX$$partition: " + ls_lockedby)
	END IF
	RETURN TRUE
END IF

RETURN TRUE
end function

public subroutine of_traitunlock ();// of_TraitUnLock

UPDATE t_Commande SET Locked = 'C' WHERE Locked = 'T' ;
COMMIT USING SQLCA;
end subroutine

public subroutine of_repartunlock ();//of_repartunlock

UPDATE t_Commande SET Locked = 'C' WHERE Locked = 'R' ;
COMMIT USING SQLCA;
end subroutine

public subroutine of_traitlock ();// of_TraitLock

string	ls_user
ls_user = THIS.of_getuserid( )

UPDATE t_Commande SET Locked = 'T', lockedby = :ls_user WHERE Locked = 'C' AND date(datecommande) = date(today());
COMMIT USING SQLCA;
end subroutine

public subroutine of_repartlock ();//of_repartlock

string	ls_user
ls_user = THIS.of_getuserid( )

UPDATE t_Commande SET Locked = 'R', lockedby = :ls_user WHERE Locked = 'C' AND date(datecommande) = date(today());
COMMIT USING SQLCA;
end subroutine

public function boolean of_chkiflockandlock (string as_orderno, boolean ab_tolock);//of_ChkIfLockAndLock

string	ls_locked, ls_null, ls_user
boolean	lb_return = FALSE

SetNull(ls_null)

SELECT 	t_Commande.Locked, t_Commande.Lockedby
INTO 		:ls_locked, :ls_user
FROM 		t_Commande 
WHERE 	t_Commande.NoCommande = :as_orderno ;

IF IsNull(ls_locked) THEN 
	ls_locked = ""
ELSE
	IF ab_Tolock = TRUE THEN
		
		IF ls_locked = "C" THEN
			UPDATE t_Commande SET Locked = :ls_null WHERE t_Commande.NoCommande = :as_orderno ;
			COMMIT USING SQLCA;
		END IF
		
	END IF
	
END IF

IF IsNull(ls_user) THEN ls_user = ""

CHOOSE CASE ls_locked
		
//	CASE ""
//		gnv_app.inv_error.of_message("CIPQ0112", {""})
//		RETURN TRUE
		
	CASE "R"
		gnv_app.inv_error.of_message("CIPQ0112", {"par la r$$HEX1$$e900$$ENDHEX$$partition, par " + ls_user})
		RETURN TRUE
		
	CASE "T"
		gnv_app.inv_error.of_message("CIPQ0112", {"par le traitement des commandes, par " + ls_user})
		RETURN TRUE
		
	CASE "P"
		gnv_app.inv_error.of_message("CIPQ0112", {"par l'impression, par " + ls_user})
		RETURN TRUE
		
END CHOOSE


RETURN FALSE
end function

public subroutine of_orderlock (string as_orderno);//of_OrderLock
string	ls_null

SetNull(ls_null)

UPDATE 	t_Commande SET t_Commande.Locked = :ls_null
WHERE 	NoCommande = :as_OrderNo ;

COMMIT USING SQLCA;
end subroutine

public subroutine of_orderunlock (string as_orderno);//of_OrderUnLock

UPDATE 	t_Commande SET t_Commande.Locked = 'C'
WHERE 	NoCommande = :as_OrderNo ;

COMMIT USING SQLCA;
end subroutine

public function long of_getnextlivno (string as_cie);//of_GetNextLivNo
//Changer le prochain no de livraison

long		ll_retour = -1 , ll_inscrit
string	ls_inscrit, ls_retour

SELECT 	nobonexpe 
INTO		:ls_retour
FROM 		t_centreCIPQ
WHERE		cie = :as_cie ;

If IsNull(ls_retour) THEN ls_retour = "0"

ll_retour = long(ls_retour)
ll_inscrit = ll_retour
ll_inscrit++
ls_inscrit = string(ll_inscrit)

UPDATE  	t_centreCIPQ SET nobonexpe = :ls_inscrit
WHERE		cie = :as_cie ;

COMMIT USING SQLCA;

IF SQLCA.SQLCode = 0 THEN
	RETURN ll_retour
ELSE
	RETURN -1
END IF
end function

public function string of_get_tps (string as_cie);string	ls_tps

SELECT no_enr_tps INTO :ls_tps FROM t_centrecipq WHERE cie = :as_cie;

RETURN ls_tps
end function

public function string of_get_tvq (string as_cie);string	ls_tvq

SELECT no_enr_tvq INTO :ls_tvq FROM t_centrecipq WHERE cie = :as_cie;

RETURN ls_tvq
end function

public function string of_getgroupefacturationaccpac (long al_no_eleveur, string as_cyclecode, string as_adesc, long al_typepayeur, string as_anomgroupsec, long al_nonpayeur, long al_pouraccpac);string	ls_retour

//Si PPA
If as_CycleCode = "PPA" Then
	IF al_PourAccPac = 0 THEN
		ls_retour = "PPA"
	ELSE
		ls_retour = '"      "'
	END IF
	RETURN ls_retour
End If

If IsNull(as_aDesc) Or Len(as_aDesc) = 0 Then //Si l'$$HEX1$$e900$$ENDHEX$$leveur n'a pas de groupe
	IF al_PourAccPac = 0 THEN
		SetNull(ls_retour)
	ELSE
		ls_retour = '"      "'
	END IF
	
ELSE
	CHOOSE CASE al_TypePayeur
		CASE 0 //Le client
			IF al_PourAccPac = 0 THEN
				SetNull(ls_retour)
			ELSE
				ls_retour = '"      "'
			END IF			
			
		CASE 1 //Le groupe
			IF al_PourAccPac = 0 THEN
				ls_retour = trim( LEFT(as_aDesc, 4))
			ELSE
				ls_retour = '"' + trim( LEFT(as_aDesc, 4)) + '  "'
			END IF					
			
			
		CASE 2 //Le sous-groupe
			
			CHOOSE CASE al_NonPayeur
					
				CASE 0 //Le sous-groupe est payeur
					IF al_PourAccPac = 0 THEN
						ls_retour = trim( LEFT(as_aNomGroupSec, 4))
					ELSE
						ls_retour = '"' + trim( LEFT(as_aNomGroupSec, 4)) + '  "'
					END IF						
					
				CASE 1 //Le sous-groupe n'est pas payeur
					IF al_PourAccPac = 0 THEN
						SetNull(ls_retour)
					ELSE
						ls_retour = '"      "'
					END IF					
					
					
			END CHOOSE
			
	END CHOOSE
	
END IF

RETURN ls_retour
end function

public subroutine of_appdroits (menu am_menu);long ll_cnt, ll_idx
string ls_name

SetPointer ( HourGlass! )

if not isValid(am_menu) then return

if pos(am_menu.tag, "exclure_securite") > 0 then return

// get the class it self
ls_name = lower(classname(am_menu))

select count(1)
  into :ll_cnt
  from t_droitsusagers
 where (id_user = :il_id_user
		 or id_user in (select id_group
								from t_groupeusager
							  where id_user = :il_id_user))
	and objet = :ls_name;
	

if ll_cnt > 0 or inv_string.of_isFormat(am_menu.text) or am_menu.text = "" then
	am_menu.enabled = true
	am_menu.visible = true
else
	am_menu.enabled = false
	am_menu.visible = false
end if

// see how many objects to be scaned
ll_cnt = UpperBound(am_menu.Item)
// get the controls on the object
For ll_idx = 1 To ll_cnt
	of_appDroits(am_menu.Item[ll_idx])
Next

end subroutine

public function integer of_setjournal (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_SetJournal
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		ab_switch		
//						True - active (create) le service,
//						False - d$$HEX1$$e900$$ENDHEX$$sactive (destroy) le service
//
// Retourne:  		Integer
//						 1 - r$$HEX1$$e900$$ENDHEX$$ussi
//						 0 - aucune action ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$e
//						-1 - Une erreur s'est produite
//
//
//	Description:	Active ou d$$HEX1$$e900$$ENDHEX$$sactive le service d'impression du journal de commandes
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

//V$$HEX1$$e900$$ENDHEX$$rifier l'argument
If IsNull(ab_switch) Then
	Return -1
End if

IF ab_Switch THEN
	IF IsNull(inv_journal) Or Not IsValid (inv_journal) THEN
		inv_journal = CREATE n_cst_Journal
		Return 1
	END IF
ELSE
	IF IsValid (inv_journal) THEN
		DESTROY inv_journal
		Return 1
	END IF	
END IF

Return 0
end function

public subroutine of_dolistemale (date ad_debut);//of_DoListeMale

long ll_nb
string ls_sql

// Cr$$HEX1$$e900$$ENDHEX$$er ou vider #Tmp_recolte, #Tmp_MaleRecolte et #Tmp_Recolte_ValiderDelai
select count(1) into :ll_nb from #Tmp_recolte;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_recolte (norecolte integer not null,~r~n" + &
													"cie_no varchar(3) not null,~r~n" + &
													"codeverrat varchar(12) not null,~r~n" + &
													"date_recolte datetime null,~r~n" + &
													"volume double null,~r~n" + &
													"absorbance double null,~r~n" + &
													"ampo_total double null,~r~n" + &
													"ampo_faite double null,~r~n" + &
													"type_sem varchar(1) null,~r~n" + &
													"pourc_dechets double null,~r~n" + &
													"prepose integer null,~r~n" + &
													"jeudi varchar(1) null,~r~n" + &
													"concentration double null,~r~n" + &
													"nbr_sperm integer null,~r~n" + &
													"transdate datetime null,~r~n" + &
													"heure_recolte datetime null,~r~n" + &
													"classe varchar(20) null,~r~n" + &
													"motilite_p integer null,~r~n" + &
													"collectis bit null,~r~n" + &
													"exclusif bit null,~r~n" + &
													"gedis bit null,~r~n" + &
													"validation bit null,~r~n" + &
													"heure_analyse datetime null,~r~n" + &
													"ancien_codeverrat varchar(12) null,~r~n" + &
													"heure_edition datetime null,~r~n" + &
													"messagerecolte varchar(150) null,~r~n" + &
													"compteurpunch integer null,~r~n" + &
													"preplaboid integer null,~r~n" + &
													"emplacement varchar(6) null,~r~n" + &
													"type_exclu smallint null,~r~n" + &
													"primary key (norecolte, cie_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ai_rec on #Tmp_recolte (norecolte asc,~r~n" + &
																 "cie_no asc,~r~n" + &
																 "codeverrat asc,~r~n" + &
																 "date_recolte asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create clustered index ai_rec_v on #Tmp_recolte (codeverrat asc,~r~n" + &
																				 "date_recolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create unique index ix_heure on #Tmp_recolte (norecolte asc,~r~n" + &
																			 "cie_no asc,~r~n" + &
																			 "date_recolte desc,~r~n" + &
																			 "heure_recolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_12_4 on #Tmp_recolte (codeverrat asc,~r~n" + &
																	"exclusif asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_fdsfds_2 on #Tmp_recolte (date_recolte desc,~r~n" + &
																		 "norecolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil_4 on #Tmp_recolte (date_recolte asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil1_1 on #Tmp_recolte (cie_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil1_2 on #Tmp_recolte (codeverrat asc,~r~n" + &
																		"cie_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_recolte;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Tmp_MaleRecolte;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_MaleRecolte (norecolte integer not null,~r~n" + &
													"cie_no varchar(3) not null,~r~n" + &
													"codeverrat varchar(12) not null,~r~n" + &
													"date_recolte datetime null,~r~n" + &
													"volume double null,~r~n" + &
													"absorbance double null,~r~n" + &
													"ampo_total double null,~r~n" + &
													"ampo_faite double null,~r~n" + &
													"type_sem varchar(1) null,~r~n" + &
													"pourc_dechets double null,~r~n" + &
													"prepose integer null,~r~n" + &
													"jeudi varchar(1) null,~r~n" + &
													"concentration double null,~r~n" + &
													"nbr_sperm integer null,~r~n" + &
													"transdate datetime null,~r~n" + &
													"heure_recolte datetime null,~r~n" + &
													"classe varchar(20) null,~r~n" + &
													"motilite_p integer null,~r~n" + &
													"collectis bit null,~r~n" + &
													"exclusif bit null,~r~n" + &
													"gedis bit null,~r~n" + &
													"validation bit null,~r~n" + &
													"heure_analyse datetime null,~r~n" + &
													"ancien_codeverrat varchar(12) null,~r~n" + &
													"heure_edition datetime null,~r~n" + &
													"messagerecolte varchar(150) null,~r~n" + &
													"compteurpunch integer null,~r~n" + &
													"preplaboid integer null,~r~n" + &
													"emplacement varchar(6) null,~r~n" + &
													"type_exclu smallint null,~r~n" + &
													"primary key (norecolte, cie_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ai_rec on #Tmp_MaleRecolte (norecolte asc,~r~n" + &
																	  "cie_no asc,~r~n" + &
																	  "codeverrat asc,~r~n" + &
																	  "date_recolte asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create clustered index ai_rec_v on #Tmp_MaleRecolte (codeverrat asc,~r~n" + &
																					  "date_recolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create unique index ix_heure on #Tmp_MaleRecolte (norecolte asc,~r~n" + &
																				  "cie_no asc,~r~n" + &
																				  "date_recolte desc,~r~n" + &
																				  "heure_recolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_12_4 on #Tmp_MaleRecolte (codeverrat asc,~r~n" + &
																		 "exclusif asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_fdsfds_2 on #Tmp_MaleRecolte (date_recolte desc,~r~n" + &
																			  "norecolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil_4 on #Tmp_MaleRecolte (date_recolte asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil1_1 on #Tmp_MaleRecolte (cie_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil1_2 on #Tmp_MaleRecolte (codeverrat asc,~r~n" + &
																			 "cie_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_MaleRecolte;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Tmp_Recolte_ValiderDelai;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_Recolte_ValiderDelai (codeverrat varchar(12) not null,~r~n" + &
													"date_valider datetime null,~r~n" + &
													"delai bit null,~r~n" + &
													"primary key (codeverrat))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create clustered index ix1 on #Tmp_Recolte_ValiderDelai (codeverrat asc,~r~n" + &
																							"date_valider asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_Recolte_ValiderDelai;
	commit using sqlca;
end if

//Premi$$HEX1$$e800$$ENDHEX$$re extraction: Liste des verrats r$$HEX1$$e900$$ENDHEX$$colt$$HEX1$$e900$$ENDHEX$$s dans les 3 derniers mois
INSERT INTO #Tmp_MaleRecolte ( NoRecolte, CIE_NO, CodeVerrat, TYPE_SEM, AMPO_TOTAL, DATE_recolte, Classe ) 
SELECT t_RECOLTE.NoRecolte, t_RECOLTE.CIE_NO, t_RECOLTE.CodeVerrat, t_RECOLTE.TYPE_SEM, t_RECOLTE.AMPO_TOTAL, t_RECOLTE.DATE_recolte, t_RECOLTE.Classe 
FROM t_RECOLTE 
WHERE t_RECOLTE.CodeVerrat Is not Null AND date(t_RECOLTE.DATE_recolte) >= DateAdd(month,-3,:ad_debut) 
And date(t_RECOLTE.DATE_recolte) <= :ad_debut ;
COMMIT USING SQLCA;

//Extraction secondaire: Liste des verrats avec les info de leur derni$$HEX1$$e800$$ENDHEX$$re r$$HEX1$$e900$$ENDHEX$$colte
INSERT INTO #Tmp_recolte ( CIE_NO, CodeVerrat, NoRecolte ) 
SELECT #Tmp_MaleRecolte.CIE_NO, 
#Tmp_MaleRecolte.CodeVerrat,
( select max(norecolte) from #Tmp_MaleRecolte a
WHERE #Tmp_MaleRecolte.CIE_NO = a.CIE_NO and #Tmp_MaleRecolte.CodeVerrat = a.CodeVerrat 
AND norecolte is not null) AS NoRecolte 
FROM #Tmp_MaleRecolte
WHERE #Tmp_MaleRecolte.CodeVerrat is not null
GROUP BY #Tmp_MaleRecolte.CIE_NO, #Tmp_MaleRecolte.CodeVerrat ;
COMMIT USING SQLCA;

//Supprimer les verrats $$HEX1$$e900$$ENDHEX$$limin$$HEX1$$e900$$ENDHEX$$s
DELETE FROM #Tmp_recolte 
FROM t_Verrat WHERE (#Tmp_recolte.CodeVerrat = t_Verrat.CodeVerrat) AND (#Tmp_recolte.CIE_NO = t_Verrat.CIE_NO) 
AND ((Not (t_Verrat.ELIMIN) Is Null)) ;
COMMIT USING SQLCA;

//Mise $$HEX2$$e0002000$$ENDHEX$$jour des autres champs
UPDATE #Tmp_recolte INNER JOIN #Tmp_MaleRecolte ON (#Tmp_recolte.CIE_NO = #Tmp_MaleRecolte.CIE_NO) AND (#Tmp_recolte.NoRecolte = #Tmp_MaleRecolte.NoRecolte) 
SET #Tmp_recolte.DATE_recolte = #Tmp_MaleRecolte.DATE_recolte, #Tmp_recolte.AMPO_TOTAL = #Tmp_MaleRecolte.AMPO_TOTAL, #Tmp_recolte.TYPE_SEM = #Tmp_MaleRecolte.TYPE_SEM, #Tmp_recolte.Classe = #Tmp_MaleRecolte.Classe ;
COMMIT USING SQLCA;
       
//Mise $$HEX2$$e0002000$$ENDHEX$$jour des classes qui sont vides (par oubli ou centre 114 pas mis $$HEX2$$e0002000$$ENDHEX$$jour)
UPDATE #Tmp_recolte INNER JOIN t_Verrat ON (#Tmp_recolte.CodeVerrat = t_Verrat.CodeVerrat) AND (#Tmp_recolte.CIE_NO = t_Verrat.CIE_NO) 
SET #Tmp_recolte.Classe = t_Verrat.Classe 
WHERE (((#Tmp_recolte.Classe) Is Null));
COMMIT USING SQLCA;

//Permet de rechercher, apr$$HEX1$$e800$$ENDHEX$$s supression, la r$$HEX1$$e900$$ENDHEX$$colte pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent la derni$$HEX1$$e800$$ENDHEX$$re r$$HEX1$$e900$$ENDHEX$$colte
DELETE FROM #Tmp_MaleRecolte 
FROM #Tmp_recolte 
WHERE (#Tmp_MaleRecolte.CIE_NO = #Tmp_recolte.CIE_NO) AND (#Tmp_MaleRecolte.NoRecolte = #Tmp_recolte.NoRecolte) ;
COMMIT USING SQLCA;
end subroutine

public function integer of_getdelai (string as_codeverrat, date ad_cur);//of_getdelai

string	ls_sous_groupe
long		ll_nb_jours

SELECT 	sous_groupe
INTO		:ls_sous_groupe
FROM		T_Verrat
WHERE		(codeverrat) = (:as_codeverrat) ;


IF IsNull(ls_sous_groupe) OR ls_sous_groupe = "" THEN
	ll_nb_jours = 2
ELSE
	SELECT 	JourDelai
	INTO		:ll_nb_jours
	FROM		t_Verrat_SousGroupe
	WHERE		(t_Verrat_SousGroupe.sous_groupe) = (:ls_sous_groupe) ;
	
END IF

IF IsNull(ll_nb_jours) OR ll_nb_jours = 0 THEN
	RETURN 0
END IF

//V$$HEX1$$e900$$ENDHEX$$rifier si la diff$$HEX1$$e900$$ENDHEX$$rence entre aujourd'hui et la derni$$HEX1$$e800$$ENDHEX$$re r$$HEX1$$e900$$ENDHEX$$colte est sup$$HEX1$$e900$$ENDHEX$$rieur ou $$HEX1$$e900$$ENDHEX$$gal au nombre de jour de d$$HEX1$$e900$$ENDHEX$$lai
IF RelativeDate(ad_cur, ll_nb_jours) > date(today()) THEN
	RETURN 0
END IF

RETURN 1
end function

public subroutine of_valider_qte_malerecolte (string as_cie, string as_famille, date ad_cur);//of_Valider_Qte_MaleRecolte

long	ll_qte = 0, ll_qte01, ll_qte02, ll_qte03, ll_qte04, ll_qte05, ll_qte06, ll_dow

ll_dow = DayNumber(ad_cur)

//Trouver le nombre de verrat $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$colter pour ce centre et pour cette famille selon la journ$$HEX1$$e900$$ENDHEX$$e de la semaine
SELECT 	quantite_01, quantite_02, quantite_03, quantite_04, quantite_05, quantite_06
INTO		:ll_qte01, :ll_qte02, :ll_qte03, :ll_qte04, :ll_qte05, :ll_qte06
FROM		t_Verrat_Famille_Frequence_Recolte
WHERE		Famille = :as_famille AND cie_no = :as_cie ;

CHOOSE CASE ll_dow
	CASE 1
		ll_qte = ll_qte01
	CASE 2
		ll_qte = ll_qte02
	CASE 3
		ll_qte = ll_qte03
	CASE 4
		ll_qte = ll_qte04
	CASE 5
		ll_qte = ll_qte05
	CASE 6
		ll_qte = ll_qte06
END CHOOSE

IF ll_qte = 0 THEN RETURN 

//Mettre autant de "validation" que de verrats $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$colter

n_ds		lds_tmp_recolte_validation
long		ll_rowcount, ll_cpt

lds_tmp_recolte_validation = CREATE n_ds
lds_tmp_recolte_validation.dataobject = "ds_tmp_recolte_validation"
lds_tmp_recolte_validation.of_setTransobject(SQLCA)
ll_rowcount = lds_tmp_recolte_validation.Retrieve(as_cie, as_famille)

FOR ll_cpt = 1 TO ll_qte
//FOR ll_cpt = 1 TO ll_rowcount
	IF ll_cpt > ll_rowcount THEN EXIT
	
	lds_tmp_recolte_validation.object.validation[ll_cpt] = 1
END FOR
lds_tmp_recolte_validation.update(true,true)
If IsValid(lds_tmp_recolte_validation) THEN Destroy(lds_tmp_recolte_validation)

end subroutine

public subroutine of_doepurerlistemale (date ad_cur);//of_doepurerlistemale

//Conserver uniquement selon la table "t_Verrat_Famille_Frequence_Recolte"
//Pour chaque centre list$$HEX2$$e9002000$$ENDHEX$$dans la table "#Tmp_Recolte"

n_ds		lds_tmp_recolte_cie, lds_tmp_recolte_famille
long		ll_rowcountcie, ll_cptcie, ll_rowcountfamille, ll_cptfamille
string	ls_cie, ls_famille

lds_tmp_recolte_cie = CREATE n_ds
lds_tmp_recolte_cie.dataobject = "ds_tmp_recolte_cie"
lds_tmp_recolte_cie.of_setTransobject(SQLCA)
ll_rowcountcie = lds_tmp_recolte_cie.Retrieve()

lds_tmp_recolte_famille = CREATE n_ds
lds_tmp_recolte_famille.dataobject = "ds_tmp_recolte_famille"
lds_tmp_recolte_famille.of_setTransobject(SQLCA)

FOR ll_cptcie = 1 TO ll_rowcountcie
	ls_cie = lds_tmp_recolte_cie.object.cie_no[ll_cptcie]
	
	//Lister les familles $$HEX2$$e0002000$$ENDHEX$$valider
	
	ll_rowcountfamille = lds_tmp_recolte_famille.Retrieve(ls_cie)
	
	FOR ll_cptfamille = 1 TO ll_rowcountfamille
		//Pour chaque famille, valider les verrats r$$HEX1$$e900$$ENDHEX$$coltables
		ls_famille = lds_tmp_recolte_famille.object.famille[ll_cptfamille]
		
		THIS.of_valider_qte_malerecolte( ls_cie, ls_famille, ad_cur)
	END FOR
	
END FOR

IF IsValid(lds_tmp_recolte_cie) THEN Destroy(lds_tmp_recolte_cie)
IF IsValid(lds_tmp_recolte_famille) THEN Destroy(lds_tmp_recolte_famille)

//Supprimer de la table les verrats non-valid$$HEX1$$e900$$ENDHEX$$
DELETE FROM #Tmp_Recolte WHERE #Tmp_Recolte.Validation = 0 or #Tmp_Recolte.Validation is null;
COMMIT USING SQLCA;
end subroutine

public function integer of_getdelaitocome (string as_codeverrat, date ad_cur, date ad_de);//of_getdelaitocome

string	ls_sous_groupe
long		ll_nb_jours

SELECT 	sous_groupe
INTO		:ls_sous_groupe
FROM		T_Verrat
WHERE		(codeverrat) = (:as_codeverrat) ;


IF IsNull(ls_sous_groupe) OR ls_sous_groupe = "" THEN
	ll_nb_jours = 2
ELSE
	SELECT 	JourDelai
	INTO		:ll_nb_jours
	FROM		t_Verrat_SousGroupe
	WHERE		(t_Verrat_SousGroupe.sous_groupe) = (:ls_sous_groupe) ;
	
END IF

IF IsNull(ll_nb_jours) OR ll_nb_jours = 0 THEN
	RETURN 0
END IF

//V$$HEX1$$e900$$ENDHEX$$rifier si la diff$$HEX1$$e900$$ENDHEX$$rence entre "DateRecolte" et la derni$$HEX1$$e800$$ENDHEX$$re r$$HEX1$$e900$$ENDHEX$$colte est sup$$HEX1$$e900$$ENDHEX$$rieur ou $$HEX1$$e900$$ENDHEX$$gal au nombre de jour de d$$HEX1$$e900$$ENDHEX$$lai
IF RelativeDate(ad_cur, ll_nb_jours) > ad_de THEN
	RETURN 0
END IF

RETURN 1
end function

public function string of_finddescriptionproduct (string as_produit, string as_verrat, string as_code_hebergeur);string	ls_retour
long		ll_noclasse
IF ( IsNull(as_produit) OR as_produit = "") THEN
	RETURN ""
END IF


SELECT 	FIRST t_Transport.NOM INTO :ls_retour 
FROM 		t_Transport 
WHERE 	t_Transport.CodeTransport = :as_produit ;

IF IsNull(ls_retour) OR ls_retour = "" THEN
	
	SELECT 	t_Produit.NomProduit, t_produit.noclasse INTO :ls_retour, :ll_noclasse
	FROM 		t_Produit 
	WHERE 	t_Produit.NoProduit = :as_produit ;
	
	IF ll_noclasse = 9 THEN
		RETURN ""
	END IF
		
END IF

RETURN ls_retour
end function

public function string of_tofindproduct (string as_produit, string as_verrat, string as_code_hebergeur);string	ls_retour = "", ls_emballage
long		ll_noclasse

If IsNull(as_produit) And IsNull(as_verrat) Then RETURN""


If Not IsNull(as_produit) Then
	
	SELECT 	t_Produit.noclasse, t_produit.Type_Emballage
	INTO		:ll_noclasse, :ls_emballage
	FROM 		t_Produit 
	WHERE 	t_Produit.NoProduit = :as_produit ;
    
	//Voir si classe 9 Location
   If ll_noclasse = 9 Then
		//Description abr$$HEX1$$e900$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$e(Type d'emballage)
		ls_retour = ls_emballage
	Else
		ls_retour = as_produit
	End If

End If


RETURN ls_retour
end function

public subroutine of_domoyenneexptransporteur (date ad_debut);//of_DoMoyenneExpTransporteur
long ll_nb
string ls_sql

//Vider #Temp_MoyenneExpSectTransp
select count(1) into :ll_nb from #Temp_MoyenneExpSectTransp;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_MoyenneExpSectTransp (cie_no varchar(3) not null,~r~n" + &
																	  "prod_no varchar(16) not null,~r~n" + &
																	  "semaine1 integer null,~r~n" + &
																	  "semaine2 integer null,~r~n" + &
																	  "semaine3 integer null,~r~n" + &
																	  "semaine4 integer null,~r~n" + &
																	  "semaine5 integer null,~r~n" + &
																	  "semaine6 integer null,~r~n" + &
																	  "primary key (cie_no, prod_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Temp_MoyenneExpSectTransp;
	commit using sqlca;
end if

//Vider tables d'extractions (#temp_moy_exp_tra_statfacture et #temp_moy_exp_tra_statfactureDetail)
gnv_app.of_Cree_TableFact_Temp("temp_moy_exp_tra_statfacture")

//Premi$$HEX1$$e800$$ENDHEX$$re extraction
INSERT INTO #temp_moy_exp_tra_statfacture SELECT t_statfacture.* 
	FROM t_statfacture INNER JOIN #Temp_Transporteur ON t_statfacture.IDTransporteur = #Temp_Transporteur.IDTransporteur 
	WHERE date(t_statfacture.LIV_DATE) >= dateadd(day, -42,:ad_debut) And date(t_statfacture.LIV_DATE) <= dateadd(day, -7,:ad_debut) ;

    
//#temp_moy_exp_tra_statfactureDetail
INSERT INTO #temp_moy_exp_tra_statfactureDetail SELECT t_statfactureDetail.* 
	FROM #temp_moy_exp_tra_statfacture INNER JOIN t_statfactureDetail 
	ON (#temp_moy_exp_tra_statfacture.LIV_NO = t_statfactureDetail.LIV_NO) 
	AND (#temp_moy_exp_tra_statfacture.CIE_NO = t_statfactureDetail.CIE_NO)
Commit using SQLCA;

//Remplir
//Ajout semaine 1
INSERT INTO #Temp_MoyenneExpSectTransp ( CIE_NO, PROD_NO, Semaine1 ) 
    SELECT #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO, Sum(#temp_moy_exp_tra_statfactureDetail.QTE_EXP) AS SommeDeQTE_EXP 
    FROM #temp_moy_exp_tra_statfacture INNER JOIN (t_Produit INNER JOIN #temp_moy_exp_tra_statfactureDetail 
	 ON t_Produit.NoProduit = #temp_moy_exp_tra_statfactureDetail.PROD_NO) 
	 ON (#temp_moy_exp_tra_statfacture.LIV_NO = #temp_moy_exp_tra_statfactureDetail.LIV_NO) 
	 AND (#temp_moy_exp_tra_statfacture.CIE_NO = #temp_moy_exp_tra_statfactureDetail.CIE_NO) 
    WHERE date(#temp_moy_exp_tra_statfacture.LIV_DATE) = dateadd(day, -7,:ad_debut) And t_Produit.Special = 1
    GROUP BY #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO 
    HAVING SommeDeQTE_EXP <> 0 ;
Commit using SQLCA;


//MAJ semaine 2
select count(1) into :ll_nb from #Temp_MoyenneExpSectTransp_MAJ;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_MoyenneExpSectTransp_MAJ (cie_no varchar(3) not null,~r~n" + &
																			"prod_no varchar(16) not null,~r~n" + &
																			"qte_exp numeric(30,6) null,~r~n" + &
																			"primary key (cie_no, prod_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	DELETE FROM #Temp_MoyenneExpSectTransp_MAJ;
	Commit using SQLCA;
end if

INSERT INTO #Temp_MoyenneExpSectTransp_MAJ ( CIE_NO, PROD_NO, qte_exp)
SELECT #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO, Sum(#temp_moy_exp_tra_statfactureDetail.QTE_EXP) AS sommedeQTE_EXP 
    FROM #temp_moy_exp_tra_statfacture INNER JOIN (t_Produit INNER JOIN #temp_moy_exp_tra_statfactureDetail 
	 ON t_Produit.NoProduit = #temp_moy_exp_tra_statfactureDetail.PROD_NO) 
	 ON (#temp_moy_exp_tra_statfacture.LIV_NO = #temp_moy_exp_tra_statfactureDetail.LIV_NO) 
	 AND (#temp_moy_exp_tra_statfacture.CIE_NO = #temp_moy_exp_tra_statfactureDetail.CIE_NO) 
    WHERE date(#temp_moy_exp_tra_statfacture.LIV_DATE) = dateadd(day, -14,:ad_debut) And t_Produit.Special = 1
    GROUP BY #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO 
    HAVING sommedeQTE_EXP <> 0 ;
Commit using SQLCA;

UPDATE #Temp_MoyenneExpSectTransp_MAJ INNER JOIN #Temp_MoyenneExpSectTransp 
	ON (#Temp_MoyenneExpSectTransp_MAJ.CIE_NO = #Temp_MoyenneExpSectTransp.CIE_NO) 
	AND (#Temp_MoyenneExpSectTransp_MAJ.PROD_NO = #Temp_MoyenneExpSectTransp.PROD_NO) 
   SET #Temp_MoyenneExpSectTransp.Semaine2 = QTE_EXP ;
Commit using SQLCA;

//Ajout semaine 2
INSERT INTO #Temp_MoyenneExpSectTransp ( CIE_NO, PROD_NO, Semaine2 ) 
    SELECT #Temp_MoyenneExpSectTransp_MAJ.CIE_NO, #Temp_MoyenneExpSectTransp_MAJ.PROD_NO, #Temp_MoyenneExpSectTransp_MAJ.QTE_EXP 
    FROM #Temp_MoyenneExpSectTransp_MAJ LEFT JOIN #Temp_MoyenneExpSectTransp 
	 ON (#Temp_MoyenneExpSectTransp_MAJ.CIE_NO = #Temp_MoyenneExpSectTransp.CIE_NO) 
	 AND (#Temp_MoyenneExpSectTransp_MAJ.PROD_NO = #Temp_MoyenneExpSectTransp.PROD_NO) 
    WHERE (((#Temp_MoyenneExpSectTransp.CIE_NO) Is Null) AND ((#Temp_MoyenneExpSectTransp.PROD_NO) Is Null));
Commit using SQLCA;

//MAJ semaine 3
DELETE FROM #Temp_MoyenneExpSectTransp_MAJ;
Commit using SQLCA;

INSERT INTO #Temp_MoyenneExpSectTransp_MAJ ( CIE_NO, PROD_NO, qte_exp)
SELECT #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO, Sum(#temp_moy_exp_tra_statfactureDetail.QTE_EXP) AS sommeQTE_EXP  
    FROM #temp_moy_exp_tra_statfacture INNER JOIN (t_Produit INNER JOIN #temp_moy_exp_tra_statfactureDetail 
	 ON t_Produit.NoProduit = #temp_moy_exp_tra_statfactureDetail.PROD_NO) 
	 ON (#temp_moy_exp_tra_statfacture.LIV_NO = #temp_moy_exp_tra_statfactureDetail.LIV_NO) 
	 AND (#temp_moy_exp_tra_statfacture.CIE_NO = #temp_moy_exp_tra_statfactureDetail.CIE_NO) 
    WHERE date(#temp_moy_exp_tra_statfacture.LIV_DATE) = dateadd(day, -21,:ad_debut) And t_Produit.Special = 1
    GROUP BY #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO 
    HAVING sommeQTE_EXP <> 0;
Commit using SQLCA;

UPDATE #Temp_MoyenneExpSectTransp_MAJ INNER JOIN #Temp_MoyenneExpSectTransp 
ON (#Temp_MoyenneExpSectTransp_MAJ.CIE_NO = #Temp_MoyenneExpSectTransp.CIE_NO)
AND (#Temp_MoyenneExpSectTransp_MAJ.PROD_NO = #Temp_MoyenneExpSectTransp.PROD_NO) 
    SET #Temp_MoyenneExpSectTransp.Semaine3 = QTE_EXP;
Commit using SQLCA;
       
//Ajout semaine 3
INSERT INTO #Temp_MoyenneExpSectTransp ( CIE_NO, PROD_NO, Semaine3 ) 
    SELECT #Temp_MoyenneExpSectTransp_MAJ.CIE_NO, #Temp_MoyenneExpSectTransp_MAJ.PROD_NO, #Temp_MoyenneExpSectTransp_MAJ.QTE_EXP 
    FROM #Temp_MoyenneExpSectTransp_MAJ LEFT JOIN #Temp_MoyenneExpSectTransp 
	 ON (#Temp_MoyenneExpSectTransp_MAJ.CIE_NO = #Temp_MoyenneExpSectTransp.CIE_NO) 
	 AND (#Temp_MoyenneExpSectTransp_MAJ.PROD_NO = #Temp_MoyenneExpSectTransp.PROD_NO) 
    WHERE (((#Temp_MoyenneExpSectTransp.CIE_NO) Is Null) AND ((#Temp_MoyenneExpSectTransp.PROD_NO) Is Null));
Commit using SQLCA;

      
//MAJ semaine 4
DELETE FROM #Temp_MoyenneExpSectTransp_MAJ;
Commit using SQLCA;

INSERT INTO #Temp_MoyenneExpSectTransp_MAJ ( CIE_NO, PROD_NO, qte_exp)
SELECT #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO, Sum(#temp_moy_exp_tra_statfactureDetail.QTE_EXP) AS sommeQTE_EXP 
    FROM #temp_moy_exp_tra_statfacture INNER JOIN (t_Produit INNER JOIN #temp_moy_exp_tra_statfactureDetail 
	 ON t_Produit.NoProduit = #temp_moy_exp_tra_statfactureDetail.PROD_NO) 
	 ON (#temp_moy_exp_tra_statfacture.LIV_NO = #temp_moy_exp_tra_statfactureDetail.LIV_NO) 
	 AND (#temp_moy_exp_tra_statfacture.CIE_NO = #temp_moy_exp_tra_statfactureDetail.CIE_NO) 
    WHERE date(#temp_moy_exp_tra_statfacture.LIV_DATE) = dateadd(day, -28,:ad_debut) And t_Produit.Special = 1 
    GROUP BY #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO 
    HAVING sommeQTE_EXP <> 0;
Commit using SQLCA;

UPDATE #Temp_MoyenneExpSectTransp_MAJ INNER JOIN #Temp_MoyenneExpSectTransp 
ON (#Temp_MoyenneExpSectTransp_MAJ.CIE_NO = #Temp_MoyenneExpSectTransp.CIE_NO) 
AND (#Temp_MoyenneExpSectTransp_MAJ.PROD_NO = #Temp_MoyenneExpSectTransp.PROD_NO) 
    SET #Temp_MoyenneExpSectTransp.Semaine4 = QTE_EXP;
Commit using SQLCA;

//Ajout semaine 4
INSERT INTO #Temp_MoyenneExpSectTransp ( CIE_NO, PROD_NO, Semaine4 ) 
    SELECT #Temp_MoyenneExpSectTransp_MAJ.CIE_NO, #Temp_MoyenneExpSectTransp_MAJ.PROD_NO, #Temp_MoyenneExpSectTransp_MAJ.QTE_EXP 
    FROM #Temp_MoyenneExpSectTransp_MAJ LEFT JOIN #Temp_MoyenneExpSectTransp 
	 ON (#Temp_MoyenneExpSectTransp_MAJ.CIE_NO = #Temp_MoyenneExpSectTransp.CIE_NO) 
	 AND (#Temp_MoyenneExpSectTransp_MAJ.PROD_NO = #Temp_MoyenneExpSectTransp.PROD_NO) 
    WHERE (((#Temp_MoyenneExpSectTransp.CIE_NO) Is Null) AND ((#Temp_MoyenneExpSectTransp.PROD_NO) Is Null));
Commit using SQLCA;


//MAJ semaine 5
DELETE FROM #Temp_MoyenneExpSectTransp_MAJ;
Commit using SQLCA;

INSERT INTO #Temp_MoyenneExpSectTransp_MAJ ( CIE_NO, PROD_NO, qte_exp)
SELECT #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO, Sum(#temp_moy_exp_tra_statfactureDetail.QTE_EXP) AS sommeQTE_EXP
    FROM #temp_moy_exp_tra_statfacture INNER JOIN (t_Produit INNER JOIN #temp_moy_exp_tra_statfactureDetail 
	 ON t_Produit.NoProduit = #temp_moy_exp_tra_statfactureDetail.PROD_NO) 
	 ON (#temp_moy_exp_tra_statfacture.LIV_NO = #temp_moy_exp_tra_statfactureDetail.LIV_NO) 
	 AND (#temp_moy_exp_tra_statfacture.CIE_NO = #temp_moy_exp_tra_statfactureDetail.CIE_NO) 
    WHERE date(#temp_moy_exp_tra_statfacture.LIV_DATE) = dateadd(day, -35,:ad_debut) And t_Produit.Special = 1 
    GROUP BY #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO 
    HAVING sommeQTE_EXP <> 0;
Commit using SQLCA;

UPDATE #Temp_MoyenneExpSectTransp_MAJ INNER JOIN #Temp_MoyenneExpSectTransp ON (#Temp_MoyenneExpSectTransp_MAJ.CIE_NO = #Temp_MoyenneExpSectTransp.CIE_NO) AND (#Temp_MoyenneExpSectTransp_MAJ.PROD_NO = #Temp_MoyenneExpSectTransp.PROD_NO) 
    SET #Temp_MoyenneExpSectTransp.Semaine5 = QTE_EXP;
Commit using SQLCA;

//Ajout semaine 5
INSERT INTO #Temp_MoyenneExpSectTransp ( CIE_NO, PROD_NO, Semaine5 ) 
    SELECT #Temp_MoyenneExpSectTransp_MAJ.CIE_NO, #Temp_MoyenneExpSectTransp_MAJ.PROD_NO, #Temp_MoyenneExpSectTransp_MAJ.QTE_EXP 
    FROM #Temp_MoyenneExpSectTransp_MAJ LEFT JOIN #Temp_MoyenneExpSectTransp 
	 ON (#Temp_MoyenneExpSectTransp_MAJ.CIE_NO = #Temp_MoyenneExpSectTransp.CIE_NO) 
	 AND (#Temp_MoyenneExpSectTransp_MAJ.PROD_NO = #Temp_MoyenneExpSectTransp.PROD_NO) 
    WHERE (((#Temp_MoyenneExpSectTransp.CIE_NO) Is Null) AND ((#Temp_MoyenneExpSectTransp.PROD_NO) Is Null));
Commit using SQLCA;


//MAJ semaine 6
DELETE FROM #Temp_MoyenneExpSectTransp_MAJ;
Commit using SQLCA;

INSERT INTO #Temp_MoyenneExpSectTransp_MAJ ( CIE_NO, PROD_NO, qte_exp)
SELECT #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO, Sum(#temp_moy_exp_tra_statfactureDetail.QTE_EXP) AS sommeQTE_EXP 
    FROM #temp_moy_exp_tra_statfacture INNER JOIN (t_Produit INNER JOIN #temp_moy_exp_tra_statfactureDetail 
	 ON t_Produit.NoProduit = #temp_moy_exp_tra_statfactureDetail.PROD_NO) 
	 ON (#temp_moy_exp_tra_statfacture.LIV_NO = #temp_moy_exp_tra_statfactureDetail.LIV_NO) 
	 AND (#temp_moy_exp_tra_statfacture.CIE_NO = #temp_moy_exp_tra_statfactureDetail.CIE_NO) 
    WHERE date(#temp_moy_exp_tra_statfacture.LIV_DATE) = dateadd(day, -42,:ad_debut) And t_Produit.Special = 1 
    GROUP BY #temp_moy_exp_tra_statfacture.CIE_NO, #temp_moy_exp_tra_statfactureDetail.PROD_NO 
    HAVING sommeQTE_EXP <> 0;
Commit using SQLCA;

UPDATE #Temp_MoyenneExpSectTransp_MAJ INNER JOIN #Temp_MoyenneExpSectTransp 
ON (#Temp_MoyenneExpSectTransp_MAJ.CIE_NO = #Temp_MoyenneExpSectTransp.CIE_NO) 
AND (#Temp_MoyenneExpSectTransp_MAJ.PROD_NO = #Temp_MoyenneExpSectTransp.PROD_NO) 
    SET #Temp_MoyenneExpSectTransp.Semaine6 = QTE_EXP ;
Commit using SQLCA;
        
//Ajout semaine 6
INSERT INTO #Temp_MoyenneExpSectTransp ( CIE_NO, PROD_NO, Semaine6 ) 
    SELECT #Temp_MoyenneExpSectTransp_MAJ.CIE_NO, #Temp_MoyenneExpSectTransp_MAJ.PROD_NO, #Temp_MoyenneExpSectTransp_MAJ.QTE_EXP 
    FROM #Temp_MoyenneExpSectTransp_MAJ LEFT JOIN #Temp_MoyenneExpSectTransp 
	 ON (#Temp_MoyenneExpSectTransp_MAJ.CIE_NO = #Temp_MoyenneExpSectTransp.CIE_NO) 
	 AND (#Temp_MoyenneExpSectTransp_MAJ.PROD_NO = #Temp_MoyenneExpSectTransp.PROD_NO) 
    WHERE (((#Temp_MoyenneExpSectTransp.CIE_NO) Is Null) AND ((#Temp_MoyenneExpSectTransp.PROD_NO) Is Null));
Commit using SQLCA;

ls_sql = "drop table #Temp_MoyenneExpSectTransp_MAJ"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
ls_sql = "drop table #temp_moy_exp_tra_statfacturedetail"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
ls_sql = "drop table #temp_moy_exp_tra_statfacture"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
end subroutine

public subroutine of_domoyennecommande_orig_mel (date ad_debut);//of_domoyennecommande_orig_mel
long ll_nb
string ls_sql

select count(1) into :ll_nb from #Temp_MoyenneCommOrig_Melange;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_MoyenneCommOrig_Melange (NoProduit varchar(16),~r~n" + &
																		  "semaine1 integer null,~r~n" + &
																		  "semaine2 integer null,~r~n" + &
																		  "semaine3 integer null,~r~n" + &
																		  "semaine4 integer null,~r~n" + &
																		  "semaine5 integer null,~r~n" + &
																		  "semaine6 integer null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Temp_MoyenneCommOrig_Melange;
	commit using sqlca;
end if

//Ajout semaine 1
INSERT INTO #Temp_MoyenneCommOrig_Melange ( NoProduit, Semaine1 ) 
    SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
    FROM t_CommandeOriginale INNER JOIN t_Produit ON t_CommandeOriginale.NoProduit = t_Produit.NoProduit 
    WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -7,:ad_debut)
	 And t_CommandeOriginale.CodeVerrat Is Null
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;

//MAJ semaine 2
select count(1) into :ll_nb from #Temp_moyenneCommOrig_MAJ;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_moyenneCommOrig_MAJ (NoProduit varchar(16) null,~r~n" + &
																	 "SommeDeQteInit double null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	DELETE FROM #Temp_moyenneCommOrig_MAJ;
	COMMIT USING SQLCA;
end if

INSERT INTO #Temp_MoyenneCommOrig_MAJ (NoProduit, SommeDeQteInit)
SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit  
    FROM #Temp_MoyenneCommOrig_Melange INNER JOIN t_CommandeOriginale 
	 ON #Temp_MoyenneCommOrig_Melange.NoProduit = t_CommandeOriginale.NoProduit 
    WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -14,:ad_debut)
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;

UPDATE #Temp_MoyenneCommOrig_MAJ INNER JOIN #Temp_MoyenneCommOrig_Melange 
ON #Temp_MoyenneCommOrig_MAJ.NoProduit = #Temp_MoyenneCommOrig_Melange.NoProduit 
    SET #Temp_MoyenneCommOrig_Melange.Semaine2 = SommeDeQteInit;
commit using SQLCA;

//Ajout semaine 2
INSERT INTO #Temp_MoyenneCommOrig_Melange ( NoProduit, Semaine2 ) 
    SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
    FROM (t_CommandeOriginale LEFT JOIN #Temp_MoyenneCommOrig_Melange 
	 ON t_CommandeOriginale.NoProduit = #Temp_MoyenneCommOrig_Melange.NoProduit) 
	 INNER JOIN t_Produit ON t_CommandeOriginale.NoProduit = t_Produit.NoProduit 
    WHERE #Temp_MoyenneCommOrig_Melange.NoProduit Is Null
	 And date(t_CommandeOriginale.DateCommande) = dateadd(day, -14,:ad_debut)
	 And t_CommandeOriginale.CodeVerrat Is Null
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;

//MAJ semaine 3
DELETE FROM #Temp_MoyenneCommOrig_MAJ; 
Commit USING SQLCA;

INSERT INTO #Temp_MoyenneCommOrig_MAJ (NoProduit, SommeDeQteInit)
SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit
    FROM #Temp_MoyenneCommOrig_Melange INNER JOIN t_CommandeOriginale 
	 ON #Temp_MoyenneCommOrig_Melange.NoProduit = t_CommandeOriginale.NoProduit 
    WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -21,:ad_debut)
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;

UPDATE #Temp_MoyenneCommOrig_MAJ INNER JOIN #Temp_MoyenneCommOrig_Melange 
ON #Temp_MoyenneCommOrig_MAJ.NoProduit = #Temp_MoyenneCommOrig_Melange.NoProduit 
    SET #Temp_MoyenneCommOrig_Melange.Semaine3 = SommeDeQteInit;
commit using SQLCA;

//Ajout semaine 3
INSERT INTO #Temp_MoyenneCommOrig_Melange ( NoProduit, Semaine3 ) 
    SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
    FROM (t_CommandeOriginale LEFT JOIN #Temp_MoyenneCommOrig_Melange 
	 ON t_CommandeOriginale.NoProduit = #Temp_MoyenneCommOrig_Melange.NoProduit) INNER JOIN t_Produit 
	 ON t_CommandeOriginale.NoProduit = t_Produit.NoProduit 
    WHERE #Temp_MoyenneCommOrig_Melange.NoProduit Is Null
	 And date(t_CommandeOriginale.DateCommande) = dateadd(day, -21,:ad_debut)
	 And t_CommandeOriginale.CodeVerrat Is Null
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;

//MAJ semaine 4
DELETE FROM #Temp_MoyenneCommOrig_MAJ; 
Commit USING SQLCA;

INSERT INTO #Temp_MoyenneCommOrig_MAJ (NoProduit, SommeDeQteInit)
SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
    FROM #Temp_MoyenneCommOrig_Melange INNER JOIN t_CommandeOriginale 
	 ON #Temp_MoyenneCommOrig_Melange.NoProduit = t_CommandeOriginale.NoProduit 
    WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -28,:ad_debut)
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;

UPDATE #Temp_MoyenneCommOrig_MAJ INNER JOIN #Temp_MoyenneCommOrig_Melange 
ON #Temp_MoyenneCommOrig_MAJ.NoProduit = #Temp_MoyenneCommOrig_Melange.NoProduit 
    SET #Temp_MoyenneCommOrig_Melange.Semaine4 = SommeDeQteInit;
commit using SQLCA;

//Ajout semaine 4
INSERT INTO #Temp_MoyenneCommOrig_Melange ( NoProduit, Semaine4 ) 
    SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
    FROM (t_CommandeOriginale LEFT JOIN #Temp_MoyenneCommOrig_Melange 
	 ON t_CommandeOriginale.NoProduit = #Temp_MoyenneCommOrig_Melange.NoProduit) INNER JOIN t_Produit 
	 ON t_CommandeOriginale.NoProduit = t_Produit.NoProduit 
    WHERE #Temp_MoyenneCommOrig_Melange.NoProduit Is Null
	 And date(t_CommandeOriginale.DateCommande) = dateadd(day, -28,:ad_debut)
	 And t_CommandeOriginale.CodeVerrat Is Null
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;
        
//MAJ semaine 5
DELETE FROM #Temp_MoyenneCommOrig_MAJ; 
Commit USING SQLCA;

INSERT INTO #Temp_MoyenneCommOrig_MAJ (NoProduit, SommeDeQteInit)
SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
    FROM #Temp_MoyenneCommOrig_Melange INNER JOIN t_CommandeOriginale 
	 ON #Temp_MoyenneCommOrig_Melange.NoProduit = t_CommandeOriginale.NoProduit 
    WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -35,:ad_debut)
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;

UPDATE #Temp_MoyenneCommOrig_MAJ INNER JOIN #Temp_MoyenneCommOrig_Melange 
ON #Temp_MoyenneCommOrig_MAJ.NoProduit = #Temp_MoyenneCommOrig_Melange.NoProduit 
    SET #Temp_MoyenneCommOrig_Melange.Semaine5 = SommeDeQteInit;
commit using SQLCA;

//Ajout semaine 5
INSERT INTO #Temp_MoyenneCommOrig_Melange ( NoProduit, Semaine5 ) 
    SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
    FROM (t_CommandeOriginale LEFT JOIN #Temp_MoyenneCommOrig_Melange 
	 ON t_CommandeOriginale.NoProduit = #Temp_MoyenneCommOrig_Melange.NoProduit) INNER JOIN t_Produit 
	 ON t_CommandeOriginale.NoProduit = t_Produit.NoProduit 
    WHERE #Temp_MoyenneCommOrig_Melange.NoProduit Is Null
	 And date(t_CommandeOriginale.DateCommande) = dateadd(day, -35,:ad_debut)
	 And t_CommandeOriginale.CodeVerrat Is Null
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;

//MAJ semaine 6
DELETE FROM #Temp_MoyenneCommOrig_MAJ; 
Commit USING SQLCA;

INSERT INTO #Temp_MoyenneCommOrig_MAJ (NoProduit, SommeDeQteInit)
SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
    FROM #Temp_MoyenneCommOrig_Melange INNER JOIN t_CommandeOriginale 
	 ON #Temp_MoyenneCommOrig_Melange.NoProduit = t_CommandeOriginale.NoProduit 
    WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -42,:ad_debut)
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;

UPDATE #Temp_MoyenneCommOrig_MAJ INNER JOIN #Temp_MoyenneCommOrig_Melange 
ON #Temp_MoyenneCommOrig_MAJ.NoProduit = #Temp_MoyenneCommOrig_Melange.NoProduit 
    SET #Temp_MoyenneCommOrig_Melange.Semaine6 = SommeDeQteInit;
commit using SQLCA;

//Ajout semaine 6
INSERT INTO #Temp_MoyenneCommOrig_Melange ( NoProduit, Semaine6 ) 
    SELECT t_CommandeOriginale.NoProduit, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
    FROM (t_CommandeOriginale LEFT JOIN #Temp_MoyenneCommOrig_Melange 
	 ON t_CommandeOriginale.NoProduit = #Temp_MoyenneCommOrig_Melange.NoProduit) INNER JOIN t_Produit 
	 ON t_CommandeOriginale.NoProduit = t_Produit.NoProduit 
    WHERE #Temp_MoyenneCommOrig_Melange.NoProduit Is Null
	 And date(t_CommandeOriginale.DateCommande) = dateadd(day, -42,:ad_debut)
	 And t_CommandeOriginale.CodeVerrat Is Null
	 GROUP BY t_CommandeOriginale.NoProduit;
commit using SQLCA;

ls_sql = "drop table #Temp_moyenneCommOrig_MAJ"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
end subroutine

public subroutine of_domoyennecommorig_pur (date ad_de);//of_DoMoyenneCommOrig_Pur
long ll_nb
string ls_sql

select count(1) into :ll_nb from #Temp_MoyenneCommOrig_Pure;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_MoyenneCommOrig_Pure (NoProduit varchar(16) null,~r~n" + &
																	  "CodeVerrat varchar(12) null,~r~n" + &
																	  "semaine1 integer null,~r~n" + &
																	  "semaine2 integer null,~r~n" + &
																	  "semaine3 integer null,~r~n" + &
																	  "semaine4 integer null,~r~n" + &
																	  "semaine5 integer null,~r~n" + &
																	  "semaine6 integer null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Temp_MoyenneCommOrig_Pure;
	commit using sqlca;
end if

//Ajout semaine 1
INSERT INTO #Temp_MoyenneCommOrig_Pure ( NoProduit, CodeVerrat, Semaine1 ) 
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM t_CommandeOriginale 
WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -7,:ad_de)
And t_CommandeOriginale.CodeVerrat Is Not Null
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

//MAJ semaine 2
select count(1) into :ll_nb from #Temp_MoyenneCommOrig_MAJ_Pure;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_MoyenneCommOrig_MAJ_Pure (NoProduit varchar(16) null,~r~n" + &
																			"CodeVerrat varchar(12) null,~r~n" + &
																			"SommeDeQteInit double null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Temp_MoyenneCommOrig_MAJ_Pure; 
	commit using sqlca;
end if

INSERT INTO #Temp_MoyenneCommOrig_MAJ_Pure (NoProduit, CodeVerrat, SommeDeQteInit)
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit  
FROM #Temp_MoyenneCommOrig_Pure INNER JOIN t_CommandeOriginale 
ON #Temp_MoyenneCommOrig_Pure.CodeVerrat = t_CommandeOriginale.CodeVerrat
AND #Temp_MoyenneCommOrig_Pure.NoProduit = t_CommandeOriginale.NoProduit
WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -14,:ad_de)
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

UPDATE #Temp_MoyenneCommOrig_MAJ_Pure INNER JOIN #Temp_MoyenneCommOrig_Pure 
ON #Temp_MoyenneCommOrig_Pure.CodeVerrat = #Temp_MoyenneCommOrig_MAJ_Pure.CodeVerrat
AND #Temp_MoyenneCommOrig_MAJ_Pure.NoProduit = #Temp_MoyenneCommOrig_Pure.NoProduit
SET #Temp_MoyenneCommOrig_Pure.Semaine2 = SommeDeQteInit;
Commit using SQLCA;

//Ajout semaine 2
INSERT INTO #Temp_MoyenneCommOrig_Pure ( NoProduit, CodeVerrat, Semaine2 ) 
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM t_CommandeOriginale LEFT JOIN #Temp_MoyenneCommOrig_Pure 
ON t_CommandeOriginale.CodeVerrat = #Temp_MoyenneCommOrig_Pure.CodeVerrat
AND t_CommandeOriginale.NoProduit = #Temp_MoyenneCommOrig_Pure.NoProduit
WHERE #Temp_MoyenneCommOrig_Pure.NoProduit Is Null
And #Temp_MoyenneCommOrig_Pure.CodeVerrat Is Null
And date(t_CommandeOriginale.DateCommande) = dateadd(day, -14,:ad_de)
And t_CommandeOriginale.CodeVerrat Is Not Null
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

//MAJ semaine 3
delete from #Temp_MoyenneCommOrig_MAJ_Pure; 
commit using sqlca;

INSERT INTO #Temp_MoyenneCommOrig_MAJ_Pure (NoProduit, CodeVerrat, SommeDeQteInit)
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM #Temp_MoyenneCommOrig_Pure INNER JOIN t_CommandeOriginale 
ON #Temp_MoyenneCommOrig_Pure.CodeVerrat = t_CommandeOriginale.CodeVerrat
AND #Temp_MoyenneCommOrig_Pure.NoProduit = t_CommandeOriginale.NoProduit
WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -21,:ad_de)
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

UPDATE #Temp_MoyenneCommOrig_MAJ_Pure INNER JOIN #Temp_MoyenneCommOrig_Pure 
ON #Temp_MoyenneCommOrig_Pure.CodeVerrat = #Temp_MoyenneCommOrig_MAJ_Pure.CodeVerrat
AND #Temp_MoyenneCommOrig_MAJ_Pure.NoProduit = #Temp_MoyenneCommOrig_Pure.NoProduit
SET #Temp_MoyenneCommOrig_Pure.Semaine3 = SommeDeQteInit;
Commit using SQLCA;

//Ajout semaine 3
INSERT INTO #Temp_MoyenneCommOrig_Pure ( NoProduit, CodeVerrat, Semaine3 ) 
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM t_CommandeOriginale LEFT JOIN #Temp_MoyenneCommOrig_Pure 
ON t_CommandeOriginale.CodeVerrat = #Temp_MoyenneCommOrig_Pure.CodeVerrat
AND t_CommandeOriginale.NoProduit = #Temp_MoyenneCommOrig_Pure.NoProduit
WHERE #Temp_MoyenneCommOrig_Pure.NoProduit Is Null
And #Temp_MoyenneCommOrig_Pure.CodeVerrat Is Null
And date(t_CommandeOriginale.DateCommande) = dateadd(day, -21,:ad_de)
And t_CommandeOriginale.CodeVerrat Is Not Null
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

//MAJ semaine 4
delete from #Temp_MoyenneCommOrig_MAJ_Pure; 
commit using sqlca;

INSERT INTO #Temp_MoyenneCommOrig_MAJ_Pure (NoProduit, CodeVerrat, SommeDeQteInit)
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM #Temp_MoyenneCommOrig_Pure INNER JOIN t_CommandeOriginale 
ON #Temp_MoyenneCommOrig_Pure.CodeVerrat = t_CommandeOriginale.CodeVerrat
AND #Temp_MoyenneCommOrig_Pure.NoProduit = t_CommandeOriginale.NoProduit
WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -28,:ad_de)
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

UPDATE #Temp_MoyenneCommOrig_MAJ_Pure INNER JOIN #Temp_MoyenneCommOrig_Pure 
ON #Temp_MoyenneCommOrig_Pure.CodeVerrat = #Temp_MoyenneCommOrig_MAJ_Pure.CodeVerrat
AND #Temp_MoyenneCommOrig_MAJ_Pure.NoProduit = #Temp_MoyenneCommOrig_Pure.NoProduit
SET #Temp_MoyenneCommOrig_Pure.Semaine4 = SommeDeQteInit;
Commit using SQLCA;

//Ajout semaine 4
INSERT INTO #Temp_MoyenneCommOrig_Pure ( NoProduit, CodeVerrat, Semaine4 ) 
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM t_CommandeOriginale LEFT JOIN #Temp_MoyenneCommOrig_Pure 
ON t_CommandeOriginale.CodeVerrat = #Temp_MoyenneCommOrig_Pure.CodeVerrat
AND t_CommandeOriginale.NoProduit = #Temp_MoyenneCommOrig_Pure.NoProduit
WHERE #Temp_MoyenneCommOrig_Pure.NoProduit Is Null
And #Temp_MoyenneCommOrig_Pure.CodeVerrat Is Null
And date(t_CommandeOriginale.DateCommande) = dateadd(day, -28,:ad_de)
And t_CommandeOriginale.CodeVerrat Is Not Null
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

//MAJ semaine 5
delete from #Temp_MoyenneCommOrig_MAJ_Pure; 
commit using sqlca;

INSERT INTO #Temp_MoyenneCommOrig_MAJ_Pure (NoProduit, CodeVerrat, SommeDeQteInit)
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM #Temp_MoyenneCommOrig_Pure INNER JOIN t_CommandeOriginale 
ON #Temp_MoyenneCommOrig_Pure.CodeVerrat = t_CommandeOriginale.CodeVerrat
AND #Temp_MoyenneCommOrig_Pure.NoProduit = t_CommandeOriginale.NoProduit
WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -35,:ad_de)
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

UPDATE #Temp_MoyenneCommOrig_MAJ_Pure INNER JOIN #Temp_MoyenneCommOrig_Pure 
ON #Temp_MoyenneCommOrig_Pure.CodeVerrat = #Temp_MoyenneCommOrig_MAJ_Pure.CodeVerrat
AND #Temp_MoyenneCommOrig_MAJ_Pure.NoProduit = #Temp_MoyenneCommOrig_Pure.NoProduit
SET #Temp_MoyenneCommOrig_Pure.Semaine5 = SommeDeQteInit;
Commit using SQLCA;

//Ajout semaine 5
INSERT INTO #Temp_MoyenneCommOrig_Pure ( NoProduit, CodeVerrat, Semaine5 ) 
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM t_CommandeOriginale LEFT JOIN #Temp_MoyenneCommOrig_Pure 
ON t_CommandeOriginale.CodeVerrat = #Temp_MoyenneCommOrig_Pure.CodeVerrat
AND t_CommandeOriginale.NoProduit = #Temp_MoyenneCommOrig_Pure.NoProduit
WHERE #Temp_MoyenneCommOrig_Pure.NoProduit Is Null
And #Temp_MoyenneCommOrig_Pure.CodeVerrat Is Null
And date(t_CommandeOriginale.DateCommande) = dateadd(day, -35,:ad_de)
And t_CommandeOriginale.CodeVerrat Is Not Null
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

//MAJ semaine 6
delete from #Temp_MoyenneCommOrig_MAJ_Pure; 
commit using sqlca;

INSERT INTO #Temp_MoyenneCommOrig_MAJ_Pure (NoProduit, CodeVerrat, SommeDeQteInit)
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM #Temp_MoyenneCommOrig_Pure INNER JOIN t_CommandeOriginale 
ON #Temp_MoyenneCommOrig_Pure.CodeVerrat = t_CommandeOriginale.CodeVerrat
AND #Temp_MoyenneCommOrig_Pure.NoProduit = t_CommandeOriginale.NoProduit
WHERE date(t_CommandeOriginale.DateCommande) = dateadd(day, -42,:ad_de)
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

UPDATE #Temp_MoyenneCommOrig_MAJ_Pure INNER JOIN #Temp_MoyenneCommOrig_Pure 
ON #Temp_MoyenneCommOrig_Pure.CodeVerrat = #Temp_MoyenneCommOrig_MAJ_Pure.CodeVerrat
AND #Temp_MoyenneCommOrig_MAJ_Pure.NoProduit = #Temp_MoyenneCommOrig_Pure.NoProduit
SET #Temp_MoyenneCommOrig_Pure.Semaine6 = SommeDeQteInit;
Commit using SQLCA;

//Ajout semaine 6
INSERT INTO #Temp_MoyenneCommOrig_Pure ( NoProduit, CodeVerrat, Semaine6 ) 
SELECT t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat, Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM t_CommandeOriginale LEFT JOIN #Temp_MoyenneCommOrig_Pure 
ON t_CommandeOriginale.CodeVerrat = #Temp_MoyenneCommOrig_Pure.CodeVerrat
AND t_CommandeOriginale.NoProduit = #Temp_MoyenneCommOrig_Pure.NoProduit
WHERE #Temp_MoyenneCommOrig_Pure.NoProduit Is Null
And #Temp_MoyenneCommOrig_Pure.CodeVerrat Is Null
And date(t_CommandeOriginale.DateCommande) = dateadd(day, -42,:ad_de)
And t_CommandeOriginale.CodeVerrat Is Not Null
GROUP BY t_CommandeOriginale.NoProduit, t_CommandeOriginale.CodeVerrat;
Commit using SQLCA;

ls_sql = "drop table #Temp_MoyenneCommOrig_MAJ_Pure"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
end subroutine

public subroutine of_docommandesoriginales (date ad_debut, date ad_fin, boolean ab_parfamille);//of_DoCommandesOriginales
long ll_nb
string ls_sql

//Vider tables d'extractions (#temp_comm_ori_statfacture et #temp_comm_ori_statfactureDetail)
gnv_app.of_Cree_TableFact_Temp("temp_comm_ori_statfacture")

//#TMP_CommandeOriginale_rpt
select count(1) into :ll_nb from #TMP_CommandeOriginale_rpt;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #TMP_CommandeOriginale_rpt (No_Eleveur integer not null,~r~n" + &
																	  "Produit varchar(16) not null,~r~n" + &
																	  "Pur bit null,~r~n" + &
																	  "QteInit double null,~r~n" + &
																	  "QteExpedie float null,~r~n" + &
																	  "Famille varchar(15) null,~r~n" + &
																	  "cie_no varchar(3) not null,~r~n" + &
																	  "primary key (No_Eleveur, Produit, cie_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #TMP_CommandeOriginale_rpt;
	commit using sqlca;
end if

//#TMP_RptCommOrig_ListeProduitExpedie
select count(1) into :ll_nb from #TMP_RptCommOrig_ListeProduitExpedie;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #TMP_RptCommOrig_ListeProduitExpedie (no_eleveur integer not null,~r~n" + &
																					"produit varchar(16) not null,~r~n" + &
																					"Pur bit null,~r~n" + &
																					"QteInit float null,~r~n" + &
																					"QteExpedie float null,~r~n" + &
																					"cie_no varchar(3) not null,~r~n" + &
																					"primary key (no_eleveur, produit, cie_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #TMP_RptCommOrig_ListeProduitExpedie;
	commit using sqlca;
end if

//Premi$$HEX1$$e800$$ENDHEX$$re extraction
INSERT INTO #temp_comm_ori_statfacture 
SELECT DISTINCT T_StatFacture.* 
FROM (t_produit INNER JOIN t_classe ON t_produit.NoClasse = t_classe.NoClasse) 
INNER JOIN (T_StatFacture 
INNER JOIN T_StatFactureDetail 
ON (T_StatFacture.LIV_NO = T_StatFactureDetail.LIV_NO) AND (T_StatFacture.CIE_NO = T_StatFactureDetail.CIE_NO)) 
ON t_produit.NoProduit = T_StatFactureDetail.PROD_NO 
WHERE t_classe.Semence= 1 And date(T_StatFacture.LIV_DATE) >= :ad_debut And date(T_StatFacture.LIV_DATE) <= :ad_fin ;
Commit using sqlca;

//#temp_comm_ori_statfactureDetail
INSERT INTO #temp_comm_ori_statfactureDetail SELECT T_StatFactureDetail.* 
FROM (t_produit INNER JOIN t_classe ON t_produit.NoClasse = t_classe.NoClasse) 
INNER JOIN (T_StatFacture 
INNER JOIN T_StatFactureDetail 
ON (T_StatFacture.LIV_NO = T_StatFactureDetail.LIV_NO) AND (T_StatFacture.CIE_NO = T_StatFactureDetail.CIE_NO)) 
ON t_produit.NoProduit = T_StatFactureDetail.PROD_NO 
WHERE t_classe.Semence = 1 And date(T_StatFacture.LIV_DATE) >= :ad_debut And date(T_StatFacture.LIV_DATE) <= :ad_fin ;
Commit using sqlca;

//#TMP_CommandeOriginale_rpt
INSERT INTO #TMP_CommandeOriginale_rpt ( cie_no, No_Eleveur, Produit, Pur, QteInit ) 
SELECT t_CommandeOriginale.cieno,
t_CommandeOriginale.No_Eleveur,
IsNull(CodeVerrat,t_CommandeOriginale.NoProduit) AS Produit,
if codeverrat is null then
	0
else
	1
endif as Pur,
Sum(t_CommandeOriginale.QteInit) AS SommeDeQteInit 
FROM t_classe INNER JOIN 
(t_CommandeOriginale INNER JOIN t_produit ON t_CommandeOriginale.NoProduit = t_produit.NoProduit) 
ON t_classe.NoClasse = t_produit.NoClasse 
WHERE t_classe.Semence = 1 And date(t_CommandeOriginale.DateCommande) >= :ad_debut 
And date(t_CommandeOriginale.DateCommande) <= :ad_fin
GROUP BY t_CommandeOriginale.cieno,
t_CommandeOriginale.No_Eleveur, 
Produit, 
Pur ;
Commit using sqlca;

//#TMP_RptCommOrig_ListeProduitExpedie
INSERT INTO #TMP_RptCommOrig_ListeProduitExpedie ( CIE_NO, No_Eleveur, Produit, Pur, QteExpedie ) 
SELECT #temp_comm_ori_statfacture.cie_no,
#temp_comm_ori_statfacture.No_Eleveur, 
IsNull(VERRAT_NO,PROD_NO) AS Produit,
if VERRAT_NO is null then
	0
else
	1
endif as Pur,
Sum(#temp_comm_ori_statfactureDetail.QTE_EXP) AS QTE_EXP 
FROM (t_produit 
INNER JOIN (#temp_comm_ori_statfacture INNER JOIN #temp_comm_ori_statfactureDetail 
ON (#temp_comm_ori_statfacture.LIV_NO = #temp_comm_ori_statfactureDetail.LIV_NO) 
AND (#temp_comm_ori_statfacture.CIE_NO = #temp_comm_ori_statfactureDetail.CIE_NO)) 
ON t_produit.NoProduit = #temp_comm_ori_statfactureDetail.PROD_NO) INNER JOIN t_classe 
ON t_produit.NoClasse = t_classe.NoClasse 
WHERE t_classe.Semence = 1 And #temp_comm_ori_statfactureDetail.QTE_EXP <> 0
GROUP BY #temp_comm_ori_statfacture.cie_no,
#temp_comm_ori_statfacture.No_Eleveur, 
produit,
pur ;
Commit using sqlca;

//MAJ
UPDATE #TMP_CommandeOriginale_rpt 
INNER JOIN #TMP_RptCommOrig_ListeProduitExpedie 
ON (upper(#TMP_CommandeOriginale_rpt.Produit) = upper(#TMP_RptCommOrig_ListeProduitExpedie.Produit) )
AND (#TMP_CommandeOriginale_rpt.No_Eleveur = #TMP_RptCommOrig_ListeProduitExpedie.No_Eleveur) 
AND (#TMP_CommandeOriginale_rpt.CIE_NO = #TMP_RptCommOrig_ListeProduitExpedie.CIE_NO) 
SET #TMP_CommandeOriginale_rpt.QteExpedie = #TMP_RptCommOrig_ListeProduitExpedie.QteExpedie ;
Commit using sqlca;

//Ajout
INSERT INTO #TMP_CommandeOriginale_rpt ( cie_no, No_Eleveur, Produit, Pur, QteExpedie ) 
SELECT #TMP_RptCommOrig_ListeProduitExpedie.cie_no, 
#TMP_RptCommOrig_ListeProduitExpedie.No_Eleveur, 
#TMP_RptCommOrig_ListeProduitExpedie.Produit, 
#TMP_RptCommOrig_ListeProduitExpedie.Pur, 
#TMP_RptCommOrig_ListeProduitExpedie.QteExpedie 
FROM #TMP_CommandeOriginale_rpt 
RIGHT JOIN #TMP_RptCommOrig_ListeProduitExpedie 
ON (#TMP_CommandeOriginale_rpt.No_Eleveur = #TMP_RptCommOrig_ListeProduitExpedie.No_Eleveur) 
AND (#TMP_CommandeOriginale_rpt.CIE_NO = #TMP_RptCommOrig_ListeProduitExpedie.CIE_NO)
AND (#TMP_CommandeOriginale_rpt.Produit = #TMP_RptCommOrig_ListeProduitExpedie.Produit) 
WHERE (#TMP_CommandeOriginale_rpt.No_Eleveur Is Null) AND (#TMP_CommandeOriginale_rpt.Produit Is Null) ;
Commit using sqlca;

//MAJ de la famille
//M$$HEX1$$e900$$ENDHEX$$langes
UPDATE #TMP_CommandeOriginale_rpt 
INNER JOIN t_produit ON upper(#TMP_CommandeOriginale_rpt.Produit) = upper(t_produit.NoProduit) 
SET #TMP_CommandeOriginale_rpt.Famille = t_produit.Famille 
WHERE #TMP_CommandeOriginale_rpt.Pur = 0 ;
Commit using sqlca;

//Pures
UPDATE #TMP_CommandeOriginale_rpt 
INNER JOIN t_verrat ON #TMP_CommandeOriginale_rpt.Produit = t_verrat.CodeVerrat
INNER JOIN t_verrat_Classe ON t_verrat.Classe = t_verrat_Classe.ClasseVerrat 
SET #TMP_CommandeOriginale_rpt.Famille = t_verrat_Classe.Famille 
WHERE #TMP_CommandeOriginale_rpt.Pur = 1 ;
Commit using sqlca;

ls_sql = "drop table #TMP_RptCommOrig_ListeProduitExpedie"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
ls_sql = "drop table #temp_comm_ori_statfactureDetail"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
ls_sql = "drop table #temp_comm_ori_statfacture"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
end subroutine

public subroutine of_docompilationrecoltesg (date ad_de, date ad_au);//of_DoCompilationRecolteSG
gnv_app.of_Cree_TableFact_Temp("Temp_req_StatFacture")

//Premi$$HEX1$$e800$$ENDHEX$$re extraction
INSERT INTO #Temp_req_StatFacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE date(t_StatFacture.LIV_DATE) >= :ad_de AND date(t_StatFacture.LIV_DATE) <= :ad_au ;
COMMIT USING SQLCA;

//#Temp_req_StatFactureDetail
INSERT INTO #Temp_req_StatFactureDetail SELECT t_StatFactureDetail.* 
FROM #Temp_req_StatFacture 
INNER JOIN t_StatFactureDetail 
ON (#Temp_req_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#Temp_req_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;

//DoCmd.OpenQuery "CipqQryCompilationSousGroupeR$$HEX1$$e900$$ENDHEX$$colte_Ajout"


//DoCmd.OpenQuery "CipqQryCompilationSousGroupePure_Ajout"

//DoCmd.OpenQuery "CipqQryCompilationSousGroupeM$$HEX1$$e900$$ENDHEX$$lange_Ajout"

//DoCmd.OpenQuery "CipqQryCompilationR$$HEX1$$e900$$ENDHEX$$colteSG_Pure_MAJ"

//DoCmd.OpenQuery "CipqQryCompilationR$$HEX1$$e900$$ENDHEX$$colteSG_Pure_Ajout"

//DoCmd.OpenQuery "CipqQryCompilationR$$HEX1$$e900$$ENDHEX$$colteSG_M$$HEX1$$e900$$ENDHEX$$lange_MAJ"

//DoCmd.OpenQuery "CipqQryCompilationR$$HEX1$$e900$$ENDHEX$$colteSG_M$$HEX1$$e900$$ENDHEX$$lange_Ajout"

end subroutine

public subroutine of_docompilationrecolte (date ad_de, date ad_au);//of_docompilationrecolte
long ll_nb
string ls_sql

gnv_app.of_Cree_TableFact_Temp("temp_comp_rec_statfacture")

select count(1) into :ll_nb from #Tmp_CompilationRecolte;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_CompilationRecolte (CodeHebergeur varchar(1) not null,~r~n" + &
																  "DateCompilation datetime not null,~r~n" + &
																  "NbrDose integer null,~r~n" + &
																  "NbrPure integer null,~r~n" + &
																  "NbrMelange integer null,~r~n" + &
																  "primary key (CodeHebergeur, DateCompilation))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_CompilationRecolte;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Tmp_CompilationMelange;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_CompilationMelange (CodeHebergeur varchar(1) not null,~r~n" + &
																  "DateCompilation datetime not null,~r~n" + &
																  "NbrMelange integer null,~r~n" + &
																  "primary key (CodeHebergeur, DateCompilation))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_CompilationMelange;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Tmp_CompilationPure;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_CompilationPure (CodeHebergeur varchar(1) not null,~r~n" + &
															  "DateCompilation datetime not null,~r~n" + &
															  "NbrDose integer null,~r~n" + &
															  "NbrPure integer null,~r~n" + &
															  "NbrMelange integer null,~r~n" + &
															  "primary key (CodeHebergeur, DateCompilation))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_CompilationPure;
	commit using sqlca;
end if

//Premi$$HEX1$$e800$$ENDHEX$$re extraction
INSERT INTO #temp_comp_rec_statfacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE date(t_StatFacture.LIV_DATE) >= :ad_de AND date(t_StatFacture.LIV_DATE) <= :ad_au ;
COMMIT USING SQLCA;

//#temp_comp_rec_statfactureDetail
INSERT INTO #temp_comp_rec_statfactureDetail SELECT t_StatFactureDetail.* 
FROM #temp_comp_rec_statfacture 
INNER JOIN t_StatFactureDetail 
ON (#temp_comp_rec_statfacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#temp_comp_rec_statfacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;


//Ancien CipqQryCompilationRecolte_Ajout
INSERT INTO 
#Tmp_CompilationRecolte ( CodeHebergeur, DateCompilation, NbrDose )
SELECT 
Left(t_Verrat.CodeVerrat,1) AS CodeHebergeur, 
t_RECOLTE.DATE_recolte, 
isnull(Sum(round(AMPO_TOTAL,0)),0) AS NbrDose
FROM t_Verrat 
INNER JOIN t_RECOLTE ON t_Verrat.CodeVerrat = t_RECOLTE.CodeVerrat
GROUP BY 
CodeHebergeur, t_RECOLTE.DATE_recolte, t_Verrat.CodeRACE
HAVING t_RECOLTE.DATE_recolte >= :ad_de And t_RECOLTE.DATE_recolte <= :ad_au AND NbrDose <> 0 AND t_Verrat.CodeRACE = 'LO' ;
COMMIT USING SQLCA;


//Ancien CipqQryCompilationPure_Ajout
INSERT INTO 
#Tmp_CompilationPure ( CodeHebergeur, DateCompilation, NbrPure )
SELECT 
Left(t_Verrat.CodeVerrat,1) AS CodeHebergeur, 
datetime(dateformat(#temp_comp_rec_statfacture.LIV_DATE, 'yyyy-mm-dd') || ' 00:00:00'), 
Sum(#temp_comp_rec_statfactureDetail.QTE_EXP) AS Pure
FROM #temp_comp_rec_statfacture 
INNER JOIN (t_Verrat INNER JOIN #temp_comp_rec_statfactureDetail 
ON t_Verrat.CodeVerrat = #temp_comp_rec_statfactureDetail.VERRAT_NO) 
ON (#temp_comp_rec_statfacture.LIV_NO = #temp_comp_rec_statfactureDetail.LIV_NO) 
AND (#temp_comp_rec_statfacture.CIE_NO = #temp_comp_rec_statfactureDetail.CIE_NO)
WHERE t_Verrat.CodeRACE = 'LO'
GROUP BY CodeHebergeur, date(#temp_comp_rec_statfacture.LIV_DATE)
HAVING Pure <> 0;
COMMIT USING SQLCA;

//Ancien CipqQryCompilationMelange_Ajout
INSERT INTO #Tmp_CompilationMelange ( CodeHebergeur, DateCompilation, NbrMelange )
SELECT 
substr(PROD_NO,3,1) AS CodeHeb, 
datetime(dateformat(#temp_comp_rec_statfacture.LIV_DATE, 'yyyy-mm-dd') || ' 00:00:00' ), 
Sum(#temp_comp_rec_statfactureDetail.QTE_EXP) as SommeDeQTE_EXP
FROM #temp_comp_rec_statfacture 
INNER JOIN #temp_comp_rec_statfactureDetail 
ON ((#temp_comp_rec_statfacture.LIV_NO = #temp_comp_rec_statfactureDetail.LIV_NO) 
AND (#temp_comp_rec_statfacture.CIE_NO = #temp_comp_rec_statfactureDetail.CIE_NO))
INNER JOIN t_eleveur_group 
ON ( t_eleveur_group.code_hebergeur =  CodeHeb )
WHERE #temp_comp_rec_statfactureDetail.PROD_NO Like 'M-%' AND NOT(t_eleveur_group.code_hebergeur is null)
GROUP BY 
CodeHeb,
date(#temp_comp_rec_statfacture.LIV_DATE)
HAVING SommeDeQTE_EXP <> 0 ;
COMMIT USING SQLCA;

//Ancien CipqQryCompilationRecolte_Pure_MAJ
UPDATE #Tmp_CompilationRecolte 
INNER JOIN #Tmp_CompilationPure 
ON (#Tmp_CompilationRecolte.DateCompilation = #Tmp_CompilationPure.DateCompilation) 
AND (#Tmp_CompilationRecolte.CodeHebergeur = #Tmp_CompilationPure.CodeHebergeur) 
SET #Tmp_CompilationRecolte.NbrPure = #Tmp_CompilationPure.NbrPure;
COMMIT USING SQLCA;

//Ancien CipqQryCompilationRecolte_Pure_Ajout
INSERT INTO #Tmp_CompilationRecolte ( CodeHebergeur, DateCompilation, NbrPure )
SELECT 
#Tmp_CompilationPure.CodeHebergeur, 
#Tmp_CompilationPure.DateCompilation, 
#Tmp_CompilationPure.NbrPure
FROM #Tmp_CompilationRecolte 
RIGHT JOIN #Tmp_CompilationPure 
ON (#Tmp_CompilationRecolte.DateCompilation = #Tmp_CompilationPure.DateCompilation) 
AND (#Tmp_CompilationRecolte.CodeHebergeur = #Tmp_CompilationPure.CodeHebergeur)
WHERE (#Tmp_CompilationRecolte.CodeHebergeur Is Null) AND (#Tmp_CompilationRecolte.DateCompilation Is Null);
COMMIT USING SQLCA;

//Ancien CipqQryCompilationRecolte_Melange_MAJ
UPDATE #Tmp_CompilationRecolte 
INNER JOIN #Tmp_CompilationMelange 
ON (#Tmp_CompilationRecolte.DateCompilation = #Tmp_CompilationMelange.DateCompilation) 
AND (#Tmp_CompilationRecolte.CodeHebergeur = #Tmp_CompilationMelange.CodeHebergeur) 
SET #Tmp_CompilationRecolte.NbrMelange = #Tmp_CompilationMelange.NbrMelange;
COMMIT USING SQLCA;

//Ancien CipqQryCompilationRecolte_Melange_Ajout
INSERT INTO #Tmp_CompilationRecolte ( CodeHebergeur, DateCompilation, NbrMelange )
SELECT 
#Tmp_CompilationMelange.CodeHebergeur, 
#Tmp_CompilationMelange.DateCompilation, 
#Tmp_CompilationMelange.NbrMelange
FROM #Tmp_CompilationRecolte 
RIGHT JOIN #Tmp_CompilationMelange 
ON (#Tmp_CompilationRecolte.DateCompilation = #Tmp_CompilationMelange.DateCompilation) 
AND (#Tmp_CompilationRecolte.CodeHebergeur = #Tmp_CompilationMelange.CodeHebergeur)
WHERE (#Tmp_CompilationRecolte.CodeHebergeur Is Null) AND (#Tmp_CompilationRecolte.DateCompilation Is Null);
COMMIT USING SQLCA;

ls_sql = "drop table #temp_comp_rec_statfacturedetail"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
ls_sql = "drop table #temp_comp_rec_statfacture"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
ls_sql = "drop table #Tmp_CompilationMelange"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
ls_sql = "drop table #Tmp_CompilationPure"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
end subroutine

public subroutine of_docompilationdetailrecolte (date ad_de, date ad_au);//of_DoCompilationDetailRecolte
long ll_nb
string ls_sql

gnv_app.of_Cree_TableFact_Temp("temp_comp_det_rec_statfacture")

select count(1) into :ll_nb from #Tmp_CompilationRecolte_Detail;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_CompilationRecolte_Detail (CodeHebergeur varchar(1) not null,~r~n" + &
																			"DateCompilation datetime not null,~r~n" + &
																			"NbrDose integer null,~r~n" + &
																			"NbrPure integer null,~r~n" + &
																			"NbrMelange integer null,~r~n" + &
																			"CodeVerrat varchar(12) not null,~r~n" + &
																			"primary key (CodeHebergeur, DateCompilation, CodeVerrat))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_CompilationRecolte_Detail;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Tmp_CompilationPure_Detail;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_CompilationPure_Detail (CodeHebergeur varchar(1) not null,~r~n" + &
																		"DateCompilation datetime not null,~r~n" + &
																		"NbrPure integer null,~r~n" + &
																		"CodeVerrat varchar(12) not null,~r~n" + &
																		"No_eleveur integer not null,~r~n" + &
																		"primary key (CodeHebergeur, DateCompilation, CodeVerrat, No_eleveur))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_CompilationPure_Detail;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Tmp_CompilationPure_Detail_Sommaire;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_CompilationPure_Detail_Sommaire (CodeHebergeur varchar(1) not null,~r~n" + &
																					"DateCompilation datetime not null,~r~n" + &
																					"NbrPure integer null,~r~n" + &
																					"CodeVerrat varchar(12) not null,~r~n" + &
																					"primary key (CodeHebergeur, DateCompilation, CodeVerrat))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_CompilationPure_Detail_Sommaire;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Tmp_CompilationMelange_Detail_Sommaire;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_CompilationMelange_Detail_Sommaire (CodeHebergeur varchar(1) not null,~r~n" + &
																						"DateCompilation datetime not null,~r~n" + &
																						"NbrMelange integer null,~r~n" + &
																						"No_Produit varchar(16) not null,~r~n" + &
																						"primary key (CodeHebergeur, DateCompilation, No_Produit))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_CompilationMelange_Detail_Sommaire;
	commit using sqlca;
end if

//Premi$$HEX1$$e800$$ENDHEX$$re extraction
INSERT INTO #temp_comp_det_rec_statfacture SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE date(t_StatFacture.LIV_DATE) >= :ad_de AND date(t_StatFacture.LIV_DATE) <= :ad_au ;
COMMIT USING SQLCA;

//#temp_comp_det_rec_statfactureDetail
INSERT INTO #temp_comp_det_rec_statfactureDetail SELECT t_StatFactureDetail.* 
FROM #temp_comp_det_rec_statfacture 
INNER JOIN t_StatFactureDetail 
ON (#temp_comp_det_rec_statfacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#temp_comp_det_rec_statfacture.CIE_NO = t_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;

//Ancien CipqQryCompilationD$$HEX1$$e900$$ENDHEX$$tailR$$HEX1$$e900$$ENDHEX$$colte_Ajout
INSERT INTO 
#Tmp_CompilationRecolte_Detail ( CodeHebergeur, DateCompilation, NbrDose, CodeVerrat )
SELECT 
Left(t_Verrat.CodeVerrat,1) AS CodeHebergeur, 
t_RECOLTE.DATE_recolte, 
isnull(Sum(round(AMPO_TOTAL,0)),0) AS NbrDose,
t_RECOLTE.CodeVerrat
FROM t_Verrat 
INNER JOIN t_RECOLTE ON t_Verrat.CodeVerrat = t_RECOLTE.CodeVerrat
GROUP BY 
CodeHebergeur, t_RECOLTE.DATE_recolte, t_Verrat.CodeRACE, t_RECOLTE.CodeVerrat
HAVING t_RECOLTE.DATE_recolte >= :ad_de And t_RECOLTE.DATE_recolte <= :ad_au AND NbrDose <> 0 AND t_Verrat.CodeRACE = 'LO' ;
COMMIT USING SQLCA;

//Ancien CipqQryCompilationD$$HEX1$$e900$$ENDHEX$$tailPure_Ajout
INSERT INTO 
#Tmp_CompilationPure_Detail ( CodeHebergeur, DateCompilation, NbrPure, CodeVerrat, No_eleveur )
SELECT 
Left(t_Verrat.CodeVerrat,1) AS CodeHebergeur, 
datetime(dateformat(#temp_comp_det_rec_statfacture.LIV_DATE, 'yyyy-mm-dd') || ' 00:00:00'),
Sum(#temp_comp_det_rec_statfactureDetail.QTE_EXP) AS Pure,
t_Verrat.CodeVerrat,
#temp_comp_det_rec_statfacture.No_eleveur
FROM #temp_comp_det_rec_statfacture 
INNER JOIN (t_Verrat INNER JOIN #temp_comp_det_rec_statfactureDetail 
ON t_Verrat.CodeVerrat = #temp_comp_det_rec_statfactureDetail.VERRAT_NO) 
ON (#temp_comp_det_rec_statfacture.LIV_NO = #temp_comp_det_rec_statfactureDetail.LIV_NO) 
AND (#temp_comp_det_rec_statfacture.CIE_NO = #temp_comp_det_rec_statfactureDetail.CIE_NO)
WHERE t_Verrat.CodeRACE = 'LO'
GROUP BY CodeHebergeur, date(#temp_comp_det_rec_statfacture.LIV_DATE), t_Verrat.CodeVerrat, #temp_comp_det_rec_statfacture.No_eleveur
HAVING Pure <> 0;
COMMIT USING SQLCA;

//Ancien CipqQryCompilationD$$HEX1$$e900$$ENDHEX$$tailSommairePure_Ajout
INSERT INTO #Tmp_CompilationPure_Detail_Sommaire ( CodeHebergeur, DateCompilation, CodeVerrat, NbrPure )
SELECT 
#Tmp_CompilationPure_Detail.CodeHebergeur, 
#Tmp_CompilationPure_Detail.DateCompilation, 
#Tmp_CompilationPure_Detail.CodeVerrat, 
Sum(#Tmp_CompilationPure_Detail.NbrPure) AS SommeDeNbrPure
FROM #Tmp_CompilationPure_Detail
GROUP BY 
#Tmp_CompilationPure_Detail.CodeHebergeur, 
#Tmp_CompilationPure_Detail.DateCompilation, 
#Tmp_CompilationPure_Detail.CodeVerrat ;
COMMIT USING SQLCA;

//Ancien CipqQryCompilationD$$HEX1$$e900$$ENDHEX$$tailR$$HEX1$$e900$$ENDHEX$$colte_Pure_MAJ
UPDATE #Tmp_CompilationRecolte_Detail 
INNER JOIN #Tmp_CompilationPure_Detail_Sommaire 
ON (#Tmp_CompilationRecolte_Detail.CodeVerrat = #Tmp_CompilationPure_Detail_Sommaire.CodeVerrat) 
AND (#Tmp_CompilationRecolte_Detail.DateCompilation = #Tmp_CompilationPure_Detail_Sommaire.DateCompilation) 
AND (#Tmp_CompilationRecolte_Detail.CodeHebergeur = #Tmp_CompilationPure_Detail_Sommaire.CodeHebergeur) 
SET #Tmp_CompilationRecolte_Detail.NbrPure = #Tmp_CompilationPure_Detail_Sommaire.NbrPure ;
COMMIT USING SQLCA;

//Ancien CipqQryCompilationD$$HEX1$$e900$$ENDHEX$$tailSommaireM$$HEX1$$e900$$ENDHEX$$lange_Ajout
INSERT INTO #Tmp_CompilationMelange_Detail_Sommaire ( CodeHebergeur, DateCompilation, NbrMelange, No_produit )
SELECT
substr(PROD_NO,3,1) AS CodeHeb,
datetime(dateformat(#temp_comp_det_rec_statfacture.LIV_DATE, 'yyyy-mm-dd') || ' 00:00:00'),
Sum(#temp_comp_det_rec_statfactureDetail.QTE_EXP) as SommeDeQTE_EXP,
#temp_comp_det_rec_statfactureDetail.PROD_NO
FROM #temp_comp_det_rec_statfacture 
INNER JOIN #temp_comp_det_rec_statfactureDetail 
ON ((#temp_comp_det_rec_statfacture.LIV_NO = #temp_comp_det_rec_statfactureDetail.LIV_NO) 
AND (#temp_comp_det_rec_statfacture.CIE_NO = #temp_comp_det_rec_statfactureDetail.CIE_NO))
INNER JOIN t_eleveur_group 
ON ( t_eleveur_group.code_hebergeur =  CodeHeb )
WHERE #temp_comp_det_rec_statfactureDetail.PROD_NO Like 'M-%' AND NOT(t_eleveur_group.code_hebergeur is null)
GROUP BY 
CodeHeb, 
date(#temp_comp_det_rec_statfacture.LIV_DATE),
#temp_comp_det_rec_statfactureDetail.PROD_NO
HAVING SommeDeQTE_EXP <> 0 ;
COMMIT USING SQLCA;

ls_sql = "drop table #temp_comp_det_rec_statfacturedetail"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
ls_sql = "drop table #temp_comp_det_rec_statfacture"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
ls_sql = "drop table #Tmp_CompilationPure_Detail_Sommaire"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;
end subroutine

public subroutine of_doregistrerecolte (date ad_de, date ad_au);//of_DoRegistreRecolte
long ll_nb
string ls_sql

select count(1) into :ll_nb from #Temp_RegistreRecolte;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_RegistreRecolte (cie_no varchar(3) not null,~r~n" + &
																"date_recolte datetime not null,~r~n" + &
																"PREPOSE integer not null,~r~n" + &
																"~"05_00~" integer null,~r~n" + &
																"~"05_30~" integer null,~r~n" + &
																"~"06_00~" integer null,~r~n" + &
																"~"06_30~" integer null,~r~n" + &
																"~"07_00~" integer null,~r~n" + &
																"~"07_30~" integer null,~r~n" + &
																"~"08_00~" integer null,~r~n" + &
																"~"08_30~" integer null,~r~n" + &
																"~"09_00~" integer null,~r~n" + &
																"~"09_30~" integer null,~r~n" + &
																"~"10_00~" integer null,~r~n" + &
																"~"10_30~" integer null,~r~n" + &
																"~"11_00~" integer null,~r~n" + &
																"~"11_30~" integer null,~r~n" + &
																"~"12_00~" integer null,~r~n" + &
																"~"12_30~" integer null,~r~n" + &
																"~"13_00~" integer null,~r~n" + &
																"~"13_30~" integer null,~r~n" + &
																"~"14_00~" integer null,~r~n" + &
																"~"14_30~" integer null,~r~n" + &
																"~"15_00~" integer null,~r~n" + &
																"~"15_30~" integer null,~r~n" + &
																"~"16_00~" integer null,~r~n" + &
																"~"16_30~" integer null,~r~n" + &
																"~"17_00~" integer null,~r~n" + &
																"~"17_30~" integer null,~r~n" + &
																"~"18_00~" integer null,~r~n" + &
																"primary key(cie_no, date_recolte, PREPOSE))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Temp_RegistreRecolte;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Temp_RegistreRecolteMAJ;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_RegistreRecolteMAJ (cie_no varchar(3) not null,~r~n" + &
																	"date_recolte datetime null,~r~n" + &
																	"prepose integer null,~r~n" + &
																	"NbrRecolte integer null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Temp_RegistreRecolteMAJ;
	commit using sqlca;
end if

//Ajuster toutes les heures
//5:00
INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "05_00" )
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte
FROM t_Recolte
WHERE ((t_Recolte.Heure_Recolte Is Null)
OR ( dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '05:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '05:30:00' )) 
AND t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

//5:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '05:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '06:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."05_30" = #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "05_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '05:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '06:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//6:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '06:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '06:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."06_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "06_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '06:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '06:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//6:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '06:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '07:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."06_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "06_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '06:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '07:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//7:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '07:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '07:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."07_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "07_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '07:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '07:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//7:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '07:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '08:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."07_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "07_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '07:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '08:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//8:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '08:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '08:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."08_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "08_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '08:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '08:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//8:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '08:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '09:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."08_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "08_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '08:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '09:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//9:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '09:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '09:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."09_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "09_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '09:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '09:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//9:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '09:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '10:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."09_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "09_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '09:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '10:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//10:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '10:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '10:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."10_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "10_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '10:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '10:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//10:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '10:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '11:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."10_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "10_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '10:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '11:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//11:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '11:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '11:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."11_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "11_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '11:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '11:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//11:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '11:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '12:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."11_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "11_30")
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '11:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '12:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//12:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '12:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '12:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."12_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "12_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '12:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '12:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//12:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '12:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '13:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."12_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "12_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '12:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '13:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//13:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '13:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '13:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."13_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "13_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '13:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '13:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//13:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '13:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '14:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."13_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "13_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '13:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '14:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//14:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '14:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '14:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."14_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "14_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '14:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '14:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//14:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '14:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '15:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."14_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "14_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '14:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '15:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//15:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '15:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '15:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."15_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "15_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '15:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '15:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//15:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '15:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '16:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."15_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "15_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '15:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '16:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//16:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '16:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '16:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."16_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "16_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '16:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '16:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//16:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '16:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '17:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."16_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "16_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '16:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '17:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//17:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '17:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '17:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."17_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "17_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '17:00:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '17:30:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//17:30
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '17:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '18:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."17_30"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "17_30" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '17:30:00' 
And dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') < '18:00:00'
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;

//18:00
INSERT INTO #Temp_RegistreRecolteMAJ(cie_no, date_recolte, prepose, NbrRecolte)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
isnull(t_Recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte 
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolte 
ON (t_Recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_Recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '18:00:00' 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte, cc_PREPOSE;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolte 
INNER JOIN #Temp_RegistreRecolteMAJ 
ON (#Temp_RegistreRecolte.PREPOSE = #Temp_RegistreRecolteMAJ.PREPOSE) 
AND (#Temp_RegistreRecolte.Date_Recolte = #Temp_RegistreRecolteMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolte.CIE_NO = #Temp_RegistreRecolteMAJ.CIE_NO) 
SET #Temp_RegistreRecolte."18_00"= #Temp_RegistreRecolteMAJ.NbrRecolte;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolte ( CIE_NO, Date_Recolte, PREPOSE, "18_00" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
isnull(t_recolte.PREPOSE,0) AS cc_PREPOSE, 
Count(t_recolte.CodeVerrat) AS NbrRecolte
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolte 
ON (t_recolte.PREPOSE = #Temp_RegistreRecolte.PREPOSE) 
AND (t_recolte.DATE_recolte = #Temp_RegistreRecolte.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolte.CIE_NO)
WHERE dateformat(t_Recolte.Heure_Recolte, 'hh:nn:ss') >= '18:00:00' 
AND (#Temp_RegistreRecolte.CIE_NO Is Null) 
AND (#Temp_RegistreRecolte.Date_Recolte Is Null) 
AND (#Temp_RegistreRecolte.PREPOSE Is Null)
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte, cc_prepose;
COMMIT USING SQLCA;
end subroutine

public subroutine of_doregistreanalyserecolte (date ad_de, date ad_au);//of_doregistreanalyserecolte
long ll_nb
string ls_sql

select count(1) into :ll_nb from #Temp_RegistreRecolteAnalyse;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_RegistreRecolteAnalyse (cie_no varchar(3) not null,~r~n" + &
																		 "date_recolte datetime not null,~r~n" + &
																		 "~"05_00~" integer null,~r~n" + &
																		 "~"05_30~" integer null,~r~n" + &
																		 "~"06_00~" integer null,~r~n" + &
																		 "~"06_30~" integer null,~r~n" + &
																		 "~"07_00~" integer null,~r~n" + &
																		 "~"07_30~" integer null,~r~n" + &
																		 "~"08_00~" integer null,~r~n" + &
																		 "~"08_30~" integer null,~r~n" + &
																		 "~"09_00~" integer null,~r~n" + &
																		 "~"09_30~" integer null,~r~n" + &
																		 "~"10_00~" integer null,~r~n" + &
																		 "~"10_30~" integer null,~r~n" + &
																		 "~"11_00~" integer null,~r~n" + &
																		 "~"11_30~" integer null,~r~n" + &
																		 "~"12_00~" integer null,~r~n" + &
																		 "~"12_30~" integer null,~r~n" + &
																		 "~"13_00~" integer null,~r~n" + &
																		 "~"13_30~" integer null,~r~n" + &
																		 "~"14_00~" integer null,~r~n" + &
																		 "~"14_30~" integer null,~r~n" + &
																		 "~"15_00~" integer null,~r~n" + &
																		 "~"15_30~" integer null,~r~n" + &
																		 "~"16_00~" integer null,~r~n" + &
																		 "~"16_30~" integer null,~r~n" + &
																		 "~"17_00~" integer null,~r~n" + &
																		 "~"17_30~" integer null,~r~n" + &
																		 "~"18_00~" integer null,~r~n" + &
																		 "~"05_00D~" integer null,~r~n" + &
																		 "~"05_30D~" integer null,~r~n" + &
																		 "~"06_00D~" integer null,~r~n" + &
																		 "~"06_30D~" integer null,~r~n" + &
																		 "~"07_00D~" integer null,~r~n" + &
																		 "~"07_30D~" integer null,~r~n" + &
																		 "~"08_00D~" integer null,~r~n" + &
																		 "~"08_30D~" integer null,~r~n" + &
																		 "~"09_00D~" integer null,~r~n" + &
																		 "~"09_30D~" integer null,~r~n" + &
																		 "~"10_00D~" integer null,~r~n" + &
																		 "~"10_30D~" integer null,~r~n" + &
																		 "~"11_00D~" integer null,~r~n" + &
																		 "~"11_30D~" integer null,~r~n" + &
																		 "~"12_00D~" integer null,~r~n" + &
																		 "~"12_30D~" integer null,~r~n" + &
																		 "~"13_00D~" integer null,~r~n" + &
																		 "~"13_30D~" integer null,~r~n" + &
																		 "~"14_00D~" integer null,~r~n" + &
																		 "~"14_30D~" integer null,~r~n" + &
																		 "~"15_00D~" integer null,~r~n" + &
																		 "~"15_30D~" integer null,~r~n" + &
																		 "~"16_00D~" integer null,~r~n" + &
																		 "~"16_30D~" integer null,~r~n" + &
																		 "~"17_00D~" integer null,~r~n" + &
																		 "~"17_30D~" integer null,~r~n" + &
																		 "~"18_00D~" integer null,~r~n" + &
																		 "primary key(cie_no, date_recolte))"
	execute immediate :ls_sql using SQLCA;
else
	delete from #Temp_RegistreRecolteAnalyse;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Temp_RegistreRecolteAnalyseMAJ;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_RegistreRecolteAnalyseMAJ (cie_no varchar(3) not null,~r~n" + &
																			 "date_recolte datetime null,~r~n" + &
																			 "NbrRecolte integer null,~r~n" + &
																			 "NbDoses float null)"
	execute immediate :ls_sql using SQLCA;
else
	delete from #Temp_RegistreRecolteAnalyseMAJ;
	commit using sqlca;
end if

//Ajuster toutes les heures
//5:00
INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "05_00", "05_00D" )
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_Recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte
WHERE ((t_Recolte.heure_analyse Is Null)
OR ( dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '05:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '05:30:00' )) 
AND t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

//5:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '05:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '06:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."05_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."05_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "05_30", "05_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '05:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '06:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//6:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '06:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '06:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."06_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."06_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "06_00", "06_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '06:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '06:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//6:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '06:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '07:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."06_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."06_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "06_30", "06_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '06:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '07:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//7:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '07:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '07:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."07_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."07_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "07_00", "07_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '07:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '07:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//7:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '07:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '08:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."07_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."07_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "07_30", "07_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '07:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '08:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//8:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '08:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '08:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."08_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."08_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "08_00", "08_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '08:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '08:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//8:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '08:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '09:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."08_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."08_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "08_30", "08_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '08:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '09:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//9:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '09:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '09:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."09_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."09_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "09_00", "09_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '09:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '09:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//9:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '09:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '10:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."09_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."09_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "09_30", "09_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '09:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '10:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//10:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '10:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '10:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."10_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."10_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "10_00", "10_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '10:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '10:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//10:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '10:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '11:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."10_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."10_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "10_30", "10_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '10:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '11:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//11:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '11:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '11:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."11_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."11_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "11_00", "11_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '11:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '11:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//11:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '11:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '12:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."11_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."11_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "11_30", "11_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '11:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '12:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//12:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '12:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '12:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."12_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."12_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "12_00", "12_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '12:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '12:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//12:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '12:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '13:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."12_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."12_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "12_30", "12_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '12:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '13:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//13:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '13:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '13:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."13_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."13_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "13_00", "13_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '13:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '13:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//13:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '13:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '14:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."13_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."13_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "13_30", "13_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '13:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '14:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//14:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '14:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '14:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."14_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."14_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "14_00", "14_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '14:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '14:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//14:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '14:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '15:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."14_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."14_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "14_30", "14_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '14:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '15:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//15:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '15:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '15:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."15_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."15_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "15_00", "15_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '15:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '15:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//15:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '15:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '16:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."15_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."15_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "15_30", "15_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '15:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '16:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//16:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '16:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '16:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."16_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."16_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "16_00", "16_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '16:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '16:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//16:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '16:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '17:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."16_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."16_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "16_30", "16_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '16:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '17:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//17:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '17:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '17:30:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."17_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."17_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "17_00", "17_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '17:00:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '17:30:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//17:30
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '17:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '18:00:00'
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."17_30" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."17_30D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "17_30", "17_30D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '17:30:00' 
And dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') < '18:00:00'
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;

//18:00
INSERT INTO #Temp_RegistreRecolteAnalyseMAJ(cie_no, date_recolte, NbrRecolte, NbDoses)
SELECT 
t_Recolte.CIE_NO, 
t_Recolte.DATE_recolte, 
Count(t_Recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_Recolte 
INNER JOIN #Temp_RegistreRecolteAnalyse 
ON (t_Recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_Recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '18:00:00' 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_Recolte.CIE_NO, t_Recolte.DATE_recolte;
COMMIT USING SQLCA;

UPDATE #Temp_RegistreRecolteAnalyse 
INNER JOIN #Temp_RegistreRecolteAnalyseMAJ 
ON (#Temp_RegistreRecolteAnalyse.Date_Recolte = #Temp_RegistreRecolteAnalyseMAJ.DATE_recolte) 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO = #Temp_RegistreRecolteAnalyseMAJ.CIE_NO) 
SET #Temp_RegistreRecolteAnalyse."18_00" = #Temp_RegistreRecolteAnalyseMAJ.NbrRecolte, 
#Temp_RegistreRecolteAnalyse."18_00D" = #Temp_RegistreRecolteAnalyseMAJ.NbDoses ;
COMMIT USING SQLCA;

DELETE FROM #Temp_RegistreRecolteAnalyseMAJ;
COMMIT USING SQLCA;

INSERT INTO #Temp_RegistreRecolteAnalyse ( CIE_NO, Date_Recolte, "18_00", "18_00D" )
SELECT 
t_recolte.CIE_NO, 
t_recolte.DATE_recolte, 
Count(t_recolte.CodeVerrat) AS NbrRecolte,
Sum(t_recolte.AMPO_TOTAL) AS NbDoses
FROM t_recolte 
LEFT JOIN #Temp_RegistreRecolteAnalyse 
ON (t_recolte.DATE_recolte = #Temp_RegistreRecolteAnalyse.Date_Recolte) 
AND (t_recolte.CIE_NO = #Temp_RegistreRecolteAnalyse.CIE_NO)
WHERE dateformat(t_Recolte.heure_analyse, 'hh:nn:ss') >= '18:00:00' 
AND (#Temp_RegistreRecolteAnalyse.CIE_NO Is Null) 
AND (#Temp_RegistreRecolteAnalyse.Date_Recolte Is Null) 
And t_Recolte.DATE_recolte >= :ad_de AND t_Recolte.DATE_recolte <= :ad_au
GROUP BY t_recolte.CIE_NO, t_recolte.DATE_recolte;
COMMIT USING SQLCA;
end subroutine

public function long of_cntheb (string as_centre, boolean ab_all, boolean ab_cumul, date ad_de, date ad_au);//of_CntHeb

long		ll_retour = 0
string	ls_cie
date		ld_debutannee

ld_debutannee = date(string(year(ad_au)) + "-01-01")

IF ab_all = TRUE THEN
	IF ab_cumul = TRUE THEN
		SELECT Count(t_StatFacture.LIV_NO) 
		INTO :ll_retour
		FROM (t_StatFacture INNER JOIN t_StatFactureDetail ON 
		(t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) AND 
		(t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)) INNER JOIN 
		t_Produit ON t_StatFactureDetail.PROD_NO = t_Produit.NoProduit		
		WHERE t_StatFacture.FACT_DATE Between :ld_debutannee And :ad_au
		GROUP BY t_Produit.NoClasse 
		HAVING t_Produit.NoClasse=19;
	ELSE
		SELECT Count(t_StatFacture.LIV_NO) 
		INTO :ll_retour
		FROM (t_StatFacture INNER JOIN t_StatFactureDetail ON 
		(t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) AND 
		(t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)) INNER JOIN 
		t_Produit ON t_StatFactureDetail.PROD_NO = t_Produit.NoProduit		
		WHERE t_StatFacture.FACT_DATE Between :ad_de And :ad_au
		GROUP BY t_Produit.NoClasse 
		HAVING t_Produit.NoClasse=19;
	END IF
	
ELSE
	
	IF ab_cumul = TRUE THEN
		SELECT t_StatFacture.CIE_NO, Count(t_StatFacture.LIV_NO) 
		INTO :ls_cie, :ll_retour
		FROM (t_StatFacture INNER JOIN t_StatFactureDetail ON 
		(t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) AND 
		(t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)) INNER JOIN 
		t_Produit ON t_StatFactureDetail.PROD_NO = t_Produit.NoProduit		
		WHERE t_StatFacture.FACT_DATE Between :ld_debutannee And :ad_au
		GROUP BY t_StatFacture.CIE_NO, t_Produit.NoClasse
		HAVING t_StatFacture.CIE_NO= :as_Centre AND t_Produit.NoClasse=19;
	ELSE
		SELECT t_StatFacture.CIE_NO, Count(t_StatFacture.LIV_NO) 
		INTO :ls_cie, :ll_retour
		FROM (t_StatFacture INNER JOIN t_StatFactureDetail ON 
		(t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) AND 
		(t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)) INNER JOIN 
		t_Produit ON t_StatFactureDetail.PROD_NO = t_Produit.NoProduit	
		WHERE t_StatFacture.FACT_DATE Between :ad_de And :ad_au
		GROUP BY t_StatFacture.CIE_NO, t_Produit.NoClasse
		HAVING t_StatFacture.CIE_NO= :as_Centre AND t_Produit.NoClasse=19;
	END IF
	
END IF

RETURN ll_retour
end function

public function string of_getvaleurftp (string as_section, string as_key);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_getvaleurftp
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		as_section	- section du .ini
//						as_key		- cl$$HEX1$$e900$$ENDHEX$$
//
//	Retourne:  		La valeur
//
// Description:	Fonction pour retourner les valeurs du fichier .ini de
//						ftp.ini
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////


RETURN ProfileString ("C:\ii4net\CIPQ\images\ftp.ini", as_section, as_key, "")
end function

public function long of_recupererprochainno (string as_cie);//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_recupererprochainno
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
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
//	Date			Programmeur				Description
//	2007-10-15	Mathieu Gendron		Cr$$HEX1$$e900$$ENDHEX$$ation
// 2009-08-21	S$$HEX1$$e900$$ENDHEX$$bastien Tremblay	R$$HEX1$$e900$$ENDHEX$$duction au maximum de calculs entre la lecture et l'$$HEX1$$e900$$ENDHEX$$criture
//
//////////////////////////////////////////////////////////////////////////////


//of_GetNextLivNo
//Changer le prochain no de livraison

long		ll_retour = -1

SELECT 	cast(isnull(derniernocommande, '0') as integer)
INTO		:ll_retour
FROM 		t_centreCIPQ
WHERE		cie = :as_cie ;

UPDATE  	t_centreCIPQ SET derniernocommande = string(:ll_retour + 1)
WHERE		cie = :as_cie ;

COMMIT USING SQLCA;

IF SQLCA.SQLCode = 0 THEN
	RETURN ll_retour
ELSE
	RETURN -1
END IF
end function

public function long of_dynamic_count (string as_string);//of_dynamic_count

long		ll_count

//Exemple: select count(1) from t_eleveur

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
PREPARE SQLSA FROM :as_string ;
OPEN DYNAMIC my_cursor ;
FETCH my_cursor INTO :ll_count ;
CLOSE my_cursor ;

RETURN ll_count
end function

public subroutine of_updatetable ();//of_updatetable
//Gestion des mises-$$HEX1$$e000$$ENDHEX$$-jour
string 	ls_sql, ls_nocie
long		ll_no, ll_retour, ll_no_bon

ls_nocie = THIS.of_getcompagniedefaut( )

IF il_version = 12 THEN
	ls_sql = "ALTER TABLE t_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE t_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE t_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_moy_exp_tra_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_moy_exp_tra_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_moy_exp_tra_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_comm_ori_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_comm_ori_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_comm_ori_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE Temp_t_StatFacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE Temp_t_StatFacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE Temp_t_StatFacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_comp_rec_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_comp_rec_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_comp_rec_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE temp_t_comp_det_rec_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_comp_det_rec_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_comp_det_rec_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_punaise_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_punaise_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_punaise_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_acc_som_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_acc_som_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_acc_som_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_acc_det_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_acc_det_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_acc_det_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_cli_sec_tra_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_cli_sec_tra_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_cli_sec_tra_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_com_heb_cen_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_com_heb_cen_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_com_heb_cen_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE temp_t_com_heb_glo_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_com_heb_glo_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_com_heb_glo_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_com_jou_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_com_jou_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_com_jou_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE temp_t_com_men_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_com_men_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_com_men_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_com_en_lot_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_com_en_lot_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_com_en_lot_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_des_dos_spe_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_des_dos_spe_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_des_dos_spe_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_des_pro_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_des_pro_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_des_pro_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_des_pro_sufa_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_des_pro_sufa_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_des_pro_sufa_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE Temp_t_StatFacture_exped_cipq ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE Temp_t_StatFacture_exped_cipq ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE Temp_t_StatFacture_exped_cipq ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE temp_t_exp_sec_tra_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_exp_sec_tra_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_exp_sec_tra_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE temp_t_qua_non_exp_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_qua_non_exp_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_qua_non_exp_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_som_det_fac_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_som_det_fac_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_som_det_fac_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE temp_t_som_exp_sec_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_som_exp_sec_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_som_exp_sec_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE temp_t_sta_ven_cla_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_cla_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_cla_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_sta_ven_clpr_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_clpr_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_clpr_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_sta_ven_mat_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_mat_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_mat_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;

	ls_sql = "ALTER TABLE temp_t_sta_ven_rac_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_rac_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_rac_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE temp_t_sta_ven_ver_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_ver_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_ver_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE temp_t_sta_ven_velo_statfacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_velo_statfacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE temp_t_sta_ven_velo_statfacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE Temp_t_ven_dep_StatFacture ADD billing_cycle_code varchar(6)"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE Temp_t_ven_dep_StatFacture ADD groupe integer"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE Temp_t_ven_dep_StatFacture ADD groupesecondaire integer"
	execute immediate :ls_sql using sqlca;
	
END IF

IF il_version = 13 THEN
	ls_sql = "CREATE TABLE t_recolte_cote_peremption (" + &
														"cie_no			varchar(3) 	not null, " + &
														"date_recolte	datetime		not null, " + &
														"famille			varchar(50)	not null, " + &
														"nolot			varchar(12)	not null, " + &
														"preplaboid		integer		not null, " + &
														"cote				integer		not null, " + &
														"nbdoses			integer		null, " + &													
														"transdate		datetime		null, " + &
														"PRIMARY KEY (cie_no,date_recolte,famille,nolot) )"
	execute immediate :ls_sql using sqlca;

	ls_sql = "INSERT INTO t_transfert (centre, transftype, seq, tblname,fct) VALUES ('110','REC', 6, 't_recolte_cote_peremption', 'TrDataTbl')"
	execute immediate :ls_sql using sqlca;

	ls_sql = "INSERT INTO t_transfert (centre, transftype, seq, tblname,fct) VALUES ('111','ENV', 6, 't_recolte_cote_peremption', 'TrDataTbl')"
	execute immediate :ls_sql using sqlca;

	ls_sql = "INSERT INTO t_transfert (centre, transftype, seq, tblname,fct) VALUES ('112','ENV', 6, 't_recolte_cote_peremption', 'TrDataTbl')"
	execute immediate :ls_sql using sqlca;

	ls_sql = "INSERT INTO t_transfert (centre, transftype, seq, tblname,fct) VALUES ('113','ENV', 6, 't_recolte_cote_peremption', 'TrDataTbl')"
	execute immediate :ls_sql using sqlca;
	
END IF

IF il_version = 14 THEN
	ls_sql = "ALTER TABLE t_recolte_cote_peremption ADD remarque VARCHAR(100) NULL"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 15 THEN
	Insert into messages (msgid, msgtitle, msgtext, msgicon, msgbutton, msgdefaultbutton, msgseverity, msgprint, msguserinput) VALUES ('CIPQ0160', 'Attention', 'Voulez-vous vraiment enrigistrer 2 fois le m$$HEX1$$ea00$$ENDHEX$$me produit avec le m$$HEX1$$ea00$$ENDHEX$$me verrat ?', 'Exclamation!', 'YesNo', 2, 0, 'N', 'N' );
	
	ls_sql = "ALTER TABLE t_recolte_cote_peremption MODIFY cote NULL"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 16 THEN
	ls_sql = "ALTER TABLE t_droitsusagers drop foreign key fk_user"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 17 THEN
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('110','ENV', 44, 't_associationprod')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('111','REC', 44, 't_associationprod')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('112','REC', 44, 't_associationprod')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('113','REC', 44, 't_associationprod')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfertafaire (tblname) values ('t_associationprod')"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 18 THEN
	ls_sql = "alter table t_eleveur add filtre bit null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "update t_eleveur set filtre = 0 where filtre is null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('114','REC', 44, 't_associationprod')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_eleveur_groupe"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_moyennecommorig_maj"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_moyennecommorig_maj_pure"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_moyennecommorig_melange"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_moyennecommorig_pure"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_moyenneexpsecttransp"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_moyenneexpsecttransp_maj"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_moy_exp_tra_statfacturedetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_moy_exp_tra_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_transporteur"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 19 THEN
	ls_sql = "drop table Temp_NbrDoseVendu"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Temp_QteCommande"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Temp_QteCommandeSum"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_punaise_statfacturedetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_punaise_statfacture"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 20 THEN
	ls_sql = "drop table Temp_RegistreRecolte"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Temp_RegistreRecolteMAJ"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Temp_RegistreRecolteAnalyse"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Temp_RegistreRecolteAnalyseMAJ"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 21 THEN
	ls_sql = "drop table temp_t_acc_det_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_acc_det_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_acc_som_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_acc_som_statfactureDetail"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 22 THEN
	ls_sql = "drop table tmp_liste_produit_" + this.of_getuserid()
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_cli_sec_tra_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_cli_sec_tra_statfactureDetail"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 23 THEN
	ls_sql = "drop table temp_t_com_en_lot_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_com_en_lot_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_com_heb_cen_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_com_heb_cen_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_com_heb_glo_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_com_heb_glo_statfactureDetail"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 24 THEN
	ls_sql = "drop table temp_t_com_jou_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_com_jou_statfactureDetail"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 25 THEN
	ls_sql = "alter table t_pharmacie add codebarre varchar(15) null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('110','ENV', 45, 't_observation')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('111','REC', 45, 't_observation')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('112','REC', 45, 't_observation')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('113','REC', 45, 't_observation')"
	execute immediate :ls_sql using sqlca;

	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('114','REC', 45, 't_observation')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfertafaire (tblname) values ('t_observation')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('110','ENV', 46, 't_pharmacie')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('111','REC', 46, 't_pharmacie')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('112','REC', 46, 't_pharmacie')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('113','REC', 46, 't_pharmacie')"
	execute immediate :ls_sql using sqlca;

	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname) values ('114','REC', 46, 't_pharmacie')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfertafaire (tblname) values ('t_pharmacie')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_com_men_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_com_men_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table TMP_t_CommandeOriginale_rpt"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table TMP_RptCommandeOriginale_ListeProduitExpedie"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_comm_ori_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_comm_ori_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "Insert into messages (msgid, msgtitle, msgtext, msgicon, msgbutton, msgdefaultbutton, msgseverity, msgprint, msguserinput) VALUES ('CIPQ0161', 'Attention', 'Impossible de proc$$HEX1$$e900$$ENDHEX$$der au transfert : une commande de l''$$HEX1$$e900$$ENDHEX$$leveur %s est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$e.', 'Exclamation!', 'OK', 1, 0, 'N', 'N' )"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 26 THEN
	ls_sql = "drop table temp_t_comp_det_rec_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_comp_det_rec_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_CompilationRecolte_Detail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_CompilationPure_Detail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_CompilationPure_Detail_Sommaire"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_CompilationMelange_Detail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_CompilationMelange_Detail_Sommaire"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_comp_rec_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_comp_rec_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_CompilationRecolte"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_CompilationMelange"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_CompilationPure"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 27 THEN
	ls_sql = "drop table temp_t_des_dos_spe_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_des_dos_spe_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_des_pro_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_des_pro_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_des_pro_sufa_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_des_pro_sufa_statfactureDetail"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 28 THEN
	ls_sql = "Insert into messages (msgid, msgtitle, msgtext, msgicon, msgbutton, msgdefaultbutton, msgseverity, msgprint, msguserinput) " + &
		"VALUES ('CIPQ0162', 'Attention', 'Cet $$HEX1$$e900$$ENDHEX$$leveur est dans le rouge, votre s$$HEX1$$e900$$ENDHEX$$lection est refus$$HEX1$$e900$$ENDHEX$$e.', 'Stopsign!', 'OK', 1, 0, 'N', 'N' )"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "Insert into messages (msgid, msgtitle, msgtext, msgicon, msgbutton, msgdefaultbutton, msgseverity, msgprint, msguserinput) " + &
		"VALUES ('CIPQ0163', 'Attention', 'Cet $$HEX1$$e900$$ENDHEX$$leveur n''est plus actif, voulez-vous le s$$HEX1$$e900$$ENDHEX$$lectionner quand m$$HEX1$$ea00$$ENDHEX$$me ?', 'Question!', 'YesNo', 1, 0, 'N', 'N' )"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "Insert into messages (msgid, msgtitle, msgtext, msgicon, msgbutton, msgdefaultbutton, msgseverity, msgprint, msguserinput) " + &
		"VALUES ('CIPQ0164', 'Attention', 'Cet $$HEX1$$e900$$ENDHEX$$leveur est dans le rouge, voulez-vous le s$$HEX1$$e900$$ENDHEX$$lectionner quand m$$HEX1$$ea00$$ENDHEX$$me ?', 'Question!', 'YesNo', 1, 0, 'N', 'N' )"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_exp_sec_tra_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_exp_sec_tra_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_qua_non_exp_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_qua_non_exp_statfactureDetail"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 29 THEN
	ls_sql = "drop table temp_t_som_det_fac_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_som_det_fac_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_som_exp_sec_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_som_exp_sec_statfactureDetail"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 30 THEN
	ls_sql = "alter table t_statfacturedetail modify melange varchar(150)"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_commandedetail modify melange varchar(150)"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_eleveur add droitnucleusporcin bit null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "update t_eleveur set droitnucleusporcin = isnull(droitnucleusporcin, 0)"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_recolte add type_exclu smallint null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_recolte_112 add type_exclu smallint null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_cla_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_cla_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_pharmacie add ind_utilisation smallint null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_pharmacie add dosage decimal(10,4) null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_pharmacie add poidsdosage decimal(10,4) null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_pharmacie add codebarre varchar(25) null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_pharmacie add actif bit null default 1"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "update t_pharmacie set actif = 1 where actif is null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "Insert into messages (msgid, msgtitle, msgtext, msgicon, msgbutton, msgdefaultbutton, msgseverity, msgprint, msguserinput) " + &
		"VALUES ('CIPQ0165', 'Attention', 'Il doit y avoir un poids de dosage lorsque l''indicateur d''utilisation est $$HEX2$$ab002000$$ENDHEX$$Calcul $$HEX1$$bb00$$ENDHEX$$.', 'Exclamation!', 'OK', 1, 0, 'N', 'N' )"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 31 THEN
	ls_sql = "drop table temp_t_sta_ven_clpr_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_clpr_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_mat_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_mat_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_rac_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_rac_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_velo_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_velo_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_ver_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_sta_ven_ver_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_t_Recolte_ValiderDelai"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_t_MaleRecolte"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_t_Recolte_Famille_Frequence_Reelle"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_t_Recolte"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_t_Recolte_Commande_ProduitDetail"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 32 THEN
	ls_sql = "alter table t_isolementverrat add hofa varchar(20)"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 33 THEN
	ls_sql = "Update messages set msgtext = " + &
		"'Il est impossible d''ajouter ou de modifier des d$$HEX1$$e900$$ENDHEX$$tails puisque la date d''exportation dans AccPak est pass$$HEX1$$e900$$ENDHEX$$e (%s).' where msgid = 'CIPQ0128'"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_ven_dep_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_ven_dep_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_statfacture_exped_cipq"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_statfactureDetail_exped_cipq"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_statfacture"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table temp_t_statfactureDetail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table t_statfacture_tempo"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table t_statfactureDetail_tempo"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 34 THEN
	ls_sql = "drop table tempT_RapLoc"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 35 THEN
	ls_sql = "alter table t_verrat add agressif bit not null default 0"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_verrat_fichesante add transdate datetime null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "INSERT INTO t_transfert (centre, transftype, seq, tblname,fct) VALUES ('110','ENV', 47, 't_verrat_fichesante', 'TrDataTbl')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "INSERT INTO t_transfert (centre, transftype, seq, tblname,fct) VALUES ('111','REC', 47, 't_verrat_fichesante', 'TrDataTbl')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "INSERT INTO t_transfert (centre, transftype, seq, tblname,fct) VALUES ('112','REC', 47, 't_verrat_fichesante', 'TrDataTbl')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "INSERT INTO t_transfert (centre, transftype, seq, tblname,fct) VALUES ('113','REC', 47, 't_verrat_fichesante', 'TrDataTbl')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "INSERT INTO t_transfert (centre, transftype, seq, tblname,fct) VALUES ('114','REC', 47, 't_verrat_fichesante', 'TrDataTbl')"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 36 THEN
	ls_sql = "drop table TMP_Emplacement_Vide"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 37 THEN
	ls_sql = "delete from t_transfertafaire where tblname = 't_verrat_fichesante'"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 38 THEN
	ls_sql = "drop table tmp_liste_produit_" + this.of_getuserid()
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_RaportPrintEtiquettes"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 39 THEN
	ls_sql = "Insert into messages (msgid, msgtitle, msgtext, msgicon, msgbutton, msgdefaultbutton, msgseverity, msgprint, msguserinput) " + &
		"VALUES ('CIPQ0166', 'Attention', 'Il n''y a pas de produit dans ce bon de livraison.~r~nVoulez-vous poursuivre ?', 'Exclamation!', 'YesNo', 2, 0, 'N', 'N' )"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 40 THEN
	ls_sql = "alter table t_transfert_reception add DateDonnees date null"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "alter table t_eleveur_group add actif bit null default 1"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table tmp_lab_infolot"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table tmp_lab_infolot_detail"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table tmp_problem_fact"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmp_RaportPrintEtiquettes"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmplt_Commande"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "drop table Tmplt_CommandeDetail"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 41 THEN
	ls_sql = "alter table t_verrat_fichesante modify quantite decimal(8,2), add poids smallint"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "Insert into messages (msgid, msgtitle, msgtext, msgicon, msgbutton, msgdefaultbutton, msgseverity, msgprint, msguserinput) " + &
		"VALUES ('CIPQ0167', 'Attention', 'Il existe d$$HEX1$$e900$$ENDHEX$$ja une commande en date du %s $$HEX2$$e0002000$$ENDHEX$$%s pour l''$$HEX1$$e900$$ENDHEX$$leveur %s.~r~nD$$HEX1$$e900$$ENDHEX$$sirez-vous l''importer quand m$$HEX1$$ea00$$ENDHEX$$me ?', 'Question!', 'YesNo', 2, 0, 'N', 'N' )"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 42 THEN

	ls_sql = "CREATE TABLE t_emplacementverrat( dateemplacement DATE NOT NULL, &
															  cie_no VARCHAR(3) NOT NULL, &
															  tatouage VARCHAR(20) NOT NULL, &
															  emplacement VARCHAR(100) NULL, &
															  PRIMARY KEY(tatouage,dateemplacement,cie_no))"
	execute immediate :ls_sql using sqlca;
	
//	ls_sql = "ALTER TABLE t_pharmacie ADD traitementmultiple BIT NULL"
//	execute immediate :ls_sql using sqlca;
	
	ls_sql = "ALTER TABLE t_verrat_cause MODIFY id_cause DEFAULT autoincrement"
	execute immediate :ls_sql using sqlca;
			
END IF

IF il_version = 43 THEN

	ls_sql = "ALTER TABLE t_emplacementverrat ADD transdate DATETIME NULL"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "INSERT INTO t_transfertafaire(tblname,afaire) values('t_emplacementverrat',1)"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname, fct) values ('110','ENV', 48, 't_emplacementverrat','TrDataTbl')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname, fct) values ('111','REC', 48, 't_emplacementverrat','TrDataTbl')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname, fct) values ('112','REC', 48, 't_emplacementverrat','TrDataTbl')"
	execute immediate :ls_sql using sqlca;
	
	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname, fct) values ('113','REC', 48, 't_emplacementverrat','TrDataTbl')"
	execute immediate :ls_sql using sqlca;

	ls_sql = "insert into t_transfert (centre, transftype, seq, tblname, fct) values ('114','REC', 48, 't_emplacementverrat','TrDataTbl')"
			
END IF

IF il_version = 44 THEN

	ls_sql = "ALTER TABLE t_isolementverrat ADD cie_no INTEGER NULL"
	execute immediate :ls_sql using sqlca;
				
END IF

IF il_version = 45 THEN
	ls_sql = "ALTER TABLE t_recolte_cote_peremption ADD datecontrole DATE NULL"
	execute immediate :ls_sql using sqlca;
END IF


IF il_version = 46 THEN
	ls_sql = "ALTER TABLE t_verrat ADD asortir DATE NULL"
END IF

IF il_version = 47 THEN
	ls_sql = "ALTER TABLE t_parametre ADD corrpath VARCHAR(500) NULL"
	execute immediate :ls_sql using sqlca;
	ls_sql = "ALTER TABLE t_parametre ADD wordpath VARCHAR(500) NULL"
	execute immediate :ls_sql using sqlca;
END IF

IF il_version = 48 THEN
	//ls_sql = "INSERT INTO t_transfertafaire(tblname,afaire) values('t_AllianceMaternelle_Recolte_GestionLot_Verrat',1)"
	//execute immediate :ls_sql using sqlca;
END IF


end subroutine

public function string of_sqllisteverrats (long al_noclient);return "select t_verrat.codeverrat,~r~n" + &
"t_verrat.nom,~r~n" + &
"t_verrat.tatouage,~r~n" + &
"t_verrat.typeverrat,~r~n" + &
"t_verrat.cie_no,~r~n" + &
"t_verrat.classe,~r~n" + &
"t_verrat.messagerecolte,~r~n" + &
"t_verrat.coderace~r~n " + &
"FROM t_Eleveur inner join T_Verrat on t_Eleveur.No_Eleveur = '"+string(al_noclient)+"'~r~n" + &
"left outer join t_ELEVEUR_Group on t_ELEVEUR_Group.Code_H$$HEX1$$e900$$ENDHEX$$bergeur = Left(T_Verrat.CodeVerrat,1)~r~n" + &
"left outer join t_Eleveur_CodeHebergeur on Left(t_Verrat.CodeVerrat,1) = t_Eleveur_CodeHebergeur.CodeHebergeur~r~n" + &
"and t_Eleveur_CodeHebergeur.No_Eleveur = '"+string(al_noclient)+"' and t_Eleveur_CodeHebergeur.DroitVerrat = 1~r~n" + &
"WHERE T_Verrat.ELIMIN Is Null~r~n" + &
"	and ((T_Verrat.TypeVerrat = 1~r~n" + &
"		and (t_ELEVEUR_Group.Code_Hebergeur Is Null~r~n" + &
"			or t_Eleveur_CodeHebergeur.CodeHebergeur is not null))~r~n" + &
"		or (t_Verrat.TypeVerrat = 2~r~n" + &
"			and t_Eleveur.DroitVerratExclusif = 1)~r~n" + &
"		or (t_Verrat.TypeVerrat = 3~r~n" + &
"			and t_Eleveur.DroitNucleusPorcin = 1))~r~n" + &
"order by T_Verrat.CodeVerrat asc"
end function

public function boolean of_checkifpunaiseopen ();boolean	lb_punaise_open
string	ls_cie

ls_cie = gnv_app.of_getcompagniedefaut( )

SELECT	punaise_open
INTO		:lb_punaise_open
FROM 		t_centrecipq
WHERE		cie = :ls_cie;

IF IsNull(lb_punaise_open) OR lb_punaise_open = FALSE THEN
	UPDATE	t_centrecipq 
	SET		punaise_open = 1
	WHERE		cie = :ls_cie;
	RETURN FALSE
ELSE
	RETURN TRUE
END IF
end function

public subroutine of_verrat_famille_frequence_recolte_vali (date ad_de, date ad_a);Dec		ldec_qte = 0.00, ldec_qteinit = 0.00
long		ll_count = 0, ll_nbdose, ll_rowcount, ll_cpt, ll_count_verrat, ll_qte, ll_quantite_01, ll_quantite_02, &
			ll_quantite_03, ll_quantite_04, ll_quantite_05, ll_quantite_06, ll_qteCumul, ll_nbdose_01, ll_nbdose_02, &
			ll_nbdose_03, ll_nbdose_04, ll_nbdose_05, ll_nbdose_06, ll_nb
dec		ldec_frequence = 0.00, ldec_ratio1 = 0.00, ldec_ratio2 = 0.00, ldec_ratio3 = 0.00, ldec_ratio4 = 0.00, &
			ldec_ratio5 = 0.00, ldec_ratio6 = 0.00
string	ls_famille, ls_cie, ls_sql
w_r_frequence_recolte_famille_ajout	lw_wind
n_ds		lds_frequence

SetPointer(HourGlass!)

select count(1) into :ll_nb from #Tmp_recolte;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_recolte (norecolte integer not null,~r~n" + &
													"cie_no varchar(3) not null,~r~n" + &
													"codeverrat varchar(12) not null,~r~n" + &
													"date_recolte datetime null,~r~n" + &
													"volume double null,~r~n" + &
													"absorbance double null,~r~n" + &
													"ampo_total double null,~r~n" + &
													"ampo_faite double null,~r~n" + &
													"type_sem varchar(1) null,~r~n" + &
													"pourc_dechets double null,~r~n" + &
													"prepose integer null,~r~n" + &
													"jeudi varchar(1) null,~r~n" + &
													"concentration double null,~r~n" + &
													"nbr_sperm integer null,~r~n" + &
													"transdate datetime null,~r~n" + &
													"heure_recolte datetime null,~r~n" + &
													"classe varchar(20) null,~r~n" + &
													"motilite_p integer null,~r~n" + &
													"collectis bit null,~r~n" + &
													"exclusif bit null,~r~n" + &
													"gedis bit null,~r~n" + &
													"validation bit null,~r~n" + &
													"heure_analyse datetime null,~r~n" + &
													"ancien_codeverrat varchar(12) null,~r~n" + &
													"heure_edition datetime null,~r~n" + &
													"messagerecolte varchar(150) null,~r~n" + &
													"compteurpunch integer null,~r~n" + &
													"preplaboid integer null,~r~n" + &
													"emplacement varchar(6) null,~r~n" + &
													"type_exclu smallint null,~r~n" + &
													"primary key (norecolte, cie_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ai_rec on #Tmp_recolte (norecolte asc,~r~n" + &
																 "cie_no asc,~r~n" + &
																 "codeverrat asc,~r~n" + &
																 "date_recolte asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create clustered index ai_rec_v on #Tmp_recolte (codeverrat asc,~r~n" + &
																				 "date_recolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ix_heure on #Tmp_recolte (norecolte asc,~r~n" + &
																	"cie_no asc,~r~n" + &
																	"date_recolte desc,~r~n" + &
																	"heure_recolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_12_4 on #Tmp_recolte (codeverrat asc,~r~n" + &
																	"exclusif asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_fdsfds_2 on #Tmp_recolte (date_recolte desc,~r~n" + &
																		 "norecolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil_4 on #Tmp_recolte (date_recolte asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil1_1 on #Tmp_recolte (cie_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil1_2 on #Tmp_recolte (codeverrat asc,~r~n" + &
																		"cie_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_recolte;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Tmp_Recolte_Famille_Frequence_Reelle;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_Recolte_Famille_Frequence_Reelle (famille varchar(15) not null,~r~n" + &
													"cie_no varchar(3) not null,~r~n" + &
													"quantite_01 integer null,~r~n" + &
													"quantite_02 integer null,~r~n" + &
													"quantite_03 integer null,~r~n" + &
													"quantite_04 integer null,~r~n" + &
													"quantite_05 integer null,~r~n" + &
													"quantite_06 integer null,~r~n" + &
													"nb_dose_01 integer null,~r~n" + &
													"nb_dose_02 integer null,~r~n" + &
													"nb_dose_03 integer null,~r~n" + &
													"nb_dose_04 integer null,~r~n" + &
													"nb_dose_05 integer null,~r~n" + &
													"nb_dose_06 integer null,~r~n" + &
													"nbdosemoyenne float null,~r~n" + &
													"primary key (famille, cie_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_Recolte_Famille_Frequence_Reelle;
	commit using sqlca;
end if

//V$$HEX1$$e900$$ENDHEX$$rifier si ajout

SELECT count(t_Verrat_Classe.Famille)
INTO	:ll_count
FROM t_Verrat_Classe
INNER JOIN t_verrat ON (t_Verrat_Classe.ClasseVerrat = T_Verrat.Classe )
LEFT JOIN t_Verrat_Famille_Frequence_Recolte 
ON (t_Verrat.CIE_NO = t_Verrat_Famille_Frequence_Recolte.CIE_NO) 
AND (t_Verrat_Classe.Famille = t_Verrat_Famille_Frequence_Recolte.Famille)
WHERE T_Verrat.ELIMIN Is Null AND 
(((t_Verrat_Famille_Frequence_Recolte.Famille) Is Null) 
AND ((t_Verrat_Famille_Frequence_Recolte.CIE_NO) Is Null))
GROUP BY t_Verrat_Classe.Famille, t_Verrat.CIE_NO
ORDER BY t_verrat_classe.Famille, t_verrat.CIE_NO;

IF ll_count > 0 THEN
	//On a des donn$$HEX1$$e900$$ENDHEX$$es, on imprime le r$$HEX1$$e900$$ENDHEX$$sultat
	gnv_app.inv_error.of_message("CIPQ0073")
	
	OpenSheet(lw_wind, gnv_app.of_GetFrame(), 6, layered!)
	SetPointer(HourGlass!)
	//Quand ferm$$HEX1$$e900$$ENDHEX$$, faire l'insertion
	INSERT INTO t_Verrat_Famille_Frequence_Recolte (famille, cie_no, nbverrat, frequence, nbdosemoyenne) 
	SELECT t_Verrat_Classe.Famille, 
	t_Verrat.CIE_NO, 
	Count(t_Verrat.CodeVerrat) AS NbVerrat, 
	2 AS Frequence,
	:ll_nbdose as cc_nb_dose_moyenne
	FROM t_Verrat_Classe
	INNER JOIN t_verrat ON (t_Verrat_Classe.ClasseVerrat = T_Verrat.Classe )
	LEFT JOIN t_Verrat_Famille_Frequence_Recolte 
	ON (t_Verrat.CIE_NO = t_Verrat_Famille_Frequence_Recolte.CIE_NO) 
	AND ((t_Verrat_Classe.Famille) = (t_Verrat_Famille_Frequence_Recolte.Famille))
	WHERE T_Verrat.ELIMIN Is Null AND 
	(((t_Verrat_Famille_Frequence_Recolte.Famille) Is Null) 
	AND ((t_Verrat_Famille_Frequence_Recolte.CIE_NO) Is Null))
	GROUP BY t_Verrat_Classe.Famille, t_Verrat.CIE_NO
	ORDER BY t_verrat_classe.Famille, t_verrat.CIE_NO	USING SQLCA;
	
END IF

//2008-12-12 	Mathieu Gendron
//Pr$$HEX1$$e900$$ENDHEX$$parer les chiffres de ratio de quantit$$HEX1$$e900$$ENDHEX$$s pour toutes les familles
//Comme dans fr$$HEX1$$e900$$ENDHEX$$quence des r$$HEX1$$e900$$ENDHEX$$coltes r$$HEX1$$e900$$ENDHEX$$elles
INSERT INTO #Tmp_recolte 
SELECT 	t_RECOLTE.* 
FROM 		t_RECOLTE 
INNER JOIN t_Verrat_Classe 
ON t_RECOLTE.Classe = t_Verrat_Classe.ClasseVerrat 
WHERE date(t_RECOLTE.DATE_recolte) >= :ad_de And date(t_RECOLTE.DATE_recolte) <= :ad_a ;
COMMIT USING SQLCA;

SetPointer(HourGlass!)

INSERT INTO #Tmp_Recolte_Famille_Frequence_Reelle 
( Famille, CIE_NO, Quantite_01, Quantite_02, Quantite_03, Quantite_04, Quantite_05, Quantite_06, Nb_Dose_01, Nb_Dose_02, Nb_Dose_03, Nb_Dose_04, Nb_Dose_05, Nb_Dose_06 )

SELECT DISTINCT
t_Verrat_Classe.Famille, 
#Tmp_recolte.CIE_NO,

isnull((select count(1) from #Tmp_recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 1 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat1,

isnull((select count(1) from #Tmp_recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 2 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat2,

isnull((select count(1) from #Tmp_recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 3 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat3,

isnull((select count(1) from #Tmp_recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 4 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat4,

isnull((select count(1) from #Tmp_recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 5 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat5,

isnull((select count(1) from #Tmp_recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 6 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat6,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 1 AND 
doses1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses1,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 2 AND 
doses1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses2,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 3 AND 
doses1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses3,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 4 AND 
doses1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses4,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 5 AND 
doses1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses5,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 6 AND 
doses1.cie_no = #Tmp_recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses6

FROM t_Verrat_Classe INNER JOIN #Tmp_recolte ON (t_Verrat_Classe.ClasseVerrat = #Tmp_recolte.Classe);
COMMIT USING SQLCA;

SetPointer(HourGlass!)
//2008-12-12 FIN

//On recalcul le tout
lds_frequence = CREATE n_ds
lds_frequence.dataobject = "ds_frequence_recolte"
lds_frequence.of_setTransobject(SQLCA)
ll_rowcount = lds_frequence.Retrieve()

FOR ll_cpt = 1 TO ll_rowcount
	SetPointer(HourGlass!)
	
	ls_famille = lds_frequence.object.famille[ll_cpt]
	ls_cie = lds_frequence.object.cie_no[ll_cpt]
	
	//MAJ du nombre de verrat dans cette famille pour ce centre
	SELECT Count(T_Verrat.CodeVerrat)
	INTO	:ll_count_verrat
	FROM T_Verrat, t_Verrat_Classe
	WHERE upper(T_Verrat.Classe) = upper(t_Verrat_Classe.ClasseVerrat) 
		AND upper(t_Verrat_Classe.Famille) = upper(:ls_famille) AND 
	t_Verrat.CIE_NO=:ls_cie AND T_Verrat.ELIMIN Is Null USING SQLCA;

	If IsNull(ll_count_verrat) THEN ll_count_verrat = 0
	lds_frequence.object.nbverrat[ll_cpt] = ll_count_verrat
	
	ldec_frequence = lds_frequence.object.frequence[ll_cpt]
	IF IsNull(ldec_frequence) THEN
		ldec_frequence = 1
		lds_frequence.object.frequence[ll_cpt] = 1
	END IF
	
	//ll_nbdose = lds_frequence.object.nbdosemoyenne[ll_cpt]
	//IF IsNull(ll_nbdose) THEN
		ll_nbdose = gnv_app.of_getnbdosesmoyenne( )
		lds_frequence.object.nbdosemoyenne[ll_cpt] = ll_nbdose
	//END IF
	
	//Calcul selon NbVerrat et Frequence
	ll_qte = round(ldec_frequence * ll_count_verrat,0)
	ll_quantite_01 = lds_frequence.object.quantite_01[ll_cpt]
	If IsNull(ll_quantite_01) THEN ll_quantite_01 = 0
	ll_quantite_02 = lds_frequence.object.quantite_02[ll_cpt]
	If IsNull(ll_quantite_02) THEN ll_quantite_02 = 0
	ll_quantite_03 = lds_frequence.object.quantite_03[ll_cpt]
	If IsNull(ll_quantite_03) THEN ll_quantite_03 = 0
	ll_quantite_04 = lds_frequence.object.quantite_04[ll_cpt]
	If IsNull(ll_quantite_04) THEN ll_quantite_04 = 0
	ll_quantite_05 = lds_frequence.object.quantite_05[ll_cpt]
	If IsNull(ll_quantite_05) THEN ll_quantite_05 = 0
	ll_qteCumul = ll_quantite_01 + ll_quantite_02 + ll_quantite_03 + ll_quantite_04 + ll_quantite_05
	ll_quantite_06 = round(ll_qte - ll_qteCumul,0)
	lds_frequence.object.quantite_06[ll_cpt] = ll_quantite_06
	
	//Calcul des doses r$$HEX1$$e900$$ENDHEX$$coltables
	
//	lds_frequence.object.nb_dose_01[ll_cpt] = ll_quantite_01 * ll_nbdose
//	lds_frequence.object.nb_dose_02[ll_cpt] = ll_quantite_02 * ll_nbdose
//	lds_frequence.object.nb_dose_03[ll_cpt] = ll_quantite_03 * ll_nbdose
//	lds_frequence.object.nb_dose_04[ll_cpt] = ll_quantite_04 * ll_nbdose
//	lds_frequence.object.nb_dose_05[ll_cpt] = ll_quantite_05 * ll_nbdose
//	lds_frequence.object.nb_dose_06[ll_cpt] = ll_quantite_06 * ll_nbdose
	
	//2008-12-11 Mathieu Gendron Nouvelle fa$$HEX1$$e700$$ENDHEX$$on de calculer le nombre de doses
	// Calcul par jour de la semaine
	
	SELECT 	if quantite_01 = 0 then
					0.00
				else
					isnull(nb_dose_01, 0) / cast(isnull(quantite_01,1) as decimal(10,2))
				endif as ratio1,
				if quantite_02 = 0 then
					0.00
				else
					isnull(nb_dose_02, 0) / cast(isnull(quantite_02,1) as decimal(10,2))
				endif as ratio2,
				if quantite_03 = 0 then
					0.00
				else
					isnull(nb_dose_03, 0) / cast(isnull(quantite_03,1) as decimal(10,2))
				endif as ratio3,
				if quantite_04 = 0 then
					0.00
				else
					isnull(nb_dose_04, 0) / cast(isnull(quantite_04,1) as decimal(10,2))
				endif as ratio4,
				if quantite_05 = 0 then
					0.00
				else
					isnull(nb_dose_05, 0) / cast(isnull(quantite_05,1) as decimal(10,2))
				endif as ratio5,
				if quantite_06 = 0 then
					0.00
				else
					isnull(nb_dose_06, 0) / cast(isnull(quantite_06,1) as decimal(10,2))
				endif as ratio6
	INTO		:ldec_ratio1,
				:ldec_ratio2,
				:ldec_ratio3,
				:ldec_ratio4,
				:ldec_ratio5,
				:ldec_ratio6
	FROM		#Tmp_Recolte_Famille_Frequence_Reelle
	WHERE 	famille = :ls_famille and cie_no = :ls_cie ;
	
	IF ldec_ratio1 = 0 THEN ldec_ratio1 = ll_nbdose
	IF ldec_ratio2 = 0 THEN ldec_ratio2 = ll_nbdose
	IF ldec_ratio3 = 0 THEN ldec_ratio3 = ll_nbdose
	IF ldec_ratio4 = 0 THEN ldec_ratio4 = ll_nbdose
	IF ldec_ratio5 = 0 THEN ldec_ratio5 = ll_nbdose
	IF ldec_ratio6 = 0 THEN ldec_ratio6 = ll_nbdose
	
	lds_frequence.object.nb_dose_01[ll_cpt] = ll_quantite_01 * ldec_ratio1
	lds_frequence.object.nb_dose_02[ll_cpt] = ll_quantite_02 * ldec_ratio2
	lds_frequence.object.nb_dose_03[ll_cpt] = ll_quantite_03 * ldec_ratio3
	lds_frequence.object.nb_dose_04[ll_cpt] = ll_quantite_04 * ldec_ratio4
	lds_frequence.object.nb_dose_05[ll_cpt] = ll_quantite_05 * ldec_ratio5
	lds_frequence.object.nb_dose_06[ll_cpt] = ll_quantite_06 * ldec_ratio6
	
	//Mathieu Gendron	2008-12-15 Sauvegarde des ratios
	lds_frequence.object.ratio1[ll_cpt] = ldec_ratio1
	lds_frequence.object.ratio2[ll_cpt] = ldec_ratio2
	lds_frequence.object.ratio3[ll_cpt] = ldec_ratio3
	lds_frequence.object.ratio4[ll_cpt] = ldec_ratio4
	lds_frequence.object.ratio5[ll_cpt] = ldec_ratio5
	lds_frequence.object.ratio6[ll_cpt] = ldec_ratio6
	
END FOR

lds_frequence.Update(TRUE,TRUE)
If IsValid(lds_frequence) THEN Destroy(lds_frequence)

//Supprimer les centres o$$HEX2$$f9002000$$ENDHEX$$nbverrats=0
DELETE from t_Verrat_Famille_Frequence_Recolte
WHERE t_Verrat_Famille_Frequence_Recolte.NbVerrat=0 USING SQLCA;

//gnv_app.inv_error.of_message( "CIPQ0036")

gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat_Famille_Frequence_Recolte", TRUE)
end subroutine

public function integer of_cree_tablefact_temp (string as_table_name);// Fonction of_Cree_TableFact_Temp
// Cr$$HEX1$$e900$$ENDHEX$$e une table temporaire pour les factures et les d$$HEX1$$e900$$ENDHEX$$tails avec le nom pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$e800$$ENDHEX$$tre
string ls_sql

ls_sql = "select count(1) from #" + as_table_name
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

if SQLCA.SQLCode = -1 then
	ls_sql = "create table #" + as_table_name + " (cie_no varchar(3) not null,~r~n" + &
																"liv_no varchar(7) not null,~r~n" + &
																"fact_no varchar(8) null,~r~n" + &
																"reg_agr varchar(2) null,~r~n" + &
																"no_eleveur integer null,~r~n" + &
																"vend_no integer null,~r~n" + &
																"fact_date datetime null,~r~n" + &
																"liv_date datetime null,~r~n" + &
																"ampm varchar(2) null,~r~n" + &
																"credit double null,~r~n" + &
																"message_liv varchar(75) null,~r~n" + &
																"boncommandeclient varchar(7) null,~r~n" + &
																"idtransporteur integer null,~r~n" + &
																"transdate datetime null,~r~n" + &
																"dicom bit null,~r~n" + &
																"accpac_date datetime null,~r~n" + &
																"vente float null,~r~n" + &
																"taxep float null,~r~n" + &
																"taxef float null,~r~n" + &
																"modif_date datetime null,~r~n" + &
																"pourc_fed float null,~r~n" + &
																"pourc_prov float null,~r~n" + &
																"billing_cycle_code varchar(6) null,~r~n" + &
																"groupe integer null,~r~n" + &
																"groupesecondaire integer null,~r~n" + &
																"primary key (cie_no, liv_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create clustered index ix1 on #" + as_table_name + " (cie_no asc,~r~n" + &
																						"liv_no asc,~r~n" + &
																						"liv_date asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ix2 on #" + as_table_name + " (no_eleveur asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ix3 on #" + as_table_name + " (liv_date asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ix4 on #" + as_table_name + " (fact_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_s_1 on #" + as_table_name + " (fact_date asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	ls_sql = "delete from #" + as_table_name
	execute immediate :ls_sql using SQLCA;
	commit using sqlca;
end if

ls_sql = "select count(1) from #" + as_table_name + "detail"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

if SQLCA.SQLCode = -1 then
	ls_sql = "create table #" + as_table_name + "detail (cie_no varchar(3) not null,~r~n" + &
																		 "liv_no varchar(7) not null,~r~n" + &
																		 "ligne_no double not null,~r~n" + &
																		 "prod_no varchar(16) null,~r~n" + &
																		 "verrat_no varchar(12) null,~r~n" + &
																		 "qte_comm double null,~r~n" + &
																		 "qte_exp double null,~r~n" + &
																		 "uprix double null,~r~n" + &
																		 "description varchar(50) null,~r~n" + &
																		 "melange varchar(150) null,~r~n" + &
																		 "qteinit integer null,~r~n" + &
																		 "noligneheader integer null,~r~n" + &
																		 "choix integer null,~r~n" + &
																		 "noitem integer null,~r~n" + &
																		 "id_depot integer null,~r~n" + &
																		 "date_expedie_depot datetime null,~r~n" + &
																		 "primary key (cie_no, liv_no, ligne_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ix1 on #" + as_table_name + "detail (cie_no asc,~r~n" + &
																				  "liv_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create clustered index ix2 on #" + as_table_name + "detail (ligne_no asc,~r~n" + &
																								"cie_no asc,~r~n" + &
																								"liv_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ix3 on #" + as_table_name + "detail (cie_no asc,~r~n" + &
																				  "liv_no asc,~r~n" + &
																				  "ligne_no asc,~r~n" + &
																				  "prod_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ix4 on #" + as_table_name + "detail (liv_no asc,~r~n" + &
																				  "prod_no asc,~r~n" + &
																				  "cie_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ix5 on #" + as_table_name + "detail (liv_no asc,~r~n" + &
																				  "cie_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_ee_2 on #" + as_table_name + "detail (prod_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	ls_sql = "delete from #" + as_table_name + "detail"
	execute immediate :ls_sql using SQLCA;
	commit using sqlca;
end if

return 1
end function

public subroutine of_dotmpemplacementvide (date adt_de);String ls_Value, ls_Place, ls_SQL, ls_emplacement, ls_cieno
Integer li_NoParc, li_section, li_noparcdebut, li_noparcfin
Long ll_nb

//#TMP_Emplacement_Vide
select count(1) into :ll_nb from #TMP_Emplacement_Vide;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #TMP_Emplacement_Vide (Emplacement varchar(6) null,~r~n" + &
																	  "CIE_NO varchar(3) null,~r~n" + &
																	  "No_Parc integer null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #TMP_Emplacement_Vide;
	commit using sqlca;
end if

//If Not IsNull(Forms!frmRapport.CboCie) And Forms!frmRapport.CboCie <> "*" Then
//    MonSQL = MonSQL + " WHERE (((tblEmplacement_Section.CIE_NO)='" + Forms!frmRapport.CboCie + "'))"
//End If
n_ds		lds_t_Emplacement_Section
long		ll_rowcount
integer  li_i

lds_t_Emplacement_Section = CREATE n_ds
lds_t_Emplacement_Section.dataobject = "ds_Emplacement_Section"
lds_t_Emplacement_Section.of_setTransobject(SQLCA)
ll_rowcount = lds_t_Emplacement_Section.Retrieve()
For li_i = 1 to ll_rowcount
	ls_emplacement = lds_t_Emplacement_Section.getitemstring(li_i, "emplacement")
	ls_cieno = lds_t_Emplacement_Section.getitemstring(li_i, "cie_no")
	li_section = lds_t_Emplacement_Section.getitemnumber(li_i, "section")
	li_noparcdebut = lds_t_Emplacement_Section.getitemnumber(li_i, "noparc_debut")
	li_noparcfin = lds_t_Emplacement_Section.getitemnumber(li_i, "noparc_fin")
    If Not IsNull(li_noparcdebut) And Not IsNull(li_noparcfin) Then
        For li_NoParc = li_noparcdebut To li_noparcfin
            ls_Place = ls_emplacement + "-" + string(li_NoParc)
				ls_value = ""
				SELECT 	t_Verrat.CodeVerrat
				INTO		:ls_Value
				FROM		t_Verrat INNER JOIN t_emplacementverrat ON t_emplacementverrat.tatouage = T_Verrat.tatouage AND 
                                                                                   t_emplacementverrat.dateemplacement = (select max(dateemplacement) 
                                                                                                                          from t_emplacementverrat as verremp 
                                                                                                                          where verremp.tatouage = t_emplacementverrat.tatouage and 
                                                                                                                                :adt_de >= verremp.dateemplacement)
				WHERE		:adt_de between t_Verrat.ENTPRODUCT and isNull(t_Verrat.ELIMIN, :adt_de) AND 
							(t_emplacementverrat.CIE_NO) = (:ls_cieno) AND 
							(t_emplacementverrat.Emplacement) = (:ls_place) USING SQLCA;
				
	           If IsNull(ls_Value) or ls_value = "" Then
	            INSERT INTO #TMP_Emplacement_Vide ( Emplacement, CIE_NO, No_Parc ) 
					Values( :ls_emplacement, :ls_cieno, :li_NoParc);
					//FROM t_emplacement_Section;
					COMMIT USING SQLCA;
			End If
        Next
    End If
Next

end subroutine

public subroutine of_dotmpemplacementvide ();String ls_Value, ls_Place, ls_SQL, ls_emplacement, ls_cieno
Integer li_NoParc, li_section, li_noparcdebut, li_noparcfin
Long ll_nb

//#TMP_Emplacement_Vide
select count(1) into :ll_nb from #TMP_Emplacement_Vide;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #TMP_Emplacement_Vide (Emplacement varchar(6) null,~r~n" + &
																	  "CIE_NO varchar(3) null,~r~n" + &
																	  "No_Parc integer null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #TMP_Emplacement_Vide;
	commit using sqlca;
end if

//If Not IsNull(Forms!frmRapport.CboCie) And Forms!frmRapport.CboCie <> "*" Then
//    MonSQL = MonSQL + " WHERE (((tblEmplacement_Section.CIE_NO)='" + Forms!frmRapport.CboCie + "'))"
//End If
n_ds		lds_t_Emplacement_Section
long		ll_rowcount
integer  li_i

lds_t_Emplacement_Section = CREATE n_ds
lds_t_Emplacement_Section.dataobject = "ds_Emplacement_Section"
lds_t_Emplacement_Section.of_setTransobject(SQLCA)
ll_rowcount = lds_t_Emplacement_Section.Retrieve()
For li_i = 1 to ll_rowcount
	ls_emplacement = lds_t_Emplacement_Section.getitemstring(li_i, "emplacement")
	ls_cieno = lds_t_Emplacement_Section.getitemstring(li_i, "cie_no")
	li_section = lds_t_Emplacement_Section.getitemnumber(li_i, "section")
	li_noparcdebut = lds_t_Emplacement_Section.getitemnumber(li_i, "noparc_debut")
	li_noparcfin = lds_t_Emplacement_Section.getitemnumber(li_i, "noparc_fin")
    If Not IsNull(li_noparcdebut) And Not IsNull(li_noparcfin) Then
        For li_NoParc = li_noparcdebut To li_noparcfin
            ls_Place = ls_emplacement + "-" + string(li_NoParc)
				ls_value = ""
				SELECT 	t_Verrat.CodeVerrat
				INTO		:ls_Value
				FROM		t_Verrat
				WHERE		(t_Verrat.CIE_NO) = (:ls_cieno) AND (t_Verrat.Emplacement) = (:ls_place) USING SQLCA;
				
            If IsNull(ls_Value) or ls_value = "" Then
	            INSERT INTO #TMP_Emplacement_Vide ( Emplacement, CIE_NO, No_Parc ) 
					Values( :ls_emplacement, :ls_cieno, :li_NoParc);
					//FROM t_emplacement_Section;
					COMMIT USING SQLCA;
			End If
        Next
    End If
Next

end subroutine

on n_cst_cipq_appmanager.create
call super::create
end on

on n_cst_cipq_appmanager.destroy
call super::destroy
end on

event constructor;call super::constructor;//Instantiation du service de l'entrep$$HEX1$$f400$$ENDHEX$$t global
THIS.of_SetEntrepotGlobal(TRUE)
THIS.of_setVersion("1.3.4.2")

// Instancier le service de fichier
inv_filesrv = CREATE n_cst_filesrvwin32

//V$$HEX1$$e900$$ENDHEX$$rification date syst$$HEX1$$e800$$ENDHEX$$me
string ls_from_reg = ''

RegistryGet("HKEY_CURRENT_USER\Control Panel\International","sShortDate", RegString!, ls_from_reg)
//if ls_from_reg <> 'dd-MM-yyyy' and ls_from_reg <> 'jj-MM-aaaa' then
if lower(ls_from_reg) <> 'yyyy-mm-dd' and lower(ls_from_reg) <> 'aaaa-mm-jj' then
	Messagebox("Attention", 'La date du poste de travail doit $$HEX1$$ea00$$ENDHEX$$tre dans le format : "aaaa-MM-jj" ou "yyyy-MM-dd"')
	gnv_app.event pfc_close()
end if

end event

event pfc_open;call super::pfc_open;n_cst_logonattrib	lnv_attrib
string	ls_user, ls_path, ls_odbc
long		ll_logged_in = 0

RegistryGet( "HKEY_CURRENT_USER\Software\Progitek\cipq", "LogId", ls_user)
IF IsNull(ls_user) THEN ls_user = ""

lnv_attrib.is_userid = ls_user
OpenWithParm(w_cipq_logon,lnv_attrib)
IF long(THIS.inv_entrepotglobal.of_retournedonnee("retour login", FALSE)) <> 1 THEN
	HALT CLOSE
END IF		


//Instantiation du service d'erreur
THIS.of_SetError(TRUE)
THIS.inv_error.of_SetStyle(inv_error.PFCWINDOW)
THIS.inv_error.of_SetPredefinedSource(SQLCA)

//Instantiation du service de traduction de messages
THIS.of_SetMessageFrancais(TRUE)

//Instantiation du service d'impression du journal de commandes
THIS.of_SetJournal(TRUE)

// Initialiser la ligne MicroHelp
THIS.iapp_object.microhelpdefault = "Pr$$HEX1$$ea00$$ENDHEX$$t"

//Pour franciser la barre d'outils
THIS.iapp_object.ToolbarSheetTitle = "Barre d'outils"
THIS.iapp_object.ToolbarPopMenuText="&Gauche,&Haut,&Droite,&Bas,&Flottante,Afficher &texte,Afficher &info-bulles"

// D$$HEX1$$e900$$ENDHEX$$termin$$HEX2$$e9002000$$ENDHEX$$l'environnement
IF Handle(getapplication()) = 0 THEN 
	inv_EntrepotGlobal.of_AjouteDonnee("environnement", "DEV")
ELSE
	inv_EntrepotGlobal.of_AjouteDonnee("environnement", "PROD")
END IF 
// Path de l'application
// Le path en ex$$HEX1$$e900$$ENDHEX$$cutable
ls_path = getcurrentdirectory()
IF RIGHT(ls_path,1) <> "\" THEN
 ls_path += "\"
END IF
inv_EntrepotGlobal.of_AjouteDonnee("path", ls_path)

//Fichier ini
ls_odbc = gnv_app.inv_entrepotglobal.of_retournedonnee('ODBC_INI')
if ls_odbc = 'cipqstpat' then 
	of_SetAppIniFile("Z:\CIPQ\cipqstpat.ini")
else
	of_SetAppIniFile("Z:\CIPQ\cipq.ini")
end if

inv_dernieracces = CREATE n_cst_dernier_acces

gnv_app.inv_EntrepotGlobal.of_AjouteDonnee("Code application", "CIPQ")
gnv_app.inv_EntrepotGlobal.of_AjouteDonnee("Login usager", is_userid)

THIS.of_updatetable()

inv_api = CREATE n_cst_platformwin32

SELECT 	logged_in
INTO 		:ll_logged_in
FROM		t_users
WHERE 	id_user = :il_id_user;

IF ll_logged_in = 1 THEN
	IF Messagebox("Question", "Le syst$$HEX1$$e800$$ENDHEX$$me d$$HEX1$$e900$$ENDHEX$$tecte que vous $$HEX1$$ea00$$ENDHEX$$tes d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$connect$$HEX1$$e900$$ENDHEX$$. Voulez-vous continuer?", Information!, YesNo!, 2) = 2 THEN
		HALT CLOSE
	END IF
END IF

UPDATE t_users SET logged_in = 1 WHERE id_user = :il_id_user;

THIS.of_setFrame(w_application)
Open(w_application)
end event

event pfc_close;call super::pfc_close;IF IsValid(gnv_app.inv_dernieracces) THEN Destroy gnv_app.inv_dernieracces

If IsValid(inv_filesrv) THEN DESTROY inv_filesrv
If IsValid(inv_api) THEN DESTROY inv_api

end event

event destructor;call super::destructor;THIS.of_SetMessageFrancais(FALSE)
end event

event pfc_systemerror;// 2007-10-26	Mathieu Gendron
//Override pour pas quitter


//////////////////////////////////////////////////////////////////////////////
//
//	Event:  PFC_systemerror
//
//	Arguments:	None
//
//	Returns:  None
//
//
//	Description:  Triggered whenever the a system level error occurs.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////
string 	ls_message
string	ls_msgparm[1]

ls_message = 'Error Number '+string(error.number) & 
	+'.~r~nError text = '+Error.text &
	+'.~r~nWindow/Menu/Object = '+error.windowmenu &
	+'.~r~nError Object/Control = '+Error.object &
	+'.~r~nScript = '+Error.objectevent &
	+'.~r~nLine in Script = '+string(Error.line) + '.'

if isvalid(inv_error) then
	ls_msgparm[1] = ls_message
	inv_error.of_message('pfc_systemerror', ls_msgparm)
else
	of_Messagebox('pfc_systemerror','System Error',ls_message, StopSign!, Ok!, 1)
end if

//Logguer si la connection est active
datetime ldt_today
string ls_detail

ldt_today = datetime(today(),now())
insert into t_error(ligne,code,errtext,fenetre,errdate) values(:Error.line,:error.number, :ls_message,:Error.windowmenu,:ldt_today);
commit;

//this.event pfc_exit()
end event


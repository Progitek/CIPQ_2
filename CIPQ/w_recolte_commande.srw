HA$PBExportHeader$w_recolte_commande.srw
forward
global type w_recolte_commande from w_sheet_frame
end type
type rr_1 from roundrectangle within w_recolte_commande
end type
type st_1 from statictext within w_recolte_commande
end type
type em_date from u_em within w_recolte_commande
end type
type uo_toolbar from u_cst_toolbarstrip within w_recolte_commande
end type
type cb_masquer from commandbutton within w_recolte_commande
end type
type cb_minuterie from commandbutton within w_recolte_commande
end type
type em_derniere from u_em within w_recolte_commande
end type
type dw_gestion_recolte_commande from u_dw within w_recolte_commande
end type
type st_exp from statictext within w_recolte_commande
end type
type gb_1 from groupbox within w_recolte_commande
end type
type cbx_exporter from u_cbx within w_recolte_commande
end type
type cb_zero from commandbutton within w_recolte_commande
end type
end forward

global type w_recolte_commande from w_sheet_frame
string tag = "menu=m_gestiondesrcoltes"
rr_1 rr_1
st_1 st_1
em_date em_date
uo_toolbar uo_toolbar
cb_masquer cb_masquer
cb_minuterie cb_minuterie
em_derniere em_derniere
dw_gestion_recolte_commande dw_gestion_recolte_commande
st_exp st_exp
gb_1 gb_1
cbx_exporter cbx_exporter
cb_zero cb_zero
end type
global w_recolte_commande w_recolte_commande

type variables
boolean	ib_timer = FALSE
string	is_sql_original, is_sql_en_cours
end variables

forward prototypes
public subroutine of_timer ()
end prototypes

public subroutine of_timer ();long		ll_rowcount
string	ls_cur, ls_cie
datetime	ldt_cur, ldt_report, ldt_today

SetPointer(Hourglass!)

//Le rafraichissement - fonction de la mort

ls_cur = em_date.text
ldt_cur = datetime(ls_cur)
ls_cie = gnv_app.of_getcompagniedefaut( )
//Si aucun enregistrement, remplir au complet et supprimer les enr. des jours pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents

if date(ldt_cur) < today() then
	ldt_cur = datetime(today(), 00:00:00)
	em_date.text = string(ldt_cur, 'yyyy-mm-dd')
	
	ll_rowcount = 0
else
	ll_rowcount = dw_gestion_recolte_commande.RowCount()
end if

IF ll_rowcount = 0 THEN
	//supprimer les enr. des jours pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents
	DELETE FROM t_Recolte_Commande WHERE date(t_Recolte_Commande.DateCommande) < date(today()) USING SQLCA;
	COMMIT USING SQLCA;
	
	//Ajouter la liste des verrats reli$$HEX1$$e900$$ENDHEX$$s au centre
	CHOOSE CASE ls_cie
		//110 le temps des tests
		CASE "111"
			INSERT INTO t_Recolte_Commande ( DateCommande, Famille, Verrat )
         	SELECT :ldt_cur AS DateCommande, t_Verrat.CodeVerrat AS Famille, 1 AS Verrat
            FROM t_Verrat
            WHERE t_Verrat.ELIMIN Is Null AND (t_Verrat.CIE_NO = '115' Or t_Verrat.CIE_NO = '118' or t_verrat.CIE_NO = '119') AND
					(t_Verrat.TypeVerrat = 1 Or t_Verrat.TypeVerrat = 2 Or t_Verrat.TypeVerrat = 3) USING SQLCA;
			
		CASE "112"
			INSERT INTO t_Recolte_Commande ( DateCommande, Famille, Verrat )
         	SELECT :ldt_cur AS DateCommande, t_Verrat.CodeVerrat AS Famille, 1 AS Verrat
            FROM t_Verrat
            WHERE t_Verrat.ELIMIN Is Null AND (t_Verrat.CIE_NO = '112' Or t_Verrat.CIE_NO = '114') AND
					(t_Verrat.TypeVerrat = 1 Or t_Verrat.TypeVerrat = 2 Or t_Verrat.TypeVerrat = 3) USING SQLCA;
						
		CASE "113"
			INSERT INTO t_Recolte_Commande ( DateCommande, Famille, Verrat )
         	SELECT :ldt_cur AS DateCommande, t_Verrat.CodeVerrat AS Famille, 1 AS Verrat
            FROM t_Verrat
            WHERE t_Verrat.ELIMIN Is Null AND t_Verrat.CIE_NO = '113' AND
					(t_Verrat.TypeVerrat = 1 Or t_Verrat.TypeVerrat = 2 Or t_Verrat.TypeVerrat = 3)
				USING SQLCA;
				
		CASE "116"
			INSERT INTO t_Recolte_Commande ( DateCommande, Famille, Verrat )
         	SELECT :ldt_cur AS DateCommande, t_Verrat.CodeVerrat AS Famille, 1 AS Verrat
            FROM t_Verrat
            WHERE t_Verrat.ELIMIN Is Null AND t_Verrat.CIE_NO = '116' AND
					(t_Verrat.TypeVerrat = 1 Or t_Verrat.TypeVerrat = 2 Or t_Verrat.TypeVerrat = 3)
				USING SQLCA;
			
	END CHOOSE
	
	COMMIT USING SQLCA;
	
	//Mettre les verrats exclusifs $$HEX2$$e0002000$$ENDHEX$$'complet'
//	UPDATE t_Recolte_Commande INNER JOIN t_Verrat ON t_Recolte_Commande.Famille = t_Verrat.CodeVerrat 
//		SET t_Recolte_Commande.Complete = 1 
//      WHERE (date(t_Recolte_Commande.DateCommande) = date(:ldt_cur) AND t_Verrat.TypeVerrat >= 2)
//		USING SQLCA;
//	COMMIT USING SQLCA; //Modif Mike le 31/08/2005
	
	//Ajouter la liste des produits actifs
	INSERT INTO t_Recolte_Commande ( DateCommande, Famille, Verrat ) 
   	SELECT :ldt_cur AS DateCommande, t_Produit.Famille, 0 AS Verrat 
      FROM (t_Produit INNER JOIN t_Classe ON upper(t_Produit.NoClasse) = upper(t_Classe.NoClasse)) 
		LEFT JOIN t_Verrat_Produit ON upper(t_Produit.NoProduit) = upper(t_Verrat_Produit.NoProduit) 
      WHERE isnull(t_Produit.Famille, '') <> '' AND t_Verrat_Produit.NoProduit Is Null AND t_produit.actif = 1
		GROUP BY t_Produit.Famille USING SQLCA;
	COMMIT USING SQLCA;
	
END IF

SetPointer(HourGlass!)

//MAJ des champs de calcul $$HEX2$$e0002000$$ENDHEX$$0
UPDATE t_Recolte_Commande SET t_Recolte_Commande.QteCommande = 0, t_Recolte_Commande.QteRecolte = 0, 
	t_Recolte_Commande.QteSoldeNonUtilise = 0, t_Recolte_Commande.QteSoldeaRecolter = 0, 
	t_Recolte_Commande.QteSoldeaRecolterCommande = 0 
WHERE date(t_Recolte_Commande.DateCommande) = date(:ldt_cur) USING SQLCA;
COMMIT USING SQLCA;

//***********
//PURE
//***********
SetPointer(Hourglass!)
//Init commande de verrats (PURE)
select count(1) into :ll_rowcount from #Temp_QteCommande;
if SQLCA.SQLCode = -1 then
	ls_cur = "create table #Temp_QteCommande (DateCommande datetime null,~r~n" + &
														  "famille varchar(50) null,~r~n" + &
														  "qtecommande integer null default 0)"
	EXECUTE IMMEDIATE :ls_cur USING SQLCA;
else
	delete from #Temp_QteCommande;
end if

gnv_app.of_Cree_TableFact_Temp("temp_punaise_statfacture")

//Lire dans les commandes
INSERT INTO #Temp_QteCommande ( DateCommande, Famille, QteCommande )
	SELECT :ldt_cur AS DateComm, t_CommandeDetail.CodeVerrat AS Famille, isnull(Sum(t_CommandeDetail.QteCommande),0) AS SommeDeQteCommande 
   FROM t_Commande INNER JOIN t_CommandeDetail 
		ON t_Commande.NoCommande = t_CommandeDetail.NoCommande AND t_Commande.CieNo = t_CommandeDetail.CieNo
	WHERE date(t_Commande.DateCommande) = date(:ldt_cur)
		AND isnull(t_CommandeDetail.CodeVerrat, '') <> ''
   GROUP BY t_CommandeDetail.CodeVerrat 
   HAVING SommeDeQteCommande <> 0
USING SQLCA ;
COMMIT USING SQLCA;

//Lire dans les livraisons
//Remplir #temp_punaise_statfactureDetail
//Va servir pour les pures et les m$$HEX1$$e900$$ENDHEX$$langes
INSERT INTO #temp_punaise_statfacture SELECT T_StatFacture.* FROM T_StatFacture 
WHERE date(T_StatFacture.LIV_DATE)= date(:ldt_cur) USING SQLCA;
COMMIT USING SQLCA;

INSERT INTO #temp_punaise_statfactureDetail SELECT T_StatFactureDetail.* 
	FROM t_StatFacture INNER JOIN t_StatFactureDetail ON
	t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO AND t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO
   WHERE date(t_StatFacture.LIV_DATE) = date(:ldt_cur) USING SQLCA;
COMMIT USING SQLCA;

//Pr$$HEX1$$e900$$ENDHEX$$paration table temp pour mise $$HEX2$$e0002000$$ENDHEX$$jour des qt$$HEX1$$e900$$ENDHEX$$s exp$$HEX1$$e900$$ENDHEX$$di$$HEX1$$e900$$ENDHEX$$es
select count(1) into :ll_rowcount from #Temp_NbrDoseVendu;
if SQLCA.SQLCode = -1 then
	ls_cur = "create table #Temp_NbrDoseVendu (DateCommande datetime null,~r~n" + &
															"famille varchar(50) null,~r~n" + &
															"qtecommande integer null default 0)"
	EXECUTE IMMEDIATE :ls_cur USING SQLCA;
else
	delete from #Temp_NbrDoseVendu;
end if

INSERT INTO #Temp_NbrDoseVendu ( DateCommande, Famille, QteCommande ) 
	SELECT :ldt_cur AS DateComm, #temp_punaise_statfactureDetail.VERRAT_NO,
	isnull(Sum(#temp_punaise_statfactureDetail.QTE_EXP),0) AS SommeDeQTE_EXP
	FROM #temp_punaise_statfacture INNER JOIN #temp_punaise_statfactureDetail
	ON #temp_punaise_statfacture.LIV_NO = #temp_punaise_statfactureDetail.LIV_NO AND
	#temp_punaise_statfacture.CIE_NO = #temp_punaise_statfactureDetail.CIE_NO
	WHERE #temp_punaise_statfactureDetail.VERRAT_NO Is Not Null
	GROUP BY #temp_punaise_statfactureDetail.VERRAT_NO 
	HAVING SommeDeQTE_EXP <> 0 USING SQLCA;
COMMIT USING SQLCA;

//MAJ des qt$$HEX1$$e900$$ENDHEX$$s exp$$HEX1$$e900$$ENDHEX$$di$$HEX1$$e900$$ENDHEX$$es en se servant de la table '#Temp_NbrDoseVendu'
UPDATE #Temp_QteCommande 
	INNER JOIN #Temp_NbrDoseVendu ON 
	upper(#Temp_QteCommande.Famille) = upper(#Temp_NbrDoseVendu.Famille)
	AND date(#Temp_QteCommande.DateCommande) = date(#Temp_NbrDoseVendu.DateCommande)
	SET #Temp_QteCommande.QteCommande = isnull(#Temp_QteCommande.QteCommande,0) + isnull(#Temp_NbrDoseVendu.QteCommande,0)
	USING SQLCA;
COMMIT USING SQLCA;

//Ajout des lignes $$HEX2$$e0002000$$ENDHEX$$null
INSERT INTO #Temp_QteCommande 
	SELECT #Temp_NbrDoseVendu.* 
	FROM #Temp_NbrDoseVendu 
	LEFT JOIN #Temp_QteCommande ON upper(#Temp_NbrDoseVendu.Famille) = upper(#Temp_QteCommande.Famille)
	AND #Temp_NbrDoseVendu.DateCommande = #Temp_QteCommande.DateCommande
	WHERE #Temp_QteCommande.DateCommande Is Null
	AND isnull(#Temp_QteCommande.Famille, '') = '' USING SQLCA;
COMMIT USING SQLCA;

//MAJ de Qt$$HEX1$$e900$$ENDHEX$$Commande (Verrat en Commandes + exp$$HEX1$$e900$$ENDHEX$$dition)
UPDATE #Temp_QteCommande INNER JOIN t_Recolte_Commande 
	ON upper(#Temp_QteCommande.Famille) = upper(t_Recolte_Commande.Famille)
	AND date(#Temp_QteCommande.DateCommande) = date(t_Recolte_Commande.DateCommande)
	SET t_Recolte_Commande.QteCommande = isnull(#Temp_QteCommande.QteCommande,0) 
	USING SQLCA;
COMMIT USING SQLCA;

//Ajout de Qt$$HEX1$$e900$$ENDHEX$$Commande (Verrats en Commandes + exp$$HEX1$$e900$$ENDHEX$$dition)
INSERT INTO t_Recolte_Commande ( DateCommande, Famille, QteCommande )
	SELECT #Temp_QteCommande.DateCommande, #Temp_QteCommande.Famille, #Temp_QteCommande.QteCommande
	FROM #Temp_QteCommande LEFT JOIN t_Recolte_Commande ON
	date(#Temp_QteCommande.DateCommande) = date(t_Recolte_Commande.DateCommande)
	AND upper(#Temp_QteCommande.Famille) = upper(t_Recolte_Commande.Famille)
	WHERE t_Recolte_Commande.DateCommande Is Null
	AND isnull(t_Recolte_Commande.Famille, '') = '' USING SQLCA;
COMMIT USING SQLCA;

//MAJ de Qt$$HEX1$$e900$$ENDHEX$$Recolte (Verrat en R$$HEX1$$e900$$ENDHEX$$coltes)
DELETE FROM #Temp_QteCommande USING SQLCA;
COMMIT USING SQLCA;

INSERT INTO #Temp_QteCommande ( DateCommande, Famille, QteCommande ) 
	SELECT t_RECOLTE.DATE_recolte AS DateCommande, t_RECOLTE.CodeVerrat AS Famille, Sum(Round(isnull(t_RECOLTE.AMPO_TOTAL,0) ,0)) AS QteCommande 
	FROM t_RECOLTE
	WHERE date(t_RECOLTE.DATE_recolte) = date(:ldt_cur)
	GROUP BY t_RECOLTE.DATE_recolte, t_RECOLTE.CodeVerrat USING SQLCA;
COMMIT USING SQLCA;

//***********************************************
//Traitement verrats exclusifs
//Soustraire les verrats de s$$HEX1$$e900$$ENDHEX$$lection r$$HEX1$$e900$$ENDHEX$$colt$$HEX2$$e9002000$$ENDHEX$$en non exclusif
UPDATE #Temp_QteCommande INNER JOIN t_RECOLTE ON date(#Temp_QteCommande.DateCommande) = date(t_RECOLTE.DATE_recolte)
	AND upper(#Temp_QteCommande.Famille) = upper(t_RECOLTE.CodeVerrat)
	INNER JOIN t_Verrat ON upper(t_RECOLTE.CodeVerrat) = upper(t_Verrat.CodeVerrat)
	SET #Temp_QteCommande.QteCommande = isnull(QteCommande,0) - isnull(Round(t_RECOLTE.AMPO_TOTAL,0),0)
	WHERE date(t_RECOLTE.DATE_recolte) = date(:ldt_cur)
	AND t_Verrat.TypeVerrat >= 2 AND t_RECOLTE.Exclusif = 0 USING SQLCA;
COMMIT USING SQLCA;

//Supprimer les lignes $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro
DELETE FROM #Temp_QteCommande WHERE isnull(#Temp_QteCommande.QteCommande,0) = 0 USING SQLCA;
COMMIT USING SQLCA;

SetPointer(HourGlass!)

//***********************************************
//Traitement r$$HEX1$$e900$$ENDHEX$$colte externe
//MAJ de Qt$$HEX1$$e900$$ENDHEX$$Recolte externe
UPDATE #Temp_QteCommande INNER JOIN t_Recolte_Externe 
	ON upper(#Temp_QteCommande.Famille) = upper(t_Recolte_Externe.NoVerrat) AND
	date(#Temp_QteCommande.DateCommande) = date(t_Recolte_Externe.Date_Recolte)
	SET #Temp_QteCommande.QteCommande = isnull(QteCommande,0) + isnull(Qte_Recolte,0) USING SQLCA;
COMMIT USING SQLCA;

//Ajout de Qt$$HEX1$$e900$$ENDHEX$$Recolte externe
INSERT INTO #Temp_QteCommande ( DateCommande, Famille, QteCommande )
	SELECT t_Recolte_Externe.Date_Recolte, t_Recolte_Externe.NoVerrat, t_Recolte_Externe.Qte_Recolte 
	FROM #Temp_QteCommande RIGHT JOIN t_Recolte_Externe 
	ON date(#Temp_QteCommande.DateCommande) = date(t_Recolte_Externe.Date_Recolte)
	AND upper(#Temp_QteCommande.Famille) = upper(t_Recolte_Externe.NoVerrat)
	WHERE #Temp_QteCommande.DateCommande Is Null
	AND isnull(#Temp_QteCommande.Famille, '') = ''
	AND t_Recolte_Externe.NoVerrat is not null USING SQLCA;
COMMIT USING SQLCA;

//***********************************************
UPDATE #Temp_QteCommande INNER JOIN t_Recolte_Commande 
ON date(#Temp_QteCommande.DateCommande) = date(t_Recolte_Commande.DateCommande) AND
upper(#Temp_QteCommande.Famille) = upper(t_Recolte_Commande.Famille)
	SET t_Recolte_Commande.QteRecolte = isnull(#Temp_QteCommande.QteCommande,0)
   WHERE t_Recolte_Commande.Verrat = 1 USING SQLCA;
COMMIT USING SQLCA;

//MAJ de Qt$$HEX1$$e900$$ENDHEX$$Verraterie (qt$$HEX2$$e9002000$$ENDHEX$$disponible), Qt$$HEX1$$e900$$ENDHEX$$Solde$$HEX1$$c000$$ENDHEX$$R$$HEX1$$e900$$ENDHEX$$colter, Qt$$HEX1$$e900$$ENDHEX$$SoldeCommande
UPDATE 	t_Recolte_Commande 
	SET 	t_Recolte_Commande.QteVerraterie = isnull(QteRecolte,0), 
			t_Recolte_Commande.QteSoldeaRecolter = 0, 
			t_Recolte_Commande.QteSoldeCommande = isnull(QteRecolte,0) - isnull(QteCommande,0)
   WHERE date(t_Recolte_Commande.DateCommande) = date(:ldt_cur)
	AND t_Recolte_Commande.Verrat = 1 USING SQLCA;
COMMIT USING SQLCA;

//***********
//M$$HEX1$$c900$$ENDHEX$$LANGE
//***********
SetPointer(Hourglass!)
//Init commande de m$$HEX1$$e900$$ENDHEX$$lange (familles de produits)
DELETE FROM #Temp_QteCommande USING SQLCA;
COMMIT USING SQLCA;

//Lire dans les commandes
INSERT INTO #Temp_QteCommande ( DateCommande, Famille, QteCommande ) 
	SELECT :ldt_cur as DateComm, t_Produit.Famille, isnull(Sum(t_CommandeDetail.QteCommande),0) AS SommeDeQteCommande
	FROM t_Commande INNER JOIN t_CommandeDetail ON t_Commande.NoCommande = t_CommandeDetail.NoCommande AND
	t_Commande.CieNo = t_CommandeDetail.CieNo INNER JOIN t_Produit
	ON upper(t_CommandeDetail.NoProduit) = upper(t_Produit.NoProduit)
	WHERE date(t_Commande.DateCommande) = date(:ldt_cur)
	And isnull(t_CommandeDetail.CodeVerrat, '') = ''
	And t_Produit.Special = 1
	GROUP BY t_Produit.Famille
	HAVING SommeDeQteCommande <> 0 USING SQLCA;
COMMIT USING SQLCA;

//Lire dans les livraisons
//Pr$$HEX1$$e900$$ENDHEX$$paration table temp pour mise $$HEX2$$e0002000$$ENDHEX$$jour des qt$$HEX1$$e900$$ENDHEX$$s
DELETE FROM #Temp_NbrDoseVendu USING SQLCA;
COMMIT USING SQLCA;

INSERT INTO #Temp_NbrDoseVendu ( DateCommande, Famille, QteCommande ) 
	SELECT :ldt_cur as DateComm, t_Produit.Famille, isnull(Sum(#temp_punaise_statfactureDetail.QTE_EXP),0) AS SommeDeQTE_EXP 
   FROM t_Produit INNER JOIN #temp_punaise_statfactureDetail ON t_Produit.NoProduit = #temp_punaise_statfactureDetail.PROD_NO
	INNER JOIN #temp_punaise_statfacture
	ON #temp_punaise_statfacture.LIV_NO = #temp_punaise_statfactureDetail.LIV_NO
	AND #temp_punaise_statfacture.CIE_NO = #temp_punaise_statfactureDetail.CIE_NO
   WHERE t_Produit.Special = 1
   GROUP BY t_Produit.Famille
   HAVING SommeDeQTE_EXP <> 0 USING SQLCA;

//MAJ de Qt$$HEX1$$e900$$ENDHEX$$Commande $$HEX2$$e0002000$$ENDHEX$$partir des qt$$HEX1$$e900$$ENDHEX$$s exp$$HEX1$$e900$$ENDHEX$$di$$HEX1$$e900$$ENDHEX$$es
UPDATE #Temp_QteCommande INNER JOIN #Temp_NbrDoseVendu ON
upper(#Temp_QteCommande.Famille) = upper(#Temp_NbrDoseVendu.Famille)
AND date(#Temp_QteCommande.DateCommande) = date(#Temp_NbrDoseVendu.DateCommande)
SET #Temp_QteCommande.QteCommande = isnull(#Temp_QteCommande.QteCommande,0) + isnull(#Temp_NbrDoseVendu.QteCommande,0)
USING SQLCA;
COMMIT USING SQLCA;

SetPointer(HourGlass!)

//Ajout des lignes $$HEX2$$e0002000$$ENDHEX$$null
INSERT INTO #Temp_QteCommande
	SELECT #Temp_NbrDoseVendu.*
	FROM #Temp_NbrDoseVendu LEFT JOIN #Temp_QteCommande ON
	upper(#Temp_NbrDoseVendu.Famille) = upper(#Temp_QteCommande.Famille)
	AND date(#Temp_NbrDoseVendu.DateCommande) = date(#Temp_QteCommande.DateCommande)
   WHERE #Temp_QteCommande.DateCommande Is Null
	AND isnull(#Temp_QteCommande.Famille, '') = '' USING SQLCA;
COMMIT USING SQLCA;

//MAJ de Qt$$HEX1$$e900$$ENDHEX$$Commande $$HEX2$$e0002000$$ENDHEX$$partir des familles de produits(Commandes + exp$$HEX1$$e900$$ENDHEX$$dition)
UPDATE #Temp_QteCommande INNER JOIN t_Recolte_Commande ON 
upper(#Temp_QteCommande.Famille) = upper(t_Recolte_Commande.Famille)
AND date(#Temp_QteCommande.DateCommande) = date(t_Recolte_Commande.DateCommande)
SET t_Recolte_Commande.QteCommande = isnull(#Temp_QteCommande.QteCommande,0)
USING SQLCA;
COMMIT USING SQLCA;

//Ajout des familles de produits(Commandes + exp$$HEX1$$e900$$ENDHEX$$dition)
INSERT INTO t_Recolte_Commande ( DateCommande, Famille, QteCommande ) 
	SELECT #Temp_QteCommande.DateCommande, #Temp_QteCommande.Famille, #Temp_QteCommande.QteCommande 
   FROM #Temp_QteCommande LEFT JOIN t_Recolte_Commande ON 
	date(#Temp_QteCommande.DateCommande) = date(t_Recolte_Commande.DateCommande)
	AND upper(#Temp_QteCommande.Famille) = upper(t_Recolte_Commande.Famille)
   WHERE t_Recolte_Commande.DateCommande Is Null
	AND isnull(t_Recolte_Commande.Famille, '') = '' USING SQLCA;
COMMIT USING SQLCA;

//MAJ de Qt$$HEX1$$e900$$ENDHEX$$Recolte des familles de produits (R$$HEX1$$e900$$ENDHEX$$coltes) pour les types de verrats <> de s$$HEX1$$e900$$ENDHEX$$lection et exclusif
DELETE FROM #Temp_QteCommande USING SQLCA;
COMMIT USING SQLCA;

INSERT INTO #Temp_QteCommande ( DateCommande, QteCommande, Famille ) 
	SELECT :ldt_cur AS DateComm, isnull(Sum(round(isnull(AMPO_TOTAL,0),0)),0) AS QteCommande,
	t_Verrat_Classe.Famille
   FROM t_Recolte_Commande RIGHT JOIN (t_RECOLTE LEFT JOIN t_Verrat_Classe ON
	upper(t_RECOLTE.Classe) = upper(t_Verrat_Classe.ClasseVerrat)) ON
	upper(t_Recolte_Commande.Famille) = upper(t_RECOLTE.CodeVerrat)
	AND date(t_Recolte_Commande.DateCommande) = date(t_RECOLTE.DATE_recolte)
   WHERE t_Recolte_Commande.DateCommande Is Null
	And isnull(t_Recolte_Commande.Famille, '') = ''
	And date(t_RECOLTE.DATE_recolte) = date(:ldt_cur)
   GROUP BY t_Verrat_Classe.Famille
	HAVING QteCommande <> 0 AND isnull(t_Verrat_Classe.Famille, '') <> '' USING SQLCA;
COMMIT USING SQLCA;

SetPointer(HourGlass!)

//***********************************************
//Traitement verrats exclusifs
//Ajouter les verrats de s$$HEX1$$e900$$ENDHEX$$lection r$$HEX1$$e900$$ENDHEX$$colt$$HEX2$$e9002000$$ENDHEX$$comme non exclusif
select count(1) into :ll_rowcount from #Temp_QteCommandeSum;
if SQLCA.SQLCode = -1 then
	ls_cur = "create table #Temp_QteCommandeSum (DateCommande datetime null,~r~n" + &
															  "famille varchar(50) null,~r~n" + &
															  "qtecommande integer null default 0)"
	EXECUTE IMMEDIATE :ls_cur USING SQLCA;
else
	delete from #Temp_QteCommandeSum;
	commit using SQLCA;
end if


// ENlever par Dave avec discusion L$$HEX1$$e900$$ENDHEX$$onard nous en sommes venus a la conclusion du non-fond$$HEX2$$e9002000$$ENDHEX$$de cette instruction
// 15-06-2011


//Sum des verrats de s$$HEX1$$e900$$ENDHEX$$lection r$$HEX1$$e900$$ENDHEX$$colt$$HEX2$$e9002000$$ENDHEX$$comme non exclusif
INSERT INTO #Temp_QteCommandeSum ( DateCommande, Famille, QteCommande )
	SELECT :ldt_cur AS DateComm, t_Verrat_Classe.Famille, Sum(round(isnull(AMPO_TOTAL,0),0)) AS QteCommande 
   FROM t_RECOLTE INNER JOIN t_Verrat ON upper(t_RECOLTE.CodeVerrat) = upper(t_Verrat.CodeVerrat)
	INNER JOIN t_Verrat_Classe ON upper(t_RECOLTE.Classe) = upper(t_Verrat_Classe.ClasseVerrat)
   WHERE date(t_RECOLTE.DATE_recolte) = date(:ldt_cur) And t_Verrat.TypeVerrat >= 2
	And t_RECOLTE.Exclusif = 0
   GROUP BY t_Verrat_Classe.Famille USING SQLCA;
COMMIT USING SQLCA;

//MAJ des qt$$HEX1$$e900$$ENDHEX$$es pour les familles existantes
UPDATE #Temp_QteCommande INNER JOIN #Temp_QteCommandeSum
ON #Temp_QteCommande.Famille = #Temp_QteCommandeSum.Famille AND
date(#Temp_QteCommande.DateCommande) = date(#Temp_QteCommandeSum.DateCommande)
SET #Temp_QteCommande.QteCommande = isnull(#Temp_QteCommande.QteCommande,0) + isnull(#Temp_QteCommandeSum.QteCommande,0)
USING SQLCA;
COMMIT USING SQLCA;

//Ajout des qt$$HEX1$$e900$$ENDHEX$$es pour les familles non existantes
INSERT INTO #Temp_QteCommande SELECT #Temp_QteCommandeSum.* 
FROM #Temp_QteCommande RIGHT JOIN #Temp_QteCommandeSum ON 
date(#Temp_QteCommande.DateCommande) = date(#Temp_QteCommandeSum.DateCommande)
AND upper(#Temp_QteCommande.Famille) = upper(#Temp_QteCommandeSum.Famille)
WHERE #Temp_QteCommande.DateCommande Is Null
AND isnull(#Temp_QteCommande.Famille, '') = '' USING SQLCA;
COMMIT USING SQLCA;

//***********************************************
//Traitement r$$HEX1$$e900$$ENDHEX$$colte externe
DELETE FROM #Temp_QteCommandeSum USING SQLCA;
COMMIT USING SQLCA;

//Sum des famille de recolte_externe
INSERT INTO #Temp_QteCommandeSum ( DateCommande, QteCommande, Famille ) 
	SELECT :ldt_cur As DateComm,
	isnull(Sum(round(t_Recolte_Externe.Qte_Recolte,0)),0) AS SommeDeQte_Recolte, t_Verrat_Classe.Famille 
	FROM (t_Recolte_Commande RIGHT JOIN
	(t_Recolte_Externe INNER JOIN t_Verrat ON upper(t_Recolte_Externe.NoVerrat) = upper(t_Verrat.CodeVerrat)) ON
	upper(t_Recolte_Commande.Famille) = upper(t_Recolte_Externe.NoVerrat) AND
	date(t_Recolte_Commande.DateCommande) = date(t_Recolte_Externe.Date_Recolte))
	INNER JOIN t_Verrat_Classe ON upper(t_Verrat.Classe) = upper(t_Verrat_Classe.ClasseVerrat)
	WHERE t_Recolte_Commande.DateCommande Is Null
	And isnull(t_Recolte_Commande.Famille, '') = ''
	And date(t_Recolte_Externe.Date_Recolte) = date(:ldt_cur)
	GROUP BY t_Verrat_Classe.Famille
	HAVING SommeDeQte_Recolte <> 0 AND isnull(t_Verrat_Classe.Famille, '') <> ''
	USING SQLCA;
COMMIT USING SQLCA;

SetPointer(HourGlass!)

//MAJ #Temp_QteCommande
UPDATE #Temp_QteCommandeSum INNER JOIN #Temp_QteCommande ON
	upper(#Temp_QteCommandeSum.Famille) = upper(#Temp_QteCommande.Famille) AND
	date(#Temp_QteCommandeSum.DateCommande) = date(#Temp_QteCommande.DateCommande)
	SET #Temp_QteCommande.QteCommande = isnull(#Temp_QteCommande.QteCommande,0) + isnull(#Temp_QteCommandeSum.QteCommande,0)
	USING SQLCA;
COMMIT USING SQLCA;

//AJout #Temp_QteCommande
INSERT INTO #Temp_QteCommande ( DateCommande, Famille, QteCommande )
	SELECT #Temp_QteCommandeSum.DateCommande, #Temp_QteCommandeSum.Famille, #Temp_QteCommandeSum.QteCommande 
   FROM #Temp_QteCommandeSum LEFT JOIN #Temp_QteCommande ON
	date(#Temp_QteCommandeSum.DateCommande) = date(#Temp_QteCommande.DateCommande) AND
	upper(#Temp_QteCommandeSum.Famille) = upper(#Temp_QteCommande.Famille)
   WHERE #Temp_QteCommande.DateCommande Is Null
	AND isnull(#Temp_QteCommande.Famille, '') = '' USING SQLCA;
COMMIT USING SQLCA;

//***********************************************
//MAJ t_Recolte_Commande.QteRecolte

UPDATE #Temp_QteCommande INNER JOIN t_Recolte_Commande ON
date(#Temp_QteCommande.DateCommande) = date(t_Recolte_Commande.DateCommande) AND
upper(#Temp_QteCommande.Famille) = upper(t_Recolte_Commande.Famille)
	SET t_Recolte_Commande.QteRecolte = isnull(#Temp_QteCommande.QteCommande,0)
	USING SQLCA;
COMMIT USING SQLCA;

//MAJ de Qt$$HEX1$$e900$$ENDHEX$$SoldeNonUtilis$$HEX2$$e9002000$$ENDHEX$$des familles de produits (R$$HEX1$$e900$$ENDHEX$$coltes) pour les types de verrats = de s$$HEX1$$e900$$ENDHEX$$lection ou exclusif
DELETE FROM #Temp_QteCommande USING SQLCA;
COMMIT USING SQLCA;

INSERT INTO #Temp_QteCommande ( DateCommande, Famille, QteCommande )
	SELECT t_Recolte_Commande.DateCommande, t_Verrat_Classe.Famille, isnull(Sum(QteRecolte),0) - isnull(Sum(QteCommande),0) AS QteDisponible
   FROM t_Verrat INNER JOIN t_Recolte_Commande ON upper(t_Verrat.CodeVerrat) = upper(t_Recolte_Commande.Famille)
	INNER JOIN t_Verrat_Classe ON upper(t_Verrat_Classe.ClasseVerrat) = upper(t_Verrat.Classe)
   WHERE date(t_Recolte_Commande.DateCommande) = date(:ldt_cur) And t_Recolte_Commande.QteRecolte > 0 And
	t_Recolte_Commande.Verrat = 1
	And isnull(t_Verrat_Classe.Famille, '') <> ''
   GROUP BY t_Recolte_Commande.DateCommande, t_Verrat_Classe.Famille USING SQLCA;
COMMIT USING SQLCA;

//ICI
SetPointer(HourGlass!)

UPDATE #Temp_QteCommande INNER JOIN t_Recolte_Commande ON 
date(#Temp_QteCommande.DateCommande) = date(t_Recolte_Commande.DateCommande)
	AND upper(#Temp_QteCommande.Famille) = upper(t_Recolte_Commande.Famille)
	SET t_Recolte_Commande.QteSoldeNonUtilise = isnull(#Temp_QteCommande.QteCommande,0)
	WHERE t_Recolte_Commande.Verrat = 0 USING SQLCA;
COMMIT USING SQLCA;

//******************************************************************
// Suprimer les produits li$$HEX4$$e9002000e0002000$$ENDHEX$$t_Verrat_Produit: 3 E, PUR LOC
//******************************************************************

DELETE FROM t_Recolte_Commande where t_Recolte_Commande.Famille in (
SELECT t_Produit.Famille
FROM t_Produit INNER JOIN t_Verrat_Produit 
ON upper(t_Produit.NoProduit) = upper(t_Verrat_Produit.NoProduit)
where isnull(t_Produit.Famille, '') <> '') USING SQLCA;
COMMIT USING SQLCA;

//*******************************************************************
// MAJ Qt$$HEX1$$e900$$ENDHEX$$Solde$$HEX1$$c000$$ENDHEX$$R$$HEX1$$e900$$ENDHEX$$colter, Qt$$HEX1$$e900$$ENDHEX$$Solde$$HEX1$$c000$$ENDHEX$$R$$HEX1$$e900$$ENDHEX$$colterCommande, Qt$$HEX1$$e900$$ENDHEX$$SoldeCommande
//*******************************************************************
UPDATE t_Recolte_Commande
	SET t_Recolte_Commande.QteSoldeaRecolter = (isnull(QteRecolte,0) + isnull(QteSoldeNonUtilise,0)) - isnull(QteVerraterie,0),
	t_Recolte_Commande.QteSoldeaRecolterCommande = (isnull(QteRecolte,0) + isnull(QteSoldeNonUtilise,0)) - isnull(QteCommande,0),
	t_Recolte_Commande.QteSoldeCommande = isnull(QteVerraterie,0) - isnull(QteCommande ,0)
	WHERE date(t_Recolte_Commande.DateCommande) = date(:ldt_cur) USING SQLCA;
COMMIT USING SQLCA;

ldt_today = datetime(today(),now())

//************************************************
//Transfert des r$$HEX1$$e900$$ENDHEX$$coltes commandes de 112 vers 111
//************************************************
//110 le temps des tests
IF ls_cie = "112" OR ls_cie = "110" THEN
	
	SetPointer(HourGlass!)
	
	SELECT	LastDate_rptRecolteCommande
	INTO		:ldt_report
	FROM 		t_centreCIPQ
	WHERE		cie= :ls_cie USING SQLCA;
	
	IF cbx_exporter.checked = TRUE THEN
		cbx_exporter.checked = FALSE
		
		//G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer la table
		DELETE FROM t_Recolte_Commande_112 USING SQLCA;
		COMMIT USING SQLCA;
		
		DELETE FROM t_RECOLTE_112 USING SQLCA;
		COMMIT USING SQLCA;
		
		INSERT INTO t_RECOLTE_112
		SELECT t_RECOLTE.*
		FROM t_RECOLTE
		WHERE date(t_RECOLTE.DATE_recolte) = Date(today()) USING SQLCA;
		COMMIT USING SQLCA;
		
		INSERT INTO t_Recolte_Commande_112
		SELECT t_Recolte_Commande.*
		FROM t_Recolte_Commande
		WHERE date(t_Recolte_Commande.DateCommande) = date(:ldt_cur)
		AND t_Recolte_Commande.Complete = 0
		AND (isnull(t_Recolte_Commande.QteVerraterie, 0) <> 0 OR
			  isnull(t_Recolte_Commande.QteCommande, 0) <> 0 OR
			  isnull(t_Recolte_Commande.QteRecolte, 0) <> 0 OR
			  isnull(t_Recolte_Commande.QteSoldeaRecolter, 0) <> 0 OR
			  isnull(t_Recolte_Commande.QteSoldeCommande, 0) <> 0);
		COMMIT USING SQLCA;
		
		SetPointer(HourGlass!)
		gnv_app.inv_transfert_inter_centre.of_transfert_recolte_commande( )
		
		do while yield()
		loop
		
		//MAJ de la date et heure de l'exportation
		em_derniere.text = string(ldt_today, "yyyy-mm-dd hh:mm:ss")
		
		UPDATE t_CentreCIPQ SET t_CentreCIPQ.LastDate_rptRecolteCommande = :ldt_today 
		WHERE t_CentreCIPQ.CIE = :ls_cie;
		
		COMMIT USING SQLCA;
	END IF
END IF

IF gnv_app.of_getcompagniedefaut( ) = "111" THEN
	SELECT	LastDate_rptRecolteCommande
	INTO		:ldt_report
	FROM 		t_centreCIPQ
	WHERE		cie='111' USING SQLCA;
	
	em_derniere.text = string(ldt_report,"yyyy-mm-dd hh:mm:ss")
END IF

dw_gestion_recolte_commande.Retrieve(date(ldt_cur))

//If Not Fisloaded("frmRecolte") And Not Forms!Login.CurrentUser = "Verrat" Then
//    blnTimer = False
//    Forms!FrmRecolte_Commande.BtnMinuterie.Caption = "Minuterie en attente"
//    Forms!FrmRecolte_Commande.BtnMinuterie.ForeColor = "255" 'Rouge
//    Forms!FrmRecolte_Commande.FrmRecolte_Commande_SF.Form.AllowEdits = True
//End If
end subroutine

on w_recolte_commande.create
int iCurrent
call super::create
this.rr_1=create rr_1
this.st_1=create st_1
this.em_date=create em_date
this.uo_toolbar=create uo_toolbar
this.cb_masquer=create cb_masquer
this.cb_minuterie=create cb_minuterie
this.em_derniere=create em_derniere
this.dw_gestion_recolte_commande=create dw_gestion_recolte_commande
this.st_exp=create st_exp
this.gb_1=create gb_1
this.cbx_exporter=create cbx_exporter
this.cb_zero=create cb_zero
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rr_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_date
this.Control[iCurrent+4]=this.uo_toolbar
this.Control[iCurrent+5]=this.cb_masquer
this.Control[iCurrent+6]=this.cb_minuterie
this.Control[iCurrent+7]=this.em_derniere
this.Control[iCurrent+8]=this.dw_gestion_recolte_commande
this.Control[iCurrent+9]=this.st_exp
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.cbx_exporter
this.Control[iCurrent+12]=this.cb_zero
end on

on w_recolte_commande.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rr_1)
destroy(this.st_1)
destroy(this.em_date)
destroy(this.uo_toolbar)
destroy(this.cb_masquer)
destroy(this.cb_minuterie)
destroy(this.em_derniere)
destroy(this.dw_gestion_recolte_commande)
destroy(this.st_exp)
destroy(this.gb_1)
destroy(this.cbx_exporter)
destroy(this.cb_zero)
end on

event open;call super::open;date	ld_cur
uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Imprimer 'Sommaire des r$$HEX1$$e900$$ENDHEX$$coltes journali$$HEX1$$e800$$ENDHEX$$res'", "ArrangeTables5!")
uo_toolbar.of_AddItem("Rapport", "Print!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

ld_cur = date(today())
em_date.text = string(ld_cur)
SetPointer(HourGlass!)
dw_gestion_recolte_commande.Retrieve(ld_cur)

is_sql_original = dw_gestion_recolte_commande.GetSqlSelect()
is_sql_en_cours = is_sql_original

IF gnv_app.of_getcompagniedefaut( ) = "112" THEN //Roxton
	st_exp.visible = true
	em_derniere.visible = true
	cbx_exporter.visible = true
END IF

IF gnv_app.of_getcompagniedefaut( ) = "111" THEN 
	st_exp.visible = true
	em_derniere.visible = true
	st_exp.text = "Derni$$HEX1$$e800$$ENDHEX$$re importation:"
END IF

dw_gestion_recolte_commande.Object.qteverraterie.visible = false
dw_gestion_recolte_commande.Object.qteverraterie_t.visible = false
dw_gestion_recolte_commande.Object.qtesoldearecolter.visible = false
dw_gestion_recolte_commande.Object.qtesoldearecolter_t.visible = false	

Timer(60)
	
	
end event

event timer;call super::timer;of_timer()
end event

event pfc_postopen;call super::pfc_postopen;THIS.event timer()
end event

event close;call super::close;string	ls_cie, ls_sql

ls_cie = gnv_app.of_getcompagniedefaut( )

UPDATE	t_centrecipq 
SET		punaise_open = 0
WHERE		cie = :ls_cie ;

ls_sql = "drop table #Temp_NbrDoseVendu"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

ls_sql = "drop table #Temp_QteCommande"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

ls_sql = "drop table #Temp_QteCommandeSum"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

ls_sql = "drop table #temp_punaise_statfacturedetail"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

ls_sql = "drop table #temp_punaise_statfacture"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

COMMIT USING SQLCA;
end event

type st_title from w_sheet_frame`st_title within w_recolte_commande
integer x = 192
integer y = 52
integer width = 2162
string text = "Gestion des r$$HEX1$$e900$$ENDHEX$$coltes en comparaison avec les commandes"
end type

type p_8 from w_sheet_frame`p_8 within w_recolte_commande
integer x = 46
integer y = 40
integer width = 133
integer height = 112
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\punaise.gif"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_recolte_commande
integer y = 32
integer height = 128
end type

type rr_1 from roundrectangle within w_recolte_commande
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 184
integer width = 4549
integer height = 1960
integer cornerheight = 40
integer cornerwidth = 46
end type

type st_1 from statictext within w_recolte_commande
integer x = 91
integer y = 232
integer width = 224
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Date:"
boolean focusrectangle = false
end type

type em_date from u_em within w_recolte_commande
integer x = 320
integer y = 232
integer width = 425
integer height = 80
integer taborder = 0
boolean bringtotop = true
integer textsize = -12
fontcharset fontcharset = ansi!
long backcolor = 15793151
boolean border = false
boolean displayonly = true
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean ib_rmbmenu = false
end type

event modified;call super::modified;dw_gestion_recolte_commande.Retrieve(date(em_date.text))
parent.of_timer()
end event

type uo_toolbar from u_cst_toolbarstrip within w_recolte_commande
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2200
integer width = 4558
integer height = 108
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;string	ls_date

ls_date = em_date.text
CHOOSE CASE as_button

	CASE "Imprimer 'Sommaire des r$$HEX1$$e900$$ENDHEX$$coltes journali$$HEX1$$e800$$ENDHEX$$res'"
		
		IF Parent.event pfc_save() >= 0 THEN
			w_r_sommaire_recolte_journ	lw_vr_journ
			
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rapport recolte commande date", ls_date)
			OpenSheet(lw_vr_journ, gnv_app.of_GetFrame(), 6, layered!)
		END IF
		
	CASE "Rapport"
		
		IF Parent.event pfc_save() >= 0 THEN
			IF gnv_app.inv_error.of_message("CIPQ0090") = 1 THEN
				w_r_recolte_commande	lw_vr
				w_r_recolte_commande_112	lw_vr_112
				
				IF gnv_app.of_getcompagniedefaut( ) = "111" THEN	 //Si 111 seulement, en premier pour qu'il soit en dessous de l'autre
					gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rapport recolte commande date", ls_date)
					OpenSheet(lw_vr_112, gnv_app.of_GetFrame(), 6, layered!)
				END IF
				
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rapport recolte commande date", ls_date)
				OpenSheet(lw_vr, gnv_app.of_GetFrame(), 6, layered!)
				
			END IF
		END IF
		
	CASE "Enregistrer"
		Parent.event pfc_save()

	CASE "Fermer", "Close"
		parent.event pfc_close()

END CHOOSE

end event

type cb_masquer from commandbutton within w_recolte_commande
integer x = 3013
integer y = 212
integer width = 722
integer height = 116
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Masquer les lignes $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro"
end type

event clicked;long	ll_rowcount

If THIS.text = "Masquer les lignes $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro" Then
	THIS.text = "Afficher toutes les lignes"
	THIS.flatstyle = TRUE

	is_sql_en_cours = &
		"SELECT t_recolte_commande.famille,   " + &
      "t_recolte_commande.qteverraterie,   " + &
      "t_recolte_commande.qtecommande,   " + &
      "t_recolte_commande.qterecolte,   " + &
      "t_recolte_commande.qtesoldearecolter,   " + &
      "t_recolte_commande.qtesoldecommande,   " + &
      "t_recolte_commande.complete,   " + &
      "t_recolte_commande.verrat,   " + &
      "t_recolte_commande.qtesoldenonutilise,   " + &
      "t_recolte_commande.qtesoldearecoltercommande,   " + &
      "t_recolte_commande.datecommande  " + &
		"FROM t_Recolte_Commande " + &
		"WHERE date(t_Recolte_Commande.DateCommande) = :ad_cur And " + &
				"(t_Recolte_Commande.QteVerraterie <> 0 " + &
					"Or t_Recolte_Commande.QteCommande <> 0 " + &
					"Or t_Recolte_Commande.QteRecolte <> 0 " + &
					"Or qtesoldenonutilise <> 0) " + &
		"ORDER BY t_Recolte_Commande.Complete DESC , t_Recolte_Commande.Verrat DESC , t_Recolte_Commande.Famille"
	
	dw_gestion_recolte_commande.modify("datawindow.table.select=~""+is_sql_en_cours+"~"")
	dw_gestion_recolte_commande.SetTransObject(SQLCA)
	ll_rowcount = dw_gestion_recolte_commande.Retrieve(date(em_date.text))
Else
	THIS.text = "Masquer les lignes $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro"
	THIS.flatstyle = FALSE

	is_sql_en_cours = is_sql_original
	dw_gestion_recolte_commande.modify("datawindow.table.select=~""+is_sql_en_cours+"~"")
	dw_gestion_recolte_commande.SetTransObject(SQLCA)
	ll_rowcount = dw_gestion_recolte_commande.Retrieve(date(em_date.text))

End If
end event

type cb_minuterie from commandbutton within w_recolte_commande
integer x = 3785
integer y = 212
integer width = 722
integer height = 116
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Minuterie en fonction"
end type

event clicked;If ib_timer = True Then
	ib_timer = False
	THIS.TEXT = "Minuterie en attente"
	THIS.flatstyle = FALSE
	dw_gestion_recolte_commande.taborder = 1
	Timer(0)
Else
	ib_timer = True
	THIS.TEXT = "Minuterie en fonction"
	THIS.flatstyle = FALSE
	dw_gestion_recolte_commande.taborder = 0
	Timer(60)
End If

end event

type em_derniere from u_em within w_recolte_commande
boolean visible = false
integer x = 891
integer y = 2020
integer width = 718
integer height = 96
integer taborder = 0
boolean bringtotop = true
integer textsize = -12
fontcharset fontcharset = ansi!
long backcolor = 12639424
alignment alignment = center!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy-mm-dd hh:mm:ss"
end type

type dw_gestion_recolte_commande from u_dw within w_recolte_commande
integer x = 183
integer y = 432
integer width = 4256
integer height = 1504
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_gestion_recolte_commande"
end type

event buttonclicked;call super::buttonclicked;string	ls_famille, ls_tmpvalue, ls_sql
long		ll_count

//Piton d$$HEX1$$e900$$ENDHEX$$tails +++

IF row > 0 THEN
	ls_famille = dw_gestion_recolte_commande.object.famille[row]
	
	IF IsNull(ls_famille) OR ls_famille = "" THEN RETURN
	
	//Vider #Tmp_Recolte_Commande_ProduitDetail
	select count(1) into :ll_count from #Tmp_Recolte_Commande_ProduitDetail;
	if SQLCA.SQLCode = -1 then
		ls_sql = "create table #Tmp_Recolte_Commande_ProduitDetail (produit varchar(16) null,~r~n" + &
														"qtecommande integer null)"
		EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	else
		delete from #Tmp_Recolte_Commande_ProduitDetail;
		commit using sqlca;
	end if
	
	//Voir si famille est un verrat
	SELECT 	count(1)
	INTO		:ll_count
	FROM		t_verrat
	WHERE 	codeverrat = :ls_famille ;
	
	IF ll_count > 0 THEN //C'est un verrat
		//Les commandes
		INSERT INTO #Tmp_Recolte_Commande_ProduitDetail ( Produit, QteCommande )
        SELECT t_CommandeDetail.CodeVerrat, Sum(t_CommandeDetail.QteCommande) AS SommeDeQteCommande
        FROM t_Commande INNER JOIN t_CommandeDetail ON t_Commande.NoCommande = t_CommandeDetail.NoCommande AND t_Commande.CieNo = t_CommandeDetail.CieNo
        WHERE date(t_Commande.DateCommande) = Date(today()) AND t_CommandeDetail.CodeVerrat = :ls_famille
        GROUP BY t_CommandeDetail.CodeVerrat USING SQLCA;
		  
		COMMIT USING SQLCA;
		
		//Les exp$$HEX1$$e900$$ENDHEX$$ditions
		INSERT INTO #Tmp_Recolte_Commande_ProduitDetail ( Produit, QteCommande )
        SELECT t_StatFactureDetail.VERRAT_NO, Sum(t_StatFactureDetail.QTE_EXP) AS SommeDeQTE_EXP
        FROM t_StatFacture INNER JOIN t_StatFactureDetail
		  ON t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO AND t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO
        WHERE date(t_StatFacture.LIV_DATE) = Date(today()) And t_StatFactureDetail.VERRAT_NO = :ls_famille
        GROUP BY t_StatFactureDetail.VERRAT_NO USING SQLCA;
		
		COMMIT USING SQLCA;
	ELSE

		//Voir si Famille de produit
		
		SELECT 	COUNT(1)
		INTO 		:ll_count
		FROM		t_Produit_Famille
		WHERE		famille = :ls_famille ;
		
		IF ll_count > 0 THEN  //C'est une Famille de produit
			//Les commandes
			INSERT INTO #Tmp_Recolte_Commande_ProduitDetail ( Produit, QteCommande ) 
            SELECT t_CommandeDetail.NoProduit, Sum(t_CommandeDetail.QteCommande) AS SommeDeQteCommande
            FROM t_Commande INNER JOIN t_CommandeDetail ON t_Commande.NoCommande = t_CommandeDetail.NoCommande
											  AND t_Commande.CieNo = t_CommandeDetail.CieNo
									 INNER JOIN t_Produit ON t_CommandeDetail.NoProduit = t_Produit.NoProduit
            WHERE date(t_Commande.DateCommande) = DATE(today()) And t_Produit.Famille = :ls_famille
            GROUP BY t_CommandeDetail.NoProduit USING SQLCA;
				
			COMMIT USING SQLCA;
			
			//Les exp$$HEX1$$e900$$ENDHEX$$ditions
        INSERT INTO #Tmp_Recolte_Commande_ProduitDetail ( Produit, QteCommande ) 
            SELECT t_StatFactureDetail.PROD_NO, Sum(t_StatFactureDetail.QTE_EXP) AS SommeDeQTE_EXP
            FROM t_StatFacture INNER JOIN t_StatFactureDetail ON t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO
				AND t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO
				INNER JOIN t_Produit ON t_StatFactureDetail.PROD_NO = t_Produit.NoProduit
            WHERE date(t_StatFacture.LIV_DATE) = DATE(today()) And t_Produit.Famille = :ls_famille 
            GROUP BY t_StatFactureDetail.PROD_NO USING SQLCA;
				
			COMMIT USING SQLCA;
			
		ELSE
			Messagebox("Autres", "Autres")
		END IF
		
		
	END IF
	
	SetPointer(Hourglass!)
	
	//ouvrir l'interface
	w_recolte_commande_produit_detail lw_wind
	Open(lw_wind)
END IF
end event

type st_exp from statictext within w_recolte_commande
boolean visible = false
integer x = 91
integer y = 2028
integer width = 795
integer height = 88
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "Derni$$HEX1$$e800$$ENDHEX$$re exportation:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_recolte_commande
integer x = 91
integer y = 328
integer width = 4421
integer height = 1672
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
end type

type cbx_exporter from u_cbx within w_recolte_commande
boolean visible = false
integer x = 1659
integer y = 2044
integer width = 718
integer height = 68
integer taborder = 50
boolean bringtotop = true
long backcolor = 15793151
string text = "Exporter le rapport pour 111"
end type

type cb_zero from commandbutton within w_recolte_commande
integer x = 3680
integer y = 52
integer width = 827
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Remettre $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro toutes les donn$$HEX1$$e900$$ENDHEX$$es"
end type

event clicked;DELETE FROM t_recolte_commande;
COMMIT USING SQLCA;

Messagebox("Attention", "Veuillez fermer l'interface pour que les changements soient pris en compte.")
end event

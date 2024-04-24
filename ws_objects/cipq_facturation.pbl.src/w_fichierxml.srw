$PBExportHeader$w_fichierxml.srw
forward
global type w_fichierxml from w_sheet
end type
type uo_imprimer from u_cst_toolbarstrip within w_fichierxml
end type
type st_7 from statictext within w_fichierxml
end type
type ddlb_eleveur from u_ddlb within w_fichierxml
end type
type st_6 from statictext within w_fichierxml
end type
type rb_bon from radiobutton within w_fichierxml
end type
type rb_date from radiobutton within w_fichierxml
end type
type uo_fermer from u_cst_toolbarstrip within w_fichierxml
end type
type st_5 from statictext within w_fichierxml
end type
type lb_files from u_lb within w_fichierxml
end type
type uo_creerxml from u_cst_toolbarstrip within w_fichierxml
end type
type uo_rechercher from u_cst_toolbarstrip within w_fichierxml
end type
type st_4 from statictext within w_fichierxml
end type
type st_3 from statictext within w_fichierxml
end type
type st_2 from statictext within w_fichierxml
end type
type st_1 from statictext within w_fichierxml
end type
type sle_fin from singlelineedit within w_fichierxml
end type
type sle_deb from singlelineedit within w_fichierxml
end type
type em_debut from editmask within w_fichierxml
end type
type em_fin from editmask within w_fichierxml
end type
type dw_fichierxmlbon from u_dw within w_fichierxml
end type
type rr_1 from roundrectangle within w_fichierxml
end type
end forward

global type w_fichierxml from w_sheet
integer width = 1723
integer height = 2496
boolean ib_isupdateable = false
uo_imprimer uo_imprimer
st_7 st_7
ddlb_eleveur ddlb_eleveur
st_6 st_6
rb_bon rb_bon
rb_date rb_date
uo_fermer uo_fermer
st_5 st_5
lb_files lb_files
uo_creerxml uo_creerxml
uo_rechercher uo_rechercher
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_fin sle_fin
sle_deb sle_deb
em_debut em_debut
em_fin em_fin
dw_fichierxmlbon dw_fichierxmlbon
rr_1 rr_1
end type
global w_fichierxml w_fichierxml

forward prototypes
public subroutine uf_traduction ()
public subroutine of_http_post (string as_xml)
public subroutine of_log (string as_log)
public subroutine of_bon_commande_impression ()
public function long of_reservenextlivno (string as_cie)
public subroutine of_posterbonlivraison (string as_cie)
end prototypes

public subroutine uf_traduction ();uo_rechercher.of_settheme("classics")
uo_rechercher.of_displayborder(true)
uo_rechercher.of_addItem("Rechercher","Search!")
uo_rechercher.of_displaytext(true)

uo_creerxml.of_settheme("classics")
uo_creerxml.of_displayborder(true)
uo_creerxml.of_addItem("Créer fichier XML","PasteSQL5!")
uo_creerxml.of_displaytext(true)

uo_fermer.of_settheme("classics")
uo_fermer.of_displayborder(true)
uo_fermer.of_addItem("Fermer","Exit!")
uo_fermer.of_displaytext(true)



uo_imprimer.of_settheme("classics")
uo_imprimer.of_addItem("Imprimer","print!")
uo_imprimer.of_displayborder(true)
uo_imprimer.of_displaytext(true)






end subroutine

public subroutine of_http_post (string as_xml);//wei create 2022-05-19
httpclient lnv_client
string ls_url
integer li_rc
string ls_reponse
string ls_log
ls_log = '*****************************************************************************************~r~n'
ls_log+="CIPQ operation " + string(now(),"yyyy-mm-dd hh:mm:ss") + '~r~n'
ls_log +='Request xml~r~n' + as_xml + '~r~n'
ls_url = 'https://test7.cybercat.ca/cipq/livraison/bons/envoyer?token=794yPT7RPTc7K4k5Rv7x6BBVjpmdsSTT'
lnv_client = create httpclient
try
	lnv_client.SetRequestHeader("Content-Type", "application/xml")
	li_rc = lnv_client.SendRequest("POST",ls_url,as_xml)
	lnv_client.GetResponseBody(ls_reponse)
	ls_log +='Reponse ~r~n' + ls_reponse + '~r~n'
	messagebox('',lnv_client.getresponsestatuscode( ))
	of_log(ls_log)
	destroy lnv_client
catch(runtimeerror er)
    destroy lnv_client
	ls_log +='Error ~r~n' + er.getmessage() +'~r~n'
	of_log(ls_log)
end try	
end subroutine

public subroutine of_log (string as_log);//
string ls_corrpath
long ll_file
ls_corrpath='C:\ii4net\cipq\'
if not directoryexists(ls_corrpath) then
	createdirectory(ls_corrpath)
end if
ls_corrpath+='log\'
if not directoryexists(ls_corrpath) then
	createdirectory(ls_corrpath)
end if

ls_corrpath +=string(today(),'yyyy-mm-dd')+'\'
if not directoryexists(ls_corrpath) then
	createdirectory(ls_corrpath)
end if
ls_corrpath +=string(today(),'yyyy-mm-dd')+".txt" 
ll_file = fileopen(ls_corrpath,TextMode!, Write!, LockReadWrite!, Append!)
filewriteex(ll_file,as_log)
fileclose(ll_file)

end subroutine

public subroutine of_bon_commande_impression ();//wei ajouter 2023-02-17 pour le billet CIPQ-14
long i,ll_total
string ls_cie
date ldt_debut
date ldt_fin
date ldt_temp
long j
long ll_dayafter
long ll_nbrow
long ll_nofin
long ll_cpt
long ll_nobonlivraison
string ls_livno_fin 
long ll_cietab[]
long ll_NextLivNo
long ll_count
n_ds lds_commande_generer_bon
em_debut.getData(ldt_debut)
em_fin.getData(ldt_fin)
ll_dayafter = daysafter(ldt_debut,ldt_fin)

string ls_table_temp
long ll_count_total
ll_total = lb_files.totalitems( )
gnv_app.of_PrintLock()
/*
for i = 1 to ll_total
	if lb_files.state(i) = 1 then
		ls_cie = lb_files.text(i)
		ll_dayafter +=1
		for j = 1 to ll_dayafter
			ldt_temp =RelativeDate (ldt_debut, (j - 1) )
			ll_count = 0
	 //ll_cietab[i]=long(lb_files.of_getlabel(i))
	 //ls_table_temp +=lb_files.of_getlabel(i)+','
	 //ls_table_temp =mid(ls_table_temp,1,len(ls_table_temp) - 1 )
		SELECT 	count( DISTINCT t_Commande.CieNo + ' ' + t_Commande.NoCommande ) INTO	:ll_count
				FROM t_commande
				WHERE 	t_Commande.Traiter = 1 AND t_Commande.Imprimer = 0 
					AND (t_Commande.Locked ='P' OR :ldt_temp <> date(today())) AND
					date(t_Commande.DateCommande) = :ldt_temp AND t_Commande.CieNo  = :ls_cie AND
					NOT EXISTS(
					
						SELECT 		1
						FROM 			t_CommandeDetail 
						LEFT JOIN 	t_Produit ON (upper(t_CommandeDetail.NoProduit) = upper(t_Produit.NoProduit)) 
						WHERE	 		t_CommandeDetail.QteCommande <> 0 AND 
										( t_Produit.CodeTemporaire = 1 OR t_CommandeDetail.QteExpedie = 0 OR t_CommandeDetail.QteExpedie is null ) AND
										t_Commande.NoCommande = t_CommandeDetail.NoCommande 
										AND t_Commande.CieNo = t_CommandeDetail.CieNo
						
					) ;
		ll_count_total +=ll_count
	next
end if
next
*/
//ll_count_total = 1
//if ll_count_total > 0 then

	ll_total = lb_files.totalitems( )
	for i = 1 to ll_total
		if lb_files.state(i) = 1 then
			ls_cie = lb_files.text(i)
			ll_dayafter +=1
			for j = 1 to ll_dayafter
				ldt_temp =RelativeDate (ldt_debut, (j - 1) )
				
				SELECT 	cast(nobonexpe as integer) INTO :ll_NextLivNo
				FROM t_centreCIPQ
				  WHERE cie = :ls_cie ;
		
				//On exclu les commandes qui ont des produits utilisés comme 'CodeTemporaire', ou que des qtés livrés=0
				SELECT 	count( DISTINCT t_Commande.CieNo + ' ' + t_Commande.NoCommande ) INTO	:ll_count
				FROM t_commande
				WHERE 	t_Commande.Traiter = 1 AND t_Commande.Imprimer = 0 
					AND (t_Commande.Locked ='P' OR :ldt_temp <> date(today())) AND
					date(t_Commande.DateCommande) = :ldt_temp AND t_Commande.CieNo = :ls_cie AND
					NOT EXISTS(
					
						SELECT 		1
						FROM 			t_CommandeDetail 
						LEFT JOIN 	t_Produit ON (upper(t_CommandeDetail.NoProduit) = upper(t_Produit.NoProduit)) 
						WHERE	 		t_CommandeDetail.QteCommande <> 0 AND 
										( t_Produit.CodeTemporaire = 1 OR t_CommandeDetail.QteExpedie = 0 OR t_CommandeDetail.QteExpedie is null ) AND
										t_Commande.NoCommande = t_CommandeDetail.NoCommande 
										AND t_Commande.CieNo = t_CommandeDetail.CieNo
						
					) ;
					
				if ll_count = 0 THEN ll_count+=1
				ls_livno_fin = string((ll_NextLivNo + ll_count) - 1)
				
				
				lds_commande_generer_bon = CREATE n_ds	
				lds_commande_generer_bon.dataobject = "ds_commande_generer_bon"
				lds_commande_generer_bon.of_setTransobject(SQLCA)
				ll_nbrow = lds_commande_generer_bon.Retrieve(ldt_temp, ls_cie)
				ll_nofin = long(ls_livno_fin)
				ll_nobonlivraison = THIS.of_reservenextlivno(ls_cie)
				
				FOR ll_cpt = 1 TO ll_nbrow
					ll_nobonlivraison = THIS.of_reservenextlivno(ls_cie)
					lds_commande_generer_bon.object.nobonexpe[ll_cpt] = string(ll_nobonlivraison)
					lds_commande_generer_bon.object.imprimer[ll_cpt] = 1
					lds_commande_generer_bon.update(true,true)
					COMMIT USING SQLCA;
					IF ll_nofin = ll_nobonlivraison THEN EXIT
				next
				
				IF IsValid(lds_commande_generer_bon) THEN destroy(lds_commande_generer_bon) 
				
				of_posterbonlivraison(ls_cie)
			next
			
		end if
	NEXT
	gnv_app.of_printunLock()
	
//end if
end subroutine

public function long of_reservenextlivno (string as_cie);//of_ReserveNextLivNo

long ll_retour = -1
string	 ls_no

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

public subroutine of_posterbonlivraison (string as_cie);//of_posterbonlivraison

string	ls_cie, ls_sql

//ls_cie = string(dw_impression_commande.object.no_centre[1])
ls_cie = as_cie
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

on w_fichierxml.create
int iCurrent
call super::create
this.uo_imprimer=create uo_imprimer
this.st_7=create st_7
this.ddlb_eleveur=create ddlb_eleveur
this.st_6=create st_6
this.rb_bon=create rb_bon
this.rb_date=create rb_date
this.uo_fermer=create uo_fermer
this.st_5=create st_5
this.lb_files=create lb_files
this.uo_creerxml=create uo_creerxml
this.uo_rechercher=create uo_rechercher
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_fin=create sle_fin
this.sle_deb=create sle_deb
this.em_debut=create em_debut
this.em_fin=create em_fin
this.dw_fichierxmlbon=create dw_fichierxmlbon
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_imprimer
this.Control[iCurrent+2]=this.st_7
this.Control[iCurrent+3]=this.ddlb_eleveur
this.Control[iCurrent+4]=this.st_6
this.Control[iCurrent+5]=this.rb_bon
this.Control[iCurrent+6]=this.rb_date
this.Control[iCurrent+7]=this.uo_fermer
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.lb_files
this.Control[iCurrent+10]=this.uo_creerxml
this.Control[iCurrent+11]=this.uo_rechercher
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.sle_fin
this.Control[iCurrent+17]=this.sle_deb
this.Control[iCurrent+18]=this.em_debut
this.Control[iCurrent+19]=this.em_fin
this.Control[iCurrent+20]=this.dw_fichierxmlbon
this.Control[iCurrent+21]=this.rr_1
end on

on w_fichierxml.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_imprimer)
destroy(this.st_7)
destroy(this.ddlb_eleveur)
destroy(this.st_6)
destroy(this.rb_bon)
destroy(this.rb_date)
destroy(this.uo_fermer)
destroy(this.st_5)
destroy(this.lb_files)
destroy(this.uo_creerxml)
destroy(this.uo_rechercher)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_fin)
destroy(this.sle_deb)
destroy(this.em_debut)
destroy(this.em_fin)
destroy(this.dw_fichierxmlbon)
destroy(this.rr_1)
end on

event open;call super::open;string ls_odbc
em_debut.text = string(today())
em_fin.text = string(today())
lb_files.event ue_fill()


end event

type uo_imprimer from u_cst_toolbarstrip within w_fichierxml
integer x = 928
integer y = 2056
integer width = 384
integer taborder = 110
end type

event ue_buttonclicked;call super::ue_buttonclicked;long ll_row
long ll_qr
string ls_xml, ls_cieno, ls_ligneno, ls_prodno, ls_descrip, ls_livno, ls_melange, ls_regagr, ls_ampm,ls_credit
string ls_messageliv, ls_boncommande, ls_groupe, ls_transporteur, ls_nomeleveur, ls_adresseeleveur
string ls_rueeleveur, ls_villeeleveur, ls_conteeleveur, ls_provinceeleveur, ls_codposteleveur
string ls_telephoneeleveur, ls_adresseeleveur_a, ls_villeeleveur_a, ls_codposteleveur_a, ls_noroute
string ls_telephoneeleveur_a, ls_conteeleveur_a, ls_sousgroupe
long ll_qtecomm, ll_qteexp, ll_qteinit
datetime ldtt_livdate
date ldt_debut, ldt_fin
long ll_debut, ll_fin, i
string ls_path, ls_file
string ls_xml_facture[]
long ll_row_print
long ll_row_list
string ls_no_eleveur
long ll_job
blob lblob_qr
string ls_chemin
integer li_FileNum
datastore lds_fact_print
lds_fact_print = create datastore
lds_fact_print.dataobject = 'd_facture_print'
lds_fact_print.settransobject(sqlca)
lds_fact_print.retrieve()
ll_row = dw_fichierxmlbon.getrow()
if ll_row > 0 then
	ls_cieno = dw_fichierxmlbon.getItemString(ll_row,"t_statfacture_cie_no")
	ls_livno = dw_fichierxmlbon.getItemString(ll_row,"t_statfacture_liv_no")
	DECLARE liststat CURSOR FOR
		select  	 
			t_statfacturedetail.cie_no,
			t_statfacturedetail.liv_no,
			t_statfacturedetail.ligne_no,
			t_statfacturedetail.prod_no,
			t_statfacturedetail.qte_comm,
			t_statfacturedetail.qte_exp,
			t_statfacturedetail.description,
			t_statfacturedetail.melange,
			t_statfacturedetail.qteinit,
			t_statfacture.reg_agr,
			t_statfacture.liv_date,
			t_statfacture.ampm, 
			t_statfacture.credit,
			t_statfacture.message_liv,
			t_statfacture.boncommandeclient,
			t_eleveur_group.description,
			t_eleveur_groupsecondaire.nomgroupsecondaire,
			t_transporteur.secteur,
			t_eleveur.nom,
			t_eleveur.adresse,
			t_eleveur.rue,
			t_eleveur.ville,
			t_eleveur.conte,
			t_eleveur.province,
			t_eleveur.code_post,
			t_eleveur.telephone,
			t_eleveur.liv_adr_a,
			t_eleveur.liv_vil_a,
			t_eleveur.liv_cod_a,
			t_eleveur.liv_tel_a,
			t_eleveur.liv_conte,
			if isnull(liv_adr_a,'') = '' then secteur_transporteur else liv_notran endif,
			t_StatFacture.No_Eleveur
	from t_statfacture  INNER JOIN t_statfacturedetail ON t_statfacture.cie_no = t_statfacturedetail.cie_no and t_statfacture.liv_no = t_statfacturedetail.liv_no
								  LEFT OUTER JOIN t_eleveur ON t_eleveur.no_eleveur = t_statfacture.no_eleveur
								  LEFT OUTER JOIN t_transporteur ON t_transporteur.idtransporteur = t_statfacture.idtransporteur
								  LEFT OUTER JOIN t_eleveur_group ON t_eleveur_group.idgroup = t_statfacture.groupe
								  LEFT OUTER JOIN t_eleveur_groupsecondaire ON t_eleveur_groupsecondaire.idgroup = t_statfacture.groupesecondaire
	where  t_statfacture.cie_no = :ls_cieno AND t_statfacture.liv_no = :ls_livno
	;
	OPEN liststat;
	
	FETCH liststat into :ls_cieno,
						:ls_livno,
						:ls_ligneno,
						:ls_prodno,
						:ll_qtecomm,
						:ll_qteexp,
						:ls_descrip,
						:ls_melange,
						:ll_qteinit,
						:ls_regagr,
						:ldtt_livdate,
						:ls_ampm,
						:ls_credit,
						:ls_messageliv,
						:ls_boncommande,
						:ls_groupe,
						:ls_sousgroupe,
						:ls_transporteur,
						:ls_nomeleveur,
						:ls_adresseeleveur,
						:ls_rueeleveur,
						:ls_villeeleveur,
						:ls_conteeleveur,
						:ls_provinceeleveur,
						:ls_codposteleveur,
						:ls_telephoneeleveur,
						:ls_adresseeleveur_a,
						:ls_villeeleveur_a,
						:ls_codposteleveur_a,
						:ls_telephoneeleveur_a,
						:ls_conteeleveur_a,
						:ls_noroute,
						:ls_no_eleveur
	;
	DO WHILE SQLCA.SQLCode = 0
		//	2023-05-11	ClaudeB	CIPQ-23	Ajouter le mélange a la description sur la facture
//		If ls_melange <> "" or Not IsNull(ls_melange) Then 
//			ls_descrip += " - " + ls_melange 
//		End If
		//pour le print
		ll_row_print = lds_fact_print.insertrow(0)
		lds_fact_print.setitem(ll_row_print,'cie_no',ls_cieno)
		lds_fact_print.setitem(ll_row_print,'liv_no',ls_livno)
		lds_fact_print.setitem(ll_row_print,'liv_date',ldtt_livdate) 
		lds_fact_print.setitem(ll_row_print,'transporteur',ls_transporteur)
		lds_fact_print.setitem(ll_row_print,'quantite',ll_qteexp)
		lds_fact_print.setitem(ll_row_print,'code',ls_prodno)
		lds_fact_print.setitem(ll_row_print,'desc',ls_descrip)
		lds_fact_print.setitem(ll_row_print,'boncommand',ls_boncommande)
		lds_fact_print.setitem(ll_row_print,'no_eleveur',ls_no_eleveur)
		lds_fact_print.setitem(ll_row_print,'nom_eleveur',ls_nomeleveur)
		lds_fact_print.setitem(ll_row_print,'adresse_eleveur',ls_adresseeleveur)
		lds_fact_print.setitem(ll_row_print,'rue_eleveur',ls_rueeleveur)
		lds_fact_print.setitem(ll_row_print,'ville_eleveur',ls_villeeleveur)
		lds_fact_print.setitem(ll_row_print,'province_eleveur',ls_conteeleveur)
		lds_fact_print.setitem(ll_row_print,'zip_eleveur',ls_codposteleveur)
		lds_fact_print.setitem(ll_row_print,'tel_eleveur',ls_telephoneeleveur)
		lds_fact_print.setitem(ll_row_print,'melange',ls_melange)
		lds_fact_print.setitem(ll_row_print,'message', ls_messageliv)

		FETCH liststat 	into :ls_cieno,
								:ls_livno,
								:ls_ligneno,
								:ls_prodno,
								:ll_qtecomm,
								:ll_qteexp,
								:ls_descrip,
								:ls_melange,
								:ll_qteinit,
								:ls_regagr,
								:ldtt_livdate,
								:ls_ampm,
								:ls_credit,
								:ls_messageliv,
								:ls_boncommande,
								:ls_groupe,
								:ls_sousgroupe,
								:ls_transporteur,
								:ls_nomeleveur,
								:ls_adresseeleveur,
								:ls_rueeleveur,
								:ls_villeeleveur,
								:ls_conteeleveur,
								:ls_provinceeleveur,
								:ls_codposteleveur,
								:ls_telephoneeleveur,
								:ls_adresseeleveur_a,
								:ls_villeeleveur_a,
								:ls_codposteleveur_a,
								:ls_telephoneeleveur_a,
								:ls_conteeleveur_a, 
								:ls_noroute,
								:ls_no_eleveur
		;
	LOOP
	CLOSE liststat;
	
	ll_qr = dw_fichierxmlbon.getitemnumber(ll_row,'is_qr')
	if ll_qr > 0 then
		//chercher image qr
		selectblob imgcodeqr  into :lblob_qr
		from t_imgcodeqr
		where liv_no = :ls_livno and cie_no = :ls_cieno
		;
		ls_chemin = 'C:\Program Files (x86)\ii4net\'+ls_livno+'-'+ls_cieno+'.png'
		//open/create un file .png
		li_FileNum = FileOpen(ls_chemin,StreamMode!, Write!, Shared!, Replace!)
		//write blob in the file .png
		FileWriteEx(li_FileNum, lblob_qr)
		fileclose(li_filenum)
		lds_fact_print.setItem(1, "imagefile", ls_chemin)
	end if
	ll_job = PrintOpen( "Bon de commande", true)
	PrintDataWindow(ll_job, lds_fact_print)
	PrintClose(ll_job)
	filedelete(ls_chemin)
end if

end event

on uo_imprimer.destroy
call u_cst_toolbarstrip::destroy
end on

type st_7 from statictext within w_fichierxml
boolean visible = false
integer x = 987
integer y = 1972
integer width = 617
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_eleveur from u_ddlb within w_fichierxml
integer x = 32
integer y = 624
integer width = 919
integer height = 816
integer taborder = 70
boolean allowedit = true
boolean autohscroll = true
boolean hscrollbar = true
boolean ib_autoselect = true
boolean ib_search = true
end type

event constructor;call super::constructor;long ll_no_eleveur
string ls_nom
this.of_reset( )

this.of_additem( 'Tous',0)
declare listeleveur cursor for
select no_eleveur,nom from t_eleveur
where nom <>''and nom is not null
order by nom asc
;
open listeleveur;
fetch listeleveur into :ll_no_eleveur,:ls_nom;
do while SQLCA.SQLCode = 0
	of_addITem(string(ll_no_eleveur)+' '+ls_nom, ll_no_eleveur)
	fetch listeleveur into :ll_no_eleveur,:ls_nom;
loop
close listeleveur;
this.of_selectitem(1)

end event

type st_6 from statictext within w_fichierxml
integer x = 32
integer y = 552
integer width = 370
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
string text = "No de l~'éleveur: "
boolean focusrectangle = false
end type

type rb_bon from radiobutton within w_fichierxml
integer x = 466
integer y = 32
integer width = 430
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
string text = "Intervalle de bon"
end type

type rb_date from radiobutton within w_fichierxml
integer x = 27
integer y = 32
integer width = 375
integer height = 64
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
string text = "Intervalle date"
boolean checked = true
end type

type uo_fermer from u_cst_toolbarstrip within w_fichierxml
integer x = 1317
integer y = 2056
integer width = 311
integer taborder = 100
end type

on uo_fermer.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;close(parent)
end event

type st_5 from statictext within w_fichierxml
integer x = 32
integer y = 728
integer width = 498
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
string text = "Numéro de compagnie"
boolean focusrectangle = false
end type

type lb_files from u_lb within w_fichierxml
event ue_fill ( )
integer x = 32
integer y = 804
integer width = 919
integer height = 1244
integer taborder = 70
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Tahoma"
boolean multiselect = true
boolean extendedselect = true
end type

event ue_fill();string ls_odbc
string ls_cie
ls_odbc = gnv_app.of_getodbc()
choose case ls_odbc
	case 'cipq_admin'
		of_additem( string(110), string(110))
	case 'cipq_stlambert'
		of_additem( string(111), string(111))
	//	of_additem( string(114), string(114))
	//	of_additem( string(115), string(115))
	//	of_additem( string(117), string(117))
	//	of_additem( string(118), string(118))
	//	of_additem( string(119), string(119))
	case 'cipq_roxton'
		of_additem( string(112), string(112))
	case 'cipq_stcuthbert'
		of_additem( string(113), string(113))
	case 'cipq_stpatrice'
		of_additem( string(116), string(116))
	case else
		declare listcie cursor for 
			select cie from t_centrecipq
        		;
		open listcie;
		fetch listcie into :ls_cie;
		do while sqlca.sqlcode = 0
			of_additem( ls_cie, ls_cie)
			fetch listcie into :ls_cie;
		loop
		close listcie;
end choose

/*
cipq_admin = 110
cipq_stlambert =111, 114, 115, 117, 118, 119
cipq_roxton = 112
cipq_stcuthbert = 113
cipq_stpatrice = 116
*/

/*

string ls_cie

DECLARE listcie CURSOR FOR
	select cie from t_centrecipq;
	
OPEN listcie;

FETCH listcie INTO :ls_cie;

DO WHILE SQLCA.SQLCode = 0
	
	of_additem( ls_cie, ls_cie)

	FETCH listcie INTO :ls_cie;

LOOP

CLOSE listcie;
*/






 
end event

type uo_creerxml from u_cst_toolbarstrip within w_fichierxml
integer x = 425
integer y = 2056
integer taborder = 90
borderstyle borderstyle = styleshadowbox!
end type

on uo_creerxml.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;string ls_xml, ls_cieno, ls_ligneno, ls_prodno, ls_descrip, ls_livno, ls_melange, ls_regagr, ls_ampm,ls_credit
string ls_messageliv, ls_boncommande, ls_groupe, ls_transporteur, ls_nomeleveur, ls_adresseeleveur
string ls_rueeleveur, ls_villeeleveur, ls_conteeleveur, ls_provinceeleveur, ls_codposteleveur
string ls_telephoneeleveur, ls_adresseeleveur_a, ls_villeeleveur_a, ls_codposteleveur_a, ls_noroute
string ls_telephoneeleveur_a, ls_conteeleveur_a, ls_sousgroupe
long ll_qtecomm, ll_qteexp, ll_qteinit
datetime ldtt_livdate
date ldt_debut, ldt_fin
long ll_debut, ll_fin, i
string ls_path, ls_file
string ls_xml_facture[]
long ll_row
long ll_row_print
long ll_row_list
string ls_no_eleveur
long ll_is_strikeout
string ls_livno_avec_mod
string ls_adresseeleveur_a_temp
string ls_rueeleveur_a_temp
string ls_villeeleveur_a_temp
string ls_conteeleveur_a_temp
string ls_codposteleveur_a_temp
string ls_telephoneeleveur_a_temp
long j

datastore lds_fichierxml
datastore lds_facture_detail
datastore lds_fact_print
datastore lds_fact_list

lds_facture_detail = create datastore
lds_fact_print = create datastore
lds_fact_list = create datastore

lds_facture_detail.dataobject = 'd_facture_detail'
lds_facture_detail.settransobject(sqlca)
lds_facture_detail.retrieve()

lds_fact_print.dataobject = 'd_facture_print'
lds_fact_print.settransobject(sqlca)
lds_fact_print.retrieve()

lds_fact_list.dataobject = 'd_facture_list'
lds_fact_list.settransobject(sqlca)
lds_fact_list.retrieve()

em_debut.getdata(ldt_debut)
em_fin.getdata(ldt_fin)

ll_debut = long(sle_deb.text)
ll_fin =  long(sle_fin.text)

//ls_xml += "<?xml version=~"1.0~"?>"  + "~r~n"
//ls_xml += "<bibliotheque>" + "~r~n"

SetPointer(HourGlass!)
/*
for i = 1 to dw_fichierxmlbon.rowcount()
	lds_fichierxml = create datastore
	lds_fichierxml.dataobject = 'd_fichierxml'
	lds_fichierxml.settransobject(sqlca)
	
	ls_xml = ''
	ls_cieno = dw_fichierxmlbon.getItemString(i,"t_statfacture_cie_no")
	ls_livno_avec_mod = dw_fichierxmlbon.getItemString(i,"t_statfacture_liv_no")
	//pour modification
	if pos(ls_livno_avec_mod,'(M)')>0 then
		ls_livno = mid(ls_livno_avec_mod,1,len(ls_livno_avec_mod) - 3)
	else
		ls_livno = ls_livno_avec_mod
	end if
	lds_fichierxml.retrieve(ls_cieno,ls_livno)
	
	
	
	ll_is_strikeout = dw_fichierxmlbon.getItemnumber(i,"is_strikeout")
	
	ls_xml += "<?xml version=~"1.0~"?>"  + "~r~n"
	ls_xml += "<bibliotheque>" + "~r~n"
	ls_xml += "<cie_no id=~"" + ls_cieno + "~">~r~n"
	ls_xml += "<liv_no id=~"" + ls_livno + "~">~r~n"

	for j = 1 to lds_fichierxml.rowcount()
		ls_cieno = lds_fichierxml.getitemstring(j,'t_statfacturedetail_cie_no')
		ls_livno = lds_fichierxml.getitemstring(j,'t_statfacturedetail_liv_no')
		ls_ligneno = lds_fichierxml.getitemstring(j,'t_statfacturedetail_ligne_no')
		ls_prodno  = lds_fichierxml.getitemstring(j,'t_statfacturedetail_prod_no')
		ll_qtecomm =  lds_fichierxml.getitemnumber(j,'t_statfacturedetail_qte_comm')
		ll_qteexp =  lds_fichierxml.getitemnumber(j,'t_statfacturedetail_qte_exp')
		ls_descrip  =  lds_fichierxml.getitemstring(j,'t_statfacturedetail_description')
		ls_melange  =  lds_fichierxml.getitemstring(j,'t_statfacturedetail_melange')
		ll_qteinit =  lds_fichierxml.getitemnumber(j,'t_statfacturedetail_qteinit')
		ls_regagr = lds_fichierxml.getitemstring(j,'t_statfacture_reg_agr')
		ldtt_livdate = lds_fichierxml.getitemdatetime( j,"t_statfacture_liv_date")
		ls_ampm =  lds_fichierxml.getitemstring(j,'t_statfacture_ampm')
		ls_credit =  lds_fichierxml.getitemstring(j,'t_statfacture_credit')
		ls_messageliv =  lds_fichierxml.getitemstring(j,'t_statfacture_message_liv')
		ls_boncommande =  lds_fichierxml.getitemstring(j,'t_statfacture_boncommandeclient')
		ls_groupe =  lds_fichierxml.getitemstring(j,'t_eleveur_group_description')
		ls_sousgroupe=  lds_fichierxml.getitemstring(j,'t_eleveur_groupsecondaire_nomgroupsecondaire')
		ls_transporteur =  lds_fichierxml.getitemstring(j,'t_transporteur_secteur')
		ls_nomeleveur =  lds_fichierxml.getitemstring(j,'t_eleveur_nom')
		ls_adresseeleveur =  lds_fichierxml.getitemstring(j,'t_eleveur_adresse')
		ls_rueeleveur =  lds_fichierxml.getitemstring(j,'t_eleveur_rue')
		ls_villeeleveur =  lds_fichierxml.getitemstring(j,'t_eleveur_ville')
		ls_conteeleveur =  lds_fichierxml.getitemstring(j,'t_eleveur_conte')
		ls_provinceeleveur =  lds_fichierxml.getitemstring(j,'t_eleveur_province')
		ls_codposteleveur =  lds_fichierxml.getitemstring(j,'t_eleveur_code_post')
		ls_telephoneeleveur =  lds_fichierxml.getitemstring(j,'t_eleveur_telephone')
		ls_adresseeleveur_a =  lds_fichierxml.getitemstring(j,'t_eleveur_liv_adr_a')
		ls_villeeleveur_a =  lds_fichierxml.getitemstring(j,'t_eleveur_liv_vil_a')
		ls_codposteleveur_a =  lds_fichierxml.getitemstring(j,'t_eleveur_liv_cod_a')
		ls_telephoneeleveur_a =  lds_fichierxml.getitemstring(j,'t_eleveur_liv_tel_a')
		ls_conteeleveur_a =  lds_fichierxml.getitemstring(j,'t_eleveur_liv_conte')
		ls_noroute =  string(lds_fichierxml.getitemnumber(j,'no_tran'))
		ls_no_eleveur = string( lds_fichierxml.getitemnumber(j,'t_statfacture_no_eleveur'))
		
		
		ls_xml += "<bonlivraison>" + "~r~n"
		if isnull(ls_ligneno) then ls_ligneno  = ""
		ls_xml += "<ligne_no>" + ls_ligneno + "</ligne_no>" + "~r~n"
		if isnull(ls_prodno) then ls_prodno  = ""
		ls_xml += "<prod_no>" + ls_prodno + "</prod_no>" + "~r~n"
		if isnull(ll_qtecomm) then ll_qtecomm  = 0
		ls_xml += "<qte_comm>" + string(ll_qtecomm) + "</qte_comm>" + "~r~n"
		if isnull(ll_qteexp) then ll_qteexp  = 0
		ls_xml += "<qte_exp>" + string(ll_qteexp) + "</qte_exp>" + "~r~n"
		if isnull(ls_descrip) then ls_descrip  = ""
		ls_xml += "<description>" + ls_descrip + "</description>" + "~r~n"
		if isnull(ls_melange) then ls_melange  = ""
		ls_xml += "<melange>" + ls_melange + "</melange>" + "~r~n"
		if isnull(ll_qteinit) then ll_qteinit  = 0
		ls_xml += "<qteinit>" + string(ll_qteinit) + "</qteinit>" + "~r~n"
		if isnull(ls_regagr) then ls_regagr  = ""
		ls_xml += "<reg_agr>" + ls_regagr + "</reg_agr>" + "~r~n"
		ls_xml += "<liv_date>" + string(ldtt_livdate,"dd-mm-yyyy") + "</liv_date>" + "~r~n"
		if isnull(ls_ampm) then ls_ampm  = ""
		ls_xml += "<ampm>" + ls_ampm + "</ampm>" + "~r~n"
		if isnull(ls_credit) then ls_credit  = ""
		ls_xml += "<credit>" + ls_credit + "</credit>" + "~r~n"
		if isnull(ls_messageliv) then ls_messageliv  = ""
		ls_xml += "<message_liv>" + ls_messageliv + "</message_liv>" + "~r~n"
		if isnull(ls_boncommande) then ls_boncommande  = ""
		ls_xml += "<boncommande>" + ls_boncommande + "</boncommande>" + "~r~n"
		if isnull(ls_groupe) then ls_groupe  = ""
		ls_xml += "<groupe>" + ls_groupe + "</groupe>" + "~r~n"
		if isnull(ls_sousgroupe) then ls_sousgroupe  = ""
		ls_xml += "<sousgroupe>" + ls_sousgroupe + "</sousgroupe>" + "~r~n"
		if isnull(ls_transporteur) then ls_transporteur  = ""
		ls_xml += "<transporteur>" + ls_transporteur + "</transporteur>" + "~r~n"
		if isnull(ls_no_eleveur) then ls_no_eleveur  = ""
		ls_xml += "<noeleveur>" + ls_no_eleveur + "</noeleveur>" + "~r~n"
		if isnull(ls_nomeleveur) then ls_nomeleveur  = ""
		ls_xml += "<nomeleveur><![CDATA[" + ls_nomeleveur + "]]></nomeleveur>" + "~r~n"
		if isnull(ls_adresseeleveur) then ls_adresseeleveur  = ""
		ls_xml += "<adresseeleveur>" + ls_adresseeleveur + "</adresseeleveur>" + "~r~n"
		
		//ls_xml += "<adresseeleveur>XX</adresseeleveur>" + "~r~n"
		
		
		if isnull(ls_rueeleveur) then ls_rueeleveur  = ""
		ls_xml += "<rueeleveur>" + ls_rueeleveur + "</rueeleveur>" + "~r~n"
		if isnull(ls_villeeleveur) then ls_villeeleveur  = ""
		ls_xml += "<villeeleveur>" + ls_villeeleveur + "</villeeleveur>" + "~r~n"
		if isnull(ls_conteeleveur) then ls_conteeleveur  = ""
		ls_xml += "<conteeleveur>" + ls_conteeleveur + "</conteeleveur>" + "~r~n"
		if isnull(ls_provinceeleveur) then ls_provinceeleveur  = ""
		ls_xml += "<provinceeleveur>" + ls_provinceeleveur + "</provinceeleveur>" + "~r~n"
		if isnull(ls_codposteleveur) then ls_codposteleveur  = ""
		ls_xml += "<codeposteleveur>" + ls_codposteleveur + "</codeposteleveur>" + "~r~n"
		if isnull(ls_telephoneeleveur) then ls_telephoneeleveur  = ""
		ls_xml += "<telephoneeleveur>" + ls_telephoneeleveur + "</telephoneeleveur>" + "~r~n"
		if isnull(ls_adresseeleveur_a) then ls_adresseeleveur_a  = ""
		ls_xml += "<adresseeleveur_a>" + ls_adresseeleveur_a + "</adresseeleveur_a>" + "~r~n"
		if isnull(ls_villeeleveur_a) then ls_villeeleveur_a  = ""
		ls_xml += "<villeeleveur_a>" + ls_villeeleveur_a + "</villeeleveur_a>" + "~r~n"
		if isnull(ls_codposteleveur_a) then ls_codposteleveur_a  = ""
		ls_xml += "<codeposteleveur_a>" + ls_codposteleveur_a + "</codeposteleveur_a>" + "~r~n"
		if isnull(ls_telephoneeleveur_a) then ls_telephoneeleveur_a  = ""
		ls_xml += "<telephoneeleveur_a>" + ls_telephoneeleveur_a + "</telephoneeleveur_a>" + "~r~n"
		if isnull(ls_conteeleveur_a) then ls_conteeleveur_a  = ""
		ls_xml += "<conteeleveur_a>" + ls_conteeleveur_a + "</conteeleveur_a>" + "~r~n"
		if isnull(ls_noroute) then ls_noroute  = ""
		ls_xml += "<noroute>" + ls_noroute + "</noroute>" + "~r~n"
		ls_xml += "</bonlivraison>" + "~r~n"
		
		//pour le print
		ll_row_print = lds_fact_print.insertrow(0)
		lds_fact_print.setitem(ll_row_print,'cie_no',ls_cieno)
	     lds_fact_print.setitem(ll_row_print,'liv_no',ls_livno)
		lds_fact_print.setitem(ll_row_print,'liv_date',ldtt_livdate) 
		lds_fact_print.setitem(ll_row_print,'transporteur',ls_transporteur)
		lds_fact_print.setitem(ll_row_print,'quantite',ll_qteexp)
		lds_fact_print.setitem(ll_row_print,'code',ls_prodno)
		lds_fact_print.setitem(ll_row_print,'desc',ls_descrip)
		lds_fact_print.setitem(ll_row_print,'boncommand',ls_boncommande)
		lds_fact_print.setitem(ll_row_print,'no_eleveur',ls_no_eleveur)
		lds_fact_print.setitem(ll_row_print,'nom_eleveur',ls_nomeleveur)
		if ls_adresseeleveur_a = "" then
			lds_fact_print.setitem(ll_row_print,'adresse_eleveur',ls_adresseeleveur)	
			lds_fact_print.setitem(ll_row_print,'rue_eleveur',ls_rueeleveur)
			lds_fact_print.setitem(ll_row_print,'ville_eleveur',ls_villeeleveur)
			lds_fact_print.setitem(ll_row_print,'province_eleveur',ls_conteeleveur)
			lds_fact_print.setitem(ll_row_print,'zip_eleveur',ls_codposteleveur)
			lds_fact_print.setitem(ll_row_print,'tel_eleveur',ls_telephoneeleveur)
			ls_adresseeleveur_a_temp = ls_adresseeleveur
			ls_rueeleveur_a_temp = ls_rueeleveur
			ls_villeeleveur_a_temp=ls_villeeleveur
			ls_conteeleveur_a_temp=ls_conteeleveur
			ls_codposteleveur_a_temp = ls_codposteleveur
			ls_telephoneeleveur_a_temp = ls_telephoneeleveur
		else
			lds_fact_print.setitem(ll_row_print,'adresse_eleveur',ls_adresseeleveur_a)
			lds_fact_print.setitem(ll_row_print,'rue_eleveur',"")
			lds_fact_print.setitem(ll_row_print,'ville_eleveur',ls_villeeleveur_a)
			lds_fact_print.setitem(ll_row_print,'province_eleveur',ls_conteeleveur_a)
			lds_fact_print.setitem(ll_row_print,'zip_eleveur',ls_codposteleveur_a)
			lds_fact_print.setitem(ll_row_print,'tel_eleveur',ls_telephoneeleveur_a)
			ls_adresseeleveur_a_temp = ls_adresseeleveur_a
			ls_rueeleveur_a_temp = ""
			ls_villeeleveur_a_temp=ls_villeeleveur_a
			ls_conteeleveur_a_temp=ls_conteeleveur_a
			ls_codposteleveur_a_temp = ls_codposteleveur_a
			ls_telephoneeleveur_a_temp = ls_telephoneeleveur_a
		end if
		
	next
	
	ls_xml += "</liv_no>~r~n"
	ls_xml += "</cie_no>~r~n"
	ls_xml += "</bibliotheque>"
	ls_xml_facture[i]=ls_xml
	
	ll_row = lds_facture_detail.insertrow(0)
	lds_facture_detail.setitem(ll_row,'cie_no',ls_cieno)
	lds_facture_detail.setitem(ll_row,'liv_no',ls_livno)	
	lds_facture_detail.setitem(ll_row,'liv_date',ldtt_livdate)
	lds_facture_detail.setitem(ll_row,'nom',ls_nomeleveur)
	lds_facture_detail.setitem(ll_row,'telephone',ls_telephoneeleveur)
	lds_facture_detail.setitem(ll_row,'adresse',ls_adresseeleveur)
	lds_facture_detail.setitem(ll_row,'rue',ls_rueeleveur)
	lds_facture_detail.setitem(ll_row,'ville',ls_villeeleveur)
	lds_facture_detail.setitem(ll_row,'province',ls_provinceeleveur)
	lds_facture_detail.setitem(ll_row,'code_post',ls_codposteleveur)
	
	ll_row_list = lds_fact_list.insertrow(0)
	lds_fact_list.setitem(ll_row_list,'liv_no',ls_livno)
	lds_fact_list.setitem(ll_row_list,'cie_no',ls_cieno)
	lds_fact_list.setitem(ll_row_list,'liv_date',Date(ldtt_livdate))
	lds_fact_list.setitem(ll_row_list,'no_eleveur',ls_no_eleveur)
	lds_fact_list.setitem(ll_row_list,'no_route',ls_noroute)
	lds_fact_list.setitem(ll_row_list,'is_strikeout',ll_is_strikeout)
	
    destroy(lds_fichierxml)

next
*/

SetPointer(HourGlass!)

DECLARE liststat CURSOR FOR
	select
		t_statfacturedetail.cie_no,
		t_statfacturedetail.liv_no,
		t_statfacturedetail.ligne_no,
		t_statfacturedetail.prod_no,
		t_statfacturedetail.qte_comm,
		t_statfacturedetail.qte_exp,
		t_statfacturedetail.description,
		t_statfacturedetail.melange,
		t_statfacturedetail.qteinit,
		t_statfacture.reg_agr,
		t_statfacture.liv_date,
		t_statfacture.ampm, 
		t_statfacture.credit,
		t_statfacture.message_liv,
		t_statfacture.boncommandeclient,
		t_eleveur_group.description,
		t_eleveur_groupsecondaire.nomgroupsecondaire,
		t_transporteur.secteur,
		t_eleveur.nom,
		t_eleveur.adresse,
		t_eleveur.rue,
		t_eleveur.ville,
		t_eleveur.conte,
		t_eleveur.province,
		t_eleveur.code_post,
		t_eleveur.telephone,
		t_eleveur.liv_adr_a,
		t_eleveur.liv_vil_a,
		t_eleveur.liv_cod_a,
		t_eleveur.liv_tel_a,
		t_eleveur.liv_conte,
		if isnull(liv_adr_a,'') = '' then secteur_transporteur else liv_notran endif,
		t_StatFacture.No_Eleveur
	from t_statfacture  INNER JOIN t_statfacturedetail ON t_statfacture.cie_no = t_statfacturedetail.cie_no and t_statfacture.liv_no = t_statfacturedetail.liv_no
								  LEFT OUTER JOIN t_eleveur ON t_eleveur.no_eleveur = t_statfacture.no_eleveur
								  LEFT OUTER JOIN t_transporteur ON t_transporteur.idtransporteur = t_statfacture.idtransporteur
								  LEFT OUTER JOIN t_eleveur_group ON t_eleveur_group.idgroup = t_statfacture.groupe
								  LEFT OUTER JOIN t_eleveur_groupsecondaire ON t_eleveur_groupsecondaire.idgroup = t_statfacture.groupesecondaire
	where     t_statfacture.cie_no = :ls_cieno AND
				 t_statfacture.liv_no = :ls_livno
	;

SetPointer(HourGlass!)
for i = 1 to dw_fichierxmlbon.rowcount()
	
	ls_xml = ''
	ls_cieno = dw_fichierxmlbon.getItemString(i,"t_statfacture_cie_no")
	ls_livno_avec_mod = dw_fichierxmlbon.getItemString(i,"t_statfacture_liv_no")
	//pour modification
	if pos(ls_livno_avec_mod,'(M)')>0 then
		ls_livno = mid(ls_livno_avec_mod,1,len(ls_livno_avec_mod) - 3)
	else
		ls_livno = ls_livno_avec_mod
	end if
	
	ll_is_strikeout = dw_fichierxmlbon.getItemnumber(i,"is_strikeout")
	
	ls_xml += "<?xml version=~"1.0~"?>"  + "~r~n"
	ls_xml += "<bibliotheque>" + "~r~n"
	ls_xml += "<cie_no id=~"" + ls_cieno + "~">~r~n"
	ls_xml += "<liv_no id=~"" + ls_livno + "~">~r~n"
	
	OPEN liststat;
	
	FETCH liststat 	into	:ls_cieno,
									 :ls_livno,
									 :ls_ligneno,
									 :ls_prodno,
									 :ll_qtecomm,
									 :ll_qteexp,
									 :ls_descrip,
									 :ls_melange,
									 :ll_qteinit,
									 :ls_regagr,
									 :ldtt_livdate,
									 :ls_ampm,
									 :ls_credit,
									 :ls_messageliv,
									 :ls_boncommande,
									 :ls_groupe,
									 :ls_sousgroupe,
									 :ls_transporteur,
									 :ls_nomeleveur,
									 :ls_adresseeleveur,
									 :ls_rueeleveur,
									 :ls_villeeleveur,
									 :ls_conteeleveur,
									 :ls_provinceeleveur,
									 :ls_codposteleveur,
									 :ls_telephoneeleveur,
									 :ls_adresseeleveur_a,
									 :ls_villeeleveur_a,
									 :ls_codposteleveur_a,
									 :ls_telephoneeleveur_a,
									 :ls_conteeleveur_a,
									 :ls_noroute,
									 :ls_no_eleveur
									 ;
	DO WHILE SQLCA.SQLCode = 0
		//	2023-05-11	ClaudeB	CIPQ-23	Ajouter le mélange a la description sur la facture
//		If ls_melange <> "" or Not IsNull(ls_melange) Then 
//			ls_descrip += " - " + ls_melange 
//		End If
		
	
	//	ls_xml += "<cie_no>" + ls_cieno + "</cie_no>" + "~r~n"
	//	ls_xml += "<liv_no>" + ls_livno + "</liv_no>" + "~r~n"
		ls_xml += "<bonlivraison>" + "~r~n"
		if isnull(ls_ligneno) then ls_ligneno  = ""
		ls_xml += "<ligne_no>" + ls_ligneno + "</ligne_no>" + "~r~n"
		if isnull(ls_prodno) then ls_prodno  = ""
		ls_xml += "<prod_no>" + ls_prodno + "</prod_no>" + "~r~n"
		if isnull(ll_qtecomm) then ll_qtecomm  = 0
		ls_xml += "<qte_comm>" + string(ll_qtecomm) + "</qte_comm>" + "~r~n"
		if isnull(ll_qteexp) then ll_qteexp  = 0
		ls_xml += "<qte_exp>" + string(ll_qteexp) + "</qte_exp>" + "~r~n"
		if isnull(ls_descrip) then ls_descrip  = ""
		ls_xml += "<description>" + ls_descrip + "</description>" + "~r~n"
		if isnull(ls_melange) then ls_melange  = ""
		ls_xml += "<melange>" + ls_melange + "</melange>" + "~r~n"
		if isnull(ll_qteinit) then ll_qteinit  = 0
		ls_xml += "<qteinit>" + string(ll_qteinit) + "</qteinit>" + "~r~n"
		if isnull(ls_regagr) then ls_regagr  = ""
		ls_xml += "<reg_agr>" + ls_regagr + "</reg_agr>" + "~r~n"
		ls_xml += "<liv_date>" + string(ldtt_livdate,"dd-mm-yyyy") + "</liv_date>" + "~r~n"
		if isnull(ls_ampm) then ls_ampm  = ""
		ls_xml += "<ampm>" + ls_ampm + "</ampm>" + "~r~n"
		if isnull(ls_credit) then ls_credit  = ""
		ls_xml += "<credit>" + ls_credit + "</credit>" + "~r~n"
		if isnull(ls_messageliv) then ls_messageliv  = ""
		ls_xml += "<message_liv>" + ls_messageliv + "</message_liv>" + "~r~n"
		if isnull(ls_boncommande) then ls_boncommande  = ""
		ls_xml += "<boncommande>" + ls_boncommande + "</boncommande>" + "~r~n"
		if isnull(ls_groupe) then ls_groupe  = ""
		ls_xml += "<groupe>" + ls_groupe + "</groupe>" + "~r~n"
		if isnull(ls_sousgroupe) then ls_sousgroupe  = ""
		ls_xml += "<sousgroupe>" + ls_sousgroupe + "</sousgroupe>" + "~r~n"
		if isnull(ls_transporteur) then ls_transporteur  = ""
		ls_xml += "<transporteur>" + ls_transporteur + "</transporteur>" + "~r~n"
		if isnull(ls_no_eleveur) then ls_no_eleveur  = ""
		ls_xml += "<noeleveur>" + ls_no_eleveur + "</noeleveur>" + "~r~n"
		if isnull(ls_nomeleveur) then ls_nomeleveur  = ""
		ls_xml += "<nomeleveur><![CDATA[" + ls_nomeleveur + "]]></nomeleveur>" + "~r~n"
		if isnull(ls_adresseeleveur) then ls_adresseeleveur  = ""
		ls_xml += "<adresseeleveur>" + ls_adresseeleveur + "</adresseeleveur>" + "~r~n"
		
		//ls_xml += "<adresseeleveur>XX</adresseeleveur>" + "~r~n"
		
		
		if isnull(ls_rueeleveur) then ls_rueeleveur  = ""
		ls_xml += "<rueeleveur>" + ls_rueeleveur + "</rueeleveur>" + "~r~n"
		if isnull(ls_villeeleveur) then ls_villeeleveur  = ""
		ls_xml += "<villeeleveur>" + ls_villeeleveur + "</villeeleveur>" + "~r~n"
		if isnull(ls_conteeleveur) then ls_conteeleveur  = ""
		ls_xml += "<conteeleveur>" + ls_conteeleveur + "</conteeleveur>" + "~r~n"
		if isnull(ls_provinceeleveur) then ls_provinceeleveur  = ""
		ls_xml += "<provinceeleveur>" + ls_provinceeleveur + "</provinceeleveur>" + "~r~n"
		if isnull(ls_codposteleveur) then ls_codposteleveur  = ""
		ls_xml += "<codeposteleveur>" + ls_codposteleveur + "</codeposteleveur>" + "~r~n"
		if isnull(ls_telephoneeleveur) then ls_telephoneeleveur  = ""
		ls_xml += "<telephoneeleveur>" + ls_telephoneeleveur + "</telephoneeleveur>" + "~r~n"
		if isnull(ls_adresseeleveur_a) then ls_adresseeleveur_a  = ""
		ls_xml += "<adresseeleveur_a>" + ls_adresseeleveur_a + "</adresseeleveur_a>" + "~r~n"
		if isnull(ls_villeeleveur_a) then ls_villeeleveur_a  = ""
		ls_xml += "<villeeleveur_a>" + ls_villeeleveur_a + "</villeeleveur_a>" + "~r~n"
		if isnull(ls_codposteleveur_a) then ls_codposteleveur_a  = ""
		ls_xml += "<codeposteleveur_a>" + ls_codposteleveur_a + "</codeposteleveur_a>" + "~r~n"
		if isnull(ls_telephoneeleveur_a) then ls_telephoneeleveur_a  = ""
		ls_xml += "<telephoneeleveur_a>" + ls_telephoneeleveur_a + "</telephoneeleveur_a>" + "~r~n"
		if isnull(ls_conteeleveur_a) then ls_conteeleveur_a  = ""
		ls_xml += "<conteeleveur_a>" + ls_conteeleveur_a + "</conteeleveur_a>" + "~r~n"
		if isnull(ls_noroute) then ls_noroute  = ""
		ls_xml += "<noroute>" + ls_noroute + "</noroute>" + "~r~n"
		ls_xml += "</bonlivraison>" + "~r~n"
		
		If left(ls_messageliv, 3) = "sss" Then
			ls_messageliv = ls_messageliv
		End If
		//pour le print
		ll_row_print = lds_fact_print.insertrow(0)
		lds_fact_print.setitem(ll_row_print,'cie_no',ls_cieno)
	   lds_fact_print.setitem(ll_row_print,'liv_no',ls_livno)
		lds_fact_print.setitem(ll_row_print,'liv_date',ldtt_livdate) 
		lds_fact_print.setitem(ll_row_print,'transporteur',ls_transporteur)
		lds_fact_print.setitem(ll_row_print,'quantite',ll_qteexp)
		lds_fact_print.setitem(ll_row_print,'code',ls_prodno)
		lds_fact_print.setitem(ll_row_print,'desc',ls_descrip)
		lds_fact_print.setitem(ll_row_print,'boncommand',ls_boncommande)
		lds_fact_print.setitem(ll_row_print,'no_eleveur',ls_no_eleveur)
		lds_fact_print.setitem(ll_row_print,'nom_eleveur',ls_nomeleveur)
		lds_fact_print.setitem(ll_row_print,'numero_route',ls_noroute)
		lds_fact_print.setitem(ll_row_print,'melange',ls_melange)
		lds_fact_print.setitem(ll_row_print,'message', ls_messageliv)

		if ls_adresseeleveur_a = "" then
			lds_fact_print.setitem(ll_row_print,'adresse_eleveur',ls_adresseeleveur)	
			lds_fact_print.setitem(ll_row_print,'rue_eleveur',ls_rueeleveur)
			lds_fact_print.setitem(ll_row_print,'ville_eleveur',ls_villeeleveur)
			lds_fact_print.setitem(ll_row_print,'province_eleveur',ls_conteeleveur)
			lds_fact_print.setitem(ll_row_print,'zip_eleveur',ls_codposteleveur)
			lds_fact_print.setitem(ll_row_print,'tel_eleveur',ls_telephoneeleveur)
			ls_adresseeleveur_a_temp = ls_adresseeleveur
			ls_rueeleveur_a_temp = ls_rueeleveur
			ls_villeeleveur_a_temp=ls_villeeleveur
			ls_conteeleveur_a_temp=ls_conteeleveur
			ls_codposteleveur_a_temp = ls_codposteleveur
			ls_telephoneeleveur_a_temp = ls_telephoneeleveur
		else
			lds_fact_print.setitem(ll_row_print,'adresse_eleveur',ls_adresseeleveur_a)
			lds_fact_print.setitem(ll_row_print,'rue_eleveur',"")
			lds_fact_print.setitem(ll_row_print,'ville_eleveur',ls_villeeleveur_a)
			lds_fact_print.setitem(ll_row_print,'province_eleveur',ls_conteeleveur_a)
			lds_fact_print.setitem(ll_row_print,'zip_eleveur',ls_codposteleveur_a)
			lds_fact_print.setitem(ll_row_print,'tel_eleveur',ls_telephoneeleveur_a)
			ls_adresseeleveur_a_temp = ls_adresseeleveur_a
			ls_rueeleveur_a_temp = ""
			ls_villeeleveur_a_temp=ls_villeeleveur_a
			ls_conteeleveur_a_temp=ls_conteeleveur_a
			ls_codposteleveur_a_temp = ls_codposteleveur_a
			ls_telephoneeleveur_a_temp = ls_telephoneeleveur_a
		end if
		
		FETCH liststat 	into	:ls_cieno,
										 :ls_livno,
										 :ls_ligneno,
										 :ls_prodno,
										 :ll_qtecomm,
										 :ll_qteexp,
										 :ls_descrip,
										 :ls_melange,
										 :ll_qteinit,
										 :ls_regagr,
										 :ldtt_livdate,
										 :ls_ampm,
										 :ls_credit,
										 :ls_messageliv,
										 :ls_boncommande,
										 :ls_groupe,
										 :ls_sousgroupe,
										 :ls_transporteur,
										 :ls_nomeleveur,
										 :ls_adresseeleveur,
										 :ls_rueeleveur,
										 :ls_villeeleveur,
										 :ls_conteeleveur,
										 :ls_provinceeleveur,
										 :ls_codposteleveur,
										 :ls_telephoneeleveur,
										 :ls_adresseeleveur_a,
										 :ls_villeeleveur_a,
										 :ls_codposteleveur_a,
										 :ls_telephoneeleveur_a,
										 :ls_conteeleveur_a, 
										 :ls_noroute,
										 :ls_no_eleveur
										 ;
			
		
	LOOP
	
	CLOSE liststat;
	
	
	ls_xml += "</liv_no>~r~n"
	ls_xml += "</cie_no>~r~n"
	ls_xml += "</bibliotheque>"
	ls_xml_facture[i]=ls_xml
	
	ll_row = lds_facture_detail.insertrow(0)
	lds_facture_detail.setitem(ll_row,'cie_no',ls_cieno)
	lds_facture_detail.setitem(ll_row,'liv_no',ls_livno)	
	lds_facture_detail.setitem(ll_row,'liv_date',ldtt_livdate)
	lds_facture_detail.setitem(ll_row,'nom',ls_nomeleveur)

	
	if ls_adresseeleveur_a = "" then
		lds_facture_detail.setitem(ll_row,'telephone',ls_telephoneeleveur)
		lds_facture_detail.setitem(ll_row,'adresse',ls_adresseeleveur)
		lds_facture_detail.setitem(ll_row,'rue',ls_rueeleveur)
		lds_facture_detail.setitem(ll_row,'ville',ls_villeeleveur)
		lds_facture_detail.setitem(ll_row,'province',ls_provinceeleveur)
		lds_facture_detail.setitem(ll_row,'code_post',ls_codposteleveur)
			
	else
		lds_facture_detail.setitem(ll_row,'telephone',ls_telephoneeleveur_a)
		lds_facture_detail.setitem(ll_row,'adresse',ls_adresseeleveur_a)
		lds_facture_detail.setitem(ll_row,'rue',"")
		lds_facture_detail.setitem(ll_row,'ville',ls_villeeleveur_a)
		lds_facture_detail.setitem(ll_row,'province',ls_conteeleveur_a)
		lds_facture_detail.setitem(ll_row,'code_post',ls_codposteleveur_a)
		
	end if
	ll_row_list = lds_fact_list.insertrow(0)
	lds_fact_list.setitem(ll_row_list,'liv_no',ls_livno)
	lds_fact_list.setitem(ll_row_list,'cie_no',ls_cieno)
	lds_fact_list.setitem(ll_row_list,'liv_date',Date(ldtt_livdate))
	lds_fact_list.setitem(ll_row_list,'no_eleveur',ls_no_eleveur)
	lds_fact_list.setitem(ll_row_list,'no_route',ls_noroute)
	lds_fact_list.setitem(ll_row_list,'is_strikeout',ll_is_strikeout)
	
next

SetPointer(arrow!)
//wei ajouter 2022-05-25
gnv_app.inv_entrepotglobal.of_ajoutedonnee( 'facture_detail_datastore',lds_facture_detail)
gnv_app.inv_entrepotglobal.of_ajoutedonnee('facture_print_datastore',lds_fact_print)
gnv_app.inv_entrepotglobal.of_ajoutedonnee( 'facture_list_datastore',lds_fact_list)
gnv_app.inv_entrepotglobal.of_ajoutedonnee( 'xml_facture',ls_xml_facture)
		
//		lds_fact_print.SaveAs("C:\Users\cblais\Desktop\FACT2.TXT", Text!, tRUE)

w_http_reponse	lw_fen
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
//open(w_http_reponse)
/*
//ls_xml += "</bibliotheque>" 

//of_http_post(ls_xml)
long ll_file
//ls_path = "E:\Progitek\ii4net\CIPQ"
ls_path = "C:\ii4net\cipq"

if not directoryexists(ls_path) then
	createdirectory(ls_path)
end if
ls_path += "\curl"
if not directoryexists(ls_path) then
	createdirectory(ls_path)
end if

string ls_file_path
ls_file_path =ls_path + "\text.xml"

ll_file = fileopen(ls_file_path,textmode!,write!,LockReadWrite!, Replace!, EncodingUTF8!)

filewriteex(ll_file,ls_xml)
fileclose(ll_file)

long ll_run
n_cst_syncproc luo_sync
luo_sync = CREATE n_cst_syncproc
			
luo_sync.of_setwindow('Minimized!')
luo_sync.of_RunAndWait('"' + ls_path + "\curl_request.bat" + '"')
*/

//ll_run = run("C:\ii4net\cipq\curl\curl_request.bat",Normal!)
//messagebox('run',ll_run)

// c:\ii4net\cipq\curl\bin\curl.exe 

//ls_path = "C:\Bon de livraison"
//li_rc = GetFileSaveName ( "Sauvegarder le fichier", ls_path, ls_file, "XML",  "Fichier XML (*.*),*.xml" , "C:\My Documents", 32770) 
//
//gnv_app.inv_filesrv.of_filewrite(ls_file, ls_xml, false)

		
/*
insert into t_facture_print_temp(
	cie_no,
	liv_no,
	liv_date,
	transporteur,
	quantite,
	code,
	desc_facture,
	boncommand,
	no_eleveur,
	nom_eleveur,
	adresse_eleveur,
	rue_eleveur,
	ville_eleveur,
	province_eleveur,
	zip_eleveur,
	tel_eleveur
)
values(
	:ls_cieno,
	:ls_livno,
	:ldtt_livdate,
	:ls_transporteur,
	:ll_qteexp,
	:ls_prodno,
	:ls_descrip,
	:ls_boncommande,
	:ls_no_eleveur,
	:ls_nomeleveur,
	:ls_adresseeleveur_a_temp,
	:ls_rueeleveur_a_temp,
	:ls_villeeleveur_a_temp,
	:ls_conteeleveur_a_temp,
	:ls_codposteleveur_a_temp,
	:ls_telephoneeleveur_a_temp
)
;
if SQLCA.SQLCode = 0 then
	commit using SQLCA;
else
	rollback using SQLCA;
end if
*/

/*
	insert into t_facture_list_detail_temp(
		cie_no,
		liv_no,
		liv_date,
		nom,
		telephone,
		adresse,
		rue,
		ville,
		province,
		code_post,
		no_eleveur,
		no_route,
		is_strikeout
	)
	values(
		:ls_cieno,
		:ls_livno	,
		:ldtt_livdate,
		:ls_nomeleveur,
		:ls_telephoneeleveur,
		:ls_adresseeleveur,
		:ls_rueeleveur,
		:ls_villeeleveur,
		:ls_provinceeleveur,
		:ls_codposteleveur,
		:ls_no_eleveur,
		:ls_noroute,
		:ll_is_strikeout
	)
	;
	if SQLCA.SQLCode = 0 then
		commit using SQLCA;
	else
		rollback using SQLCA;
	end if
	*/
end event

type uo_rechercher from u_cst_toolbarstrip within w_fichierxml
integer x = 5
integer y = 2056
integer width = 411
integer taborder = 80
end type

on uo_rechercher.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;date ldt_debut, ldt_fin
long ll_debut, ll_fin,  ll_insertrow, ll_ret, i, ll_state, j, k
string ls_livno, ls_cie[], ls_cietemp, ls_cieno
long ll_pres
datastore lds_temp
long ll_count_bon
long m
long ll_qte_comm
long ll_qte_exp
long ll_mod
string ls_temp
long ll_sum_exp
SetPointer(HourGlass!)
//wei ajouter 2023-02-17 pour le billet CIPQ-14
of_bon_commande_impression()

//SetPointer(arrow!)



dw_fichierxmlbon.of_reset()

em_debut.getData(ldt_debut)
em_fin.getData(ldt_fin)

 ll_debut  =  long(sle_deb.text)
 ll_fin =  long(sle_fin.text)

if rb_date.checked then
	ll_ret = 0
else
	ll_ret = 1
end if

j = 1

for i = 1 to lb_files.totalitems()
	
	ll_state = lb_files.state(i)
	if ll_state = 1 then
		ls_cie[j] = lb_files.text(i)
		j++
	end if
	
next

//wei ajouter 2022-08-09 pour eleveur
long ll_no_eleveur
ll_no_eleveur = long(ddlb_eleveur.of_getselecteddata( ))
	
DECLARE listbon CURSOR FOR
	select  	DISTINCT t_statfacturedetail.cie_no , t_statfacturedetail.liv_no 
	from t_statfacture  INNER JOIN t_statfacturedetail ON t_statfacture.cie_no = t_statfacturedetail.cie_no and t_statfacture.liv_no = t_statfacturedetail.liv_no
	where (:ll_ret = 0 and date(liv_date) between :ldt_debut and :ldt_fin and 
					(
						:ll_no_eleveur > 0 and t_statfacture.no_eleveur = :ll_no_eleveur or
						:ll_no_eleveur = 0 and t_statfacture.no_eleveur = t_statfacture.no_eleveur 
					)
			) 
			or
			(:ll_ret = 1 and CAST(t_statfacturedetail.liv_no AS INTEGER) between :ll_debut and :ll_fin and
				(
						:ll_no_eleveur > 0 and t_statfacture.no_eleveur = :ll_no_eleveur or
						:ll_no_eleveur = 0 and t_statfacture.no_eleveur = t_statfacture.no_eleveur
				)			
			)
	order by t_statfacturedetail.cie_no asc, t_statfacturedetail.liv_no asc 
	;

OPEN listbon;

FETCH listbon INTO :ls_cieno, :ls_livno;

DO WHILE SQLCA.SQLCode = 0

	ls_cietemp = ""
	for k = 1 to upperbound(ls_cie)
		
		if ls_cieno = ls_cie[k] then
			
			ll_insertrow = dw_fichierxmlbon.insertRow(0)
			dw_fichierxmlbon.setItem(ll_insertrow, 't_statfacture_liv_no', ls_livno)
			dw_fichierxmlbon.setItem(ll_insertrow, 't_statfacture_cie_no', ls_cieno)
			//pour separer envoyer/non envoyer
			select count(1)  into :ll_pres
			from t_imgcodeqr
			where liv_no = :ls_livno and cie_no = :ls_cieno
			;
			//ll_pres > 0 --- on a deja envoye plus une fois.
			//ll_pres = 0 --- on a deja envoye seulement une fois.
			if ll_pres > 0  then
				select isnull(mod,0) into :ll_mod
				from t_imgcodeqr
				where liv_no = :ls_livno and cie_no = :ls_cieno
				;
				//ll_mod > 0 --- deja modifier.
				//ll_mod = 0 --- rien de modification.
				if ll_mod = 0 then
					dw_fichierxmlbon.setitem(ll_insertrow,'is_qr',1)
				else
					dw_fichierxmlbon.setitem(ll_insertrow,'is_qr',0)
					//pour modification
					dw_fichierxmlbon.setItem(ll_insertrow, 't_statfacture_liv_no', ls_livno+'(M)')
				end if
			else
				dw_fichierxmlbon.setitem(ll_insertrow,'is_qr',0)
			end if
			//pour barrer la ligne
			select
				isnull("t_statfacturedetail"."qte_comm" ,0),isnull("t_statfacturedetail"."qte_exp" , 0) into :ll_qte_comm,:ll_qte_exp        
          	from "t_statfacturedetail" 
			where liv_no = :ls_livno and cie_no = :ls_cieno
			;
			select sum(qte_exp) into :ll_sum_exp
			from t_statfacturedetail 
			where liv_no = :ls_livno and cie_no = :ls_cieno and prod_no in (
    				select t_Produit.NoProduit
    				from t_produit
    				where actif = 1 and noproduit not in ( 'LMAI','CR-LMAI')
			)
			;
			if ll_sum_exp=0 then
				dw_fichierxmlbon.setitem(ll_insertrow,'is_strikeout',1)
			end if
			/*
			if ll_qte_comm=0 and ll_qte_exp=0 then
				dw_fichierxmlbon.setitem(ll_insertrow,'is_strikeout',1)
			end if
			*/
		end if
	next
	FETCH listbon INTO :ls_cieno, :ls_livno;
LOOP
CLOSE listbon;
st_7.visible = true
st_7.text = 'Total : ' + string(dw_fichierxmlbon.rowcount())
dw_fichierxmlbon.scrolltorow(1)
dw_fichierxmlbon.setfocus()



dw_fichierxmlbon.setrowfocusindicator(hand!)

SetPointer(arrow!)


end event

type st_4 from statictext within w_fichierxml
integer x = 32
integer y = 448
integer width = 160
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "au:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_fichierxml
integer x = 32
integer y = 344
integer width = 160
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Du:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_fichierxml
integer x = 32
integer y = 240
integer width = 160
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "au:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_fichierxml
integer x = 32
integer y = 136
integer width = 160
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Du:"
boolean focusrectangle = false
end type

type sle_fin from singlelineedit within w_fichierxml
integer x = 229
integer y = 456
integer width = 219
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "0"
boolean border = false
end type

type sle_deb from singlelineedit within w_fichierxml
integer x = 229
integer y = 352
integer width = 219
integer height = 80
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "0"
boolean border = false
end type

type em_debut from editmask within w_fichierxml
integer x = 229
integer y = 136
integer width = 411
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
boolean border = false
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type em_fin from editmask within w_fichierxml
integer x = 229
integer y = 240
integer width = 411
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
boolean border = false
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type dw_fichierxmlbon from u_dw within w_fichierxml
integer x = 987
integer y = 40
integer width = 617
integer height = 1924
integer taborder = 110
string dataobject = "d_fichierxmlbon"
end type

event clicked;call super::clicked;if row>0 then
	/*
	this.scrolltorow(row)
	this.selectrow(0,false)
	this.setrow(row)
	this.selectrow(row,true)
	this.setfocus()
	*/
	dw_fichierxmlbon.scrolltorow(row)
	dw_fichierxmlbon.setfocus()
	dw_fichierxmlbon.setrowfocusindicator(hand!)
	
	
end if
end event

event doubleclicked;call super::doubleclicked;string ls_cie_no
string ls_liv_no
long ll_strikeout
string ls_mod
string ls_temp
if row > 0 then
	ll_strikeout = this.getitemnumber(row,'is_strikeout')
	//if ll_strikeout = 0 then
		ls_cie_no = this.getitemstring(row,'t_statfacture_cie_no')
		ls_liv_no = this.getitemstring(row,'t_statfacture_liv_no')
		if pos(ls_liv_no,'(M)')>0 then
			ls_liv_no = mid(ls_liv_no,1,len(ls_liv_no) - 3)
		end if
		
		
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon centre", ls_cie_no)
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon no bon", ls_liv_no)
		
		
		
		
		w_bon_expedition	lw_fen
		SetPointer(HourGlass!)
		OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
		//open(lw_fen)
		lw_fen.bringtotop = true
		/*
		ls_mod = string(gnv_app.inv_entrepotglobal.of_retournedonnee( "bon_modification"))
		
		messagebox('',ls_mod)
		if ls_mod = "true" then
			
			this.setitem(row,"is_qr",0)
			ls_temp = this.getitemstring(row,'t_statfacture_liv_no')
			this.setitem(row,'t_statfacture_liv_no',ls_temp+'(M)')
		end if
		*/
	//end if
end if

end event

type rr_1 from roundrectangle within w_fichierxml
long linecolor = 134217738
integer linethickness = 4
long fillcolor = 1073741824
integer x = 983
integer y = 32
integer width = 631
integer height = 1928
integer cornerheight = 40
integer cornerwidth = 46
end type


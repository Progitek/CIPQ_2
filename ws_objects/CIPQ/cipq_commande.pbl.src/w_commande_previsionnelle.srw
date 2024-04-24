$PBExportHeader$w_commande_previsionnelle.srw
forward
global type w_commande_previsionnelle from w_response
end type
type st_message from statictext within w_commande_previsionnelle
end type
type dw_commande_previsionnelle from u_dw within w_commande_previsionnelle
end type
type p_1 from picture within w_commande_previsionnelle
end type
type st_1 from statictext within w_commande_previsionnelle
end type
type uo_toolbar from u_cst_toolbarstrip within w_commande_previsionnelle
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_commande_previsionnelle
end type
type rr_1 from roundrectangle within w_commande_previsionnelle
end type
type rr_2 from roundrectangle within w_commande_previsionnelle
end type
end forward

global type w_commande_previsionnelle from w_response
string tag = "menu=m_commandesprevisionnelles"
integer width = 2107
integer height = 1276
string title = "Commandes prévisionnelles"
long backcolor = 12639424
st_message st_message
dw_commande_previsionnelle dw_commande_previsionnelle
p_1 p_1
st_1 st_1
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
rr_1 rr_1
rr_2 rr_2
end type
global w_commande_previsionnelle w_commande_previsionnelle

forward prototypes
public function long of_recupererprochainnumero (string as_cie)
end prototypes

public function long of_recupererprochainnumero (string as_cie);//////////////////////////////////////////////////////////////////////////////
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
//	2007-12-21	Mathieu Gendron	Création
// 2008-10-29	Mathieu Gendron	Code de bat arrangé
//
//////////////////////////////////////////////////////////////////////////////

RETURN gnv_app.of_recupererprochainno(as_cie)

//long		ll_no, ll_retour
//n_ds		lds_no_auto
//
//
//lds_no_auto = CREATE n_ds
//lds_no_auto.Dataobject = "ds_commande_no_auto"
//lds_no_auto.of_settransobject(SQLCA)
//
//ll_retour = lds_no_auto.Retrieve(as_cie)
//IF ll_retour > 0 THEN
//	ll_no = lds_no_auto.object.cc_maximum[1]
//	IF IsNull(ll_no) OR ll_no = 0 THEN ll_no = 1
//ELSE
//	ll_no = 1
//END IF
//
//IF IsValid(lds_no_auto) THEN Destroy(lds_no_auto)
//
//RETURN ll_no
end function

on w_commande_previsionnelle.create
int iCurrent
call super::create
this.st_message=create st_message
this.dw_commande_previsionnelle=create dw_commande_previsionnelle
this.p_1=create p_1
this.st_1=create st_1
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.rr_1=create rr_1
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_message
this.Control[iCurrent+2]=this.dw_commande_previsionnelle
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.uo_toolbar_gauche
this.Control[iCurrent+7]=this.rr_1
this.Control[iCurrent+8]=this.rr_2
end on

on w_commande_previsionnelle.destroy
call super::destroy
destroy(this.st_message)
destroy(this.dw_commande_previsionnelle)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_gauche)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

uo_toolbar_gauche.of_settheme("classic")
uo_toolbar_gauche.of_DisplayBorder(true)
uo_toolbar_gauche.of_AddItem("Enregistrer les commandes répétitives...", "Custom007!")
uo_toolbar_gauche.POST of_displaytext(true)

//Mettre les valeurs par défaut
date	ld_temp
n_cst_datetime	lnv_date
long	ll_day

ll_day = lnv_date.of_dayofweek( today())
IF ll_day = 1 THEN
	ld_temp = today()
ELSE
	ld_temp = RelativeDate(today(), 7 - ll_day)
END IF
dw_commande_previsionnelle.object.de[1] = ld_temp
dw_commande_previsionnelle.object.a[1] = RelativeDate(ld_temp, 7)
end event

type st_message from statictext within w_commande_previsionnelle
integer x = 87
integer y = 696
integer width = 1897
integer height = 288
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
boolean focusrectangle = false
end type

type dw_commande_previsionnelle from u_dw within w_commande_previsionnelle
integer x = 59
integer y = 276
integer width = 1938
integer height = 732
integer taborder = 10
string dataobject = "d_commande_previsionnelle"
boolean vscrollbar = false
boolean ib_isupdateable = false
end type

type p_1 from picture within w_commande_previsionnelle
integer x = 41
integer y = 28
integer width = 165
integer height = 140
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\commande_prev.bmp"
boolean focusrectangle = false
end type

type st_1 from statictext within w_commande_previsionnelle
integer x = 274
integer y = 60
integer width = 1051
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Commandes prévisionnelles"
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_commande_previsionnelle
event destroy ( )
integer x = 1554
integer y = 1076
integer width = 507
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_commande_previsionnelle
event destroy ( )
integer x = 18
integer y = 1076
integer width = 1019
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;date		ld_debut, ld_fin
datetime	ldt_datecommande
long		ll_no_eleveur, ll_nbrow, ll_cpt, ll_no_commande, ll_no_eleveur_comm, ll_nbrow_detail, ll_cpt_item, ll_no_ligne, &
			ll_quantite_commande, ll_noligneheader, ll_choix, ll_noitem, ll_activesms, ll_row, ll_trans
string	ls_critere = "", ls_sql = "", ls_cie, ls_codetransport, ls_ampm, ls_boncommande, ls_message, ls_no_repeat, &
			ls_no_produit, ls_code_verrat, ls_description, ls_centre, ls_numerocell, ls_sujet,ls_body,ls_eleveurcell
string      ls_entete,ls_commandeboucle, ls_commande, ls_emailexp
string      ls_footer
n_ds		lds_repetitive, lds_repetitive_item,lds_imprimer_etiquette
string ls_emaildest , ls_filename
boolean ib_sms, ib_email

ls_centre = gnv_app.of_getcompagniedefaut()

select isnull(t_centrecipq.transfert,0) into :ll_trans from t_centrecipq where cie = :ls_centre;
if ll_trans = 1 then
	messagebox("Avertissement!","Un envoie d'un autre centre est en cours veuillez attendre 1 minute avant de procéder",Information!, OK!)
	return
end if

//Batch pour générer les commandes
SetPointer(HourGlass!)

dw_commande_previsionnelle.accepttext()

ld_debut = dw_commande_previsionnelle.object.de[1]
ld_fin = dw_commande_previsionnelle.object.a[1]
ll_no_eleveur = dw_commande_previsionnelle.object.no_eleveur[1] //no eleveur peut être null

lds_repetitive = CREATE n_ds
lds_repetitive.dataobject = "ds_commande_repetitive"
//lds_repetitive.SetSQLSelect(ls_sql)
lds_repetitive.SetTransobject(SQLCA)
ll_nbrow = lds_repetitive.retrieve(ld_debut, ld_fin, ll_no_eleveur)

IF ll_nbrow = 0 THEN
	gnv_app.inv_error.of_message("CIPQ0066")
	RETURN
END IF

lds_repetitive_item = CREATE n_ds
lds_repetitive_item.dataobject = "ds_commande_repetitive_item"
//lds_repetitive_item.SetSQLSelect(ls_sql)
lds_repetitive_item.SetTransobject(SQLCA)

//Demander à l'utilisateur si il veut continuer
IF gnv_app.inv_error.of_message("CIPQ0067", {string(ll_nbrow) }) <> 1 THEN
	RETURN
END IF

FOR ll_cpt = 1 TO ll_nbrow
	
	// Configuration Message
	select isnull(sujetcourriel,''), isnull(messagecourriel,'')
	    into :ls_sujet, :ls_body
        from t_messagecourriel  
     where titrecourriel = 'Enregistrer les commandes';
		  
	select isnull(smtpuserid,''),isnull(NumeroCell,''), isnull(activeSMS,0)
	   into :ls_emailexp,:ls_numerocell, :ll_activesms
	  from t_centrecipq 
     where cie = :ls_centre;
	
	//Looper sur chacune des commandes à créer
	ls_cie = lds_repetitive.object.t_commanderepetitive_cieno[ll_cpt]
	ls_no_repeat = lds_repetitive.object.t_commanderepetitive_norepeat[ll_cpt]
	ll_no_eleveur_comm = lds_repetitive.object.t_commanderepetitive_no_eleveur[ll_cpt]
	ldt_datecommande = datetime(date(lds_repetitive.object.datecommande[ll_cpt]), now())
	ls_codetransport = lds_repetitive.object.t_commanderepetitive_codetransport[ll_cpt]
	If IsNull(ls_codetransport) THEN ls_codetransport = ""
	ls_ampm = lds_repetitive.object.t_commanderepetitive_livrampm[ll_cpt]
	If IsNull(ls_ampm) THEN ls_ampm = ""
	ls_message = gnv_app.inv_string.of_globalReplace(lds_repetitive.object.t_commanderepetitive_message_commande[ll_cpt], "'", "''")
	If IsNull(ls_message) THEN ls_message = ""
	ls_boncommande = lds_repetitive.object.t_commanderepetitive_boncommandeclient[ll_cpt]
	If IsNull(ls_boncommande) THEN ls_boncommande = ""
	
	//Récupérer le prochain numéro
	ll_no_commande = PARENT.of_recupererprochainnumero(ls_cie)
	
	st_message.text = "No repeat: " + string(ls_no_repeat) + "~r~nDate: " + string(ldt_datecommande, "yyyy-mm-dd") + &
		"~r~nClient: " + string(ll_no_eleveur_comm) + "~r~nPosition: " + string(ll_cpt)
	
	//Générer t_commande
	ls_sql = "INSERT INTO t_commande (CieNo, NoCommande, NoRepeat, No_Eleveur, DateCommande, CodeTransport, LivrAMPM, Message_Commande, BonCommandeClient, Repeat, locked, traiter, imprimer,facture, novendeur) " + &
	"VALUES ('" + ls_cie + "', '" + string(ll_no_commande) + "', '" + ls_no_repeat + &
	"', " + string(ll_no_eleveur_comm) + ", '" + string(ldt_datecommande, "yyyy-mm-dd hh:mm:ss") + "', '" + ls_codetransport + &
	"', '" + ls_ampm + "', '" + ls_message + "', '" + ls_boncommande + "', 1, 'C',0,0,0,0  )"
	
	gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_commande", "Insertion", parent.title)
	
	// Message
	select isnull(trim(courriel),''), isnull(trim(cellulaire),'') 
	    into :ls_emaildest, :ls_eleveurcell
        from t_eleveur
     where no_eleveur = :ll_no_eleveur_comm; 
	
	if ll_activesms = 1 and len(ls_numerocell) = 10 then
		if ls_eleveurcell <> '' and len(ls_eleveurcell) = 10 then 
			ib_sms = true
			ls_entete = mid(ls_body,1,pos(ls_body,'/*DEBUTCOMMANDE*/') - 1)
		     ls_commandeboucle = mid(ls_body,pos(ls_body,'/*DEBUTCOMMANDE*/') + 17,pos(ls_body,'/*FINCOMMANDE*/') - pos(ls_body,'/*DEBUTCOMMANDE*/') - 17 )
		else
			ib_sms = false
		end if
	end if
	
	if  (ls_emaildest <> '') then
		ib_email = true
		lds_imprimer_etiquette = CREATE n_ds
		lds_imprimer_etiquette.dataobject = "d_r_boncommande_pdf"
		lds_imprimer_etiquette.of_setTransobject(SQLCA)
		lds_imprimer_etiquette.retrieve(ll_no_eleveur_comm)	
	else
		ib_email = false
	end if
		
		
		
	//réinitialiser
	ls_commande = ""
	//Générer t_commandedetail
	ll_nbrow_detail = lds_repetitive_item.retrieve(ls_cie, ls_no_repeat)
	FOR ll_cpt_item = 1 TO ll_nbrow_detail
		
		ll_no_ligne = lds_repetitive_item.object.noligne[ll_cpt_item]
		ls_no_produit = lds_repetitive_item.object.noproduit[ll_cpt_item]
		ls_code_verrat = lds_repetitive_item.object.codeverrat[ll_cpt_item]
		IF IsNull(ls_code_verrat) THEN ls_code_verrat = ""
		ls_description = left(gnv_app.inv_string.of_globalReplace(lds_repetitive_item.object.nomproduit[ll_cpt_item], "'", "''"), 50)
		IF IsNull(ls_description) THEN ls_description = ""
		ll_quantite_commande = lds_repetitive_item.object.qtecommande[ll_cpt_item]
		IF IsNull(ll_quantite_commande) THEN ll_quantite_commande = 0
		ll_noligneheader = lds_repetitive_item.object.noligneheader[ll_cpt_item]
		IF IsNull(ll_noligneheader) THEN ll_noligneheader = 0
		ll_choix = lds_repetitive_item.object.choix[ll_cpt_item]
		IF IsNull(ll_choix) THEN ll_choix = 0
		ll_noitem = lds_repetitive_item.object.noitem[ll_cpt_item]
		IF IsNull(ll_noitem) THEN ll_noitem = 0
		
		if ib_sms then
			ls_commande += ls_commandeboucle
			ls_commande = rep(ls_commande,'<<qte_commande>>',string(ll_quantite_commande))
			ls_commande = rep(ls_commande,'<<nom_produit>>', ls_no_produit)
			ls_commande = rep(ls_commande,'<<no_verrat>>',ls_code_verrat )
		end if
		if ib_email then
			ll_row = lds_imprimer_etiquette.insertrow(0)
			lds_imprimer_etiquette.setitem(ll_row,'qtecommande',string(ll_quantite_commande))
			lds_imprimer_etiquette.setitem(ll_row,'nomproduit',ls_no_produit)
			lds_imprimer_etiquette.setitem(ll_row,'codeverrat',ls_code_verrat)
			lds_imprimer_etiquette.setitem(ll_row,'datecommande',string(relativedate(date(ldt_datecommande),1)))
		end if
		

		IF ls_code_verrat = "" THEN
			ls_sql = "INSERT INTO t_commandedetail (cieno, NoCommande, NoRepeat, NoLigne, NoProduit, CodeVerrat, Description, QteCommande, QteInit, NoLigneHeader, Choix, NoItem) " + &
				" VALUES ('" + ls_cie + "', '" + string(ll_no_commande) + "', '" + ls_no_repeat + &
				"', " + string(ll_no_ligne) + ", '" + ls_no_produit + "', null" + &
				", '" + ls_description + "', " + string(ll_quantite_commande) + ", " + string(ll_quantite_commande) + &
				", " + string(ll_noligneheader) + ", " + string(ll_choix) + ", " + string(ll_noitem) + " ) "
		ELSE
			ls_sql = "INSERT INTO t_commandedetail (cieno, NoCommande, NoRepeat, NoLigne, NoProduit, CodeVerrat, Description, QteCommande, QteInit, NoLigneHeader, Choix, NoItem) " + &
				" VALUES ('" + ls_cie + "', '" + string(ll_no_commande) + "', '" + ls_no_repeat + &
				"', " + string(ll_no_ligne) + ", '" + ls_no_produit + "', '" + ls_code_verrat + &
				"', '" + ls_description + "', " + string(ll_quantite_commande) + ", " + string(ll_quantite_commande) + &
				", " + string(ll_noligneheader) + ", " + string(ll_choix) + ", " + string(ll_noitem) + " ) "
			END IF
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_commandedetail", "Insertion", parent.title)
		
	END FOR
	
	if ll_nbrow_detail > 0 then
		if ib_sms then
			ls_footer = mid(ls_body,pos(ls_body,'/*FINCOMMANDE*/') + 17,len(ls_body) - pos(ls_body,'/*FINCOMMANDE*/'))		
			ls_body = rep(ls_entete + ' ' + ls_commande + ' ' + ls_footer,'<<date_livraison>>',string(relativedate(date(ldt_datecommande),1)))
			insert into t_message(dateenvoye, priorite, message_de, message_a, sujet, message_texte, fichier_attache, source, statut,statut_lu, statut_affiche, typemessagerie, couleur, email, envoyer, sms, nomemail, id_user, nomordinateur, nomreel,failmsg,no_eleveur,logs)
			values(string(date(:ldt_datecommande)) + ' 07:30:00.000', 0, :ls_numerocell, :ls_eleveurcell, :ls_sujet, :ls_body,null, 'e', 'a', 'o','o', 'U', 15780518, 1, 0, 1,'',0,'','',null,:ll_no_eleveur_comm,:ls_no_repeat);
			if SQLCA.SQLCode = 0 then
				commit using SQLCA;
			else
				rollback using SQLCA;
			end if
		end if
		
		if ib_email then
			ls_sujet = 'Cipq - Bon de commande'
			ls_body = 'Pour votre livraison du  ' + string(relativedate(date(ldt_datecommande),1))
				
			ls_filename = "c:\ii4net\cipq\boncommande\bc_"+ string(ll_no_eleveur_comm) + '_' + string(now(),"ddmmyyyyhhmmss") + '.PDF'
			if lds_imprimer_etiquette.saveas(ls_filename, PDF!,false ) = 1 then
				insert into t_message(dateenvoye, priorite, message_de, message_a, sujet, message_texte, fichier_attache, source, statut,statut_lu, statut_affiche, typemessagerie, couleur, email, envoyer, sms, nomemail, id_user, nomordinateur, nomreel,failmsg,no_eleveur,logs)
				values(string(date(:ldt_datecommande)) + ' 07:30:00.000', 0, :ls_emailexp, :ls_emaildest, :ls_sujet, :ls_body, :ls_filename, 'e', 'a', 'o','o', 'U', 15780518, 1, 0, 1,'',0,'','',null,:ll_no_eleveur_comm,:ls_no_repeat);
				
				if SQLCA.SQLCode = 0 then
					commit using SQLCA;
				else
					rollback using SQLCA;
				end if
			end if		
		end if
	end if
	//On met à jour la date "DateDernierRepeat"
	lds_repetitive.object.t_commanderepetitive_datedernierrepeat[ll_cpt] = ldt_datecommande
	lds_repetitive.Update(TRUE,TRUE)
	
END FOR

IF IsValid(lds_repetitive) THEN DesTroy(lds_repetitive)
IF IsValid(lds_repetitive_item) THEN DesTroy(lds_repetitive_item)

st_message.text = ""

gnv_app.inv_error.of_message("CIPQ0068")












/*


date		ld_debut, ld_fin
datetime	ldt_datecommande
long		ll_no_eleveur, ll_nbrow, ll_cpt, ll_no_commande, ll_no_eleveur_comm, ll_nbrow_detail, ll_cpt_item, ll_no_ligne, &
			ll_quantite_commande, ll_noligneheader, ll_choix, ll_noitem
string	ls_critere = "", ls_sql = "", ls_cie, ls_codetransport, ls_ampm, ls_boncommande, ls_message, ls_no_repeat, &
			ls_no_produit, ls_code_verrat, ls_description
n_ds		lds_repetitive, lds_repetitive_item


//Batch pour générer les commandes
SetPointer(HourGlass!)

dw_commande_previsionnelle.accepttext()

ld_debut = dw_commande_previsionnelle.object.de[1]
ld_fin = dw_commande_previsionnelle.object.a[1]
ll_no_eleveur = dw_commande_previsionnelle.object.no_eleveur[1] //no eleveur peut être null

lds_repetitive = CREATE n_ds
lds_repetitive.dataobject = "ds_commande_repetitive"
//lds_repetitive.SetSQLSelect(ls_sql)
lds_repetitive.SetTransobject(SQLCA)
ll_nbrow = lds_repetitive.retrieve(ld_debut, ld_fin, ll_no_eleveur)

IF ll_nbrow = 0 THEN
	gnv_app.inv_error.of_message("CIPQ0066")
	RETURN
END IF

lds_repetitive_item = CREATE n_ds
lds_repetitive_item.dataobject = "ds_commande_repetitive_item"
//lds_repetitive_item.SetSQLSelect(ls_sql)
lds_repetitive_item.SetTransobject(SQLCA)

//Demander à l'utilisateur si il veut continuer
IF gnv_app.inv_error.of_message("CIPQ0067", {string(ll_nbrow) }) <> 1 THEN
	RETURN
END IF

FOR ll_cpt = 1 TO ll_nbrow
	//Looper sur chacune des commandes à créer
	
	ls_cie = lds_repetitive.object.t_commanderepetitive_cieno[ll_cpt]
	ls_no_repeat = lds_repetitive.object.t_commanderepetitive_norepeat[ll_cpt]
	ll_no_eleveur_comm = lds_repetitive.object.t_commanderepetitive_no_eleveur[ll_cpt]
	ldt_datecommande = datetime(date(lds_repetitive.object.datecommande[ll_cpt]), now())
	ls_codetransport = lds_repetitive.object.t_commanderepetitive_codetransport[ll_cpt]
	If IsNull(ls_codetransport) THEN ls_codetransport = ""
	ls_ampm = lds_repetitive.object.t_commanderepetitive_livrampm[ll_cpt]
	If IsNull(ls_ampm) THEN ls_ampm = ""
	ls_message = gnv_app.inv_string.of_globalReplace(lds_repetitive.object.t_commanderepetitive_message_commande[ll_cpt], "'", "''")
	If IsNull(ls_message) THEN ls_message = ""
	ls_boncommande = lds_repetitive.object.t_commanderepetitive_boncommandeclient[ll_cpt]
	If IsNull(ls_boncommande) THEN ls_boncommande = ""
	
	//Récupérer le prochain numéro
	ll_no_commande = PARENT.of_recupererprochainnumero(ls_cie)
	
	st_message.text = "No repeat: " + string(ls_no_repeat) + "~r~nDate: " + string(ldt_datecommande, "yyyy-mm-dd") + &
		"~r~nClient: " + string(ll_no_eleveur_comm) + "~r~nPosition: " + string(ll_cpt)
	
	//Générer t_commande
	ls_sql = "INSERT INTO t_commande (CieNo, NoCommande, NoRepeat, No_Eleveur, DateCommande, CodeTransport, LivrAMPM, Message_Commande, BonCommandeClient, Repeat, locked, traiter, imprimer,facture, novendeur) " + &
	"VALUES ('" + ls_cie + "', '" + string(ll_no_commande) + "', '" + ls_no_repeat + &
	"', " + string(ll_no_eleveur_comm) + ", '" + string(ldt_datecommande, "yyyy-mm-dd hh:mm:ss") + "', '" + ls_codetransport + &
	"', '" + ls_ampm + "', '" + ls_message + "', '" + ls_boncommande + "', 1, 'C',0,0,0,0  )"
	
	gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_commande", "Insertion", parent.title)
	
	
	//Générer t_commandedetail
	ll_nbrow_detail = lds_repetitive_item.retrieve(ls_cie, ls_no_repeat)
	FOR ll_cpt_item = 1 TO ll_nbrow_detail
		
		ll_no_ligne = lds_repetitive_item.object.noligne[ll_cpt_item]
		ls_no_produit = lds_repetitive_item.object.noproduit[ll_cpt_item]
		ls_code_verrat = lds_repetitive_item.object.codeverrat[ll_cpt_item]
		IF IsNull(ls_code_verrat) THEN ls_code_verrat = ""
		ls_description = left(gnv_app.inv_string.of_globalReplace(lds_repetitive_item.object.nomproduit[ll_cpt_item], "'", "''"), 50)
		IF IsNull(ls_description) THEN ls_description = ""
		ll_quantite_commande = lds_repetitive_item.object.qtecommande[ll_cpt_item]
		IF IsNull(ll_quantite_commande) THEN ll_quantite_commande = 0
		ll_noligneheader = lds_repetitive_item.object.noligneheader[ll_cpt_item]
		IF IsNull(ll_noligneheader) THEN ll_noligneheader = 0
		ll_choix = lds_repetitive_item.object.choix[ll_cpt_item]
		IF IsNull(ll_choix) THEN ll_choix = 0
		ll_noitem = lds_repetitive_item.object.noitem[ll_cpt_item]
		IF IsNull(ll_noitem) THEN ll_noitem = 0
		
		IF ls_code_verrat = "" THEN
			ls_sql = "INSERT INTO t_commandedetail (cieno, NoCommande, NoRepeat, NoLigne, NoProduit, CodeVerrat, Description, QteCommande, QteInit, NoLigneHeader, Choix, NoItem) " + &
				" VALUES ('" + ls_cie + "', '" + string(ll_no_commande) + "', '" + ls_no_repeat + &
				"', " + string(ll_no_ligne) + ", '" + ls_no_produit + "', null" + &
				", '" + ls_description + "', " + string(ll_quantite_commande) + ", " + string(ll_quantite_commande) + &
				", " + string(ll_noligneheader) + ", " + string(ll_choix) + ", " + string(ll_noitem) + " ) "
		ELSE
			ls_sql = "INSERT INTO t_commandedetail (cieno, NoCommande, NoRepeat, NoLigne, NoProduit, CodeVerrat, Description, QteCommande, QteInit, NoLigneHeader, Choix, NoItem) " + &
				" VALUES ('" + ls_cie + "', '" + string(ll_no_commande) + "', '" + ls_no_repeat + &
				"', " + string(ll_no_ligne) + ", '" + ls_no_produit + "', '" + ls_code_verrat + &
				"', '" + ls_description + "', " + string(ll_quantite_commande) + ", " + string(ll_quantite_commande) + &
				", " + string(ll_noligneheader) + ", " + string(ll_choix) + ", " + string(ll_noitem) + " ) "
			END IF
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_commandedetail", "Insertion", parent.title)
		
	END FOR
	
	//On met à jour la date "DateDernierRepeat"
	lds_repetitive.object.t_commanderepetitive_datedernierrepeat[ll_cpt] = ldt_datecommande
	lds_repetitive.Update(TRUE,TRUE)
	
END FOR

IF IsValid(lds_repetitive) THEN DesTroy(lds_repetitive)
IF IsValid(lds_repetitive_item) THEN DesTroy(lds_repetitive_item)

st_message.text = ""

gnv_app.inv_error.of_message("CIPQ0068")


*/










end event

type rr_1 from roundrectangle within w_commande_previsionnelle
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 212
integer width = 2039
integer height = 828
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_commande_previsionnelle
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 2039
integer height = 172
integer cornerheight = 40
integer cornerwidth = 46
end type


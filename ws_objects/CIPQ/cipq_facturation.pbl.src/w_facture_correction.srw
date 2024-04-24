﻿$PBExportHeader$w_facture_correction.srw
forward
global type w_facture_correction from w_sheet_frame
end type
type uo_toolbar from u_cst_toolbarstrip within w_facture_correction
end type
type st_vente_totale from statictext within w_facture_correction
end type
type st_tps from statictext within w_facture_correction
end type
type st_tvq from statictext within w_facture_correction
end type
type st_grand_total from statictext within w_facture_correction
end type
type dw_facture_correction from u_dw within w_facture_correction
end type
type dw_facture_correction_livraison from u_dw within w_facture_correction
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_facture_correction
end type
type dw_facture_correction_detail from u_dw within w_facture_correction
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_facture_correction
end type
type uo_toolbar_milieu from u_cst_toolbarstrip within w_facture_correction
end type
type gb_1 from groupbox within w_facture_correction
end type
type gb_2 from groupbox within w_facture_correction
end type
type gb_3 from groupbox within w_facture_correction
end type
type rr_1 from roundrectangle within w_facture_correction
end type
end forward

global type w_facture_correction from w_sheet_frame
string tag = "menu=m_consulterlesfactures"
string title = "Consultation des factures"
uo_toolbar uo_toolbar
st_vente_totale st_vente_totale
st_tps st_tps
st_tvq st_tvq
st_grand_total st_grand_total
dw_facture_correction dw_facture_correction
dw_facture_correction_livraison dw_facture_correction_livraison
uo_toolbar_haut uo_toolbar_haut
dw_facture_correction_detail dw_facture_correction_detail
uo_toolbar_bas uo_toolbar_bas
uo_toolbar_milieu uo_toolbar_milieu
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
rr_1 rr_1
end type
global w_facture_correction w_facture_correction

type variables
private:
	long il_livraison_sans_produit = 0
	long il_nofact
	long il_noeleveur
	date id_date
	string is_centre

end variables

forward prototypes
public subroutine of_calculcommande ()
public subroutine of_calculdetail ()
public function integer of_livraison_sans_produit ()
public function integer of_courriel (long al_debut, long al_fin)
end prototypes

public subroutine of_calculcommande ();//of_calculcommande
long		ll_row, ll_derniere
string	ls_fact
dec		ldec_VenteTotale, ldec_tps, ldec_tvq, ldec_pourcfed, ldec_pourcprov

ll_row = dw_facture_correction.GetRow()
ll_derniere = dw_facture_correction_livraison.Rowcount()
IF ll_row > 0 AND ll_derniere > 0 THEN
	
	ls_fact = dw_facture_correction.object.FACT_NO[ll_row]
	
	/*
	SELECT	sum(taxef), sum(taxep), sum(vente)
	INTO		:ldec_tps, :ldec_tvq,  :ldec_VenteTotale
	FROM		T_StatFacture
	WHERE		FACT_NO =  :ls_fact;
	*/
	
	SELECT round(sum(t_statfactureDetail.QTE_EXP * uprix),2),
	       round(sum(t_statfactureDetail.TPS),2), 
	       round(sum(t_statfactureDetail.TVQ),2)
	INTO   :ldec_VenteTotale,
	       :ldec_tps, 
	       :ldec_tvq
   FROM   t_statfacture INNER JOIN t_StatFactureDetail ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
																		AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)
	WHERE  t_statfacture.fact_no = :ls_fact;
	
	

	/*SELECT 	Sum(QTE_EXP * UPRIX ) AS Vent 
	INTO		:ldec_VenteTotale
	FROM 		t_StatFactureDetail INNER JOIN t_StatFacture 
				ON (t_StatFactureDetail.CIE_NO = t_StatFacture.CIE_NO) 
				AND (t_StatFactureDetail.LIV_NO = t_StatFacture.LIV_NO) 
	WHERE 	t_StatFacture.FACT_NO = :ls_fact;*/
				
	If IsNull(ldec_VenteTotale) THEN ldec_VenteTotale = 0
	
	//ldec_pourcfed = dw_facture_correction_livraison.object.taxe_fede[ll_derniere]
	//ldec_pourcprov = dw_facture_correction_livraison.object.taxe_prov[ll_derniere]

	ldec_VenteTotale = Round(ldec_VenteTotale,2)
	st_vente_totale.text = "Vente totale: " + string(ldec_VenteTotale, "0.00 $")

	//ldec_tps = round((ldec_VenteTotale * ldec_pourcfed) / 100,2)
	If IsNull(ldec_tps) THEN ldec_tps = 0
	
	//ldec_tvq = round((ldec_VenteTotale * ldec_pourcprov) / 100,2)
	If IsNull(ldec_tvq) THEN ldec_tvq = 0
	
	st_tps.text = "TPS: " + string(ldec_tps, "0.00 $")
	st_tvq.text = "TVQ: " + string(ldec_tvq, "0.00 $")
	
	st_grand_total.text = "Grand total: " + string(ldec_VenteTotale + ldec_tps + ldec_tvq , "0.00 $")
END IF
end subroutine

public subroutine of_calculdetail ();//of_calculdetail

Dec 	ldec_Vente = 0, ldec_TPS = 0, ldec_TVQ = 0, ll_row, ldec_VenteTotal = 0, ldec_uprix = 0, ldec_qte,ldec_taxetps,ldec_taxetvq
long	ll_cpt, ll_no_facture

ll_row = dw_facture_correction_livraison.GetRow()
IF ll_row > 0 THEN
	//Calcul le cumul du détail
	FOR ll_cpt = 1 TO dw_facture_correction_detail.RowCount()
		ldec_qte = dw_facture_correction_detail.object.qte_exp[ll_cpt]
		ldec_uprix = dw_facture_correction_detail.object.uprix[ll_cpt]
		
		If IsNull(ldec_qte) THEN ldec_qte = 0
		If IsNull(ldec_uprix) THEN ldec_uprix = 0
		ldec_Vente = Round(ldec_Vente + (ldec_qte * ldec_uprix) , 2)
		
	END FOR

	//Mise à jour selon le bon de livraison
	ldec_Vente = Round(ldec_Vente,2)
	ldec_tps = dw_facture_correction_livraison.object.taxe_fede[ll_row] / 100.0000
	If IsNull(ldec_tps) THEN ldec_tps = 0
	ldec_tvq = dw_facture_correction_livraison.object.taxe_prov[ll_row] / 100.0000
	If IsNull(ldec_tvq) THEN ldec_tvq = 0
	ldec_tps = ldec_Vente * ldec_tps
	ldec_tps = Round(ldec_tps,2)
	ldec_tvq = ldec_Vente * ldec_tvq
	ldec_tvq = Round(ldec_tvq,2)
	
	ldec_VenteTotal = ldec_Vente + ldec_tps + ldec_tvq 
	
	dw_facture_correction_livraison.object.vente[ll_row] = ldec_Vente
	dw_facture_correction_livraison.object.taxef[ll_row] = ldec_tps
	dw_facture_correction_livraison.object.taxep[ll_row] = ldec_tvq
	dw_facture_correction_livraison.object.soustotal[ll_row] = ldec_VenteTotal
	
	ldec_taxetps = dw_facture_correction_livraison.object.taxe_fede[ll_row] / 100.0000
	ldec_taxetvq = dw_facture_correction_livraison.object.taxe_prov[ll_row] / 100.0000
	
	If Not IsNull(il_nofact) AND il_nofact <> 0 THEN
		UPDATE t_statfacturedetail INNER JOIN t_StatFacture ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO)
											AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)
		SET tps = (qte_exp * uprix) * :ldec_taxetps, tvq = (qte_exp * uprix) * :ldec_taxetvq 
		WHERE t_statfacture.fact_no = :il_nofact;
	end if
	
	If Not IsNull(il_noeleveur) AND il_noeleveur <> 0 THEN
		UPDATE t_statfacturedetail INNER JOIN t_StatFacture ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO)
											AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)
		SET tps = (qte_exp * uprix) * :ldec_taxetps, tvq = (qte_exp * uprix) * :ldec_taxetvq 
		WHERE t_statfacture.no_eleveur = :il_noeleveur;
	end if
	
	If Not IsNull(id_date) AND id_date <> 1900-01-01 THEN
		UPDATE t_statfacturedetail INNER JOIN t_StatFacture ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO)
											AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO)
		SET tps = (qte_exp * uprix) * :ldec_taxetps, tvq = (qte_exp * uprix) * :ldec_taxetvq 
		WHERE date(t_statfacture.FACT_DATE) = date(:id_date);
	end if
	if SQLCA.SQLCode = 0 then
		COMMIT USING SQLCA;
	else
		ROLLBACK USING SQLCA;
	end if

END IF

dw_facture_correction_livraison.update(true,true)

THIS.of_calculcommande()
end subroutine

public function integer of_livraison_sans_produit ();// of_livraison_sans_produit
// Fonction qui vérifie s'il n'y a pas au moins un produit dans la livraison

long ll_row, ll_count
string ls_noproduit
boolean lb_produit_pg1 = false

// 2010-02-24 - Sébastien - avertissement quand il n'y a pas de produit facturé
for ll_row = 1 to dw_facture_correction_detail.rowCount()
	if lb_produit_pg1 then exit
	
	ls_noproduit = dw_facture_correction_detail.object.prod_no[ll_row]
	// 2010-07-13 - Sébastien - On ne valide plus la quantité
//	ll_qte = dw_facture_correction_detail.object.qte_exp[ll_row]
//	If IsNull(ll_qte) THEN ll_qte = 0
	
	select count(1) into :ll_count
	from t_Transport where codeTransport = :ls_noproduit;
	
	if ll_count = 0 then lb_produit_pg1 = true
next

if not lb_produit_pg1 then
	return gnv_app.inv_error.of_message("CIPQ0166")
end if

return 0
end function

public function integer of_courriel (long al_debut, long al_fin);string ls_destinataire,ls_pathfile,ls_filename
string ls_courriel, ls_sujet, ls_body,ls_erreur
long ll_envoyer,ll_noeleveur

select isnull(email,''), isnull(factsubject,''),isnull(factbody,'') 
  into :ls_courriel, :ls_sujet, :ls_body 
  from t_centrecipq 
 where cie = :is_centre;

if ls_courriel = '' then 
	messagebox("Avertissement","Courriel du destinataire absent!")
	return -1
end if
if ls_sujet = '' then 
	messagebox("Avertissement","Veuillez entrer un sujet !")
	return -1
end if

ls_pathfile = gnv_app.of_getValeurIni("FACTURATION", "Path")
if ls_pathfile = "" then
	messagebox("Avertissement","Impossible de créer PDF pour la facturation. Chemin introuvable.")
	return -1
end if

n_ds ds_facturation
ds_facturation = Create n_ds
ds_facturation.dataobject = 'd_r_facturation_template' 
ds_facturation.SetTransObject(SQLCA)
ds_facturation.retrieve(al_debut,al_fin)
ds_facturation.setFilter("(t_ELEVEUR.Billing_cycle_code <> 'PPA') And (isnull(t_eleveur.af_ courriel,'') <> '')")
ds_facturation.filter()

setnull(ls_filename)
setnull(ls_destinataire)
setnull(ll_noeleveur)
setnull(ls_erreur)
ll_envoyer = 0

ls_destinataire = ds_facturation.getItemString(1,'af_courriel')
if ls_destinataire = "" or isnull(ls_destinataire) then 
	ls_erreur = "Le courriel du destinataire absent !"
end if

ll_noeleveur = ds_facturation.getItemNumber(1,'no_eleveur')

if not match(ls_destinataire,'^[a-zA-Z0-9][a-zA-Z\0-9\-_\.]*[^.]\@[^.][a-zA-Z\0-9\-_\.]+\.[a-zA-Z\0-9\-_\.]*[a-zA-Z\0-9]+$') then
	ls_erreur = "Courriel du destinataire invalide !"
end if

ls_filename = ls_pathfile+"\"+string(now(),"yyyymm")+"\"+ string(al_debut) +"-"+string(now(),"dd-mm-yyyy-hh-mm-ss") + ".pdf"
if ds_facturation.saveas(ls_filename,PDF!,false) <> 1 then
	ls_erreur = "Impossible de créer la pièce jointe !"
end if

if not isnull(ls_erreur) then
	ll_envoyer = -1
end if
		
insert into t_message(dateenvoye, priorite, message_de, message_a, sujet, message_texte, fichier_attache, source, statut,statut_lu, statut_affiche, typemessagerie, couleur, email, envoyer, sms, nomemail, id_user, nomordinateur, nomreel,failmsg,no_eleveur)
values(now(), 0, :ls_courriel, :ls_destinataire, :ls_sujet, :ls_body, :ls_filename, 'e', 'a', 'o','o', 'U', 15780518, 1, :ll_envoyer, 0,'',0,'','',:ls_erreur,:ll_noeleveur);
if SQLCA.SQLCode = 0 then
	commit using SQLCA;
else
	rollback using SQLCA;
end if

Messagebox("Envoi","Courriel envoyé avec succès !")

return 0
end function

on w_facture_correction.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.st_vente_totale=create st_vente_totale
this.st_tps=create st_tps
this.st_tvq=create st_tvq
this.st_grand_total=create st_grand_total
this.dw_facture_correction=create dw_facture_correction
this.dw_facture_correction_livraison=create dw_facture_correction_livraison
this.uo_toolbar_haut=create uo_toolbar_haut
this.dw_facture_correction_detail=create dw_facture_correction_detail
this.uo_toolbar_bas=create uo_toolbar_bas
this.uo_toolbar_milieu=create uo_toolbar_milieu
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.st_vente_totale
this.Control[iCurrent+3]=this.st_tps
this.Control[iCurrent+4]=this.st_tvq
this.Control[iCurrent+5]=this.st_grand_total
this.Control[iCurrent+6]=this.dw_facture_correction
this.Control[iCurrent+7]=this.dw_facture_correction_livraison
this.Control[iCurrent+8]=this.uo_toolbar_haut
this.Control[iCurrent+9]=this.dw_facture_correction_detail
this.Control[iCurrent+10]=this.uo_toolbar_bas
this.Control[iCurrent+11]=this.uo_toolbar_milieu
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_3
this.Control[iCurrent+15]=this.rr_1
end on

on w_facture_correction.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.st_vente_totale)
destroy(this.st_tps)
destroy(this.st_tvq)
destroy(this.st_grand_total)
destroy(this.dw_facture_correction)
destroy(this.dw_facture_correction_livraison)
destroy(this.uo_toolbar_haut)
destroy(this.dw_facture_correction_detail)
destroy(this.uo_toolbar_bas)
destroy(this.uo_toolbar_milieu)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.rr_1)
end on

event open;call super::open;date		ld_date
long		ll_no_facture, ll_rtn, ll_no_eleveur
string	ls_filtre = "", ls_sql_dw = ""

is_centre = gnv_app.of_getcompagniedefaut( )

ld_date = date(gnv_app.inv_entrepotglobal.of_retournedonnee("critere fact date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere fact date", "")
ll_no_facture = long(gnv_app.inv_entrepotglobal.of_retournedonnee("critere fact no fact"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere fact no fact", "")
ll_no_eleveur = long(gnv_app.inv_entrepotglobal.of_retournedonnee("critere fact no eleveur"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere fact no eleveur", "")

il_nofact = ll_no_facture
il_noeleveur = ll_no_eleveur
id_date = ld_date

If Not IsNull(ld_date) AND ld_date <> 1900-01-01 THEN
	ls_filtre += " date(FACT_DATE) = date('" + string(ld_date, "yyyy-mm-dd") + "') "
END IF

If Not IsNull(ll_no_facture) AND ll_no_facture <> 0 THEN
	IF Len(ls_filtre) > 0 THEN ls_filtre += " AND "
	ls_filtre += " FACT_NO = '" + string(ll_no_facture) + "' "
END IF

If Not IsNull(ll_no_eleveur) AND ll_no_eleveur <> 0 THEN
	IF Len(ls_filtre) > 0 THEN ls_filtre += " AND "
	ls_filtre += " t_StatFacture.no_eleveur = " + string(ll_no_eleveur) + " "
END IF

IF ls_filtre <> "" THEN
	//Arrange la clause where
	ls_sql_dw = dw_facture_correction.GetSqlSelect()
	ls_sql_dw = ls_sql_dw + " WHERE " + ls_filtre
	SetPointer(HourGlass!)
	ll_rtn = dw_facture_correction.SetSqlSelect(ls_sql_dw)
END IF

SetPointer(HourGlass!)
dw_facture_correction.event pfc_retrieve()
end event

event pfc_postopen;call super::pfc_postopen;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Imprimer cette facture", "Print!")
uo_toolbar.of_AddItem("Envoi par courriel", "C:\ii4net\CIPQ\images\mail.ico")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Supprimer cette facture", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_haut.POST of_displaytext(true)

uo_toolbar_milieu.of_settheme("classic")
uo_toolbar_milieu.of_DisplayBorder(true)
uo_toolbar_milieu.of_AddItem("Ajouter une livraison", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_milieu.POST of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un item", "AddWatch5!")
uo_toolbar_bas.of_AddItem("Supprimer cet item", "DeleteWatch5!")
uo_toolbar_bas.POST of_displaytext(true)

end event

event closequery;call super::closequery;if ancestorReturnValue > 0 then return ancestorReturnValue

if of_livraison_sans_produit() = 2 then return 1
end event

type st_title from w_sheet_frame`st_title within w_facture_correction
string text = "Consultation des factures"
end type

type p_8 from w_sheet_frame`p_8 within w_facture_correction
integer x = 64
integer y = 48
integer width = 96
integer height = 84
boolean originalsize = false
string picturename = "Custom072!"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_facture_correction
end type

type uo_toolbar from u_cst_toolbarstrip within w_facture_correction
event destroy ( )
integer x = 27
integer y = 2232
integer width = 4539
integer taborder = 70
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long		ll_row
string	ls_nofacture
		
CHOOSE CASE as_button
	
	CASE "Enregistrer"
		if of_livraison_sans_produit() = 2 then return
		
		IF parent.event pfc_save() >= 0 THEN
			parent.of_calculdetail()
		END IF
	
	CASE "Envoi par courriel" 
		ls_nofacture = dw_facture_correction.object.fact_no[dw_facture_correction.GetRow()]
		of_courriel(long(ls_nofacture),long(ls_nofacture))
		
	CASE "Fermer"
		Close(Parent)
		
	CASE "Imprimer cette facture"
		ll_row = dw_facture_correction.GetRow()
		
		IF ll_row > 0 THEN
			ls_nofacture = dw_facture_correction.object.fact_no[ll_row]
			
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("debut rapport facturation", ls_nofacture)
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("fin rapport facturation", ls_nofacture)
			
			//Ouvrir l'interface
			w_r_facturation	lw_fen
			SetPointer(HourGlass!)
			OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)			
		END IF
		
END CHOOSE
end event

type st_vente_totale from statictext within w_facture_correction
integer x = 105
integer y = 2080
integer width = 864
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Vente totale:"
boolean focusrectangle = false
end type

type st_tps from statictext within w_facture_correction
integer x = 1010
integer y = 2080
integer width = 517
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "TPS:"
boolean focusrectangle = false
end type

type st_tvq from statictext within w_facture_correction
integer x = 1541
integer y = 2080
integer width = 608
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "TVQ:"
boolean focusrectangle = false
end type

type st_grand_total from statictext within w_facture_correction
integer x = 3401
integer y = 2064
integer width = 1106
integer height = 120
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Grand total:"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_facture_correction from u_dw within w_facture_correction
integer x = 169
integer y = 244
integer width = 4288
integer height = 272
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_facture_correction"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)

SetRowFocusindicator(Hand!)
end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow > 0 THEN
	parent.of_CalculCommande()
END IF
end event

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)

RETURN THIS.Retrieve()
end event

event rowfocuschanging;call super::rowfocuschanging;if ancestorReturnValue > 0 then return ancestorReturnValue

if currentrow > 0 then
	choose case of_livraison_sans_produit()
		case 1
			il_livraison_sans_produit = dw_facture_correction_livraison.getRow()
		case 2
			this.post ScrollToRow(currentRow)
			
			return 1
	end choose
end if
end event

type dw_facture_correction_livraison from u_dw within w_facture_correction
integer x = 169
integer y = 704
integer width = 4288
integer height = 400
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_facture_correction_livraison"
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_facture_correction)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("fact_no","fact_no")

SetRowFocusindicator(Hand!)

THIS.of_setpremierecolonneinsertion( "cie_no")
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	THIS.object.liv_date[AncestorReturnValue] = date(today())
	
end if

RETURN AncestorReturnValue
end event

event itemchanged;call super::itemchanged;
CHOOSE CASE dwo.name
		
	CASE "liv_date"
		date	ld_dernierefact, ld_cur, ld_cur2
		n_cst_datetime	lnv_date
		
		//Vérifier si c'est dans le mois en cours (moins un jour)
		
		ld_cur = today()
		ld_cur = RelativeDate(ld_cur, - day(ld_cur))
		ld_cur2 = lnv_date.of_lastdayofmonth( ld_cur)
		
		ld_dernierefact = date(data)
		IF ld_dernierefact < ld_cur2 THEN
			gnv_app.inv_error.of_message("CIPQ0129", {string(ld_cur2)})
			RETURN 2
		END IF

		
END CHOOSE
end event

event rowfocuschanging;call super::rowfocuschanging;if ancestorReturnValue > 0 then return ancestorReturnValue

if currentrow <> il_livraison_sans_produit then
	if of_livraison_sans_produit() = 2 then
		il_livraison_sans_produit = newrow
		this.post scrollToRow(currentrow)
		
		return 0
	end if
end if

il_livraison_sans_produit = 0
end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_facture_correction
event destroy ( )
string tag = "resize=frbsr"
integer x = 119
integer y = 528
integer width = 4329
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	
	CASE "Supprimer cette facture"
		//dw_facture_correction.event pfc_deleterow()
		string	ls_facture, ls_string, ls_cie, ls_livr_no
		long		ll_row, ll_count
		
		ll_row = dw_facture_correction.GetRow()
		IF ll_row > 0 THEN
			//Vérifier s'il y a des détails
			ll_count = dw_facture_correction_detail.RowCount()
			IF ll_count > 0 THEN
				//Refuser
				gnv_app.inv_error.of_message("CIPQ0118")
				RETURN
			END IF
			
			IF gnv_app.inv_error.of_message("CIPQ0021") = 1 THEN
				ls_facture = dw_facture_correction.object.fact_no[ll_row]				
				
				//Détruire les parents
				ls_string = "DELETE FROM t_statfacture WHERE fact_no = '" + ls_facture + "' "
				gnv_app.inv_audit.of_runsql_audit( ls_string, "t_statfacture", "Destruction", parent.Title)
				
				dw_facture_correction.post event pfc_retrieve()
			END IF
		END IF

END CHOOSE
end event

type dw_facture_correction_detail from u_dw within w_facture_correction
integer x = 123
integer y = 1296
integer width = 4343
integer height = 612
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_facture_correction_detail"
boolean ib_insertion_a_la_fin = true
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_facture_correction_livraison)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("cie_no","cie_no")
this.inv_linkage.of_Register("liv_no","liv_no")

SetRowFocusindicator(Hand!)

THIS.of_setpremierecolonneinsertion( "prod_no")
end event

event itemchanged;call super::itemchanged;long		ll_qte, ll_row_parent, ll_rowdddw
string	ls_no_facture, ls_desc, ls_null
dec		ldec_prix, ldec_qte_exp
datawindowchild 	ldwc_verrat, ldwc_noproduit

SetNull(ls_null)

CHOOSE CASE dwo.name
		
	CASE "qte_exp"
		ldec_qte_exp = long(data)
		
		THIS.object.qte_comm[row] = ldec_qte_exp
		THIS.object.qteinit[row] = ldec_qte_exp
		
		IF ll_qte > 0 AND THIS.object.uprix[row] > 0 THEN
			IF gnv_app.inv_error.of_message("CIPQ0113") = 1 THEN
				for ll_row_parent = 1 to dw_facture_correction_livraison.rowCount()
					dw_facture_correction_livraison.object.modif_date[ll_row_parent] = today()
				next
			END IF
		END IF
		
		THIS.AcceptText()
		parent.event pfc_save()
		parent.post of_calculdetail( )
		
	CASE "uprix"
		
		IF dec(data) >= 0 AND THIS.object.qte_exp[row] > 0 THEN
			IF gnv_app.inv_error.of_message("CIPQ0113") = 1 THEN
				for ll_row_parent = 1 to dw_facture_correction_livraison.rowCount()
					dw_facture_correction_livraison.object.modif_date[ll_row_parent] = today()
				next
			END IF
			
		END IF
		
		THIS.AcceptText()
		parent.event pfc_save()
		parent.post of_calculdetail( )
		
	CASE "prod_no"
		
		//Vérifier s'il y a un raccourci sur la saisie de l'utilisateur
		string	ls_TempValue, ls_produit
		
		THIS.GetChild('prod_no', ldwc_noproduit)
		
		SELECT id_prod_ass INTO :ls_tempvalue FROM T_AssociationProd WHERE id_ass = trim(:data) ;
		
		If Not IsNull(ls_TempValue) AND ls_TempValue <> "" Then
			ls_produit = ls_TempValue
			if ldwc_noproduit.Find("upper(noproduit) = '" + upper(ls_TempValue) + "-GS'", 1, ldwc_noproduit.RowCount()) > 0 then
				ls_produit += '-GS'
			end if
			
			THIS.object.prod_no[row] = ls_produit
		ELSE
			ls_produit = trim(data)
			if ls_produit <> data then
				THIS.object.prod_no[row] = ls_produit
			end if
		END IF
		
		ll_rowdddw = ldwc_noproduit.Find("upper(noproduit) = '" + upper(ls_produit) + "'", 1, ldwc_noproduit.RowCount())		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			//Mettre à jour la description
			ls_desc = ldwc_noproduit.GetItemString(ll_rowdddw,"nomproduit")
			THIS.object.description[row] = ls_desc
		ELSE
			gnv_app.inv_error.of_message("CIPQ0055")
			SetNull(data)
			THIS.object.prod_no[row] = ls_null
			THIS.ib_suppression_message_itemerror = TRUE
			RETURN 1
		END IF
		
		//Recharger le prix unitaire
		SELECT	prixunitaire
		INTO		:ldec_prix
		FROM		t_produit
		WHERE		noproduit = :ls_produit ;
		
		THIS.object.uprix[row] = ldec_prix
		
		If ls_produit <> data Then
			RETURN 2
		END IF
		
	CASE "verrat_no"
		IF IsNull(data) or data = "" THEN 
			THIS.object.description[row] = ""
			RETURN 
		END IF
		
		THIS.GetChild('verrat_no', ldwc_verrat)
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
			SetText("")
			RETURN 1
		END IF
		
END CHOOSE
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	//Trouver le prochain numéro de ligne
	long		ll_no_ligne, ll_row_parent
	string	ls_cie, ls_liv_no
	
	ll_row_parent = dw_facture_correction_livraison.GetRow()
	IF ll_row_parent > 0 THEN
		ls_cie = dw_facture_correction_livraison.object.cie_no[ll_row_parent]
		ls_liv_no = dw_facture_correction_livraison.object.liv_no[ll_row_parent]
		
		SELECT 	Max(LIGNE_NO)
		INTO		:ll_no_ligne
		FROM		t_statfacturedetail
		WHERE		CIE_NO = :ls_cie AND LIV_NO = :ls_liv_no ;
		
		IF IsNull(ll_no_ligne) THEN ll_no_ligne = 0
		
		ll_no_ligne ++
		
		THIS.object.LIGNE_NO[AncestorReturnValue] = ll_no_ligne
	END IF
END IF

RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;IF AncestorReturnValue = SUCCESS THEN
	//Trouver le prochain numéro de ligne
	long ll_row_parent
	
	ll_row_parent = dw_facture_correction_livraison.GetRow()
	IF ll_row_parent > 0 THEN
		date ld_export
//		n_cst_datetime	lnv_date
		
		//Ancienne ligne 2008-12-09
//		ld_cur = today()
//		ld_cur = RelativeDate(ld_cur, - day(ld_cur))
//		ld_cur = RelativeDate(ld_cur, - day(ld_cur))
//		ld_cur2 = lnv_date.of_lastdayofmonth( ld_cur)
//		ld_dernierefact = date(dw_facture_correction_livraison.object.liv_date[ll_row_parent])
		//2009-01-06 changé
		//ld_dernierefact = date(dw_facture_correction.object.fact_date[dw_facture_correction.GetRow()])
//		ld_cur2 = date(today())
		
		ld_export = date(dw_facture_correction.object.t_statfacture_accpac_date[dw_facture_correction.GetRow()])
		
		//2009-01-06 changé
//		IF ld_dernierefact < ld_cur2 AND Not Isnull(ld_dernierefact) THEN
		IF ld_export < today() AND Not Isnull(ld_export) THEN
			gnv_app.inv_error.of_message("CIPQ0128", {string(ld_export)})
			RETURN FAILURE
		END IF
		
	END IF
	
END IF

RETURN AncestorReturnValue
end event

event pfc_populatedddw;call super::pfc_populatedddw;if as_colname = 'verrat_no' then
	if dw_facture_correction.getRow() > 0 then
		adwc_obj.setTransObject(SQLCA)
		adwc_obj.setSQLSelect(gnv_app.of_sqllisteverrats(dw_facture_correction.object.no_eleveur[dw_facture_correction.getRow()]))
		return adwc_obj.retrieve()
	else
		adwc_obj.reset()
		return 0
	end if
end if
end event

event pfc_retrieve;call super::pfc_retrieve;// Pour filtrer la liste de verrats - Sébastien 2008-10-31
// 2010-03-16 - Sébastien - Désactivé, la personne qui fait des modifications ici doit savoir ce qu'elle fait
//datawindowchild ldwc_verrat
//
//if this.getChild("verrat_no", ldwc_verrat) = 1 then
//	return this.event pfc_populatedddw("verrat_no", ldwc_verrat)
//else
//	return -1
//end if

return AncestorReturnValue
end event

event pfc_postupdate;call super::pfc_postupdate;IF AncestorReturnValue > 0 THEN
	parent.of_calculdetail()
END IF

RETURN AncestorReturnValue
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;IF AncestorReturnValue > 0 THEN
	long ll_row_parent
	
	ll_row_parent = dw_facture_correction.GetRow()
	IF ll_row_parent > 0 THEN
		date	ld_export
//		n_cst_datetime	lnv_date
		
		// Vérifier si c'est avant l'exportation
		
//		ld_cur = today()
//		ld_cur = RelativeDate(ld_cur, - day(ld_cur))
//		ld_cur = RelativeDate(ld_cur, - day(ld_cur))
//		ld_cur2 = lnv_date.of_lastdayofmonth( ld_cur)
//		
//		ld_dernierefact = date(dw_facture_correction_livraison.object.liv_date[ll_row_parent])

		ld_export = date(dw_facture_correction.object.t_statfacture_accpac_date[ll_row_parent])
		
		//2009-08-19 changé pour ne pas ajouter quand la facture est exportée dans AccPac
//		IF ld_dernierefact < ld_cur2 AND Not Isnull(ld_dernierefact) THEN
		IF ld_export <= today() AND Not Isnull(ld_export) THEN
			gnv_app.inv_error.of_message("CIPQ0128", {string(ld_export)})
			RETURN PREVENT_ACTION
		END IF
	END IF
END IF

RETURN AncestorReturnValue
end event

event dropdown;call super::dropdown;datawindowchild 	ldwc_noproduit
string 				ls_produit
long					ll_rowdddw

IF THIS.GetRow() > 0 THEN
	
	CHOOSE CASE THIS.GetColumnName()
		CASE "prod_no"
			
			ls_produit = THIS.object.prod_no[THIS.GetRow()]
			IF IsNull(ls_produit) THEN
				AcceptText()
				ls_produit = THIS.object.prod_no[THIS.GetRow()]
			END IF

			IF GetChild( "prod_no", ldwc_noproduit ) = 1 THEN
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

event itemfocuschanged;call super::itemfocuschanged;//datawindowchild 	ldwc_verrat, ldwc_noproduit
//string 				ls_select_str, ls_column, ls_rtn, ls_codeverrat
//n_cst_eleveur		lnv_eleveur
//long					ll_row_parent, ll_eleveur
//boolean				lb_gedis = FALSE
//
//IF Row > 0 THEN
//	
//	ll_row_parent = dw_facture_correction.GetRow()
//	
//	ll_eleveur = dw_facture_correction.object.no_eleveur[ll_row_parent]
//	
//	lb_gedis = lnv_eleveur.of_formationgedis(ll_eleveur)	
//	IF isnull(lb_gedis) THEN lb_gedis = FALSE
//
//	CHOOSE CASE dwo.name 
//		CASE "prod_no"
//			
//			ls_codeverrat = THIS.object.verrat_no[row]
//			
//			If Not IsNull(ls_codeverrat) AND ls_codeverrat <> "" Then
//				//Filtre par no de verrat
//				ls_select_str = "SELECT DISTINCT t_Produit.NoProduit, t_Produit.NomProduit, t_Produit.NoClasse, t_Produit.PrixUnitaire " + &
//					" FROM t_Produit INNER JOIN t_Verrat_Produit ON upper(t_Produit.NoProduit) = upper(t_Verrat_Produit.NoProduit) "
//					
//				If lb_gedis = TRUE Then
//					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + "'))"
//				Else
//					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + &
//						"') AND ((Right(t_Produit.NoProduit,3))<>'-GS'))"
//				End If
//						
//			ELSE
//				//Pas de verrat spécifié
//				ls_select_str = gnv_app.of_findsqlproduit( ll_eleveur, TRUE, FALSE)
//				
//			END IF
//
//			IF GetChild( "prod_no", ldwc_noproduit ) = 1 THEN
//				ls_rtn = ldwc_noproduit.modify( "DataWindow.Table.Select=~"" + ls_select_str + "~"" )
//				
//				//Nouveau retrieve parce que la dddw n'était pas toujours bien chargée
//				ldwc_noproduit.setTransObject(SQLCA)
//				ldwc_noproduit.Retrieve()
//			END IF
//			
//	END CHOOSE
//
//END IF
end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_facture_correction
event destroy ( )
string tag = "resize=frbsr"
integer x = 123
integer y = 1908
integer width = 4261
integer taborder = 60
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

		
	CASE "Supprimer cet item"
		IF dw_facture_correction_detail.event pfc_deleterow() >= 0 THEN
			parent.of_calculdetail()
		END IF

	CASE "Ajouter un item"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_facture_correction_detail.event pfc_insertrow()
		END IF
		
	CAse "Enregistrer"
		if of_livraison_sans_produit() = 2 then return
		
		PARENT.event pfc_save()
		parent.of_calculdetail()
		
END CHOOSE

end event

type uo_toolbar_milieu from u_cst_toolbarstrip within w_facture_correction
event destroy ( )
string tag = "resize=frbsr"
integer x = 119
integer y = 1100
integer width = 4329
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar_milieu.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter une livraison"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_facture_correction_livraison.event pfc_insertrow()
		END IF

END CHOOSE
end event

type gb_1 from groupbox within w_facture_correction
integer x = 91
integer y = 652
integer width = 4421
integer height = 588
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Livraison"
end type

type gb_2 from groupbox within w_facture_correction
integer x = 91
integer y = 1244
integer width = 4421
integer height = 796
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Détail"
end type

type gb_3 from groupbox within w_facture_correction
integer x = 91
integer y = 192
integer width = 4421
integer height = 464
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Facture"
end type

type rr_1 from roundrectangle within w_facture_correction
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 176
integer width = 4549
integer height = 2036
integer cornerheight = 40
integer cornerwidth = 46
end type

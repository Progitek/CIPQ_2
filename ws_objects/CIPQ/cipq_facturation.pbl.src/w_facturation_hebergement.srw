﻿$PBExportHeader$w_facturation_hebergement.srw
forward
global type w_facturation_hebergement from w_sheet
end type
type st_ligne_donnee from statictext within w_facturation_hebergement
end type
type st_ligne from statictext within w_facturation_hebergement
end type
type st_eleveur_donnee from statictext within w_facturation_hebergement
end type
type st_eleveur from statictext within w_facturation_hebergement
end type
type st_texte from statictext within w_facturation_hebergement
end type
type st_mois from statictext within w_facturation_hebergement
end type
type st_2 from statictext within w_facturation_hebergement
end type
type uo_toolbar from u_cst_toolbarstrip within w_facturation_hebergement
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_facturation_hebergement
end type
type st_1 from statictext within w_facturation_hebergement
end type
type p_ra from picture within w_facturation_hebergement
end type
type rr_2 from roundrectangle within w_facturation_hebergement
end type
type rr_1 from roundrectangle within w_facturation_hebergement
end type
end forward

global type w_facturation_hebergement from w_sheet
string tag = "menu=m_facturesdhebergement"
integer width = 1838
integer height = 1092
string title = "Factures d~'hébergement"
st_ligne_donnee st_ligne_donnee
st_ligne st_ligne
st_eleveur_donnee st_eleveur_donnee
st_eleveur st_eleveur
st_texte st_texte
st_mois st_mois
st_2 st_2
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
rr_2 rr_2
rr_1 rr_1
end type
global w_facturation_hebergement w_facturation_hebergement

type variables
n_cst_datetime	inv_datetime
date	id_debut, id_fin
end variables

forward prototypes
public subroutine of_ajustecr ()
public subroutine of_messok (long al_nbrcmd)
public subroutine of_afficheerreur (string as_proc, long al_numerr, string as_descrerr)
public function integer of_nbrjours (date ad_debmois, date ad_finmois, date ad_datedeb, date ad_datefin)
public function integer of_validok ()
public function boolean of_retireok ()
public function boolean of_retireanc ()
public subroutine of_ajustpres ()
public subroutine of_creefact ()
end prototypes

public subroutine of_ajustecr ();//of_AjustEcr

st_texte.text = "Calcul des factures en cours"
st_eleveur.Visible = True
st_ligne_donnee.Visible = True
st_eleveur_donnee.Visible = True
st_ligne.Visible = True
end subroutine

public subroutine of_messok (long al_nbrcmd);// of_MessOk
// message affiché en cas de réussite.

gnv_app.inv_error.of_message("CIPQ0105",{string(al_nbrcmd)})

end subroutine

public subroutine of_afficheerreur (string as_proc, long al_numerr, string as_descrerr);
gnv_app.inv_error.of_message("CIPQ0106",{as_proc, string(al_NumErr), as_DescrErr})
end subroutine

public function integer of_nbrjours (date ad_debmois, date ad_finmois, date ad_datedeb, date ad_datefin);//of_NbrJours

long 	ll_nbrjours
date	ad_DateMin, ad_DateMax

ad_datedeb = RelativeDate(ad_datedeb, 1)

IF ad_debmois < ad_datedeb THEN
	ad_DateMin = ad_datedeb
ELSE
	ad_DateMin = ad_debmois
END IF

If Not IsNull(ad_datefin) Then
	IF ad_DateFin > ad_FinMois THEN
		ad_DateMax = ad_FinMois
	ELSE
		ad_DateMax = ad_DateFin
	END IF
Else
	ad_DateMax = ad_finmois
End If

ll_nbrjours = DaysAfter ( ad_DateMin, ad_DateMax ) + 1

RETURN ll_nbrjours
end function

public function integer of_validok ();// of_ValidOk

long	ll_retour, ll_count

//Valeurs de retour possibles :
//   0   :   Rien à retirer.
//   1   :   Retrait nécessaire et confirmé
//   2   :   Retrait non confirmé.

SELECT 	count(1)
INTO		:ll_count
FROM 		t_Produit RIGHT JOIN 
			(T_StatFacture INNER JOIN T_StatFactureDetail ON 
			(T_StatFacture.LIV_NO = T_StatFactureDetail.LIV_NO) AND (T_StatFacture.CIE_NO = T_StatFactureDetail.CIE_NO)) 
			ON (t_Produit.NoProduit) = (T_StatFactureDetail.PROD_NO)
WHERE 	(((t_Produit.NoClasse)=19) AND ((t_Produit.actif)=0) AND 
			(date(T_StatFacture.LIV_DATE)=:id_fin)) ;

If ll_count = 0 Then
   ll_retour = 0
Else
	IF this.of_RetireOk() THEN
		ll_retour = 1
	ELSE
		ll_retour = 2
	END IF
End If

RETURN ll_retour

end function

public function boolean of_retireok ();//of_RetireOk
string	ls_texte
long		ll_retour

ls_texte = inv_datetime.of_monthname(month(id_debut)) + " " + string(year(id_debut))

ll_retour = gnv_app.inv_error.of_message("CIPQ0107",{ls_texte})
IF ll_retour = 1 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

public function boolean of_retireanc ();st_texte.text = "Suppression des anciennes factures"

DELETE FROM T_StatFactureDetail
FROM 			t_Produit RIGHT JOIN (T_StatFacture INNER JOIN T_statFactureDetail ON 
				(T_StatFacture.LIV_NO = T_StatFactureDetail.LIV_NO) AND (T_StatFacture.CIE_NO = T_StatFactureDetail.CIE_NO)) 
				ON (t_Produit.NoProduit) = (T_StatFactureDetail.PROD_NO)
WHERE 		((t_Produit.NoClasse=19) AND ((t_Produit.actif)=0) AND 
				(date(T_StatFacture.LIV_DATE)=:id_fin));

IF SQLCA.SQLCode < 0 THEN 
	of_afficheerreur("RetireAnc", SQLCA.SQLCODE, SQLCA.SqlErrText)
	RETURN FALSE
END IF
				
COMMIT USING SQLCA;

IF SQLCA.SQLCode < 0 THEN 
	of_afficheerreur("RetireAnc", SQLCA.SQLCODE, SQLCA.SqlErrText)
	RETURN FALSE
END IF


DELETE FROM 	T_StatFacture 
FROM 	T_StatFacture 
LEFT JOIN 		T_StatFactureDetail ON 
					(T_StatFacture.LIV_NO = T_StatFactureDetail.LIV_NO) AND 
					(T_StatFacture.CIE_NO = T_StatFactureDetail.CIE_NO) 
WHERE 			(((T_StatFacture.CIE_NO)='110') AND ((T_StatFactureDetail.CIE_NO) Is Null) AND 
					((T_StatFactureDetail.LIV_NO) Is Null));

IF SQLCA.SQLCode < 0 THEN 
	of_afficheerreur("RetireAnc", SQLCA.SQLCODE, SQLCA.SqlErrText)
	RETURN FALSE
END IF

COMMIT USING SQLCA;

IF SQLCA.SQLCode < 0 THEN 
	of_afficheerreur("RetireAnc", SQLCA.SQLCODE, SQLCA.SqlErrText)
	RETURN FALSE
END IF

RETURN TRUE
end function

public subroutine of_ajustpres ();// of_AjustPres

st_texte.weight = 700

uo_toolbar_gauche.visible = FALSE
uo_toolbar.visible = FALSE

end subroutine

public subroutine of_creefact ();//of_CreeFact

long 		ll_lcCliId, ll_lnLigne, ll_lnNoLiv, ll_lnJrMois, ll_Single, ll_lnNbrCmd, ll_lnPremCmd, &
			ll_lnDernCmd, ll_nb_row, ll_cpt, ll_eleveur
dec		ldec_lnJrLoc
string	ls_DefaultCompanyNo, ls_region, ls_produit
date		ld_elimin, ld_entproduct
n_ds		lds_fact

SetPointer(HourGlass!)

lds_fact = CREATE n_ds
lds_fact.dataobject = "ds_facturation_hebergement"
lds_fact.of_setTransobject(SQLCA)
ll_nb_row = lds_fact.Retrieve(id_debut, id_fin)

ls_DefaultCompanyNo = gnv_app.of_getcompagniedefaut( )

ll_lnJrMois = Day(id_fin)
ll_lcCliId = 0
ll_lnNbrCmd = 0

of_AjustEcr()

FOR ll_cpt = 1 TO ll_nb_row
	SetPointer(HourGlass!)
	
	ll_eleveur = lds_fact.object.t_eleveur_group_no_eleveur[ll_cpt]
	ls_produit = lds_fact.object.t_produit_noproduit[ll_cpt]
	ld_elimin = date(lds_fact.object.t_verrat_elimin[ll_cpt])
	ld_entproduct = date(lds_fact.object.t_verrat_entproduct[ll_cpt])
	ls_region = lds_fact.object.t_eleveur_reg_agr[ll_cpt]
	
	
	IF ll_lcCliId <> ll_eleveur THEN
		ll_lcCliId = ll_eleveur
		st_eleveur_donnee.text = string(ll_eleveur)
		ll_lnNbrCmd++
		ll_lnLigne = 1
		ll_lnNoLiv = gnv_app.of_GetNextLivNo(ls_DefaultCompanyNo)
		//entête de la facture
		INSERT INTO T_StatFacture(Cie_No, Liv_No, reg_agr, No_Eleveur, liv_date, credit, taxep, taxef) 
		VALUES (:ls_DefaultCompanyNo, :ll_lnNoLiv, :ls_region, :ll_eleveur, :id_fin, 1, 0, 0) ;
		IF SQLCA.SQLCode < 0 THEN 
			of_afficheerreur("CreeFact", SQLCA.SQLCODE, SQLCA.SqlErrText)
			RETURN 
		END IF
		
		COMMIT USING SQLCA;			
		IF SQLCA.SQLCode < 0 THEN 
			of_afficheerreur("CreeFact", SQLCA.SQLCODE, SQLCA.SqlErrText)
			RETURN 
		END IF
		
	ELSE
		ll_lnLigne ++
		st_ligne_donnee.text = string(ll_lnLigne)
	END IF
	
	ldec_lnJrLoc = THIS.of_nbrjours( id_debut, id_fin, ld_entproduct, ld_elimin)
	ldec_lnJrLoc = round(ldec_lnJrLoc / ll_lnJrMois,6)
	
	INSERT INTO t_StatFactureDetail (cie_no, liv_no, ligne_no, prod_no, qte_comm, qte_exp) 
   VALUES (:ls_DefaultCompanyNo, :ll_lnNoLiv,:ll_lnLigne, :ls_produit, :ldec_lnJrLoc, :ldec_lnJrLoc) ;

	IF SQLCA.SQLCode < 0 THEN 
		of_afficheerreur("CreeFact", SQLCA.SQLCODE, SQLCA.SqlErrText)
		RETURN 
	END IF
	
	COMMIT USING SQLCA;			
	IF SQLCA.SQLCode < 0 THEN 
		of_afficheerreur("CreeFact", SQLCA.SQLCODE, SQLCA.SqlErrText)
		RETURN 
	END IF
	
END FOR

If IsValid(lds_fact) THEN Destroy(lds_fact)

of_MessOk(ll_lnNbrCmd)
end subroutine

on w_facturation_hebergement.create
int iCurrent
call super::create
this.st_ligne_donnee=create st_ligne_donnee
this.st_ligne=create st_ligne
this.st_eleveur_donnee=create st_eleveur_donnee
this.st_eleveur=create st_eleveur
this.st_texte=create st_texte
this.st_mois=create st_mois
this.st_2=create st_2
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.rr_2=create rr_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_ligne_donnee
this.Control[iCurrent+2]=this.st_ligne
this.Control[iCurrent+3]=this.st_eleveur_donnee
this.Control[iCurrent+4]=this.st_eleveur
this.Control[iCurrent+5]=this.st_texte
this.Control[iCurrent+6]=this.st_mois
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.uo_toolbar
this.Control[iCurrent+9]=this.uo_toolbar_gauche
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.p_ra
this.Control[iCurrent+12]=this.rr_2
this.Control[iCurrent+13]=this.rr_1
end on

on w_facturation_hebergement.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_ligne_donnee)
destroy(this.st_ligne)
destroy(this.st_eleveur_donnee)
destroy(this.st_eleveur)
destroy(this.st_texte)
destroy(this.st_mois)
destroy(this.st_2)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_gauche)
destroy(this.st_1)
destroy(this.p_ra)
destroy(this.rr_2)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

uo_toolbar_gauche.of_settheme("classic")
uo_toolbar_gauche.of_DisplayBorder(true)
uo_toolbar_gauche.of_AddItem("Confirmer...", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar_gauche.POST of_displaytext(true)

//Préparer l'interface
string	ls_desc, ls_mois

// 2009-11-30 Sébastien Tremblay - Calcul intelligent de la première et dernière date du mois précédent
id_debut = inv_datetime.of_firstDayOfMonth(inv_datetime.of_relativeMonth(today(), -1))
id_fin = inv_datetime.of_lastDayOfMonth(id_debut)

//ld_today = date(today())
//id_debut = inv_datetime.of_relativeMonth(ld_today, -1)
//id_debut = RelativeDate(id_debut, 1 - day(ld_today))
//
//id_fin = inv_datetime.of_relativeMonth(id_debut, 1)
//id_fin = RelativeDate(id_fin, -1)

ls_mois = inv_datetime.of_monthName(month(id_debut)) 
st_mois.text = ls_mois + " " + string(year(id_debut))

st_texte.text = "Désirez-vous créer les factures d'hébergement pour le mois de " + ls_mois + " ?"
end event

type st_ligne_donnee from statictext within w_facturation_hebergement
boolean visible = false
integer x = 1010
integer y = 628
integer width = 288
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = center!
boolean focusrectangle = false
end type

type st_ligne from statictext within w_facturation_hebergement
boolean visible = false
integer x = 713
integer y = 628
integer width = 288
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Ligne:"
boolean focusrectangle = false
end type

type st_eleveur_donnee from statictext within w_facturation_hebergement
boolean visible = false
integer x = 334
integer y = 628
integer width = 288
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
boolean focusrectangle = false
end type

type st_eleveur from statictext within w_facturation_hebergement
boolean visible = false
integer x = 55
integer y = 628
integer width = 288
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Éleveur:"
boolean focusrectangle = false
end type

type st_texte from statictext within w_facturation_hebergement
integer x = 55
integer y = 372
integer width = 1687
integer height = 220
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = center!
boolean focusrectangle = false
end type

type st_mois from statictext within w_facturation_hebergement
integer x = 448
integer y = 248
integer width = 1074
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
boolean focusrectangle = false
end type

type st_2 from statictext within w_facturation_hebergement
integer x = 64
integer y = 248
integer width = 343
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Mois:"
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_facturation_hebergement
event destroy ( )
integer x = 1275
integer y = 792
integer width = 507
integer taborder = 20
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_facturation_hebergement
event destroy ( )
integer x = 23
integer y = 792
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;long		ll_ok
boolean	lb_retireok

SetPointer(HourGlass!)


ll_ok = parent.of_ValidOk()
lb_retireok = True
If ll_ok <> 2 Then
    parent.of_AjustPres()

    If ll_ok = 1 Then
			lb_retireok = parent.of_RetireAnc()
    End If
    If lb_retireok Then
			SetPointer(HourGlass!)
        	parent.of_CreeFact()
    End If
End If

uo_toolbar_gauche.visible = TRUE
uo_toolbar.visible = TRUE

end event

type st_1 from statictext within w_facturation_hebergement
integer x = 274
integer y = 60
integer width = 1467
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Factures d~'hébergement"
boolean focusrectangle = false
end type

type p_ra from picture within w_facturation_hebergement
integer x = 69
integer y = 44
integer width = 128
integer height = 112
string picturename = "Library!"
boolean focusrectangle = false
end type

type rr_2 from roundrectangle within w_facturation_hebergement
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 1765
integer height = 172
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_1 from roundrectangle within w_facturation_hebergement
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 212
integer width = 1765
integer height = 560
integer cornerheight = 40
integer cornerwidth = 46
end type

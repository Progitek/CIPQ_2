$PBExportHeader$w_verrat_ecrasement.srw
forward
global type w_verrat_ecrasement from w_response
end type
type sle_centre from u_sle within w_verrat_ecrasement
end type
type sle_numero from u_sle within w_verrat_ecrasement
end type
type uo_toolbar from u_cst_toolbarstrip within w_verrat_ecrasement
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_verrat_ecrasement
end type
type st_2 from statictext within w_verrat_ecrasement
end type
type st_1 from statictext within w_verrat_ecrasement
end type
type rr_1 from roundrectangle within w_verrat_ecrasement
end type
end forward

global type w_verrat_ecrasement from w_response
string tag = "menu=m_verrats"
integer x = 214
integer y = 221
integer width = 1266
integer height = 556
string title = "Verrat - écrasement"
long backcolor = 12639424
sle_centre sle_centre
sle_numero sle_numero
uo_toolbar uo_toolbar
uo_toolbar2 uo_toolbar2
st_2 st_2
st_1 st_1
rr_1 rr_1
end type
global w_verrat_ecrasement w_verrat_ecrasement

type variables
string	is_numero, is_centre, is_tatouage, is_coderace
end variables

on w_verrat_ecrasement.create
int iCurrent
call super::create
this.sle_centre=create sle_centre
this.sle_numero=create sle_numero
this.uo_toolbar=create uo_toolbar
this.uo_toolbar2=create uo_toolbar2
this.st_2=create st_2
this.st_1=create st_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_centre
this.Control[iCurrent+2]=this.sle_numero
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.uo_toolbar2
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.rr_1
end on

on w_verrat_ecrasement.destroy
call super::destroy
destroy(this.sle_centre)
destroy(this.sle_numero)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")

uo_toolbar.of_DisplayBorder(true)

uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)

uo_toolbar.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar2.of_AddItem("Annuler", "C:\ii4net\CIPQ\images\annuler.gif")
uo_toolbar.POST of_displaytext(true)
uo_toolbar2.POST of_displaytext(true)
end event

event pfc_preopen;call super::pfc_preopen;is_numero = gnv_app.inv_entrepotglobal.of_retournedonnee("lien écrasement numéro")
is_centre = gnv_app.inv_entrepotglobal.of_retournedonnee("lien écrasement centre")
is_tatouage = gnv_app.inv_entrepotglobal.of_retournedonnee("lien écrasement tatouage")
is_coderace = gnv_app.inv_entrepotglobal.of_retournedonnee("lien écrasement code race")
end event

type sle_centre from u_sle within w_verrat_ecrasement
integer x = 667
integer y = 172
integer width = 457
integer height = 84
integer taborder = 20
integer textsize = -10
fontcharset fontcharset = ansi!
textcase textcase = upper!
end type

type sle_numero from u_sle within w_verrat_ecrasement
integer x = 667
integer y = 60
integer width = 457
integer height = 84
integer taborder = 10
integer textsize = -10
fontcharset fontcharset = ansi!
textcase textcase = upper!
end type

type uo_toolbar from u_cst_toolbarstrip within w_verrat_ecrasement
event destroy ( )
integer x = 23
integer y = 340
integer width = 507
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;string	ls_centre, ls_numero, ls_sql, ls_nom, ls_codeheb, ls_numero_conv, ls_ciedefaut
long		ll_count, ll_reponse
dec		ldec_base, ldec_heb

If IsNull(is_tatouage) Then is_tatouage = ""

//Procéder à l'écrasement

//Validation des champs obligatoires
ls_numero = sle_numero.text
ls_centre = sle_centre.text

IF IsNull(ls_numero) OR ls_numero = "" THEN
	gnv_app.inv_error.of_message( "CIPQ0032")
	RETURN
END IF
IF IsNull(ls_centre) OR ls_centre = "" THEN
	gnv_app.inv_error.of_message( "CIPQ0033")
	RETURN
END IF

SELECT Count(CodeVerrat) INTO :ll_count FROM t_verrat WHERE CodeVerrat=:ls_numero and CIE_NO=:ls_centre;

IF ll_count <> 0 THEN
	ll_reponse = gnv_app.inv_error.of_message( "CIPQ0034")
ELSE
	ll_reponse = gnv_app.inv_error.of_message( "CIPQ0035")
END IF
IF ll_reponse <> 1 THEN RETURN

ls_sql = "UPDATE T_Verrat SET T_Verrat.CIE_NO = '" + ls_centre + "', T_Verrat.CodeVerrat = '" + ls_numero + &
	"' WHERE t_Verrat.CIE_NO = '" + is_centre + "' AND t_Verrat.CodeVerrat = '" + is_numero + "'"
gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_verrat", "Mise à jour", parent.Title)

ls_sql = "UPDATE T_Recolte SET T_Recolte.CodeVerrat = '" + ls_numero + "' WHERE t_recolte.CodeVerrat = '" + is_numero + "'"
gnv_app.inv_audit.of_runsql_audit( ls_sql, "T_Recolte", "Mise à jour", parent.Title)

ls_sql = "UPDATE t_CommandeDetail SET t_CommandeDetail.CodeVerrat = '" + ls_numero + "' WHERE t_CommandeDetail.CodeVerrat = '" + is_numero + "'"
gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeDetail", "Mise à jour", parent.Title)

ls_sql = "UPDATE T_StatFactureDetail SET T_StatFactureDetail.VERRAT_NO = '" + ls_numero + "' WHERE T_StatFactureDetail.VERRAT_NO = '" + is_numero + "'"
gnv_app.inv_audit.of_runsql_audit( ls_sql, "T_StatFactureDetail", "Mise à jour", parent.Title)

//Si Verrat d'hébergement (CodeRACE='LO'), CRÉER un nouveau produit....
// JE COMPRENDS PAS TROP A QUOI CA SERT MAIS BON .....
// ON CRÉER UN PRODUIT QUI EXISTE DEJA ....
If upper(is_coderace) = "LO" Then

	
	ls_nom = "HÉBERGEMENT VERRAT " + ls_numero + ", " + is_tatouage + ", " + ls_centre
	ls_codeheb = Left(ls_numero, 1)
	ls_numero_conv = "HEB-" + ls_numero
	
	ls_ciedefaut = gnv_app.of_getcompagniedefaut()
	
	ldec_heb = gnv_app.of_getprixhebergement(ls_ciedefaut)

	ls_sql = "UPDATE t_produit SET t_produit.nomproduit = '" + ls_nom + "' WHERE t_produit.noproduit = '" + ls_numero_conv + "'"
	gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_produit", "Mise à jour", parent.Title)
	
	/*
	// MISE À JOUR PRODUIT 
	//____________________
			
	string ls_classe,ls_codev,ls_souscodeh,ls_classe2
	long   ll_idprodspec,ll_eco
	dec{2} ld_prix
			
	SELECT classe INTO :ls_classe FROM t_verrat WHERE CodeVerrat=:ls_numero and CIE_NO=:ls_centre;
	
	ls_classe2 = '%'+ls_classe+'%'
			
	ll_eco = 12
			
	setnull(ls_souscodeh)
					
	SELECT id_prodspec,isnull(codeverrat,'')
		INTO :ll_idprodspec, :ls_codev
	FROM t_prodspec 
	WHERE codehebergeur = :ls_codeheb
		AND ((substring(noclasse,1,1) = '=' AND noclasse LIKE :ls_classe2 OR :ls_classe IS NULL) OR (substring(noclasse,1,2) = '<>' AND noclasse NOT LIKE :ls_classe2 OR :ls_classe IS NULL))
		AND (substring(codeverrat,1,1) = (if substring(codeverrat,2,1) = substring(:ls_numero,2,1) then '.' else '!' endif) OR (codeverrat IS NULL));
				
	IF ll_idprodspec > 0 THEN
		SELECT prix, souscodehebergeur, economie 
			INTO :ld_prix,:ls_souscodeh,:ll_eco
		FROM t_prodspec 
		WHERE id_prodspec = :ll_idprodspec;
		ldec_heb = ld_prix
	END IF
			
	
	ls_SQL = "INSERT INTO t_Produit ( NoProduit, NomProduit, NoClasse, PrixUnitaire, PrixUnitaireSP, NoEconomieVolume, CodeHebergeur, alliancematernelle, multiplication, codetemporaire, actif, disponible, special ) " + &
   	"VALUES ('" + ls_numero_conv + "', '" + ls_nom + "', 19, " + string(ldec_heb) + ", " + string(ldec_heb) + ", 12 ,  '" + ls_codeheb + "', 0, 0, 0, 1, 1, 0 )"
		
	gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_Produit", "Insertion", parent.Title)
	*/
End If

//Tarminé
gnv_app.inv_error.of_message("CIPQ0036")
end event

type uo_toolbar2 from u_cst_toolbarstrip within w_verrat_ecrasement
event destroy ( )
integer x = 718
integer y = 340
integer width = 507
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type st_2 from statictext within w_verrat_ecrasement
integer x = 69
integer y = 172
integer width = 549
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 15793151
string text = "Nouveau centre:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_verrat_ecrasement
integer x = 69
integer y = 64
integer width = 549
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 15793151
string text = "Nouveau numéro:"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_verrat_ecrasement
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 1216
integer height = 292
integer cornerheight = 40
integer cornerwidth = 46
end type


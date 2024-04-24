$PBExportHeader$w_exportation_facture.srw
forward
global type w_exportation_facture from w_sheet_frame
end type
type em_date from u_em within w_exportation_facture
end type
type uo_toolbar from u_cst_toolbarstrip within w_exportation_facture
end type
type cb_exportation from commandbutton within w_exportation_facture
end type
type cbx_re from u_cbx within w_exportation_facture
end type
type cb_sommaire from commandbutton within w_exportation_facture
end type
type cb_detail from commandbutton within w_exportation_facture
end type
type cb_dernier from commandbutton within w_exportation_facture
end type
type cb_som from commandbutton within w_exportation_facture
end type
type dw_compte_exportation from u_dw within w_exportation_facture
end type
type em_montant from u_em within w_exportation_facture
end type
type st_message from statictext within w_exportation_facture
end type
type cb_1 from commandbutton within w_exportation_facture
end type
type gb_1 from groupbox within w_exportation_facture
end type
type rr_1 from roundrectangle within w_exportation_facture
end type
end forward

global type w_exportation_facture from w_sheet_frame
string tag = "exclure_securite"
em_date em_date
uo_toolbar uo_toolbar
cb_exportation cb_exportation
cbx_re cbx_re
cb_sommaire cb_sommaire
cb_detail cb_detail
cb_dernier cb_dernier
cb_som cb_som
dw_compte_exportation dw_compte_exportation
em_montant em_montant
st_message st_message
cb_1 cb_1
gb_1 gb_1
rr_1 rr_1
end type
global w_exportation_facture w_exportation_facture

type variables
string	is_pathdb = ""
end variables

forward prototypes
public function decimal of_transamount ()
public function string of_verif_decimal (string as_champ)
public subroutine of_updatefacture (string as_no_fact)
public subroutine of_exporteleveur ()
public subroutine of_exportfact (string as_pathdb, boolean ab_reprint, date ad_expdate)
public function boolean of_apok ()
end prototypes

public function decimal of_transamount ();//of_TransAmount

dec	ldec_amount = 0, ldec_SumOfVENTE, ldec_SumOfTAXEP, ldec_SumOfTAXEF
date	ld_cur

IF em_date.text <> "00-00-0000" THEN
	ld_cur = date(em_date.text)

	SetPointer(HourGlass!)

	SELECT 	Sum(QTE_EXP * UPRIX ) AS Vent, SUm(tps), Sum(tvq)
	INTO		:ldec_SumOfVENTE,:ldec_SumOfTAXEP,:ldec_SumOfTAXEF
	FROM 		t_StatFactureDetail INNER JOIN t_StatFacture 
				ON (t_StatFactureDetail.CIE_NO = t_StatFacture.CIE_NO) 
				AND (t_StatFactureDetail.LIV_NO = t_StatFacture.LIV_NO) 
	GROUP BY T_StatFacture.FACT_DATE
	HAVING 	((date(T_StatFacture.FACT_DATE) = :ld_cur ));
	
	/*
	SELECT 	Sum(T_StatFacture.TAXEP) AS SumOfTAXEP, 
				Sum(T_StatFacture.TAXEF) As SumOfTAXEF 
	INTO		:ldec_SumOfTAXEP, :ldec_SumOfTAXEF
	FROM 		T_StatFacture GROUP BY T_StatFacture.FACT_DATE 
	HAVING 	((date(T_StatFacture.FACT_DATE) = :ld_cur ))	 USING SQLCA;
	*/
	
	If isNull(ldec_SumOfVENTE) THEN ldec_SumOfVENTE = 0
	If isNull(ldec_SumOfTAXEP) THEN ldec_SumOfTAXEP = 0
	If isNull(ldec_SumOfTAXEF) THEN ldec_SumOfTAXEF = 0
	
	ldec_amount = ldec_SumOfVENTE + ldec_SumOfTAXEP + ldec_SumOfTAXEF
	
END IF

RETURN ldec_amount
end function

public function string of_verif_decimal (string as_champ);//of_verif_decimal

as_champ = gnv_app.inv_string.of_globalreplace( as_champ, ",", ".")

RETURN as_champ
end function

public subroutine of_updatefacture (string as_no_fact);//of_updatefacture
string	ls_date

ls_date = em_date.text

UPDATE T_StatFacture SET T_StatFacture.Accpac_Date = :ls_date
WHERE ((T_StatFacture.FACT_NO)=:as_no_fact) USING SQLCA;

COMMIT USING SQLCA;
end subroutine

public subroutine of_exporteleveur ();//of_exporteleveur

long		ll_nb_row, ll_cpt, ll_rtn
n_ds		lds_exportation
string	ls_ligne, ls_customer_number, ls_address_line_1, ls_address_line_2, ls_address_line_3, ls_address_line_4, &
			ls_postal_code, ls_phone_number, ls_contact, ls_salesperson_code, ls_limite_credit, ls_interest_option, &
			ls_report_group, ls_terme_code, ls_account_set_code, ls_billing_cycle, ls_CF, ls_customer_name, &
			ls_transport_code, ls_fichier
integer 	li_FileNum

ls_fichier = is_pathdb + "\ELEVEUR.DAT"
li_FileNum = FileOpen(ls_fichier, LineMode!, Write!, LockWrite!, Replace!)

lds_exportation = CREATE n_ds
lds_exportation.dataobject = "ds_exportation_eleveur"
lds_exportation.of_setTransobject(SQLCA)
ll_nb_row = lds_exportation.Retrieve()

FOR ll_cpt = 1 TO ll_nb_row
	ls_ligne = ""
	
	ls_customer_number = lds_exportation.object.customer_number[ll_cpt]
	st_message.text = "Exportation de l'éleveur # " + string(ls_customer_number)
	
	ls_customer_name = '"' + lds_exportation.object.customer_name[ll_cpt] + '"'
	ls_address_line_1 = '"' + lds_exportation.object.address_line_1[ll_cpt] + '"'
	ls_address_line_2 = '"' +lds_exportation.object.address_line_2[ll_cpt] + '"'
	ls_address_line_3 = '"' +lds_exportation.object.address_line_3[ll_cpt] + '"'
	ls_address_line_4 = '"' +lds_exportation.object.address_line_4[ll_cpt] + '"'
	ls_postal_code = '"' + lds_exportation.object.postal_code[ll_cpt] + '"'
	ls_phone_number = '"' + lds_exportation.object.phone_number[ll_cpt] + '"'
	ls_contact = lds_exportation.object.contact[ll_cpt]
	ls_salesperson_code = lds_exportation.object.salesperson_code[ll_cpt]
	ls_limite_credit = lds_exportation.object.limite_credit[ll_cpt]
	ls_interest_option = lds_exportation.object.interest_option[ll_cpt]
	ls_report_group = lds_exportation.object.report_group[ll_cpt]
	ls_CF = lds_exportation.object.cf_getgroupefacturationaccpac[ll_cpt]
	ls_terme_code = lds_exportation.object.terme_code[ll_cpt]
	ls_account_set_code = lds_exportation.object.account_set_code[ll_cpt]
	ls_transport_code = lds_exportation.object.transport_code[ll_cpt]
	ls_billing_cycle = '"' + lds_exportation.object.billing_cycle[ll_cpt] + '"'
	
	ls_ligne = ls_customer_number + "," + ls_customer_name + "," + ls_address_line_1 + "," + ls_address_line_2 + "," + &
		ls_address_line_3 + "," + ls_address_line_4 + "," + ls_postal_code + "," + ls_phone_number + "," + &
		ls_contact + "," + ls_salesperson_code  + "," + ls_limite_credit + "," + ls_interest_option + "," + &
		ls_report_group + "," + ls_CF + "," + ls_terme_code + "," + ls_account_set_code + "," + ls_transport_code + "," + &
		ls_billing_cycle + ","

	ll_rtn = FileWrite(li_FileNum, ls_ligne)
	
END FOR

IF IsValid(lds_exportation) THEN Destroy(lds_exportation)

FileClose(li_FileNum)
end subroutine

public subroutine of_exportfact (string as_pathdb, boolean ab_reprint, date ad_expdate);
date		ld_fact, ld_fact_date
datetime	ldt_fact_date
string	ls_ligne, ls_fichier, ls_fact_no, ls_GroupeFacturation, ls_aFact_No, ls_ccomptant, ls_cie, &
			ls_dcomptant, ls_sql
integer	li_FileNum
long		ll_rtn, ll_nb_row, ll_cpt, ll_no_eleveur, ll_rowcount_d, ll_cpt_d, ll_classe
n_ds		lds_RechH, lds_RechD
dec		ldec_SumOfVENTE, ldec_amount, ldec_tps, ldec_tvq

ld_fact = date(em_date.text)

st_message.text = "Sélectionne les factures..."

SetPointer(HourGlass!)
gnv_app.of_Cree_TableFact_Temp("Temp_export_StatFacture")

INSERT INTO #Temp_export_StatFacture 
SELECT * FROM T_StatFacture 
WHERE (((Month(FACT_DATE)) = Month(:ld_fact) ) And ((Year(FACT_DATE)) = Year(:ld_fact) )) ;
COMMIT USING SQLCA;

INSERT INTO #Temp_export_StatFactureDetail 
SELECT T_StatFactureDetail.* 
FROM #Temp_export_StatFacture INNER JOIN T_StatFactureDetail 
ON (#Temp_export_StatFacture.LIV_NO = T_StatFactureDetail.LIV_NO) AND (#Temp_export_StatFacture.CIE_NO = T_StatFactureDetail.CIE_NO);
COMMIT USING SQLCA;

DELETE FROM t_StatFacture_Detail_AccPaK;
COMMIT USING SQLCA;

//Ancien Qry_tblStatFacture_Detail_AccPaK_Ajout
INSERT INTO t_StatFacture_Detail_AccPaK ( FACT_DATE, FACT_NO, No_Eleveur, NoClasse, cie, GL, NoProduit, Amount )
SELECT DISTINCT
#Temp_export_StatFacture.FACT_DATE, 
#Temp_export_StatFacture.FACT_NO, 
#Temp_export_StatFacture.No_Eleveur, 
t_CompteAccPack.NoClasse, 
If IsNull(t_Transport.NoClasse,t_produit.NoClasse) = 19 And actif = 0 then
	IsNull(t_verrat.CIE_NO,#Temp_export_StatFactureDetail.CIE_NO)
ELSE
	#Temp_export_StatFactureDetail.CIE_NO 
ENDIF AS cie, 
CComptant + '-' + DComptant AS GL, 
t_produit.NoProduit,
(qte_exp * UPrix) AS Amount
FROM ( #Temp_export_StatFacture 
INNER JOIN ((#Temp_export_StatFactureDetail 
LEFT JOIN t_Transport ON (#Temp_export_StatFactureDetail.PROD_NO) = (t_Transport.CodeTransport)) 
LEFT JOIN ( t_produit 
LEFT JOIN t_verrat ON (substring(t_produit.noproduit,5))  = (t_verrat.CodeVerrat) AND t_verrat.CodeVerrat <> '1') 
ON (#Temp_export_StatFactureDetail.PROD_NO) = (t_produit.NoProduit)) 
ON (#Temp_export_StatFacture.LIV_NO = #Temp_export_StatFactureDetail.LIV_NO) AND (#Temp_export_StatFacture.CIE_NO = #Temp_export_StatFactureDetail.CIE_NO) ) 
INNER JOIN t_CompteAccPack 
ON ((IsNull(t_Transport.NoClasse,t_produit.NoClasse)) = (t_CompteAccPack.NoClasse)) 
AND ( (IF t_CompteAccPack.NoClasse = 19 And actif = 0 THEN IsNull(t_verrat.CIE_NO,#Temp_export_StatFactureDetail.CIE_NO) ELSE #Temp_export_StatFactureDetail.CIE_NO ENDIF)  = t_CompteAccPack.NoCie)
WHERE qte_exp * UPrix <> 0 ;
COMMIT USING SQLCA;

lds_RechH = CREATE n_ds
lds_RechH.dataobject = "ds_rechh"
lds_RechH.of_setTransobject(SQLCA)
lds_RechD = CREATE n_ds
lds_RechD.dataobject = "ds_rechd"
lds_RechD.of_setTransobject(SQLCA)
SetPointer(HourGlass!)

IF THIS.of_apok( ) THEN
	ls_fichier = is_pathdb + "\ARIBATCH.DAT" 
	//si ARIBATCH.DAT existe, il est remplacer automatiquement
	li_FileNum = FileOpen(ls_fichier, LineMode!, Write!, LockWrite!, Replace!) 
	
	ll_nb_row = lds_RechH.Retrieve(ld_fact)
	
	FOR ll_cpt = 1 TO ll_nb_row
		
		SetPointer(HourGlass!)
		
		ls_fact_no = lds_RechH.object.fact_no[ll_cpt]
		st_message.text = "Exportation de la facture # " + ls_fact_no
		
		SetPointer(HourGlass!)
		do while yield()
		loop
		
		ll_no_eleveur = long(lds_RechH.object.no_eleveur[ll_cpt])
		ls_ligne = "~"I~",~"" + Space(6 - LEN(string(ll_no_eleveur))) + string(ll_no_eleveur) + "~",~""
		
		ls_GroupeFacturation = lds_RechH.object.cf_getgroupefacturation[ll_cpt]
		
		IF IsNull(ls_GroupeFacturation) OR ls_GroupeFacturation = "" THEN
			ls_aFact_No = ls_FACT_NO
		ELSE
			ls_aFact_No = ls_FACT_NO + "-" + ls_GroupeFacturation
		END IF
		
		ls_ligne = ls_ligne + space(12 - len(ls_aFact_No)) + ls_aFact_No + "~",~""
		ldec_SumOfVENTE = lds_RechH.object.sumofvente[ll_cpt]
		IF ldec_SumOfVENTE > 0 THEN
			ls_ligne = ls_ligne + "IN~","
		ELSE
			ls_ligne = ls_ligne + "CN~","
		END IF
		ls_ligne = ls_ligne + "~"~","
		ls_ligne = ls_ligne + "~""
		
		ld_fact_date = date(lds_RechH.object.fact_date[ll_cpt])
		ls_ligne = ls_ligne + STRING(ld_fact_date, "yymmdd") + "~","
		ls_ligne = ls_ligne + "~"~","
		ls_ligne = ls_ligne + "~"~",~""
		ls_ligne = ls_ligne + STRING(relativedate(ld_fact_date,30), "yymmdd") + "~","
		ls_ligne = ls_ligne + "~"" + STRING(ld_fact_date, "yymmdd") + "~","
		ls_ligne = ls_ligne + "0.00,0.00,~"~",~"~",~"~",~"~",0.00"

		ll_rtn = FileWrite(li_FileNum, ls_ligne)
		
		ll_rowcount_d = lds_RechD.Retrieve(ld_fact, ls_FACT_NO)
		FOR ll_cpt_d = 1 TO ll_rowcount_d
			
			SetPointer(HourGlass!)
			
			ll_classe = lds_RechD.object.classe[ll_cpt_d]
			ls_cie = lds_RechD.object.cie[ll_cpt_d]
			
			SELECT 	CComptant, DComptant
			INTO		:ls_ccomptant, :ls_dcomptant
			FROM		t_compteaccpack
			WHERE		noclasse = :ll_classe AND nocie = :ls_cie ;
			
			ls_ligne = "~"D~",~"~",~""
			If Not Isnull(ls_ccomptant) THEN
				ls_ligne = ls_ligne + space(6 - len(ls_ccomptant)) + ls_ccomptant
			ELSE
				ls_ligne = ls_ligne + space(6)
			END IF
			
			ls_ligne = ls_ligne + "~",~""
			If Not Isnull(ls_dcomptant) THEN
				ls_ligne = ls_ligne + space(6 - len(ls_dcomptant)) + ls_dcomptant
			ELSE
				ls_ligne = ls_ligne + space(6)
			END IF
			
			ls_ligne = ls_ligne + "~","
			
			ldec_amount = lds_RechD.object.amount[ll_cpt_d]
			
			ls_ligne = ls_ligne + string(ldec_amount, "0.00" ) + ",0,0.00" 
			
			ll_rtn = FileWrite(li_FileNum, ls_ligne)
		END FOR
		
		ls_ligne = "~"D~",~"~",~""
		ls_ligne = ls_ligne + "  2210~",~"      ~""
		ls_ligne = ls_ligne + ","
		ldec_tps = lds_RechH.object.tps[ll_cpt]
		ls_ligne = ls_ligne + string(ldec_tps, "0.00")
		ls_ligne = ls_ligne + ",0,0.00"
		
		ll_rtn = FileWrite(li_FileNum, ls_ligne)
		
		ldt_fact_date = datetime(ld_fact_date)
		
		//Ajouter à la table t_StatFacture_Detail_AccPaK
		INSERT INTO t_StatFacture_Detail_AccPaK (fact_date, fact_no, no_eleveur, cie, gl, noproduit, amount)
		VALUES (:ldt_fact_date, :ls_fact_no, :ll_no_eleveur, :ls_cie, "2210", "TPS", ldec_tps)
		USING SQLCA;
		
		COMMIT USING SQLCA;
		
		ls_ligne = "~"D~",~"~",~""
		ls_ligne = ls_ligne + "  2208~",~"      ~""
		ls_ligne = ls_ligne + ","
		ldec_tvq = lds_RechH.object.tvq[ll_cpt]
		ls_ligne = ls_ligne + string(ldec_tvq, "0.00")
		ls_ligne = ls_ligne + ",0,0.00" 
		
		ll_rtn = FileWrite(li_FileNum, ls_ligne)
		
		ldt_fact_date = datetime(ld_fact_date)
		
		//Ajouter à la table t_StatFacture_Detail_AccPaK
		INSERT INTO t_StatFacture_Detail_AccPaK (fact_date, fact_no, no_eleveur, cie, gl, noproduit, amount)
		VALUES (:ldt_fact_date, :ls_fact_no, :ll_no_eleveur, :ls_cie, "2208", "TVQ", ldec_tvq)
		USING SQLCA;
		
		COMMIT USING SQLCA;
		
	END FOR
		
	FileClose(li_FileNum)
	
	If Not ab_RePrint Then
		UPDATE 	T_StatFacture SET Accpac_Date = FACT_DATE
		WHERE 	FACT_DATE = :ld_fact USING SQLCA;
		COMMIT USING SQLCA;
	END IF
	
END IF

ls_sql = "drop table #Temp_export_StatFactureDetail"
execute immediate :ls_sql using SQLCA;
ls_sql = "drop table #Temp_export_StatFacture"
execute immediate :ls_sql using SQLCA;

IF IsValid(lds_RechH) THEN Destroy(lds_RechH)
IF IsValid(lds_RechD) THEN Destroy(lds_RechD)

st_message.text = "Exportation terminée"
end subroutine

public function boolean of_apok ();//of_apok

boolean 	lb_ApOk = True
date		ld_cur
long		ll_cpt, ll_nb_row, ll_count, ll_classe
n_ds		lds_apok
string	ls_cie

ld_cur = date(em_date.text)

st_message.text = "Valide les factures..."

lds_apok = CREATE n_ds
lds_apok.dataobject = "ds_apok"
lds_apok.of_setTransobject(SQLCA)
ll_nb_row = lds_apok.Retrieve(ld_cur)

SetPointer(HourGlass!)
FOR ll_cpt = 1 TO ll_nb_row
	ls_cie = lds_apok.object.cie[ll_cpt]
	ll_classe = lds_apok.object.classe[ll_cpt]
	
	SELECT 	count(NoCie) INTO :ll_count FROM t_CompteAccPack 
	WHERE  	NoCie = :ls_cie AND NoClasse = :ll_classe ;
				  
	IF ll_count = 0 THEN
		gnv_app.inv_error.of_message("CIPQ0127",{ls_cie, string(ll_classe)})
		RETURN FALSE
	END IF
	
END FOR

IF IsValid(lds_apok) THEN Destroy(lds_apok)

RETURN TRUE
end function

on w_exportation_facture.create
int iCurrent
call super::create
this.em_date=create em_date
this.uo_toolbar=create uo_toolbar
this.cb_exportation=create cb_exportation
this.cbx_re=create cbx_re
this.cb_sommaire=create cb_sommaire
this.cb_detail=create cb_detail
this.cb_dernier=create cb_dernier
this.cb_som=create cb_som
this.dw_compte_exportation=create dw_compte_exportation
this.em_montant=create em_montant
this.st_message=create st_message
this.cb_1=create cb_1
this.gb_1=create gb_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_date
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.cb_exportation
this.Control[iCurrent+4]=this.cbx_re
this.Control[iCurrent+5]=this.cb_sommaire
this.Control[iCurrent+6]=this.cb_detail
this.Control[iCurrent+7]=this.cb_dernier
this.Control[iCurrent+8]=this.cb_som
this.Control[iCurrent+9]=this.dw_compte_exportation
this.Control[iCurrent+10]=this.em_montant
this.Control[iCurrent+11]=this.st_message
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.rr_1
end on

on w_exportation_facture.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_date)
destroy(this.uo_toolbar)
destroy(this.cb_exportation)
destroy(this.cbx_re)
destroy(this.cb_sommaire)
destroy(this.cb_detail)
destroy(this.cb_dernier)
destroy(this.cb_som)
destroy(this.dw_compte_exportation)
destroy(this.em_montant)
destroy(this.st_message)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

dw_compte_exportation.InsertRow(0)

em_date.text = gnv_app.inv_entrepotglobal.of_retournedonnee("date exportation fact")

em_montant.text = string(of_TransAmount(), "###,###.00 $")

is_pathdb = gnv_app.of_getvaleurini("ACCPAC", "ACCPAC_IMP_DIR")

IF IsNull(is_pathdb) OR is_pathdb = "" THEN
	is_pathdb = GetCurrentDirectory()
	If Right(is_pathdb, 1) <> "\" Then is_pathdb = is_pathdb + "\"
END IF
end event

type st_title from w_sheet_frame`st_title within w_exportation_facture
string text = "Transfert vers Accpac"
end type

type p_8 from w_sheet_frame`p_8 within w_exportation_facture
integer x = 55
integer y = 44
integer width = 123
integer height = 96
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\anim1.gif"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_exportation_facture
end type

type em_date from u_em within w_exportation_facture
integer x = 485
integer y = 376
integer width = 539
integer height = 128
integer taborder = 20
boolean bringtotop = true
integer textsize = -14
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

event modified;call super::modified;em_montant.text = string(of_TransAmount(), "###,###.00 $")
end event

type uo_toolbar from u_cst_toolbarstrip within w_exportation_facture
event destroy ( )
integer x = 4064
integer y = 2028
integer width = 507
integer taborder = 90
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type cb_exportation from commandbutton within w_exportation_facture
integer x = 2126
integer y = 356
integer width = 2208
integer height = 136
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Exportation des factures"
end type

event clicked;//Exportation des factures

date		ld_fact

ld_fact = DATE(em_date.text)

IF IsNull(ld_fact) OR ld_fact = 1900-01-01 THEN
	gnv_app.inv_error.of_message("CIPQ0124")
	RETURN	
END IF

IF gnv_app.inv_error.of_message("CIPQ0125", {em_date.text}) = 1 THEN
	
	SetPointer(HourGlass!)
	PARENT.of_exporteleveur( )
	
	SetPointer(HourGlass!)
	Parent.of_exportfact( is_pathdb, cbx_re.checked, ld_fact)
	
END IF
end event

type cbx_re from u_cbx within w_exportation_facture
integer x = 279
integer y = 764
integer width = 754
integer height = 68
integer taborder = 30
boolean bringtotop = true
integer textsize = -14
fontcharset fontcharset = ansi!
long backcolor = 15793151
string text = "Re-transférer"
end type

type cb_sommaire from commandbutton within w_exportation_facture
integer x = 2126
integer y = 592
integer width = 2208
integer height = 136
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
string text = "AccPack: Imprimer le sommaire mensuel"
end type

event clicked;//AccPack: Imprimer le sommaire mensuel

date		ld_cur

ld_cur = date(em_date.text)

SetPointer(HourGlass!)

//Vider tables d'extraction
gnv_app.of_Cree_TableFact_Temp("temp_acc_som_statfacture")

INSERT INTO #temp_acc_som_statfacture SELECT T_StatFacture.* FROM T_StatFacture 
WHERE 	date(t_StatFacture.FACT_DATE) = :ld_cur USING SQLCA;
COMMIT USING SQLCA;

INSERT INTO #temp_acc_som_statfactureDetail SELECT t_StatFactureDetail.* FROM #temp_acc_som_statfacture 
INNER JOIN t_StatFactureDetail ON (#temp_acc_som_statfacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (#temp_acc_som_statfacture.CIE_NO = t_StatFactureDetail.CIE_NO) USING SQLCA;
COMMIT USING SQLCA;

gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien sommaire mensuel", string(ld_cur))

//Ouvrir l'interface
w_r_accpac_sommaire	lw_fen
SetPointer(HourGlass!)
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
end event

type cb_detail from commandbutton within w_exportation_facture
integer x = 2126
integer y = 828
integer width = 2208
integer height = 136
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "AccPack: Imprimer le détail mensuel"
end type

event clicked;//AccPack: Imprimer le détail mensuel

date		ld_cur
string	ls_compte
ld_cur = date(em_date.text)

IF Isnull(ld_cur) THEN RETURN

SetPointer(HourGlass!)

//Vider tables d'extraction
gnv_app.of_Cree_TableFact_Temp("temp_acc_det_statfacture")

INSERT 	INTO #temp_acc_det_statfacture
SELECT 	T_StatFacture.* FROM T_StatFacture
WHERE 	date(T_StatFacture.FACT_DATE) = :ld_cur USING SQLCA;
COMMIT USING SQLCA;

INSERT INTO #temp_acc_det_statfactureDetail
SELECT T_StatFactureDetail.*
FROM	 #temp_acc_det_statfacture
INNER JOIN T_StatFactureDetail
ON (#temp_acc_det_statfacture.LIV_NO = T_StatFactureDetail.LIV_NO) AND (#temp_acc_det_statfacture.CIE_NO = T_StatFactureDetail.CIE_NO)
USING SQLCA;
COMMIT USING SQLCA;

ls_compte = dw_compte_exportation.object.compte[1]
IF Not IsNull(ls_compte) AND ls_compte <> "" THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien detail mensuel compte",ls_compte)
ELSE
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien detail mensuel compte", "")
END IF
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien detail mensuel", string(ld_cur))

//Ouvrir l'interface
w_r_accpac_detail	lw_fen
SetPointer(HourGlass!)
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
end event

type cb_dernier from commandbutton within w_exportation_facture
integer x = 2126
integer y = 1064
integer width = 2208
integer height = 136
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "AccPack: Imprimer le détail mensuel tel que le dernier transfert"
end type

event clicked;//AccPack: Imprimer le détail mensuel tel que le dernier transfert

date		ld_cur
string	ls_compte
ld_cur = date(em_date.text)

IF Isnull(ld_cur) THEN RETURN

SetPointer(HourGlass!)

ls_compte = dw_compte_exportation.object.compte[1]
IF Not IsNull(ls_compte) AND ls_compte <> "" THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien detail mensuel dernier transfert compte",ls_compte)
ELSE
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien detail mensuel dernier transfert compte", "")
END IF
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien detail mensuel dernier transfert ", string(ld_cur))

//Ouvrir l'interface
w_r_accpac_detail_export	lw_fen
SetPointer(HourGlass!)
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
end event

type cb_som from commandbutton within w_exportation_facture
integer x = 2126
integer y = 1300
integer width = 2208
integer height = 136
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "AccPack: Imprimer le détail mensuel tel que le dernier transfert (sommaire)"
end type

event clicked;//AccPack: Imprimer le détail mensuel tel que le dernier transfert (sommaire)

date		ld_cur
string	ls_compte
ld_cur = date(em_date.text)

IF Isnull(ld_cur) THEN RETURN

SetPointer(HourGlass!)

ls_compte = dw_compte_exportation.object.compte[1]
IF Not IsNull(ls_compte) AND ls_compte <> "" THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien sommaire mensuel dernier transfert compte",ls_compte)
ELSE
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien sommaire mensuel dernier transfert compte", "")
END IF
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien sommaire mensuel dernier transfert ", string(ld_cur))
//Ouvrir l'interface
w_r_accpac_sommaire_export	lw_fen
SetPointer(HourGlass!)
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
end event

type dw_compte_exportation from u_dw within w_exportation_facture
integer x = 155
integer y = 984
integer width = 1175
integer height = 132
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_compte_exportation"
boolean vscrollbar = false
boolean livescroll = false
end type

type em_montant from u_em within w_exportation_facture
integer x = 101
integer y = 1272
integer width = 1339
integer height = 164
integer taborder = 0
boolean bringtotop = true
integer textsize = -24
fontcharset fontcharset = ansi!
alignment alignment = center!
borderstyle borderstyle = stylebox!
string mask = "###,###.00 $"
end type

type st_message from statictext within w_exportation_facture
integer x = 101
integer y = 1536
integer width = 4389
integer height = 392
boolean bringtotop = true
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217856
long backcolor = 15793151
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_exportation_facture
integer x = 2126
integer y = 1516
integer width = 2203
integer height = 136
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "AccPack: Imprimer le sommaire des ventes et taxes mensuel"
end type

event clicked;//AccPack: Imprimer le détail mensuel

date		ld_cur
string	ls_compte
ld_cur = date(em_date.text)

IF Isnull(ld_cur) THEN RETURN

SetPointer(HourGlass!)

//Vider tables d'extraction
gnv_app.of_Cree_TableFact_Temp("temp_acc_som_statfacture")

INSERT 	INTO #temp_acc_som_statfacture
SELECT 	T_StatFacture.* FROM T_StatFacture
WHERE 	date(T_StatFacture.FACT_DATE) = :ld_cur USING SQLCA;
COMMIT USING SQLCA;

//Vider tables d'extraction
gnv_app.of_Cree_TableFact_Temp("temp_acc_som_statfactureDetail")

INSERT INTO #temp_acc_som_statfactureDetail
SELECT T_StatFactureDetail.*
FROM	 #temp_acc_som_statfacture
INNER JOIN T_StatFactureDetail
ON (#temp_acc_som_statfacture.LIV_NO = T_StatFactureDetail.LIV_NO) AND (#temp_acc_som_statfacture.CIE_NO = T_StatFactureDetail.CIE_NO)
USING SQLCA;
COMMIT USING SQLCA;

gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien detail mensuel", string(ld_cur))

//Ouvrir l'interface
w_r_accpac_detail_tvh lw_fen
SetPointer(HourGlass!)
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)

end event

type gb_1 from groupbox within w_exportation_facture
integer x = 101
integer y = 236
integer width = 1339
integer height = 368
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Date de facturation"
end type

type rr_1 from roundrectangle within w_exportation_facture
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 184
integer width = 4549
integer height = 1780
integer cornerheight = 40
integer cornerwidth = 46
end type


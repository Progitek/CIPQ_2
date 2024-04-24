$PBExportHeader$w_frequence_recolte_famille.srw
forward
global type w_frequence_recolte_famille from w_sheet_frame
end type
type uo_toolbar from u_cst_toolbarstrip within w_frequence_recolte_famille
end type
type dw_verrat_famille_frequence_recolte from u_dw within w_frequence_recolte_famille
end type
type st_1 from statictext within w_frequence_recolte_famille
end type
type st_2 from statictext within w_frequence_recolte_famille
end type
type st_3 from statictext within w_frequence_recolte_famille
end type
type st_4 from statictext within w_frequence_recolte_famille
end type
type st_5 from statictext within w_frequence_recolte_famille
end type
type st_6 from statictext within w_frequence_recolte_famille
end type
type st_7 from statictext within w_frequence_recolte_famille
end type
type st_8 from statictext within w_frequence_recolte_famille
end type
type st_9 from statictext within w_frequence_recolte_famille
end type
type dw_verrat_famille_frequence_recolte_112 from u_dw within w_frequence_recolte_famille
end type
type dw_verrat_famille_frequence_recolte_114 from u_dw within w_frequence_recolte_famille
end type
type dw_verrat_famille_frequence_recolte_115 from u_dw within w_frequence_recolte_famille
end type
type dw_verrat_famille_frequence_recolte_116 from u_dw within w_frequence_recolte_famille
end type
type dw_verrat_famille_frequence_rec_moyenne from u_dw within w_frequence_recolte_famille
end type
type dw_verrat_famille_frequence_recolte_118 from u_dw within w_frequence_recolte_famille
end type
type st_10 from statictext within w_frequence_recolte_famille
end type
type st_11 from statictext within w_frequence_recolte_famille
end type
type rr_1 from roundrectangle within w_frequence_recolte_famille
end type
type ln_1 from line within w_frequence_recolte_famille
end type
type dw_verrat_famille_frequence_recolte_113 from u_dw within w_frequence_recolte_famille
end type
type dw_verrat_famille_frequence_recolte_119 from u_dw within w_frequence_recolte_famille
end type
end forward

global type w_frequence_recolte_famille from w_sheet_frame
string tag = "menu=m_frequences"
integer x = 214
integer y = 221
uo_toolbar uo_toolbar
dw_verrat_famille_frequence_recolte dw_verrat_famille_frequence_recolte
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
dw_verrat_famille_frequence_recolte_112 dw_verrat_famille_frequence_recolte_112
dw_verrat_famille_frequence_recolte_114 dw_verrat_famille_frequence_recolte_114
dw_verrat_famille_frequence_recolte_115 dw_verrat_famille_frequence_recolte_115
dw_verrat_famille_frequence_recolte_116 dw_verrat_famille_frequence_recolte_116
dw_verrat_famille_frequence_rec_moyenne dw_verrat_famille_frequence_rec_moyenne
dw_verrat_famille_frequence_recolte_118 dw_verrat_famille_frequence_recolte_118
st_10 st_10
st_11 st_11
rr_1 rr_1
ln_1 ln_1
dw_verrat_famille_frequence_recolte_113 dw_verrat_famille_frequence_recolte_113
dw_verrat_famille_frequence_recolte_119 dw_verrat_famille_frequence_recolte_119
end type
global w_frequence_recolte_famille w_frequence_recolte_famille

forward prototypes
public subroutine of_calculertotaux (long al_row)
public subroutine of_chargernbdose (u_dw ldw_current)
public subroutine of_verifier ()
end prototypes

public subroutine of_calculertotaux (long al_row);long 		ll_total_moyenne, ll_row_moy, ll_moy01 = 0, ll_moy02 = 0, ll_moy03 = 0, ll_moy04 = 0, &
			ll_moy05 = 0, ll_moy06 = 0, ll_moytot = 0, ll_nbverrat, ll_nbprelevement = 0, ll_row
string	ls_famille
dec		ldec_frequence = 0.00, ldec_nb_dose = 0.00

ldec_nb_dose = dw_verrat_famille_frequence_recolte.object.cf_nb_doses[al_row]
ls_famille = dw_verrat_famille_frequence_recolte.object.famille[al_row]

ll_row_moy = dw_verrat_famille_frequence_rec_moyenne.GetRow()
IF ll_row_moy > 0 THEN
	ll_total_moyenne = dw_verrat_famille_frequence_rec_moyenne.object.cf_total_moyenne[ll_row_moy]
	ll_moy01 = dw_verrat_famille_frequence_rec_moyenne.object.sem1[ll_row_moy]
	ll_moy02 = dw_verrat_famille_frequence_rec_moyenne.object.sem2[ll_row_moy]
	ll_moy03 = dw_verrat_famille_frequence_rec_moyenne.object.sem3[ll_row_moy]
	ll_moy04 = dw_verrat_famille_frequence_rec_moyenne.object.sem4[ll_row_moy]
	ll_moy05 = dw_verrat_famille_frequence_rec_moyenne.object.sem5[ll_row_moy]
	ll_moy06 = dw_verrat_famille_frequence_rec_moyenne.object.sem6[ll_row_moy]
	ll_moytot = dw_verrat_famille_frequence_rec_moyenne.object.cf_total_moyenne[ll_row_moy]
END IF

IF Not IsNull(ldec_nb_dose) AND ldec_nb_dose > 0 THEN
	ll_nbprelevement = ROUND(ll_total_moyenne / ldec_nb_dose, 2)
	dw_verrat_famille_frequence_recolte.object.cc_nb_prelevement[al_row] = ll_nbprelevement
END IF
	
ll_nbverrat = gnv_app.of_findnbverratfamille( ls_famille)
IF IsNull(ll_nbverrat) THEN 
	ll_nbverrat = 0
	ldec_frequence = 0
ELSE
	IF ll_nbverrat > 0 THEN
		ldec_frequence = truncate(ll_nbprelevement / ll_nbverrat, 2)
	ELSE
		ldec_frequence = 0
	END IF
END IF
dw_verrat_famille_frequence_recolte.object.cc_besoinnbverrat[al_row] = ll_nbverrat
dw_verrat_famille_frequence_recolte.object.cc_frequence[al_row] = ldec_frequence

IF ldec_nb_dose > 0 AND Not IsNull(ldec_nb_dose) THEN
	dw_verrat_famille_frequence_recolte.object.cc_besoinquantite_01[al_row] = round(ll_moy01 / ldec_nb_dose, 0)
	dw_verrat_famille_frequence_recolte.object.cc_besoinquantite_02[al_row] = round(ll_moy02 / ldec_nb_dose, 0)
	dw_verrat_famille_frequence_recolte.object.cc_besoinquantite_03[al_row] = round(ll_moy03 / ldec_nb_dose, 0)
	dw_verrat_famille_frequence_recolte.object.cc_besoinquantite_04[al_row] = round(ll_moy04 / ldec_nb_dose, 0)
	dw_verrat_famille_frequence_recolte.object.cc_besoinquantite_05[al_row] = round(ll_moy05 / ldec_nb_dose, 0)
	dw_verrat_famille_frequence_recolte.object.cc_besoinquantite_06[al_row] = round(ll_moy06 / ldec_nb_dose, 0)
	dw_verrat_famille_frequence_recolte.object.cc_besoinquantite_total[al_row] = round(ll_moytot / ldec_nb_dose, 0)
END IF
end subroutine

public subroutine of_chargernbdose (u_dw ldw_current);long		ll_row_centre, ll_row, ll_count, ll_qte, ll_NbDoseMoyenne, ll_qteCumul, &
			ll_quantite_01 = 0, ll_quantite_02 = 0, ll_quantite_03 = 0, ll_quantite_04 = 0, &
			ll_quantite_05 = 0, ll_quantite_06 = 0, ll_find
string	ls_cie, ls_famille
dec		ldec_frequence = 0.00, ldec_ratio1, ldec_ratio2, ldec_ratio3, ldec_ratio4, ldec_ratio5, &
			ldec_ratio6

ll_row_centre = ldw_current.GetRow()
ll_row = dw_verrat_famille_frequence_recolte.GetRow()
IF ll_row_centre > 0 AND ll_row > 0 THEN
	ls_famille = dw_verrat_famille_frequence_recolte.object.famille[ll_row]
	ls_cie = ldw_current.object.cie_no[ll_row_centre]
	
	//MAJ du nombre de verrat dans cette famille pour ce centre
	SELECT Count(T_Verrat.CodeVerrat)
	INTO	:ll_count
	FROM T_Verrat, t_Verrat_Classe
	WHERE T_Verrat.Classe = t_Verrat_Classe.ClasseVerrat AND t_Verrat_Classe.Famille = :ls_famille AND 
	t_Verrat.CIE_NO=:ls_cie AND T_Verrat.ELIMIN Is Null USING SQLCA;

	If IsNull(ll_count) THEN ll_count = 0
	
	ldec_frequence = ldw_current.object.frequence[ll_row_centre]
	IF IsNull(ldec_frequence) OR ldec_frequence < 0 THEN
		ldec_frequence = 1
		ldw_current.object.frequence[ll_row_centre] = 1
	ELSE
		ldec_frequence = truncate(ldec_frequence, 2)
		ldw_current.object.frequence[ll_row_centre] = ldec_frequence
	END IF
	
	ldw_current.object.nbverrat[ll_row_centre] = ll_count
	//ll_NbDoseMoyenne = ldw_current.object.nbdosemoyenne[ll_row_centre]
	//If IsNull(ll_NbDoseMoyenne) THEN
		ll_NbDoseMoyenne = gnv_app.of_getnbdosesmoyenne()
		ldw_current.object.nbdosemoyenne[ll_row_centre] = ll_NbDoseMoyenne
	//END IF
	
	//Calcul selon NbVerrat et Frequence
	ll_qte = round(ldec_frequence * ll_count,0)
	ll_quantite_01 = ldw_current.object.quantite_01[ll_row_centre]
	If IsNull(ll_quantite_01) THEN ll_quantite_01 = 0
	ll_quantite_02 = ldw_current.object.quantite_02[ll_row_centre]
	If IsNull(ll_quantite_02) THEN ll_quantite_02 = 0
	ll_quantite_03 = ldw_current.object.quantite_03[ll_row_centre]
	If IsNull(ll_quantite_03) THEN ll_quantite_03 = 0
	ll_quantite_04 = ldw_current.object.quantite_04[ll_row_centre]
	If IsNull(ll_quantite_04) THEN ll_quantite_04 = 0
	ll_quantite_05 = ldw_current.object.quantite_05[ll_row_centre]
	If IsNull(ll_quantite_05) THEN ll_quantite_05 = 0
	ll_qteCumul = ll_quantite_01 + ll_quantite_02 + ll_quantite_03 + ll_quantite_04 + ll_quantite_05
	ll_quantite_06 = round(ll_qte - ll_qteCumul,0)
	ldw_current.object.quantite_06[ll_row_centre] = ll_quantite_06
	
	//Calcul des doses récoltables
	
//	ldw_current.object.nb_dose_01[ll_row_centre] = ll_quantite_01 * ll_NbDoseMoyenne
//	ldw_current.object.nb_dose_02[ll_row_centre] = ll_quantite_02 * ll_NbDoseMoyenne
//	ldw_current.object.nb_dose_03[ll_row_centre] = ll_quantite_03 * ll_NbDoseMoyenne
//	ldw_current.object.nb_dose_04[ll_row_centre] = ll_quantite_04 * ll_NbDoseMoyenne
//	ldw_current.object.nb_dose_05[ll_row_centre] = ll_quantite_05 * ll_NbDoseMoyenne
//	ldw_current.object.nb_dose_06[ll_row_centre] = ll_quantite_06 * ll_NbDoseMoyenne
	
	ldec_ratio1 = ldw_current.object.ratio1[ll_row_centre]
	ldec_ratio2 = ldw_current.object.ratio2[ll_row_centre]
	ldec_ratio3 = ldw_current.object.ratio3[ll_row_centre]
	ldec_ratio4 = ldw_current.object.ratio4[ll_row_centre]
	ldec_ratio5 = ldw_current.object.ratio5[ll_row_centre]
	ldec_ratio6 = ldw_current.object.ratio6[ll_row_centre]
	
	ldw_current.object.nb_dose_01[ll_row_centre] = ll_quantite_01 * ldec_ratio1
	ldw_current.object.nb_dose_02[ll_row_centre] = ll_quantite_02 * ldec_ratio2
	ldw_current.object.nb_dose_03[ll_row_centre] = ll_quantite_03 * ldec_ratio3
	ldw_current.object.nb_dose_04[ll_row_centre] = ll_quantite_04 * ldec_ratio4
	ldw_current.object.nb_dose_05[ll_row_centre] = ll_quantite_05 * ldec_ratio5
	ldw_current.object.nb_dose_06[ll_row_centre] = ll_quantite_06 * ldec_ratio6
	
	//Un requery
	ldw_current.Update(TRUE,TRUE)
	COMMIT USING SQLCA;
	
	dw_verrat_famille_frequence_recolte.event pfc_retrieve()
	ll_find = dw_verrat_famille_frequence_recolte.find( "famille='" + ls_famille + "'", 1, dw_verrat_famille_frequence_recolte.RowCount())
	dw_verrat_famille_frequence_recolte.SetRow(ll_find)
	dw_verrat_famille_frequence_recolte.ScrollToRow(ll_find)

	THIS.of_calculertotaux(ll_row)
	
	ldw_current.Post SetFocus()
END IF

gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat_Famille_Frequence_Recolte", TRUE)
end subroutine

public subroutine of_verifier ();date	ld_de, ld_a//, ld_premier_dimanche
long	ll_dow
n_cst_datetime lnv_datetime

// 2008-12-11 Mathieu Gendron	Ajout des dates
// Du dernier dimanche de la semaine précédente au samedi suivant

//Trouver le prochain dimanche
ll_dow = lnv_datetime.of_dayofweek( date(today()))  //Dimanche = 1

//ld_premier_dimanche = RelativeDate (date(today()), -6 - ll_dow)

//Trouver le dimanche précédent
ld_de = RelativeDate (date(today()), -6 - ll_dow)
ld_a = RelativeDate (date(today()), 0 - ll_dow)

gnv_app.of_verrat_famille_frequence_recolte_vali(ld_de, ld_a)
end subroutine

on w_frequence_recolte_famille.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.dw_verrat_famille_frequence_recolte=create dw_verrat_famille_frequence_recolte
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.dw_verrat_famille_frequence_recolte_112=create dw_verrat_famille_frequence_recolte_112
this.dw_verrat_famille_frequence_recolte_114=create dw_verrat_famille_frequence_recolte_114
this.dw_verrat_famille_frequence_recolte_115=create dw_verrat_famille_frequence_recolte_115
this.dw_verrat_famille_frequence_recolte_116=create dw_verrat_famille_frequence_recolte_116
this.dw_verrat_famille_frequence_rec_moyenne=create dw_verrat_famille_frequence_rec_moyenne
this.dw_verrat_famille_frequence_recolte_118=create dw_verrat_famille_frequence_recolte_118
this.st_10=create st_10
this.st_11=create st_11
this.rr_1=create rr_1
this.ln_1=create ln_1
this.dw_verrat_famille_frequence_recolte_113=create dw_verrat_famille_frequence_recolte_113
this.dw_verrat_famille_frequence_recolte_119=create dw_verrat_famille_frequence_recolte_119
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.dw_verrat_famille_frequence_recolte
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.st_7
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.st_9
this.Control[iCurrent+12]=this.dw_verrat_famille_frequence_recolte_112
this.Control[iCurrent+13]=this.dw_verrat_famille_frequence_recolte_114
this.Control[iCurrent+14]=this.dw_verrat_famille_frequence_recolte_115
this.Control[iCurrent+15]=this.dw_verrat_famille_frequence_recolte_116
this.Control[iCurrent+16]=this.dw_verrat_famille_frequence_rec_moyenne
this.Control[iCurrent+17]=this.dw_verrat_famille_frequence_recolte_118
this.Control[iCurrent+18]=this.st_10
this.Control[iCurrent+19]=this.st_11
this.Control[iCurrent+20]=this.rr_1
this.Control[iCurrent+21]=this.ln_1
this.Control[iCurrent+22]=this.dw_verrat_famille_frequence_recolte_113
this.Control[iCurrent+23]=this.dw_verrat_famille_frequence_recolte_119
end on

on w_frequence_recolte_famille.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.dw_verrat_famille_frequence_recolte)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.dw_verrat_famille_frequence_recolte_112)
destroy(this.dw_verrat_famille_frequence_recolte_114)
destroy(this.dw_verrat_famille_frequence_recolte_115)
destroy(this.dw_verrat_famille_frequence_recolte_116)
destroy(this.dw_verrat_famille_frequence_rec_moyenne)
destroy(this.dw_verrat_famille_frequence_recolte_118)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.rr_1)
destroy(this.ln_1)
destroy(this.dw_verrat_famille_frequence_recolte_113)
destroy(this.dw_verrat_famille_frequence_recolte_119)
end on

event pfc_postopen;call super::pfc_postopen;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Vérifier les familles et recalculer les verrats par centre", "C:\ii4net\CIPQ\images\famille.ico")
uo_toolbar.of_AddItem("Rechercher une famille...", "Search!")
uo_toolbar.of_AddItem("Imprimer...", "Print!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

THIS.of_verifier()

dw_verrat_famille_frequence_recolte.event pfc_retrieve()
end event

type st_title from w_sheet_frame`st_title within w_frequence_recolte_famille
integer x = 219
integer y = 52
integer width = 1943
string text = "Fréquences de récolte des verrats selon leur famille"
end type

type p_8 from w_sheet_frame`p_8 within w_frequence_recolte_famille
integer x = 64
integer y = 36
integer width = 128
integer height = 112
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\bouton_barre_menu_numbered_list.jpg"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_frequence_recolte_famille
integer y = 20
integer height = 140
end type

type uo_toolbar from u_cst_toolbarstrip within w_frequence_recolte_famille
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2204
integer width = 4558
integer height = 108
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long	ll_row

ll_row = dw_verrat_famille_frequence_recolte.GetRow()

CHOOSE CASE as_button
		
	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Vérifier les familles et recalculer les verrats par centre"
		of_verifier()
		Messagebox("Attention", "Veuillez fermer l'interface pour que les changements soient pris en compte.")
		//dw_verrat_famille_frequence_recolte.Retrieve()
		
	CASE "Imprimer..."
		w_r_frequence_recolte_famille	lw_window_v
		
		IF ll_row > 0 THEN
			IF PARENT.event pfc_save() >= 0 THEN
				OpenSheet(lw_window_v, gnv_app.of_GetFrame(), 6, layered!)
			END IF				
		END IF
		
		
	CASE "Rechercher une famille..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_verrat_famille_frequence_recolte.RowCount() > 0 THEN
				dw_verrat_famille_frequence_recolte.SetRow(1)
				dw_verrat_famille_frequence_recolte.ScrollToRow(1)
				dw_verrat_famille_frequence_recolte.event pfc_finddlg()
			END IF
		END IF		

		
END CHOOSE

end event

type dw_verrat_famille_frequence_recolte from u_dw within w_frequence_recolte_famille
integer x = 78
integer y = 216
integer width = 4448
integer height = 1952
integer taborder = 10
boolean bringtotop = true
string title = " "
string dataobject = "d_verrat_famille_frequence_recolte"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)
end event

event pfc_retrieve;call super::pfc_retrieve;datetime	ldt_null, ldt_de, ldt_a
long		ll_row, ll_cpt, ll_null, ll_numdays, ll_numweeks

SetNull(ldt_null)
SetNull(ll_null)

IF THIS.rowcount() = 0 THEN
	RETURN THIS.Retrieve(ldt_null, ldt_null,ll_null)
ELSE
	ll_row = this.getrow()
	IF ll_row > 0 THEN
		ldt_de = THIS.object.cc_date[ll_row]
		ldt_a = THIS.object.cc_fin[ll_row]
		ll_numdays = DaysAfter(date(ldt_de), date(ldt_a))
		if (ll_numdays / 7) = Truncate ((ll_numdays) / 7,0) then
			ll_numweeks = Truncate ((ll_numdays) / 7,0)
		else
			ll_numweeks = Truncate ((ll_numdays) / 7,0) + 1
		end if
		RETURN THIS.Retrieve(ldt_de, ldt_a, ll_numweeks)
	ELSE
		RETURN THIS.Retrieve(ldt_null, ldt_null, ll_null)
	END IF
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;
IF currentrow > 0 THEN
	parent.post of_calculertotaux(currentrow)
END IF
end event

event buttonclicked;call super::buttonclicked;string	ls_famille, ls_famille_temp, ls_famille_prev = ""
date		ld_depart, ld_fin
long		ll_sem1, ll_sem2, ll_sem3, ll_sem4, ll_sem5, ll_sem6, ll_retour, ll_cpt, ll_numdays, ll_numweeks
n_ds		lds_init
n_cst_datetime lnv_datetime

CHOOSE CASE dwo.name 
	CASE "b_calculer"
		IF row > 0 THEN
			THIS.AcceptText()
			ld_depart = date(THIS.object.cc_date[row])
			ld_fin = date(THIS.object.cc_fin[row])
			If DaysAfter ( ld_depart,ld_fin) > 0 then
				if lnv_datetime.of_dayofweek(ld_depart) = 1 then
					if lnv_datetime.of_dayofweek(ld_fin) = 7 then
						SetPointer(HourGlass!)
						
						IF IsNull(ld_depart) OR ld_depart = 1900-01-01 OR IsNull(ld_fin) OR ld_fin = 1900-01-01 THEN
							gnv_app.inv_error.of_message("CIPQ0006",{"Date"})
							THIS.SetColumn("cc_date")
							RETURN
						END IF
						
						ls_famille = THIS.object.famille[row]
						
						//Vider 'T_Demande_CommandeOriginale_Melange_Init' et 'T_MoyenneCommOrig_Mélange_36'
						DELETE FROM t_moyenne_commorig_melange_36 USING SQLCA;
						DELETE FROM T_Demande_CommandeOriginale_Melange_Init USING SQLCA;
						
						//Remplir 'T_Demande_CommandeOriginale_Melange_Init'
						INSERT 	INTO T_Demande_CommandeOriginale_Melange_Init (Famille, Demande, DateCommande) 
						SELECT 	t_Produit.Famille, Sum(t_CommandeOriginale.QteInit) AS Demande, date(t_CommandeOriginale.DateCommande)
						FROM 		t_CommandeOriginale INNER JOIN t_Produit ON 
								 	t_CommandeOriginale.NoProduit = t_Produit.NoProduit  
						WHERE		t_CommandeOriginale.CodeVerrat Is Null AND
									t_Produit.Famille is not null AND 
									date(t_CommandeOriginale.DateCommande) >= :ld_depart AND 
									date(t_CommandeOriginale.DateCommande) <= :ld_fin
						GROUP BY t_Produit.Famille, date(t_CommandeOriginale.DateCommande)
						ORDER BY date(t_CommandeOriginale.DateCommande)
						USING SQLCA;
						
						//2008-11-07 - Mathieu Gendron - Ne pas ajouter les pures, ils sont déjà compilés dans 
						// l'autre: suite à discussion avec Léonard
//						INSERT 	INTO T_Demande_CommandeOriginale_Melange_Init ( Famille, Demande, DateCommande )
//						SELECT 	t_Verrat_Classe.Famille, Sum(t_CommandeOriginale.QteInit) AS Demande, t_CommandeOriginale.DateCommande
//						FROM 		t_Verrat_Classe, t_CommandeOriginale, T_Verrat 
//						WHERE		(t_Verrat_Classe.ClasseVerrat) = (T_Verrat.Classe) AND 
//									(t_CommandeOriginale.CodeVerrat) = (T_Verrat.CodeVerrat) AND
//									(t_CommandeOriginale.DateCommande) >=:ld_depart And 
//									(t_CommandeOriginale.DateCommande) <= :ld_fin
//						GROUP BY t_Verrat_Classe.Famille, t_CommandeOriginale.DateCommande
//						ORDER BY t_CommandeOriginale.DateCommande
//						USING SQLCA;

						
						lds_init = CREATE n_ds
						lds_init.dataobject = "d_somme_sem"
						lds_init.of_setTransobject(SQLCA)
					
						ll_retour = lds_init.Retrieve()
						FOR ll_cpt = 1 TO ll_retour
							ls_famille_temp = lds_init.object.famille[ll_cpt]
							IF ls_famille_temp <> ls_famille_prev THEN
								ll_sem1 = lds_init.object.cf_sem1[ll_cpt]
								ll_sem2 = lds_init.object.cf_sem2[ll_cpt]
								ll_sem3 = lds_init.object.cf_sem3[ll_cpt]
								ll_sem4 = lds_init.object.cf_sem4[ll_cpt]
								ll_sem5 = lds_init.object.cf_sem5[ll_cpt]
								ll_sem6 = lds_init.object.cf_sem6[ll_cpt]
								
								INSERT INTO t_moyenne_commorig_melange_36 (famille, sem1, sem2, sem3, sem4, sem5, sem6) 
								VALUES (:ls_famille_temp, :ll_sem1, :ll_sem2, :ll_sem3, :ll_sem4, :ll_sem5, :ll_sem6) USING SQLCA;
							END IF
						END FOR
						
						If IsValid(lds_init) THEN Destroy(lds_init)
						
						ll_numdays = DaysAfter ( ld_depart, ld_fin )
						
						if (ll_numdays / 7) = Truncate ((ll_numdays) / 7,0) then
							ll_numweeks = Truncate ((ll_numdays) / 7,0)
						else
							ll_numweeks = Truncate ((ll_numdays) / 7,0) + 1
						end if
						
						THIS.event pfc_retrieve()
						dw_verrat_famille_frequence_rec_moyenne.retrieve(ls_famille,ll_numweeks)
						
						THIS.setRow(row)
						THIS.scrolltoRow(row)
						
						gnv_app.inv_error.of_message( "CIPQ0036")
						
						gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat_Famille_Frequence_Recolte", True)
					else
						MessageBox("Attention","La date de fin doit être un Samedi")
					end if
				else
					MessageBox("Attention","La date de début doit être un Dimanche")
				end if
			else
				MessageBox("Attention","La date de début doit être inférieur à la date de fin")
			End if	
		END IF
END CHOOSE
end event

type st_1 from statictext within w_frequence_recolte_famille
integer x = 73
integer y = 428
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Centres"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_frequence_recolte_famille
integer x = 73
integer y = 496
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "112"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_frequence_recolte_famille
integer x = 73
integer y = 660
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "113"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_frequence_recolte_famille
integer x = 73
integer y = 828
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "114"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_frequence_recolte_famille
integer x = 73
integer y = 996
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "115"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_frequence_recolte_famille
integer x = 73
integer y = 1168
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "116"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_frequence_recolte_famille
integer x = 105
integer y = 1696
integer width = 315
integer height = 180
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Résultat CIPQ"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_frequence_recolte_famille
integer x = 91
integer y = 1860
integer width = 398
integer height = 144
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Commandes originales"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_9 from statictext within w_frequence_recolte_famille
integer x = 119
integer y = 2016
integer width = 297
integer height = 136
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "BESOIN CIPQ"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_verrat_famille_frequence_recolte_112 from u_dw within w_frequence_recolte_famille
integer x = 521
integer y = 492
integer width = 3739
integer height = 172
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_verrat_famille_frequence_recolte_112"
boolean vscrollbar = false
boolean ib_insertautomatique = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_verrat_famille_frequence_recolte)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("famille","famille")

end event

event itemchanged;call super::itemchanged;IF row > 0 THEN
	THIS.AcceptText()
	PARENT.POST of_chargernbdose(THIS)
	
END IF
end event

type dw_verrat_famille_frequence_recolte_114 from u_dw within w_frequence_recolte_famille
integer x = 521
integer y = 828
integer width = 3739
integer height = 188
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_verrat_famille_frequence_recolte_114"
boolean vscrollbar = false
boolean ib_insertautomatique = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_verrat_famille_frequence_recolte)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("famille","famille")

end event

event itemchanged;call super::itemchanged;IF row > 0 THEN
	THIS.AcceptText()
	PARENT.POST of_chargernbdose(THIS)
	
END IF
end event

type dw_verrat_famille_frequence_recolte_115 from u_dw within w_frequence_recolte_famille
integer x = 521
integer y = 996
integer width = 3739
integer height = 172
integer taborder = 41
boolean bringtotop = true
string dataobject = "d_verrat_famille_frequence_recolte_115"
boolean vscrollbar = false
boolean ib_insertautomatique = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_verrat_famille_frequence_recolte)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("famille","famille")

end event

event itemchanged;call super::itemchanged;IF row > 0 THEN
	THIS.AcceptText()
	PARENT.POST of_chargernbdose(THIS)
	
END IF
end event

type dw_verrat_famille_frequence_recolte_116 from u_dw within w_frequence_recolte_famille
integer x = 521
integer y = 1164
integer width = 3739
integer height = 200
integer taborder = 51
boolean bringtotop = true
string dataobject = "d_verrat_famille_frequence_recolte_116"
boolean vscrollbar = false
boolean ib_insertautomatique = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_verrat_famille_frequence_recolte)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("famille","famille")

end event

event itemchanged;call super::itemchanged;IF row > 0 THEN
	THIS.AcceptText()
	PARENT.POST of_chargernbdose(THIS)
	
END IF
end event

type dw_verrat_famille_frequence_rec_moyenne from u_dw within w_frequence_recolte_famille
integer x = 521
integer y = 1872
integer width = 3739
integer height = 116
integer taborder = 61
boolean bringtotop = true
string dataobject = "d_verrat_famille_frequence_recolte_moyenne"
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_insertautomatique = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_verrat_famille_frequence_recolte)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("famille","famille")
this.inv_linkage.of_Register("cc_week","cc_week")


end event

type dw_verrat_famille_frequence_recolte_118 from u_dw within w_frequence_recolte_famille
integer x = 521
integer y = 1332
integer width = 3739
integer height = 200
integer taborder = 61
boolean bringtotop = true
string dataobject = "d_verrat_famille_frequence_recolte_118"
boolean vscrollbar = false
boolean ib_insertautomatique = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_verrat_famille_frequence_recolte)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("famille","famille")

end event

event itemchanged;call super::itemchanged;IF row > 0 THEN
	THIS.AcceptText()
	PARENT.POST of_chargernbdose(THIS)
	
END IF
end event

type st_10 from statictext within w_frequence_recolte_famille
integer x = 73
integer y = 1332
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "118"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_11 from statictext within w_frequence_recolte_famille
integer x = 73
integer y = 1496
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "119"
alignment alignment = center!
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_frequence_recolte_famille
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 180
integer width = 4549
integer height = 2004
integer cornerheight = 40
integer cornerwidth = 46
end type

type ln_1 from line within w_frequence_recolte_famille
long linecolor = 12639424
integer linethickness = 15
integer beginx = 169
integer beginy = 716
integer endx = 334
integer endy = 860
end type

type dw_verrat_famille_frequence_recolte_113 from u_dw within w_frequence_recolte_famille
integer x = 521
integer y = 660
integer width = 3739
integer height = 176
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_verrat_famille_frequence_recolte_113"
boolean vscrollbar = false
boolean ib_insertautomatique = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_verrat_famille_frequence_recolte)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("famille","famille")

end event

event itemchanged;call super::itemchanged;IF row > 0 THEN
	THIS.AcceptText()
	PARENT.POST of_chargernbdose(THIS)
	
END IF
end event

type dw_verrat_famille_frequence_recolte_119 from u_dw within w_frequence_recolte_famille
integer x = 521
integer y = 1496
integer width = 3739
integer height = 184
integer taborder = 71
boolean bringtotop = true
string dataobject = "d_verrat_famille_frequence_recolte_119"
boolean vscrollbar = false
boolean ib_insertautomatique = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_verrat_famille_frequence_recolte)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("famille","famille")

end event

event itemchanged;call super::itemchanged;IF row > 0 THEN
	THIS.AcceptText()
	PARENT.POST of_chargernbdose(THIS)
	
END IF
end event


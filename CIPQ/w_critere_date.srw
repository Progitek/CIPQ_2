HA$PBExportHeader$w_critere_date.srw
forward
global type w_critere_date from w_sheet
end type
type em_date from editmask within w_critere_date
end type
type uo_toolbar from u_cst_toolbarstrip within w_critere_date
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date
end type
type st_1 from statictext within w_critere_date
end type
type p_ra from picture within w_critere_date
end type
type rr_2 from roundrectangle within w_critere_date
end type
type rr_1 from roundrectangle within w_critere_date
end type
end forward

global type w_critere_date from w_sheet
integer width = 1376
integer height = 928
string title = "Crit$$HEX1$$e800$$ENDHEX$$res de date"
em_date em_date
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
rr_2 rr_2
rr_1 rr_1
end type
global w_critere_date w_critere_date

type variables
n_cst_datetime	inv_datetime
date	id_debut, id_fin
string	is_nom_fenetre = ""
end variables

on w_critere_date.create
int iCurrent
call super::create
this.em_date=create em_date
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.rr_2=create rr_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_date
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.uo_toolbar_gauche
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.p_ra
this.Control[iCurrent+6]=this.rr_2
this.Control[iCurrent+7]=this.rr_1
end on

on w_critere_date.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_date)
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
uo_toolbar_gauche.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar_gauche.POST of_displaytext(true)

is_nom_fenetre = gnv_app.inv_entrepotglobal.of_retournedonnee("rapport date")
end event

type em_date from editmask within w_critere_date
integer x = 407
integer y = 304
integer width = 544
integer height = 108
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

type uo_toolbar from u_cst_toolbarstrip within w_critere_date
event destroy ( )
integer x = 809
integer y = 636
integer width = 507
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date
event destroy ( )
integer x = 23
integer y = 636
integer width = 507
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;string	ls_date, ls_retour

//B$$HEX1$$e200$$ENDHEX$$tir le filtre
ls_date = em_date.text

IF IsNull(ls_date) OR ls_date = "00-00-0000" OR ls_date = "none"  THEN
	gnv_app.inv_error.of_message("pfc_requiredmissing",{"Date"})
	RETURN
END IF
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", ls_date)


w_r_conciliation_factures_hebergement lw_conciliation_factures_hebergement
w_r_ventes_depots	lw_ventes_depots
w_r_commande lw_commande
w_r_recolte_heure_analyse lw_recolte_heure_analyse
w_r_changement_no_verrat lw_changement_no_verrat
w_r_commandes_journalieres lw_commandes_journalieres
w_r_production_sperm_verrat_depassant_1_semaine lw_production_sperm_verrat_depassant_1_semaine
w_r_production_sperm_verrat_journaliere lw_production_sperm_verrat_journaliere
w_r_commandes_mensuelles lw_commandes_mensuelles
w_r_production_spermatique_mensuelle lw_production_spermatique_mensuelle
w_r_heures_recolte_verrat lw_heures_recolte_verrat
w_r_sommaire_recolte_journ lw_sommaire_recolte_journ
w_r_liste_males_a_recolter lw_liste_males_a_recolter
w_r_liste_males_a_recolter_abrege lw_liste_males_a_recolter_abrege
w_r_sommaire_liste_males_a_recolter lw_sommaire_liste_males_a_recolter
w_r_sommaire_facture_groupe lw_sommaire_facture_groupe
w_r_sommaire_det_facture_groupe lw_sommaire_det_facture_groupe
w_r_som_moy_com_orig_melange lw_som_moy_com_orig_melange
w_r_som_moy_com_orig_melange_ext lw_som_moy_com_orig_melange_ext
w_r_som_moy_com_orig_pure lw_som_moy_com_orig_pure
w_r_transferts_importes lw_transferts_importes
w_r_inventaire_verrat_centre_famille lw_inventaire_verrat_centre_famille
w_r_inventaire_verrats_famille lw_inventaire_verrats_famille
w_r_plan_verraterie_centre_section lw_r_plan_verraterie_centre_section
w_r_plan_verraterie_centre_verrat lw_r_plan_verraterie_centre_verrat
w_r_plan_verraterie_sommaire lw_r_plan_verraterie_sommaire

ls_retour = is_nom_fenetre

//Ouvrir l'interface
SetPointer(HourGlass!)
CHOOSE CASE ls_retour
	CASE "w_r_conciliation_factures_hebergement"
		OpenSheet(lw_conciliation_factures_hebergement, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_ventes_depots"
		OpenSheet(lw_ventes_depots, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_commande"
		OpenSheet(lw_commande, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_recolte_heure_analyse"
		OpenSheet(lw_recolte_heure_analyse, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_changement_no_verrat"
		OpenSheet(lw_changement_no_verrat, gnv_app.of_GetFrame(), 6, layered!)		
	CASE "w_r_commandes_journalieres"
		OpenSheet(lw_commandes_journalieres, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_production_sperm_verrat_depassant_1_semaine"
		OpenSheet(lw_production_sperm_verrat_depassant_1_semaine, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_production_sperm_verrat_journaliere"
		OpenSheet(lw_production_sperm_verrat_journaliere, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_commandes_mensuelles"
		OpenSheet(lw_commandes_mensuelles, gnv_app.of_GetFrame(), 6, layered!)		
	CASE "w_r_production_spermatique_mensuelle"
		OpenSheet(lw_production_spermatique_mensuelle, gnv_app.of_GetFrame(), 6, layered!)		
	CASE "w_r_heures_recolte_verrat"
		OpenSheet(lw_heures_recolte_verrat, gnv_app.of_GetFrame(), 6, layered!)		
	CASE "w_r_sommaire_recolte_journ"
		OpenSheet(lw_sommaire_recolte_journ, gnv_app.of_GetFrame(), 6, layered!)		
	CASE "w_r_liste_males_a_recolter"
		//Valider si la date est un samedi
		IF DayNumber(date(ls_date)) = 7 THEN
			gnv_app.inv_error.of_message("CIPQ0134")
		ELSE
			OpenSheet(lw_liste_males_a_recolter, gnv_app.of_GetFrame(), 6, layered!)		
		END IF
	CASE "w_r_liste_males_a_recolter_abrege"
		//Valider si la date est un samedi
		IF DayNumber(date(ls_date)) = 7 THEN
			gnv_app.inv_error.of_message("CIPQ0134")
		ELSE
			OpenSheet(lw_liste_males_a_recolter_abrege, gnv_app.of_GetFrame(), 6, layered!)		
		END IF
	CASE "w_r_sommaire_liste_males_a_recolter"
		IF DayNumber(date(ls_date)) = 7 THEN
			gnv_app.inv_error.of_message("CIPQ0134")
		ELSE
			OpenSheet(lw_sommaire_liste_males_a_recolter, gnv_app.of_GetFrame(), 6, layered!)		
		END IF
	CASE "w_r_sommaire_facture_groupe"
		OpenSheet(lw_sommaire_facture_groupe, gnv_app.of_GetFrame(), 6, layered!)		
	CASE "w_r_sommaire_det_facture_groupe"
		OpenSheet(lw_sommaire_det_facture_groupe, gnv_app.of_GetFrame(), 6, layered!)		
	CASE "w_r_som_moy_com_orig_melange"
		OpenSheet(lw_som_moy_com_orig_melange, gnv_app.of_GetFrame(), 6, layered!)		
	CASE "w_r_som_moy_com_orig_melange_ext"
		OpenSheet(lw_som_moy_com_orig_melange_ext, gnv_app.of_GetFrame(), 6, layered!)				
	CASE "w_r_som_moy_com_orig_pure"
		OpenSheet(lw_som_moy_com_orig_pure, gnv_app.of_GetFrame(), 6, layered!)				
	CASE "w_r_transferts_importes"
		OpenSheet(lw_transferts_importes, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_inventaire_verrat_centre_famille"
		OpenSheet(lw_inventaire_verrat_centre_famille, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_inventaire_verrats_famille"
		OpenSheet(lw_inventaire_verrats_famille, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_plan_verraterie_centre_section"
		OpenSheet(lw_r_plan_verraterie_centre_section, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_plan_verraterie_centre_verrat"
		OpenSheet(lw_r_plan_verraterie_centre_verrat, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_plan_verraterie_sommaire"
		OpenSheet(lw_r_plan_verraterie_sommaire, gnv_app.of_GetFrame(), 6, layered!)

END CHOOSE
end event

type st_1 from statictext within w_critere_date
integer x = 201
integer y = 44
integer width = 1042
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Veuillez sp$$HEX1$$e900$$ENDHEX$$cifier une date"
boolean focusrectangle = false
end type

type p_ra from picture within w_critere_date
integer x = 69
integer y = 48
integer width = 87
integer height = 72
string picturename = "C:\ii4net\CIPQ\images\repetitive.bmp"
boolean focusrectangle = false
end type

type rr_2 from roundrectangle within w_critere_date
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 1298
integer height = 140
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_1 from roundrectangle within w_critere_date
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 168
integer width = 1298
integer height = 436
integer cornerheight = 40
integer cornerwidth = 46
end type


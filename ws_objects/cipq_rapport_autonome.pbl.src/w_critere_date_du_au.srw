$PBExportHeader$w_critere_date_du_au.srw
forward
global type w_critere_date_du_au from w_sheet
end type
type em_au from editmask within w_critere_date_du_au
end type
type st_3 from statictext within w_critere_date_du_au
end type
type st_2 from statictext within w_critere_date_du_au
end type
type em_du from editmask within w_critere_date_du_au
end type
type uo_toolbar from u_cst_toolbarstrip within w_critere_date_du_au
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date_du_au
end type
type st_1 from statictext within w_critere_date_du_au
end type
type p_ra from picture within w_critere_date_du_au
end type
type rr_2 from roundrectangle within w_critere_date_du_au
end type
type rr_1 from roundrectangle within w_critere_date_du_au
end type
end forward

global type w_critere_date_du_au from w_sheet
integer width = 1376
integer height = 928
string title = "Critères de date"
em_au em_au
st_3 st_3
st_2 st_2
em_du em_du
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
rr_2 rr_2
rr_1 rr_1
end type
global w_critere_date_du_au w_critere_date_du_au

type variables
n_cst_datetime	inv_datetime
date	id_debut, id_fin
string	is_nom_fenetre = ""
end variables

on w_critere_date_du_au.create
int iCurrent
call super::create
this.em_au=create em_au
this.st_3=create st_3
this.st_2=create st_2
this.em_du=create em_du
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.rr_2=create rr_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_au
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_du
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.uo_toolbar_gauche
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.p_ra
this.Control[iCurrent+9]=this.rr_2
this.Control[iCurrent+10]=this.rr_1
end on

on w_critere_date_du_au.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_au)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.em_du)
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

type em_au from editmask within w_critere_date_du_au
integer x = 407
integer y = 384
integer width = 544
integer height = 108
integer taborder = 20
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

type st_3 from statictext within w_critere_date_du_au
integer x = 133
integer y = 400
integer width = 174
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 15793151
string text = "Au:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_critere_date_du_au
integer x = 133
integer y = 228
integer width = 174
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 15793151
string text = "Du:"
boolean focusrectangle = false
end type

type em_du from editmask within w_critere_date_du_au
integer x = 407
integer y = 220
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

type uo_toolbar from u_cst_toolbarstrip within w_critere_date_du_au
event destroy ( )
integer x = 809
integer y = 636
integer width = 507
integer taborder = 40
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date_du_au
event destroy ( )
integer x = 23
integer y = 636
integer width = 507
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;string	ls_du, ls_au, ls_retour
long		ll_dow
n_cst_datetime	lnv_datetime

ls_retour = is_nom_fenetre

//Bâtir le filtre
ls_du = em_du.text
IF IsNull(ls_du) OR ls_du = "00-00-0000" OR ls_du = "none" THEN
	if ls_retour = "w_r_fiche_sante" then
		ls_du = ""
	else
		gnv_app.inv_error.of_message("pfc_requiredmissing",{"Du"})
		RETURN
	end if
END IF
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", ls_du)


ls_au = em_au.text
IF IsNull(ls_au) OR ls_au = "00-00-0000" OR ls_au = "none" THEN
	if ls_retour = "w_r_fiche_sante" then
		ls_au = ""
	else
		gnv_app.inv_error.of_message("pfc_requiredmissing",{"Au"})
		RETURN
	end if
END IF
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", ls_au)

IF ls_retour = "w_r_commande_hebdo_globales" THEN
	ll_dow = lnv_datetime.of_dayofweek( date(ls_du) )
	//Valider si la date de début est un dimanche
	IF ll_dow <> 1 THEN
		gnv_app.inv_error.of_message("CIPQ0132")
		RETURN
	END IF
	//et la date de fin un samedi
	ll_dow = lnv_datetime.of_dayofweek( date(ls_au) )
	IF ll_dow <> 7 THEN
		gnv_app.inv_error.of_message("CIPQ0133")
		RETURN
	END IF
END IF

w_r_utilisation_medicament lw_utilisation_medicament
w_r_utilisation_sommaire_medicament lw_utilisation_sommaire_medicament
w_r_client_secteur_transporteur lw_client_secteur_transporteur
w_r_destination_doses_specifiques lw_destination_doses_specifiques
w_r_destination_produits lw_destination_produits
w_r_destination_produits_super_famille lw_destination_produits_super_famille
w_r_expedition_secteur_transporteur lw_expedition_secteur_transporteur
w_r_verrat_production lw_verrat_production
w_r_verrat_asortir lw_verrat_asortir
w_r_quantite_non_expediee lw_quantite_non_expediee
w_r_sommaire_alliance_maternelle lw_sommaire_alliance_maternelle
w_r_sommaire_lignes_maternelles_coop lw_sommaire_lignes_maternelles_coop
w_r_commande_hebdo_globales lw_commande_hebdo_globales
w_r_commande_hebdo_centre lw_commande_hebdo_centre
w_r_frequence_relle_recolte lw_frequence_relle_recolte
w_r_stat_vente_dose_montant_client lw_stat_vente_dose_montant
w_r_stat_vente_materiel lw_stat_vente_materiel
w_r_stat_vente_classe lw_stat_vente_classe
w_r_stat_vente_client_produit lw_stat_vente_client_produit
w_r_stat_vente_race lw_stat_vente_race
w_r_stat_vente_verrat lw_stat_vente_verrat
w_r_stat_vente_verrat_heberge lw_stat_vente_verrat_heberge
w_r_stat_vente_verrat_location lw_stat_vente_verrat_location
w_r_stat_vente_verrat_locationclassefamille lw_stat_vente_verrat_locationclassefamille
w_r_stat_vente_verrat_location_globale lw_stat_vente_verrat_location_globale
w_r_sommaire_expedition_secteur_trans lw_sommaire_expedition_secteur_trans
w_r_som_moy_expedition_secteur_trans lw_som_moy_expedition_secteur_trans
w_r_com_orig_exp_eleveur lw_com_orig_exp_eleveur
w_r_production_sperm_hebdo lw_production_sperm_hebdo
w_r_production_sperm_classe_verrat lw_production_sperm_classe_verrat
w_r_com_orig_exp_famille lw_com_orig_exp_famille
w_r_com_orig_exp_produit lw_com_orig_exp_produit
w_r_comp_recolte_liv_heb lw_comp_recolte_liv_heb
w_r_comp_det_recolte_liv_heb lw_comp_det_recolte_liv_heb
w_r_production_sperm_race lw_production_sperm_race
w_r_expedition_cipq lw_expedition_cipq
w_r_comparatif_en_lot_exp lw_comparatif_en_lot_exp
w_r_production_sperm_verrat lw_production_sperm_verrat
w_r_production_sperm_verrat_sommaire lw_production_sperm_verrat_sommaire
w_r_registre_recolte lw_registre_recolte
w_r_rejet_centre lw_rejet_centre
w_r_registre_analyse_recolte lw_registre_analyse_recolte
w_r_recolte_detaillee lw_recolte_detaillee
w_r_recolte_sommaire lw_recolte_sommaire
w_r_recolte_race lw_recolte_race
w_r_rejet_hebdomadaires lw_rejet_hebdomadaires
w_r_recolte_hebdomadaire lw_recolte_hebdomadaire
w_r_rec_prod_sperm_hebdo lw_rec_prod_sperm_sperm
w_r_cote_recolte lw_r_cote_recolte
w_r_cote_lot_recolte lw_r_cote_lot_recolte
w_r_fiche_sante lw_r_fiche_sante
w_r_suivi_courriel_facturation lw_suivi_courriel_facturation

//Ouvrir l'interface
SetPointer(HourGlass!)
CHOOSE CASE ls_retour
	CASE "w_r_cote_lot_recolte"
		OpenSheet(lw_r_cote_lot_recolte, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_utilisation_medicament"
		OpenSheet(lw_utilisation_medicament, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_utilisation_sommaire_medicament"
		OpenSheet(lw_utilisation_sommaire_medicament, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_client_secteur_transporteur"
		OpenSheet(lw_client_secteur_transporteur, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_destination_doses_specifiques"
		OpenSheet(lw_destination_doses_specifiques, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_destination_produits"
		OpenSheet(lw_destination_produits, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_destination_produits_super_famille"
		OpenSheet(lw_destination_produits_super_famille, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_expedition_secteur_transporteur"
		OpenSheet(lw_expedition_secteur_transporteur, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_verrat_production"
		OpenSheet(lw_verrat_production, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_verrat_asortir"
		OpenSheet(lw_verrat_asortir, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_quantite_non_expediee"
		OpenSheet(lw_quantite_non_expediee, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_sommaire_alliance_maternelle"
		OpenSheet(lw_sommaire_alliance_maternelle, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_sommaire_lignes_maternelles_coop"
		OpenSheet(lw_sommaire_lignes_maternelles_coop, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_commande_hebdo_globales"
		OpenSheet(lw_commande_hebdo_globales, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_commande_hebdo_centre"
		OpenSheet(lw_commande_hebdo_centre, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_frequence_relle_recolte"
		OpenSheet(lw_frequence_relle_recolte, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_stat_vente_dose_montant_client"
		OpenSheet(lw_stat_vente_dose_montant, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_stat_vente_materiel"
		OpenSheet(lw_stat_vente_materiel, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_stat_vente_classe"
		OpenSheet(lw_stat_vente_classe, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_stat_vente_client_produit"
		OpenSheet(lw_stat_vente_client_produit, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_stat_vente_race"
		OpenSheet(lw_stat_vente_race, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_stat_vente_verrat" 
		OpenSheet(lw_stat_vente_verrat, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_stat_vente_verrat_heberge" 
		OpenSheet(lw_stat_vente_verrat_heberge, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_stat_vente_verrat_location"
		OpenSheet(lw_stat_vente_verrat_location, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_stat_vente_verrat_locationclassefamille"
		OpenSheet(lw_stat_vente_verrat_locationclassefamille, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_stat_vente_verrat_location_globale"
		OpenSheet(lw_stat_vente_verrat_location_globale, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_sommaire_expedition_secteur_trans"
		OpenSheet(lw_sommaire_expedition_secteur_trans, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_som_moy_expedition_secteur_trans"
		OpenSheet(lw_som_moy_expedition_secteur_trans, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_com_orig_exp_eleveur"
		OpenSheet(lw_com_orig_exp_eleveur, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_production_sperm_hebdo"
		OpenSheet(lw_production_sperm_hebdo, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_production_sperm_classe_verrat"
		OpenSheet(lw_production_sperm_classe_verrat, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_com_orig_exp_famille"
		OpenSheet(lw_com_orig_exp_famille, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_com_orig_exp_produit"
		OpenSheet(lw_com_orig_exp_produit, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_comp_recolte_liv_heb"
		OpenSheet(lw_comp_recolte_liv_heb, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_comp_det_recolte_liv_heb"
		OpenSheet(lw_comp_det_recolte_liv_heb, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_production_sperm_race"
		OpenSheet(lw_production_sperm_race, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_expedition_cipq"
		OpenSheet(lw_expedition_cipq, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_comparatif_en_lot_exp"
		OpenSheet(lw_comparatif_en_lot_exp, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_production_sperm_verrat"
		OpenSheet( lw_production_sperm_verrat, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_production_sperm_verrat_sommaire"
		OpenSheet( lw_production_sperm_verrat_sommaire, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_registre_recolte"
		OpenSheet( lw_registre_recolte, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_rejet_centre"
		OpenSheet( lw_rejet_centre, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_registre_analyse_recolte"
		OpenSheet( lw_registre_analyse_recolte, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_recolte_detaillee"
		OpenSheet( lw_recolte_detaillee, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_recolte_sommaire"
		OpenSheet( lw_recolte_sommaire, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_recolte_race"
		OpenSheet( lw_recolte_race, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_rejet_hebdomadaires"
		OpenSheet( lw_rejet_hebdomadaires, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_recolte_hebdomadaire"
		OpenSheet( lw_recolte_hebdomadaire, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_rec_prod_sperm_hebdo"
		OpenSheet( lw_rec_prod_sperm_sperm, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_cote_recolte"
		OpenSheet( lw_r_cote_recolte, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_fiche_sante"
		OpenSheet( lw_r_fiche_sante, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_suivi_courriel_facturation"
		OpenSheet(lw_suivi_courriel_facturation, gnv_app.of_GetFrame(), 6, layered!)		
END CHOOSE
end event

type st_1 from statictext within w_critere_date_du_au
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
string text = "Veuillez spécifier une date"
boolean focusrectangle = false
end type

type p_ra from picture within w_critere_date_du_au
integer x = 69
integer y = 48
integer width = 87
integer height = 72
string picturename = "C:\ii4net\CIPQ\images\repetitive.bmp"
boolean focusrectangle = false
end type

type rr_2 from roundrectangle within w_critere_date_du_au
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

type rr_1 from roundrectangle within w_critere_date_du_au
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


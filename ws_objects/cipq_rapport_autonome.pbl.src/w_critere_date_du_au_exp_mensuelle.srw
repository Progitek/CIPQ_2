$PBExportHeader$w_critere_date_du_au_exp_mensuelle.srw
forward
global type w_critere_date_du_au_exp_mensuelle from w_sheet
end type
type cbx_facture from u_cbx within w_critere_date_du_au_exp_mensuelle
end type
type em_au from editmask within w_critere_date_du_au_exp_mensuelle
end type
type st_3 from statictext within w_critere_date_du_au_exp_mensuelle
end type
type st_2 from statictext within w_critere_date_du_au_exp_mensuelle
end type
type em_du from editmask within w_critere_date_du_au_exp_mensuelle
end type
type uo_toolbar from u_cst_toolbarstrip within w_critere_date_du_au_exp_mensuelle
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date_du_au_exp_mensuelle
end type
type st_1 from statictext within w_critere_date_du_au_exp_mensuelle
end type
type p_ra from picture within w_critere_date_du_au_exp_mensuelle
end type
type rr_2 from roundrectangle within w_critere_date_du_au_exp_mensuelle
end type
type rr_1 from roundrectangle within w_critere_date_du_au_exp_mensuelle
end type
end forward

global type w_critere_date_du_au_exp_mensuelle from w_sheet
integer width = 1376
integer height = 1056
string title = "Critères de date"
cbx_facture cbx_facture
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
global w_critere_date_du_au_exp_mensuelle w_critere_date_du_au_exp_mensuelle

type variables
n_cst_datetime	inv_datetime
date	id_debut, id_fin
string	is_nom_fenetre = ""
end variables

on w_critere_date_du_au_exp_mensuelle.create
int iCurrent
call super::create
this.cbx_facture=create cbx_facture
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
this.Control[iCurrent+1]=this.cbx_facture
this.Control[iCurrent+2]=this.em_au
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_du
this.Control[iCurrent+6]=this.uo_toolbar
this.Control[iCurrent+7]=this.uo_toolbar_gauche
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.p_ra
this.Control[iCurrent+10]=this.rr_2
this.Control[iCurrent+11]=this.rr_1
end on

on w_critere_date_du_au_exp_mensuelle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_facture)
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

type cbx_facture from u_cbx within w_critere_date_du_au_exp_mensuelle
integer x = 416
integer y = 568
integer width = 411
integer height = 68
integer taborder = 60
long backcolor = 15793151
string text = "Facturé"
boolean checked = true
end type

type em_au from editmask within w_critere_date_du_au_exp_mensuelle
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

type st_3 from statictext within w_critere_date_du_au_exp_mensuelle
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

type st_2 from statictext within w_critere_date_du_au_exp_mensuelle
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

type em_du from editmask within w_critere_date_du_au_exp_mensuelle
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

type uo_toolbar from u_cst_toolbarstrip within w_critere_date_du_au_exp_mensuelle
event destroy ( )
integer x = 809
integer y = 752
integer width = 507
integer taborder = 80
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date_du_au_exp_mensuelle
event destroy ( )
integer x = 23
integer y = 752
integer width = 507
integer taborder = 70
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;string	ls_du, ls_au, ls_facture, ls_retour
long		ll_dow
date		ld_du, ld_au
n_cst_datetime	lnv_datetime

ls_retour = is_nom_fenetre

//Bâtir le filtre
ls_du = em_du.text
IF IsNull(ls_du) OR ls_du = "00-00-0000" OR ls_du = "none" THEN
	gnv_app.inv_error.of_message("pfc_requiredmissing",{"Du"})
	RETURN
END IF
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", ls_du)


ls_au = em_au.text
IF IsNull(ls_au) OR ls_au = "00-00-0000" OR ls_au = "none" THEN
	gnv_app.inv_error.of_message("pfc_requiredmissing",{"Au"})
	RETURN
END IF
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", ls_au)

if cbx_facture.checked = true then
	ls_facture = "true"
else
	ls_facture = "false"
end if
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien facture", ls_facture)
//Valider pour pas plus de 12 mois
ld_du = date(ls_du)
ld_au = date(ls_au)

IF lnv_datetime.of_relativemonth( ld_du, 12) < ld_au or ld_du > ld_au THEN
	gnv_app.inv_error.of_message("CIPQ0135")
	RETURN
END IF


w_r_expedition_mensuel_region lw_expedition_mensuel_region
w_r_sommaire_expedition_mensuel lw_sommaire_expedition_mensuel
w_r_expedition_totales_gedis_region lw_expedition_totales_gedis_region

//Ouvrir l'interface
SetPointer(HourGlass!)
CHOOSE CASE ls_retour
	CASE "w_r_expedition_mensuel_region"
		OpenSheet(lw_expedition_mensuel_region, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_sommaire_expedition_mensuel"
		OpenSheet(lw_sommaire_expedition_mensuel, gnv_app.of_GetFrame(), 6, layered!)
	CASE "w_r_expedition_totales_gedis_region"
		OpenSheet(lw_expedition_totales_gedis_region, gnv_app.of_GetFrame(), 6, layered!)
END CHOOSE
end event

type st_1 from statictext within w_critere_date_du_au_exp_mensuelle
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

type p_ra from picture within w_critere_date_du_au_exp_mensuelle
integer x = 69
integer y = 48
integer width = 87
integer height = 72
string picturename = "C:\ii4net\CIPQ\images\repetitive.bmp"
boolean focusrectangle = false
end type

type rr_2 from roundrectangle within w_critere_date_du_au_exp_mensuelle
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

type rr_1 from roundrectangle within w_critere_date_du_au_exp_mensuelle
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 168
integer width = 1298
integer height = 564
integer cornerheight = 40
integer cornerwidth = 46
end type


$PBExportHeader$w_critere_date_du_au_exp_heb.srw
forward
global type w_critere_date_du_au_exp_heb from w_sheet
end type
type ddlb_centre from u_ddlb within w_critere_date_du_au_exp_heb
end type
type st_4 from statictext within w_critere_date_du_au_exp_heb
end type
type rr_1 from roundrectangle within w_critere_date_du_au_exp_heb
end type
type rb_sem_cipq_eleveur from u_rb within w_critere_date_du_au_exp_heb
end type
type rb_sem_cipq_prod from u_rb within w_critere_date_du_au_exp_heb
end type
type rb_exp_heb from u_rb within w_critere_date_du_au_exp_heb
end type
type rb_eleveur from u_rb within w_critere_date_du_au_exp_heb
end type
type rb_produit from u_rb within w_critere_date_du_au_exp_heb
end type
type rb_det from u_rb within w_critere_date_du_au_exp_heb
end type
type rb_som from u_rb within w_critere_date_du_au_exp_heb
end type
type em_au from editmask within w_critere_date_du_au_exp_heb
end type
type st_3 from statictext within w_critere_date_du_au_exp_heb
end type
type st_2 from statictext within w_critere_date_du_au_exp_heb
end type
type em_du from editmask within w_critere_date_du_au_exp_heb
end type
type uo_toolbar from u_cst_toolbarstrip within w_critere_date_du_au_exp_heb
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date_du_au_exp_heb
end type
type st_1 from statictext within w_critere_date_du_au_exp_heb
end type
type p_ra from picture within w_critere_date_du_au_exp_heb
end type
type gb_1 from groupbox within w_critere_date_du_au_exp_heb
end type
type gb_2 from groupbox within w_critere_date_du_au_exp_heb
end type
type rr_2 from roundrectangle within w_critere_date_du_au_exp_heb
end type
end forward

global type w_critere_date_du_au_exp_heb from w_sheet
integer width = 1376
integer height = 1620
string title = "Critères de date"
ddlb_centre ddlb_centre
st_4 st_4
rr_1 rr_1
rb_sem_cipq_eleveur rb_sem_cipq_eleveur
rb_sem_cipq_prod rb_sem_cipq_prod
rb_exp_heb rb_exp_heb
rb_eleveur rb_eleveur
rb_produit rb_produit
rb_det rb_det
rb_som rb_som
em_au em_au
st_3 st_3
st_2 st_2
em_du em_du
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
gb_1 gb_1
gb_2 gb_2
rr_2 rr_2
end type
global w_critere_date_du_au_exp_heb w_critere_date_du_au_exp_heb

type variables
n_cst_datetime	inv_datetime
date	id_debut, id_fin
string	is_nom_fenetre = ""
end variables

on w_critere_date_du_au_exp_heb.create
int iCurrent
call super::create
this.ddlb_centre=create ddlb_centre
this.st_4=create st_4
this.rr_1=create rr_1
this.rb_sem_cipq_eleveur=create rb_sem_cipq_eleveur
this.rb_sem_cipq_prod=create rb_sem_cipq_prod
this.rb_exp_heb=create rb_exp_heb
this.rb_eleveur=create rb_eleveur
this.rb_produit=create rb_produit
this.rb_det=create rb_det
this.rb_som=create rb_som
this.em_au=create em_au
this.st_3=create st_3
this.st_2=create st_2
this.em_du=create em_du
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.gb_1=create gb_1
this.gb_2=create gb_2
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_centre
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.rr_1
this.Control[iCurrent+4]=this.rb_sem_cipq_eleveur
this.Control[iCurrent+5]=this.rb_sem_cipq_prod
this.Control[iCurrent+6]=this.rb_exp_heb
this.Control[iCurrent+7]=this.rb_eleveur
this.Control[iCurrent+8]=this.rb_produit
this.Control[iCurrent+9]=this.rb_det
this.Control[iCurrent+10]=this.rb_som
this.Control[iCurrent+11]=this.em_au
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.em_du
this.Control[iCurrent+15]=this.uo_toolbar
this.Control[iCurrent+16]=this.uo_toolbar_gauche
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.p_ra
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.rr_2
end on

on w_critere_date_du_au_exp_heb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_centre)
destroy(this.st_4)
destroy(this.rr_1)
destroy(this.rb_sem_cipq_eleveur)
destroy(this.rb_sem_cipq_prod)
destroy(this.rb_exp_heb)
destroy(this.rb_eleveur)
destroy(this.rb_produit)
destroy(this.rb_det)
destroy(this.rb_som)
destroy(this.em_au)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.em_du)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_gauche)
destroy(this.st_1)
destroy(this.p_ra)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.rr_2)
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

type ddlb_centre from u_ddlb within w_critere_date_du_au_exp_heb
integer x = 425
integer y = 476
integer width = 544
integer height = 420
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
boolean sorted = false
end type

event constructor;call super::constructor;string ls_nom

addItem('Tous')

DECLARE listcentre CURSOR FOR
	select cie from t_çentrecipq order by cie;
	
OPEN listcentre;

FETCH listcentre INTO :ls_nom;

DO WHILE SQLCA.SQLCode = 0
	
	addItem(ls_nom)
	FETCH listcentre INTO :ls_nom;
	
LOOP

CLOSE listcentre;

selectItem(1)
end event

type st_4 from statictext within w_critere_date_du_au_exp_heb
integer x = 69
integer y = 484
integer width = 329
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 15793151
string text = "Centre:"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_critere_date_du_au_exp_heb
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 180
integer width = 1298
integer height = 1068
integer cornerheight = 40
integer cornerwidth = 46
end type

type rb_sem_cipq_eleveur from u_rb within w_critere_date_du_au_exp_heb
integer x = 667
integer y = 1012
integer width = 457
integer height = 68
long backcolor = 15793151
string text = "Semence CIPQ"
end type

type rb_sem_cipq_prod from u_rb within w_critere_date_du_au_exp_heb
integer x = 667
integer y = 916
integer width = 457
integer height = 68
long backcolor = 15793151
string text = "Semence CIPQ"
end type

type rb_exp_heb from u_rb within w_critere_date_du_au_exp_heb
integer x = 114
integer y = 1108
integer width = 864
integer height = 68
long backcolor = 15793151
string text = "Expéditions et hébergement"
end type

type rb_eleveur from u_rb within w_critere_date_du_au_exp_heb
integer x = 114
integer y = 1012
integer width = 416
integer height = 68
long backcolor = 15793151
string text = "Éleveur"
end type

type rb_produit from u_rb within w_critere_date_du_au_exp_heb
integer x = 114
integer y = 916
integer width = 416
integer height = 68
long backcolor = 15793151
string text = "Produit"
boolean checked = true
end type

type rb_det from u_rb within w_critere_date_du_au_exp_heb
integer x = 667
integer y = 700
integer width = 416
integer height = 68
long backcolor = 15793151
string text = "Détaillé"
boolean checked = true
end type

event clicked;call super::clicked;rb_produit.enabled = TRUE
rb_sem_cipq_prod.enabled = TRUE
rb_sem_cipq_eleveur.enabled = TRUE
rb_eleveur.enabled = TRUE
rb_exp_heb.enabled = TRUE
end event

type rb_som from u_rb within w_critere_date_du_au_exp_heb
integer x = 114
integer y = 700
integer width = 416
integer height = 68
long backcolor = 15793151
string text = "Sommaire"
end type

event clicked;call super::clicked;rb_produit.enabled = FALSE
rb_sem_cipq_prod.enabled = FALSE
rb_sem_cipq_eleveur.enabled = FALSE
rb_eleveur.enabled = FALSE
rb_exp_heb.enabled = FALSE
end event

type em_au from editmask within w_critere_date_du_au_exp_heb
integer x = 425
integer y = 344
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

type st_3 from statictext within w_critere_date_du_au_exp_heb
integer x = 78
integer y = 356
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

type st_2 from statictext within w_critere_date_du_au_exp_heb
integer x = 78
integer y = 228
integer width = 155
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

type em_du from editmask within w_critere_date_du_au_exp_heb
integer x = 425
integer y = 224
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

type uo_toolbar from u_cst_toolbarstrip within w_critere_date_du_au_exp_heb
event destroy ( )
integer x = 809
integer y = 1284
integer width = 507
integer taborder = 60
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date_du_au_exp_heb
event destroy ( )
integer x = 23
integer y = 1284
integer width = 507
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;string	ls_du, ls_au, ls_retour
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

gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien centre rapport", ddlb_centre.text)

//Ouvrir l'interface selon la sélection
SetPointer(HourGlass!)

IF rb_det.checked = TRUE AND rb_sem_cipq_eleveur.checked = TRUE THEN
	w_r_expedition_cipq_eleveur lw_r_expedition_cipq_eleveur
	OpenSheet(lw_r_expedition_cipq_eleveur, gnv_app.of_GetFrame(), 6, layered!)
	
ELSEIF rb_det.checked = TRUE AND rb_sem_cipq_prod.checked = TRUE THEN
	w_r_expedition_cipq_produit lw_r_expedition_cipq_produit
	OpenSheet(lw_r_expedition_cipq_produit, gnv_app.of_GetFrame(), 6, layered!)
	
ELSEIF rb_det.checked = TRUE AND rb_produit.checked = TRUE THEN
	w_r_expedition_produit lw_r_expedition_produit
	OpenSheet(lw_r_expedition_produit, gnv_app.of_GetFrame(), 6, layered!)
		
ELSEIF rb_det.checked = TRUE AND rb_eleveur.checked = TRUE THEN
	w_r_expedition_eleveur lw_r_expedition_eleveur
	OpenSheet(lw_r_expedition_eleveur, gnv_app.of_GetFrame(), 6, layered!)
	
ELSEIF rb_det.checked = TRUE AND rb_exp_heb.checked = TRUE THEN
	w_r_expedition_hebergement lw_r_expedition_hebergement
	OpenSheet(lw_r_expedition_hebergement, gnv_app.of_GetFrame(), 6, layered!)
	
ELSEIF rb_som.checked = TRUE THEN
	w_r_expedition_hebergement_som lw_r_expedition_hebergement_som
	OpenSheet(lw_r_expedition_hebergement_som, gnv_app.of_GetFrame(), 6, layered!)
	
END IF
end event

type st_1 from statictext within w_critere_date_du_au_exp_heb
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

type p_ra from picture within w_critere_date_du_au_exp_heb
integer x = 69
integer y = 48
integer width = 87
integer height = 72
string picturename = "C:\ii4net\CIPQ\images\repetitive.bmp"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_critere_date_du_au_exp_heb
integer x = 78
integer y = 612
integer width = 1193
integer height = 188
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Type de rapport"
end type

type gb_2 from groupbox within w_critere_date_du_au_exp_heb
integer x = 78
integer y = 828
integer width = 1193
integer height = 380
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Expédition"
end type

type rr_2 from roundrectangle within w_critere_date_du_au_exp_heb
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


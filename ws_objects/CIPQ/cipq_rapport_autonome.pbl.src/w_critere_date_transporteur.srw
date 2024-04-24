$PBExportHeader$w_critere_date_transporteur.srw
forward
global type w_critere_date_transporteur from w_sheet
end type
type dw_temp_t_transporteur from u_dw within w_critere_date_transporteur
end type
type st_supprimer from statictext within w_critere_date_transporteur
end type
type st_ajouter from statictext within w_critere_date_transporteur
end type
type st_2 from statictext within w_critere_date_transporteur
end type
type em_date from editmask within w_critere_date_transporteur
end type
type uo_toolbar from u_cst_toolbarstrip within w_critere_date_transporteur
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date_transporteur
end type
type st_1 from statictext within w_critere_date_transporteur
end type
type p_ra from picture within w_critere_date_transporteur
end type
type gb_1 from u_gb within w_critere_date_transporteur
end type
type rr_2 from roundrectangle within w_critere_date_transporteur
end type
type rr_1 from roundrectangle within w_critere_date_transporteur
end type
end forward

global type w_critere_date_transporteur from w_sheet
string tag = "exclure_securite"
integer width = 1376
integer height = 1484
string title = "Critères de date"
dw_temp_t_transporteur dw_temp_t_transporteur
st_supprimer st_supprimer
st_ajouter st_ajouter
st_2 st_2
em_date em_date
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
gb_1 gb_1
rr_2 rr_2
rr_1 rr_1
end type
global w_critere_date_transporteur w_critere_date_transporteur

type variables
n_cst_datetime	inv_datetime
date	id_debut, id_fin
string	is_nom_fenetre = ""
end variables

on w_critere_date_transporteur.create
int iCurrent
call super::create
this.dw_temp_t_transporteur=create dw_temp_t_transporteur
this.st_supprimer=create st_supprimer
this.st_ajouter=create st_ajouter
this.st_2=create st_2
this.em_date=create em_date
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.gb_1=create gb_1
this.rr_2=create rr_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_temp_t_transporteur
this.Control[iCurrent+2]=this.st_supprimer
this.Control[iCurrent+3]=this.st_ajouter
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_date
this.Control[iCurrent+6]=this.uo_toolbar
this.Control[iCurrent+7]=this.uo_toolbar_gauche
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.p_ra
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.rr_2
this.Control[iCurrent+12]=this.rr_1
end on

on w_critere_date_transporteur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_temp_t_transporteur)
destroy(this.st_supprimer)
destroy(this.st_ajouter)
destroy(this.st_2)
destroy(this.em_date)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_gauche)
destroy(this.st_1)
destroy(this.p_ra)
destroy(this.gb_1)
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

event pfc_preopen;call super::pfc_preopen;long ll_nb
string ls_sql

select count(1) into :ll_nb from #Temp_Transporteur;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Temp_Transporteur (idtransporteur integer not null,~r~n" + &
															"primary key (idtransporteur))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Temp_Transporteur;
	commit using sqlca;
end if

end event

type dw_temp_t_transporteur from u_dw within w_critere_date_transporteur
integer x = 128
integer y = 532
integer width = 1079
integer height = 416
integer taborder = 21
string dataobject = "d_temp_t_transporteur"
end type

event constructor;call super::constructor;SetRowFocusIndicator(HAND!)
end event

type st_supprimer from statictext within w_critere_date_transporteur
integer x = 896
integer y = 964
integer width = 297
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 16711680
long backcolor = 15793151
string text = "Supprimer"
boolean focusrectangle = false
end type

event clicked;dw_temp_t_transporteur.event pfc_deleterow()
end event

type st_ajouter from statictext within w_critere_date_transporteur
integer x = 146
integer y = 964
integer width = 261
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 16711680
long backcolor = 15793151
string text = "Ajouter"
boolean focusrectangle = false
end type

event clicked;dw_temp_t_transporteur.event pfc_insertrow()
end event

type st_2 from statictext within w_critere_date_transporteur
integer x = 114
integer y = 312
integer width = 242
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Date:"
boolean focusrectangle = false
end type

type em_date from editmask within w_critere_date_transporteur
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

type uo_toolbar from u_cst_toolbarstrip within w_critere_date_transporteur
event destroy ( )
integer x = 809
integer y = 1144
integer width = 507
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date_transporteur
event destroy ( )
integer x = 23
integer y = 1144
integer width = 507
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;string	ls_date, ls_retour

//Bâtir le filtre
ls_date = em_date.text

IF IsNull(ls_date) OR ls_date = "00-00-0000" OR ls_date = "none"  THEN
	gnv_app.inv_error.of_message("pfc_requiredmissing",{"Date"})
	RETURN
END IF
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", ls_date)

w_r_som_moy_expedition_secteur_trans lw_som_moy_expedition_secteur_trans
w_r_som_moy_expedition_secteur_trans_fam lw_som_moy_expedition_secteur_trans_fam

ls_retour = is_nom_fenetre

//Ouvrir l'interface
SetPointer(HourGlass!)

IF parent.event pfc_save() >= 0 THEN
	CHOOSE CASE ls_retour
			
		CASE "w_r_som_moy_expedition_secteur_trans"
			OpenSheet(lw_som_moy_expedition_secteur_trans, gnv_app.of_GetFrame(), 6, layered!)
		CASE "w_r_som_moy_expedition_secteur_trans_fam"
			OpenSheet(lw_som_moy_expedition_secteur_trans_fam, gnv_app.of_GetFrame(), 6, layered!)
	END CHOOSE
END IF
end event

type st_1 from statictext within w_critere_date_transporteur
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

type p_ra from picture within w_critere_date_transporteur
integer x = 69
integer y = 48
integer width = 87
integer height = 72
string picturename = "C:\ii4net\CIPQ\images\repetitive.bmp"
boolean focusrectangle = false
end type

type gb_1 from u_gb within w_critere_date_transporteur
integer x = 96
integer y = 448
integer width = 1129
integer height = 604
integer taborder = 11
integer textsize = -10
fontcharset fontcharset = ansi!
long backcolor = 15793151
string text = "Transporteurs"
end type

type rr_2 from roundrectangle within w_critere_date_transporteur
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

type rr_1 from roundrectangle within w_critere_date_transporteur
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 168
integer width = 1298
integer height = 936
integer cornerheight = 40
integer cornerwidth = 46
end type


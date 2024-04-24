$PBExportHeader$w_critere_date_etat_phys.srw
forward
global type w_critere_date_etat_phys from w_sheet
end type
type st_3 from statictext within w_critere_date_etat_phys
end type
type st_2 from statictext within w_critere_date_etat_phys
end type
type em_date from editmask within w_critere_date_etat_phys
end type
type uo_toolbar from u_cst_toolbarstrip within w_critere_date_etat_phys
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date_etat_phys
end type
type st_1 from statictext within w_critere_date_etat_phys
end type
type p_ra from picture within w_critere_date_etat_phys
end type
type rr_2 from roundrectangle within w_critere_date_etat_phys
end type
type rr_1 from roundrectangle within w_critere_date_etat_phys
end type
type ddlb_prepose from u_ddlb within w_critere_date_etat_phys
end type
end forward

global type w_critere_date_etat_phys from w_sheet
integer x = 214
integer y = 221
integer width = 1595
integer height = 828
string title = "Critères de date"
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
st_3 st_3
st_2 st_2
em_date em_date
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
rr_2 rr_2
rr_1 rr_1
ddlb_prepose ddlb_prepose
end type
global w_critere_date_etat_phys w_critere_date_etat_phys

type variables
Protected:

n_cst_datetime	inv_datetime
long	il_nolot
string	is_nom_fenetre = ""
end variables

on w_critere_date_etat_phys.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_2=create st_2
this.em_date=create em_date
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.rr_2=create rr_2
this.rr_1=create rr_1
this.ddlb_prepose=create ddlb_prepose
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_date
this.Control[iCurrent+4]=this.uo_toolbar
this.Control[iCurrent+5]=this.uo_toolbar_gauche
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.p_ra
this.Control[iCurrent+8]=this.rr_2
this.Control[iCurrent+9]=this.rr_1
this.Control[iCurrent+10]=this.ddlb_prepose
end on

on w_critere_date_etat_phys.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.em_date)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_gauche)
destroy(this.st_1)
destroy(this.p_ra)
destroy(this.rr_2)
destroy(this.rr_1)
destroy(this.ddlb_prepose)
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
il_nolot = gnv_app.inv_entrepotglobal.of_retournedonnee("lot isolement date")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")
end event

type st_3 from statictext within w_critere_date_etat_phys
integer x = 64
integer y = 388
integer width = 347
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Préposé:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_critere_date_etat_phys
integer x = 64
integer y = 248
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

type em_date from editmask within w_critere_date_etat_phys
integer x = 357
integer y = 228
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

type uo_toolbar from u_cst_toolbarstrip within w_critere_date_etat_phys
event destroy ( )
integer x = 1061
integer y = 636
integer width = 507
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;parent.event pfc_close()
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_date_etat_phys
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
date ldt_dte
long ll_cnt

//Bâtir le filtre
ls_date = em_date.text

IF IsNull(ls_date) OR not isDate(ls_date) THEN
	gnv_app.inv_error.of_message("pfc_requiredmissing",{"Date"})
	RETURN
END IF

ldt_dte = date(ls_date)

// Validation que la date n'existe pas déjà dans le lot
select count(1)
  into :ll_cnt
  from t_isolementverrat_etatphysique
 where nolot = :il_nolot
	and date(dateexamenetatphysique) = :ldt_dte;

if ll_cnt > 0 then
	gnv_app.inv_error.of_message("CIPQ0018", {"Il y a déjà une inspection d'état physique le "+ls_date+" pour le lot "+string(il_nolot)+"."})
	RETURN
end if

gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", ls_date)
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien prepose", ddlb_prepose.of_getSelectedData())

ls_retour = is_nom_fenetre

//Ouvrir l'interface
SetPointer(HourGlass!)
CHOOSE CASE ls_retour
	CASE "w_saisie_etat_physique"
		parent.event pfc_close()
END CHOOSE
end event

type st_1 from statictext within w_critere_date_etat_phys
integer x = 201
integer y = 44
integer width = 1088
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

type p_ra from picture within w_critere_date_etat_phys
integer x = 69
integer y = 48
integer width = 87
integer height = 72
string picturename = "C:\ii4net\CIPQ\images\repetitive.bmp"
boolean focusrectangle = false
end type

type rr_2 from roundrectangle within w_critere_date_etat_phys
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 1550
integer height = 140
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_1 from roundrectangle within w_critere_date_etat_phys
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 168
integer width = 1550
integer height = 436
integer cornerheight = 40
integer cornerwidth = 46
end type

type ddlb_prepose from u_ddlb within w_critere_date_etat_phys
integer x = 421
integer y = 380
integer width = 1106
integer height = 364
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Tahoma"
end type

event constructor;call super::constructor;long ll_nb_prep, ll_row
n_ds lnv_liste

lnv_liste = create n_ds
lnv_liste.dataobject = "dddw_prepose_centre_no_arg"
lnv_liste.SetTransObject(SQLCA)

ll_nb_prep = lnv_liste.retrieve()

for ll_row = 1 to ll_nb_prep
	if isNull(lnv_liste.object.prepnom[ll_row]) then
		this.of_additem('', lnv_liste.object.prepid[ll_row])
	else
		this.of_additem(lnv_liste.object.prepnom[ll_row], lnv_liste.object.prepid[ll_row])
	end if
next

if ll_nb_prep > 0 then this.of_selectitem(1)

destroy lnv_liste
end event


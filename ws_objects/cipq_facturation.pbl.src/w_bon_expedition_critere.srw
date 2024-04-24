$PBExportHeader$w_bon_expedition_critere.srw
forward
global type w_bon_expedition_critere from w_sheet
end type
type dw_bon_expedition_critere from u_dw within w_bon_expedition_critere
end type
type st_mois from statictext within w_bon_expedition_critere
end type
type uo_toolbar from u_cst_toolbarstrip within w_bon_expedition_critere
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_bon_expedition_critere
end type
type st_1 from statictext within w_bon_expedition_critere
end type
type p_ra from picture within w_bon_expedition_critere
end type
type rr_2 from roundrectangle within w_bon_expedition_critere
end type
type rr_1 from roundrectangle within w_bon_expedition_critere
end type
end forward

global type w_bon_expedition_critere from w_sheet
string tag = "exclure_securite"
integer width = 3488
integer height = 928
string title = "Critères de bon de livraison"
dw_bon_expedition_critere dw_bon_expedition_critere
st_mois st_mois
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
rr_2 rr_2
rr_1 rr_1
end type
global w_bon_expedition_critere w_bon_expedition_critere

type variables
n_cst_datetime	inv_datetime
date	id_debut, id_fin
end variables

on w_bon_expedition_critere.create
int iCurrent
call super::create
this.dw_bon_expedition_critere=create dw_bon_expedition_critere
this.st_mois=create st_mois
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.rr_2=create rr_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_bon_expedition_critere
this.Control[iCurrent+2]=this.st_mois
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.uo_toolbar_gauche
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.p_ra
this.Control[iCurrent+7]=this.rr_2
this.Control[iCurrent+8]=this.rr_1
end on

on w_bon_expedition_critere.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_bon_expedition_critere)
destroy(this.st_mois)
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
uo_toolbar_gauche.of_AddItem("Filtrer...", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar_gauche.POST of_displaytext(true)

dw_bon_expedition_critere.InsertRow(0)

String ls_cie

ls_cie = gnv_app.of_getcompagniedefaut( )

if ls_cie <> "110" then
	dw_bon_expedition_critere.object.cie[1] = ls_cie
	dw_bon_expedition_critere.setcolumn("no_eleveur")
end if
end event

type dw_bon_expedition_critere from u_dw within w_bon_expedition_critere
integer x = 73
integer y = 200
integer width = 3310
integer height = 380
integer taborder = 10
string dataobject = "d_bon_expedition_critere"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type st_mois from statictext within w_bon_expedition_critere
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

type uo_toolbar from u_cst_toolbarstrip within w_bon_expedition_critere
event destroy ( )
integer x = 2926
integer y = 636
integer width = 507
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_bon_expedition_critere
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

event ue_clicked_anywhere;call super::ue_clicked_anywhere;//Bâtir le filtre

string	ls_filtre = "", ls_centre
date		ld_date
long		ll_no_bon, ll_no_eleveur

dw_bon_expedition_critere.AcceptText()

ls_centre = dw_bon_expedition_critere.object.cie[1]
ll_no_bon = dw_bon_expedition_critere.object.no_bon[1]
ll_no_eleveur = dw_bon_expedition_critere.object.no_eleveur[1]
ld_date = dw_bon_expedition_critere.object.date_expe[1]

IF Not IsNull(ll_no_bon) AND ll_no_bon <> 0 AND ( IsNull(ls_centre) OR ls_centre = "" ) THEN
	gnv_app.inv_error.of_message("CIPQ0126")
	RETURN
END IF	

IF Not IsNull(ls_centre) AND ls_centre <> "" THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon centre", ls_centre)
END IF

IF Not IsNull(ld_date) AND ld_date <> 1900-01-01 THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon date", string(ld_date))
END IF

IF Not IsNull(ll_no_bon) AND ll_no_bon <> 0 THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon no bon", string(ll_no_bon))
END IF

IF Not IsNull(ll_no_eleveur) AND ll_no_eleveur <> 0 THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon no eleveur", string(ll_no_eleveur))
END IF

//Ouvrir l'interface
w_bon_expedition	lw_fen
SetPointer(HourGlass!)
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
end event

type st_1 from statictext within w_bon_expedition_critere
integer x = 201
integer y = 44
integer width = 3159
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Critères de bon de livraison"
boolean focusrectangle = false
end type

type p_ra from picture within w_bon_expedition_critere
integer x = 69
integer y = 48
integer width = 87
integer height = 72
string picturename = "Update!"
boolean focusrectangle = false
end type

type rr_2 from roundrectangle within w_bon_expedition_critere
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 3415
integer height = 140
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_1 from roundrectangle within w_bon_expedition_critere
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 168
integer width = 3415
integer height = 436
integer cornerheight = 40
integer cornerwidth = 46
end type

